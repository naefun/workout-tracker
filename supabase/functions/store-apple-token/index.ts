import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "npm:@supabase/server@1.4.1";
import {
  encryptAppleRefreshToken,
  exchangeAppleAuthorizationCode,
} from "../_shared/apple_auth.ts";
import {
  createIsolatedAdminClient,
  getSupabaseAuthUser,
} from "../_shared/supabase_admin.ts";

export default {
  fetch: withSupabase({ auth: "user" }, async (request, context) => {
    if (request.method !== "POST") {
      return Response.json({ error: "Method not allowed." }, { status: 405 });
    }

    const userId = context.userClaims?.id;
    if (!userId) {
      return Response.json(
        { error: "Authentication is required." },
        { status: 401 },
      );
    }

    try {
      const requestBody = await request.json().catch(() => null);
      const authorizationCode = requestBody?.authorizationCode;
      if (
        typeof authorizationCode !== "string" ||
        authorizationCode.length === 0
      ) {
        return Response.json(
          { error: "An Apple authorization code is required." },
          { status: 400 },
        );
      }

      const admin = createIsolatedAdminClient();
      let authUser;
      try {
        authUser = await getSupabaseAuthUser(userId);
      } catch (error) {
        console.error(
          "Failed to load the user before storing the Apple token:",
          error,
        );
        return Response.json(
          { error: "Apple authorization could not be stored." },
          { status: 500 },
        );
      }

      const appleIdentity = authUser.identities?.find(
        (identity) => identity.provider === "apple",
      );
      if (!appleIdentity) {
        return Response.json(
          { error: "The authenticated user has no Apple identity." },
          { status: 400 },
        );
      }

      const appleProviderId = appleIdentity.identity_data?.sub;
      if (typeof appleProviderId !== "string" || appleProviderId.length === 0) {
        console.error(
          "The Apple identity does not contain a provider subject.",
        );
        return Response.json(
          { error: "Apple authorization could not be stored." },
          { status: 500 },
        );
      }

      const refreshToken = await exchangeAppleAuthorizationCode(
        authorizationCode,
        appleProviderId,
      );
      const encryptedToken = await encryptAppleRefreshToken(refreshToken);
      const { error: upsertError } = await admin
        .from("apple_auth_tokens")
        .upsert(
          {
            user_id: userId,
            encrypted_refresh_token: encryptedToken.encryptedRefreshToken,
            initialization_vector: encryptedToken.initializationVector,
            updated_at: new Date().toISOString(),
          },
          { onConflict: "user_id" },
        );

      if (upsertError) {
        console.error(
          "Failed to store the encrypted Apple token:",
          upsertError,
        );
        return Response.json(
          { error: "Apple authorization could not be stored." },
          { status: 500 },
        );
      }

      return Response.json({ stored: true }, { status: 200 });
    } catch (error) {
      console.error("Unexpected Apple token storage failure:", error);
      return Response.json(
        { error: "Apple authorization could not be stored." },
        { status: 500 },
      );
    }
  }),
};
