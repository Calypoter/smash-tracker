create extension if not exists pgcrypto with schema extensions;

create table if not exists public.shared_trackers (
  token_hash text primary key check (token_hash ~ '^[0-9a-f]{64}$'),
  state jsonb not null check (jsonb_typeof(state) = 'object'),
  updated_at timestamptz not null default now()
);

alter table public.shared_trackers enable row level security;
revoke all on table public.shared_trackers from anon, authenticated;

create or replace function public.create_shared_tracker(p_token text, p_state jsonb)
returns void
language plpgsql
security definer
set search_path = ''
as $function$
begin
  if p_token is null or length(p_token) < 40 or length(p_token) > 128 then
    raise exception 'Invalid share code';
  end if;
  if p_state is null or jsonb_typeof(p_state) <> 'object' or pg_column_size(p_state) > 65536 then
    raise exception 'Invalid tracker state';
  end if;

  insert into public.shared_trackers (token_hash, state)
  values (encode(extensions.digest(convert_to(p_token, 'UTF8'), 'sha256'), 'hex'), p_state)
  on conflict (token_hash) do nothing;
end;
$function$;

create or replace function public.get_shared_tracker(p_token text)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $function$
declare
  tracker_data jsonb;
begin
  if p_token is null or length(p_token) < 40 or length(p_token) > 128 then
    raise exception 'Invalid share code';
  end if;

  select jsonb_build_object('state', tracker.state, 'updated_at', tracker.updated_at)
  into tracker_data
  from public.shared_trackers as tracker
  where tracker.token_hash = encode(extensions.digest(convert_to(p_token, 'UTF8'), 'sha256'), 'hex');

  if tracker_data is null then
    raise exception 'Shared tracker not found';
  end if;

  return tracker_data;
end;
$function$;

create or replace function public.save_shared_tracker(p_token text, p_state jsonb)
returns timestamptz
language plpgsql
security definer
set search_path = ''
as $function$
declare
  saved_at timestamptz;
begin
  if p_token is null or length(p_token) < 40 or length(p_token) > 128 then
    raise exception 'Invalid share code';
  end if;
  if p_state is null or jsonb_typeof(p_state) <> 'object' or pg_column_size(p_state) > 65536 then
    raise exception 'Invalid tracker state';
  end if;

  update public.shared_trackers as tracker
  set state = p_state, updated_at = clock_timestamp()
  where tracker.token_hash = encode(extensions.digest(convert_to(p_token, 'UTF8'), 'sha256'), 'hex')
  returning tracker.updated_at into saved_at;

  if saved_at is null then
    raise exception 'Shared tracker not found';
  end if;

  return saved_at;
end;
$function$;

create or replace function public.revoke_shared_tracker(p_token text)
returns void
language plpgsql
security definer
set search_path = ''
as $function$
declare
  removed_hash text;
begin
  if p_token is null or length(p_token) < 40 or length(p_token) > 128 then
    raise exception 'Invalid share code';
  end if;

  delete from public.shared_trackers as tracker
  where tracker.token_hash = encode(extensions.digest(convert_to(p_token, 'UTF8'), 'sha256'), 'hex')
  returning tracker.token_hash into removed_hash;

  if removed_hash is null then
    raise exception 'Shared tracker not found';
  end if;
end;
$function$;

revoke all on function public.create_shared_tracker(text, jsonb) from public;
revoke all on function public.get_shared_tracker(text) from public;
revoke all on function public.save_shared_tracker(text, jsonb) from public;
revoke all on function public.revoke_shared_tracker(text) from public;
grant execute on function public.create_shared_tracker(text, jsonb) to anon, authenticated;
grant execute on function public.get_shared_tracker(text) to anon, authenticated;
grant execute on function public.save_shared_tracker(text, jsonb) to anon, authenticated;
grant execute on function public.revoke_shared_tracker(text) to anon, authenticated;
