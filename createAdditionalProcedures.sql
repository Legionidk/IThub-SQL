CREATE OR REPLACE PROCEDURE addEmployee (
	p_login varchar,
	p_password varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
	if length(p_password) < 6 then
		raise exception 'Пароль должен быть не менее 6 символов';
	end if;

	if exists (select 1 from employeesCredentials where login = p_login) then
		raise exception 'Логин уже существует';
	end if;

	insert into employeesCredentials(login, password)
	values (p_login, p_password);
END;
$$;

CREATE OR REPLACE PROCEDURE addApplication (
	p_number varchar,
	p_agreementId int,
	p_applicantCode int
)
LANGUAGE plpgsql
AS $$
DECLARE v_status varchar;
BEGIN
	select status into v_status
	from agreements
	where id = p_agreementId;

	if v_status is null then
		raise exception 'Договор не найден';
	end if;

	if v_status <> 'Действует' then
		raise exception 'Нельзя создать заявкеу по неактивному договору';
	end if;

	insert into applications (number, agreementId, applicantCode, created_at)
	values (p_number, p_agreementId, p_applicantCode, now());
END;
$$;

CREATE OR REPLACE PROCEDURE addTask (
	p_applicationId int,
	p_workerCode int,
	p_equipmentCode int,
	p_description varchar,
	p_deadline date
)
LANGUAGE plpgsql
AS $$
BEGIN
	if p_deadline < current_date then
		raise exception 'Дедлайн не может быть в прошедшем времени';
	end if;

	insert into tasks(applicationId, workerCode, equipmentCode, description, deadline)
	values (p_applicationId, p_workerCode, p_equipmentCode, p_description, p_deadline);
END;
$$;

CREATE OR REPLACE PROCEDURE deleteCustomer (p_customerId int)
LANGUAGE plpgsql
AS $$
BEGIN
	if exists (
		select 1 from agreements where customerId = p_customerId
	) then
		raise exception 'Нельзя удалить клиента с договорами';
	end if;

	delete from customers where id = p_customerId;
END;
$$;

CREATE OR REPLACE PROCEDURE addDriver (
	p_intermediarieID int,
	p_lastName varchar,
	p_firstName varchar,
	p_middleName varchar,
	p_phone varchar,
	p_carID int
)
LANGUAGE plpgsql
AS $$
BEGIN
	if exists (
		select 1 from intermediariesDrivers where carID = p_carID
	) then
		raise exception 'Машина уже закреплена за другим водителем';
	end if;

	insert into intermediariesDrivers (intermediarieID, lastName, firstName, middleName, contactPhone, carID)
	values (p_intermediarieID, p_lastNamem, p_firstName, p_middleName, p_contactPhone, p_carID);
END;
$$;