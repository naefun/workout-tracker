create table public.apple_auth_tokens (
  user_id uuid primary key references auth.users (id) on delete cascade,
  encrypted_refresh_token text not null
    check (length(encrypted_refresh_token) > 0),
  initialization_vector text not null
    check (length(initialization_vector) > 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.apple_auth_tokens enable row level security;

revoke all on table public.apple_auth_tokens from anon, authenticated;
grant select, insert, update, delete
  on table public.apple_auth_tokens
  to service_role;
