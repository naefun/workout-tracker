import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "npm:@supabase/server@1.4.1";
import {
  decryptAppleRefreshToken,
  revokeAppleRefreshToken,
} from "../_shared/apple_auth.ts";
import {
  createIsolatedAdminClient,
  deleteSupabaseAuthUser,
  revokeSupabaseAuthSessions,
} from "../_shared/supabase_admin.ts";

export default {
  fetch: withSupabase({ auth: "user" }, async (request, context) => {
    if (request.method !== "POST") {
      return Response.json({ error: "Method not allowed." }, { status: 405 });
    }

    const authorization = request.headers.get("Authorization");
    const userId = context.userClaims?.id;
    if (!authorization?.startsWith("Bearer ") || !userId) {
      return Response.json(
        { error: "Authentication is required." },
        { status: 401 },
      );
    }

    const accessToken = authorization.slice("Bearer ".length);

    try {
      const accountAdmin = createIsolatedAdminClient();
      const { data: tokenData, error: tokenError } =
        await accountAdmin
          .from("apple_auth_tokens")
          .select("encrypted_refresh_token, initialization_vector")
          .eq("user_id", userId)
          .maybeSingle();

      if (tokenError) {
        console.error(
          "Failed to load the encrypted Apple token:",
          tokenError,
        );
        return Response.json(
          { error: "Account deletion could not be completed." },
          { status: 500 },
        );
      }

      const appMetadata = context.jwtClaims?.app_metadata as
        | { provider?: unknown; providers?: unknown }
        | undefined;
      const jwtProviders = appMetadata?.providers;
      const hasAppleIdentity = tokenData != null ||
        appMetadata?.provider === "apple" ||
        (Array.isArray(jwtProviders) && jwtProviders.includes("apple"));

      if (hasAppleIdentity && !tokenData) {
        return Response.json(
          {
            code: "APPLE_TOKEN_MISSING",
            error:
              "Sign out and sign in with Apple once before deleting this account.",
          },
          { status: 409 },
        );
      }

      if (tokenData) {
        try {
          const refreshToken = await decryptAppleRefreshToken(
            tokenData.encrypted_refresh_token,
            tokenData.initialization_vector,
          );
          await revokeAppleRefreshToken(refreshToken);
        } catch (error) {
          console.error("Failed to revoke Apple authorization:", error);
          return Response.json(
            { error: "Apple authorization could not be revoked." },
            { status: 502 },
          );
        }
      }

      try {
        await revokeSupabaseAuthSessions(accessToken);
      } catch (error) {
        console.error("Failed to revoke the user's sessions:", error);
        return Response.json(
          { error: "Account deletion could not be completed." },
          { status: 500 },
        );
      }

      try {
        await deleteSupabaseAuthUser(userId);
      } catch (error) {
        console.error("Failed to delete the authenticated user:", error);
        return Response.json(
          { error: "Account deletion could not be completed." },
          { status: 500 },
        );
      }

      return Response.json(
        {
          deleted: true,
          appleAuthorizationRevoked: hasAppleIdentity,
        },
        { status: 200 },
      );
    } catch (error) {
      console.error("Unexpected account deletion failure:", error);
      return Response.json(
        { error: "Account deletion could not be completed." },
        { status: 500 },
      );
    }
  }),
};
