type AppleTokenResponse = {
  access_token?: string;
  id_token?: string;
  refresh_token?: string;
};

export type EncryptedAppleToken = {
  encryptedRefreshToken: string;
  initializationVector: string;
};

function getRequiredEnvironmentVariable(name: string): string {
  const value = Deno.env.get(name);
  if (!value) {
    throw new Error(`${name} is not configured.`);
  }
  return value;
}

function bytesToBase64(bytes: Uint8Array): string {
  let binary = "";
  for (const byte of bytes) {
    binary += String.fromCharCode(byte);
  }
  return btoa(binary);
}

function base64ToBytes(value: string): Uint8Array {
  return Uint8Array.from(
    atob(value),
    (character) => character.charCodeAt(0),
  );
}

function base64UrlEncode(value: string | Uint8Array): string {
  const bytes = typeof value === "string"
    ? new TextEncoder().encode(value)
    : value;
  return bytesToBase64(bytes)
    .replaceAll("+", "-")
    .replaceAll("/", "_")
    .replaceAll("=", "");
}

function decodeJwtPayload(token: string): Record<string, unknown> {
  const payload = token.split(".")[1];
  if (!payload) {
    throw new Error("Apple returned an invalid identity token.");
  }

  const normalizedPayload = payload
    .replaceAll("-", "+")
    .replaceAll("_", "/")
    .padEnd(Math.ceil(payload.length / 4) * 4, "=");
  return JSON.parse(
    new TextDecoder().decode(base64ToBytes(normalizedPayload)),
  );
}

async function createAppleClientSecret(): Promise<string> {
  const clientId = getRequiredEnvironmentVariable("APPLE_CLIENT_ID");
  const now = Math.floor(Date.now() / 1000);
  const header = base64UrlEncode(JSON.stringify({
    alg: "ES256",
    kid: getRequiredEnvironmentVariable("APPLE_KEY_ID"),
    typ: "JWT",
  }));
  const payload = base64UrlEncode(JSON.stringify({
    aud: "https://appleid.apple.com",
    exp: now + 300,
    iat: now,
    iss: getRequiredEnvironmentVariable("APPLE_TEAM_ID"),
    sub: clientId,
  }));
  const unsignedToken = `${header}.${payload}`;
  const privateKey = getRequiredEnvironmentVariable("APPLE_PRIVATE_KEY");
  const privateKeyBytes = base64ToBytes(
    privateKey
      .replaceAll("\\n", "\n")
      .replace(/-----BEGIN PRIVATE KEY-----|-----END PRIVATE KEY-----|\s/g, ""),
  );
  const signingKey = await crypto.subtle.importKey(
    "pkcs8",
    privateKeyBytes,
    { name: "ECDSA", namedCurve: "P-256" },
    false,
    ["sign"],
  );
  const signature = await crypto.subtle.sign(
    { name: "ECDSA", hash: "SHA-256" },
    signingKey,
    new TextEncoder().encode(unsignedToken),
  );

  return `${unsignedToken}.${base64UrlEncode(new Uint8Array(signature))}`;
}

async function getEncryptionKey(): Promise<CryptoKey> {
  const keyBytes = base64ToBytes(
    getRequiredEnvironmentVariable("APPLE_TOKEN_ENCRYPTION_KEY"),
  );
  if (keyBytes.byteLength !== 32) {
    throw new Error(
      "APPLE_TOKEN_ENCRYPTION_KEY must be a base64-encoded 32-byte key.",
    );
  }

  return await crypto.subtle.importKey(
    "raw",
    keyBytes,
    { name: "AES-GCM" },
    false,
    ["encrypt", "decrypt"],
  );
}

export async function exchangeAppleAuthorizationCode(
  authorizationCode: string,
  expectedAppleUserId: string,
): Promise<string> {
  const clientId = getRequiredEnvironmentVariable("APPLE_CLIENT_ID");
  const tokenResponse = await fetch("https://appleid.apple.com/auth/token", {
    method: "POST",
    headers: { "content-type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      client_id: clientId,
      client_secret: await createAppleClientSecret(),
      code: authorizationCode,
      grant_type: "authorization_code",
    }),
  });
  const tokenData = await tokenResponse.json() as AppleTokenResponse;

  if (!tokenResponse.ok || !tokenData.id_token) {
    throw new Error("Apple authorization code exchange failed.");
  }

  const claims = decodeJwtPayload(tokenData.id_token);
  if (claims.iss !== "https://appleid.apple.com") {
    throw new Error("Apple returned an identity token with an invalid issuer.");
  }
  if (claims.aud !== clientId) {
    throw new Error(
      "Apple returned an identity token with an invalid audience.",
    );
  }
  if (claims.sub !== expectedAppleUserId) {
    throw new Error(
      "Apple authorization does not match the authenticated Apple identity.",
    );
  }

  if (!tokenData.refresh_token) {
    throw new Error("Apple did not return a refresh token.");
  }

  return tokenData.refresh_token;
}

export async function revokeAppleRefreshToken(
  refreshToken: string,
): Promise<void> {
  const revokeResponse = await fetch("https://appleid.apple.com/auth/revoke", {
    method: "POST",
    headers: { "content-type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      client_id: getRequiredEnvironmentVariable("APPLE_CLIENT_ID"),
      client_secret: await createAppleClientSecret(),
      token: refreshToken,
      token_type_hint: "refresh_token",
    }),
  });

  if (!revokeResponse.ok) {
    throw new Error("Apple authorization revocation failed.");
  }
}

export async function encryptAppleRefreshToken(
  refreshToken: string,
): Promise<EncryptedAppleToken> {
  const initializationVector = crypto.getRandomValues(new Uint8Array(12));
  const encryptedToken = await crypto.subtle.encrypt(
    { name: "AES-GCM", iv: initializationVector },
    await getEncryptionKey(),
    new TextEncoder().encode(refreshToken),
  );

  return {
    encryptedRefreshToken: bytesToBase64(new Uint8Array(encryptedToken)),
    initializationVector: bytesToBase64(initializationVector),
  };
}

export async function decryptAppleRefreshToken(
  encryptedRefreshToken: string,
  initializationVector: string,
): Promise<string> {
  const decryptedToken = await crypto.subtle.decrypt(
    {
      name: "AES-GCM",
      iv: base64ToBytes(initializationVector),
    },
    await getEncryptionKey(),
    base64ToBytes(encryptedRefreshToken),
  );

  return new TextDecoder().decode(decryptedToken);
}
