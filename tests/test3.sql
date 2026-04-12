-- Для этого теста необходимо запустить обновленный insertData.sql, в котором заполняются новые таблицы
CREATE OR REPLACE PROCEDURE delete_intermediary (p_id int)
LANGUAGE plpgsql
AS $$
BEGIN
	if exists (select 1 from intermediariesDrivers where intermediarieID = p_id)
	or exists (select 1 from intermediariesAgreements where intermediarieID = p_id)
	then
		raise exception 'Данная организация не может быть удалена, так как на основании неё созданы водители и договора.';
	end if;

	delete from intermediaries where id = p_id;
END;
$$;

call delete_intermediary (1);