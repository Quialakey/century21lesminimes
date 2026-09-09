-- Corrige le verrou de concurrence utilise par l'application Quialakey.
-- Sur un INSERT, il faut conserver expected_updated_at : un UPSERT execute
-- d'abord les triggers INSERT avant de devenir eventuellement un UPDATE.
create or replace function public.prevent_stale_app_state_update()
returns trigger
language plpgsql
as $$
begin
  if tg_op = 'UPDATE' then
    if new.expected_updated_at is null
      or old.updated_at is distinct from new.expected_updated_at then
      raise exception 'Ancienne version bloquee : rechargez le site avant de sauvegarder.';
    end if;

    new.expected_updated_at := null;
  end if;

  return new;
end;
$$;

drop trigger if exists app_state_prevent_stale_update on public.app_state;

create trigger app_state_prevent_stale_update
before update on public.app_state
for each row
execute function public.prevent_stale_app_state_update();
