CREATE OR REPLACE PROCEDURE add_application (
	p_agreementid int,
	p_applicantcode int,
	p_created_at timestamp
)
LANGUAGE plpgsql
AS $$
DECLARE
	new_number varchar;
	new_id int;
BEGIN
	SELECT COALESCE(MAX(id), 0) + 1 INTO new_id FROM applications;

	new_number :=
		'З-' ||
		LPAD(new_id::text, 8, '0') || -- Ничего не получалось, пришлось откопать функцию LPAD
		'-' ||
		TO_CHAR(p_created_at, 'YY');

	INSERT INTO applications(number, agreementid, applicantcode, created_at)
	VALUES (new_number, p_agreementid, p_applicantcode, p_created_at);
END;
$$;

call add_application (1, 1, '2024-02-02 12:00:10');

select *
from applications
order by id desc
limit 1;