CREATE OR REPLACE PROCEDURE add_task (
	p_applicationid int,
	p_workercode int,
	p_equipmentcode int,
	p_description varchar,
	p_deadline date
)
LANGUAGE plpgsql
AS $$
BEGIN
	if exists (
		select 1
		from tasks
		where workercode = p_workercode
		and deadline >= CURRENT_DATE
	) then
		raise exception 'Данному сотруднику не может быть назначено одновременно две и более задачи.';
	end if;

	insert into tasks (applicationid, workercode, equipmentcode, description, deadline) values
	(p_applicationid, p_workercode, p_equipmentcode, p_description, p_deadline);
END;
$$;

call add_task (1, 11, 1, 'description', '2026-11-05');
-- 1 вызов: срабатывание процедуры
-- 2 вызов: сообщение из raise exception