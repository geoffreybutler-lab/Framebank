-- FRAMEBANK SUPABASE SETUP
-- Run this once in Supabase > SQL Editor.

create extension if not exists pgcrypto;

create table if not exists public.frames (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  film text not null,
  description text default '',
  category text default 'Other',
  image_path text not null,
  created_at timestamptz not null default now()
);

alter table public.frames enable row level security;

drop policy if exists "Users can read own frames" on public.frames;
create policy "Users can read own frames"
on public.frames for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own frames" on public.frames;
create policy "Users can insert own frames"
on public.frames for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update own frames" on public.frames;
create policy "Users can update own frames"
on public.frames for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own frames" on public.frames;
create policy "Users can delete own frames"
on public.frames for delete
using (auth.uid() = user_id);

insert into storage.buckets (id, name, public)
values ('frames', 'frames', false)
on conflict (id) do update set public = false;

drop policy if exists "Users can read own frame images" on storage.objects;
create policy "Users can read own frame images"
on storage.objects for select
using (
  bucket_id = 'frames'
  and (storage.foldername(name))[1] = auth.uid()::text
);

drop policy if exists "Users can upload own frame images" on storage.objects;
create policy "Users can upload own frame images"
on storage.objects for insert
with check (
  bucket_id = 'frames'
  and (storage.foldername(name))[1] = auth.uid()::text
);

drop policy if exists "Users can update own frame images" on storage.objects;
create policy "Users can update own frame images"
on storage.objects for update
using (
  bucket_id = 'frames'
  and (storage.foldername(name))[1] = auth.uid()::text
);

drop policy if exists "Users can delete own frame images" on storage.objects;
create policy "Users can delete own frame images"
on storage.objects for delete
using (
  bucket_id = 'frames'
  and (storage.foldername(name))[1] = auth.uid()::text
);
