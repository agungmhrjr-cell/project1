-- MHRJR STORE - jalankan SEKALI di Supabase SQL Editor
-- Setelah akun admin dibuat lewat daftar.html, ganti EMAIL_ADMIN di bagian terakhir.

create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  name text not null default '',
  email text not null,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (user_id, name, email)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'name',''),
    new.email
  );
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

-- Fungsi admin membaca email pelanggan tanpa memberi akses publik.
create schema if not exists private;

create or replace function private.is_admin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1
    from public.profiles
    where user_id = (select auth.uid())
      and role = 'admin'
  );
$$;

-- Tambahkan kolom role jika belum ada.
alter table public.profiles add column if not exists role text not null default 'customer';

drop policy if exists "user can read own profile" on public.profiles;
create policy "user can read own profile"
on public.profiles for select
to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "admin can read all profiles" on public.profiles;
create policy "admin can read all profiles"
on public.profiles for select
to authenticated
using ((select private.is_admin()));

-- Setelah kamu membuat akun admin, jalankan:
-- update public.profiles
-- set role = 'admin'
-- where email = 'EMAIL_ADMIN';
