-- Pulse Relay: 无历史模式 + 1 小时自动清理
-- 用法：
-- 1. 在 Supabase Dashboard -> SQL Editor 里执行整段 SQL
-- 2. 如果提示 pg_cron 未开启，先在 Database -> Extensions 启用 pg_cron

create extension if not exists pg_cron with schema extensions;

create or replace function public.cleanup_public_chat_data()
returns void
language plpgsql
security definer
set search_path = public, storage
as $$
begin
  delete from storage.objects
  where bucket_id = 'chat-files'
    and created_at < now() - interval '1 hour';

  delete from public.messages
  where created_at < now() - interval '1 hour';
end;
$$;

do $$
declare
  existing_job_id bigint;
begin
  select jobid
  into existing_job_id
  from cron.job
  where jobname = 'cleanup-public-chat-hourly'
  limit 1;

  if existing_job_id is not null then
    perform cron.unschedule(existing_job_id);
  end if;
end
$$;

select cron.schedule(
  'cleanup-public-chat-hourly',
  '*/10 * * * *',
  $$select public.cleanup_public_chat_data();$$
);
