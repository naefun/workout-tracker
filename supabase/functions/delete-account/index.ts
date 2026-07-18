import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "npm:@supabase/server@1.4.0";

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
      const { error: signOutError } =
        await context.supabaseAdmin.auth.admin.signOut(accessToken, "global");

      if (signOutError) {
        console.error("Failed to revoke the user's sessions:", signOutError);
        return Response.json(
          { error: "Account deletion could not be completed." },
          { status: 500 },
        );
      }

      const { error: deleteError } =
        await context.supabaseAdmin.auth.admin.deleteUser(userId);

      if (deleteError) {
        console.error("Failed to delete the authenticated user:", deleteError);
        return Response.json(
          { error: "Account deletion could not be completed." },
          { status: 500 },
        );
      }

      return Response.json({ deleted: true }, { status: 200 });
    } catch (error) {
      console.error("Unexpected account deletion failure:", error);
      return Response.json(
        { error: "Account deletion could not be completed." },
        { status: 500 },
      );
    }
  }),
};
