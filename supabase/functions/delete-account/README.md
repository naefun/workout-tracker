# Account deletion Edge Functions

`store-apple-token` exchanges the authorization code returned during the
original Sign in with Apple flow, validates that it belongs to the authenticated
Supabase user's Apple identity, encrypts the resulting refresh token, and stores
it in `public.apple_auth_tokens`.

`delete-account` reads and decrypts that token, revokes the user's Apple
authorization, revokes all Supabase sessions, and deletes the Supabase user.
The foreign key cascade removes the stored token. Google-only users skip the
Apple revocation step.

The Supabase platform provides `SUPABASE_URL` and the
`SUPABASE_SECRET_KEYS` dictionary. The functions use its `default` key for
isolated admin requests and do not read or configure the legacy
`SUPABASE_SERVICE_ROLE_KEY`. Both functions additionally require these Edge
Function secrets:

- `APPLE_CLIENT_ID`: the native App ID (`com.nathanbyrne.workouttrackerapp`)
- `APPLE_TEAM_ID`: the Apple Developer team ID
- `APPLE_KEY_ID`: the identifier of the Sign in with Apple private key
- `APPLE_PRIVATE_KEY`: the contents of the associated `.p8` private key
- `APPLE_TOKEN_ENCRYPTION_KEY`: a base64-encoded, randomly generated 32-byte key

Configure them as hosted Edge Function secrets; do not add the `.p8` key or an
environment file containing it to the application repository. A hosted
deployment does not require an env file. Generate the encryption key with a
cryptographically secure command such as `openssl rand -base64 32`.

Apply `supabase/migrations/20260724201407_create_apple_auth_tokens.sql`, set all
five secrets, then deploy `store-apple-token` and `delete-account`.

Existing Apple users do not have a stored refresh token. After this change is
deployed, they must sign out and sign in with Apple once before account
deletion. Deletion itself does not ask them to authenticate with Apple again.
