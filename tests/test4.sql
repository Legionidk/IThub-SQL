CREATE OR REPLACE PROCEDURE add_employee_role (
	p_employeescode int,
	p_name varchar,
	p_lastname varchar,
	p_middlename varchar,
	p_role varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
	if exists (
		select 1
		from companyemployees
		where employeescode = p_employeescode
		and emp_role = p_role
	) then
		raise exception 'Указанная должность уже есть у выбранного сотрудника!';
	end if;

	insert into companyemployees (employeescode, name, lastname, middlename, emp_role) values
	(p_employeescode, p_name, p_lastname, p_middlename, p_role);
END;
$$;

call add_employee_role (12, 'Пётр', 'Петров', 'Петрович', 'Заместитель главного распределителя');