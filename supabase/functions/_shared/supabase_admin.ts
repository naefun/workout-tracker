import { createClient } from "npm:@supabase/supabase-js@2.110.8";

type SupabaseAuthIdentity = {
  provider?: string;
  identity_data?: {
    sub?: string;
  };
};

export type SupabaseAuthUser = {
  identities?: SupabaseAuthIdentity[];
};

function getSupabaseSecretKey(): string {
  const namedSecretKeys = Deno.env.get("SUPABASE_SECRET_KEYS");
  if (namedSecretKeys) {
    const parsedSecretKeys = JSON.parse(namedSecretKeys) as Record<
      string,
      unknown
    >;
    const defaultSecretKey = parsedSecretKeys.default;
    if (
      typeof defaultSecretKey === "string" &&
      defaultSecretKey.length > 0
    ) {
      return defaultSecretKey;
    }
  }

  const localSecretKey = Deno.env.get("SUPABASE_SECRET_KEY");
  if (localSecretKey) {
    return localSecretKey;
  }

  throw new Error("A Supabase secret key is not configured.");
}

function getSupabaseUrl(): string {
  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  if (!supabaseUrl) {
    throw new Error("SUPABASE_URL is not configured.");
  }
  return supabaseUrl;
}

export function createIsolatedAdminClient() {
  return createClient(getSupabaseUrl(), getSupabaseSecretKey(), {
    auth: {
      autoRefreshToken: false,
      detectSessionInUrl: false,
      persistSession: false,
    },
  });
}

async function performAdminAuthRequest(
  path: string,
  init?: RequestInit,
): Promise<Response> {
  const headers = new Headers(init?.headers);
  headers.set("apikey", getSupabaseSecretKey());

  return await fetch(`${getSupabaseUrl()}/auth/v1${path}`, {
    ...init,
    headers,
  });
}

export async function getSupabaseAuthUser(
  userId: string,
): Promise<SupabaseAuthUser> {
  const response = await performAdminAuthRequest(
    `/admin/users/${encodeURIComponent(userId)}`,
  );
  const responseData = await response.json().catch(() => null);

  if (!response.ok) {
    throw new Error(
      `Supabase Auth user lookup failed with status ${response.status}.`,
    );
  }

  return (responseData?.user ?? responseData) as SupabaseAuthUser;
}

export async function revokeSupabaseAuthSessions(
  accessToken: string,
): Promise<void> {
  const response = await performAdminAuthRequest("/logout?scope=global", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${accessToken}`,
    },
  });
  const responseData = await response.json().catch(() => null);
  const sessionIsMissing = response.status === 403 &&
    (responseData?.code === "session_not_found" ||
      responseData?.error_code === "session_not_found" ||
      responseData?.message?.toLowerCase().includes("session not found") ===
        true);

  if (!response.ok && !sessionIsMissing) {
    throw new Error(
      `Supabase session revocation failed with status ${response.status}.`,
    );
  }
}

export async function deleteSupabaseAuthUser(userId: string): Promise<void> {
  const response = await performAdminAuthRequest(
    `/admin/users/${encodeURIComponent(userId)}`,
    {
      method: "DELETE",
      headers: {
        "content-type": "application/json",
      },
      body: JSON.stringify({ should_soft_delete: false }),
    },
  );

  if (!response.ok) {
    throw new Error(
      `Supabase Auth user deletion failed with status ${response.status}.`,
    );
  }
}
