CREATE OR REPLACE PROCEDURE createStructure()
LANGUAGE SQL
AS $$
	CREATE TABLE IF NOT EXISTS employeesCredentials (
		code SERIAL not null
			constraint PK_employeesCredentials primary key,
		login varchar(36) not null unique,
		password varchar(36) not null
	);
	
	CREATE INDEX IF NOT EXISTS
		Index_code_employeesCredentials on employeesCredentials (code);
	CREATE INDEX IF NOT EXISTS
		Index_login_employeesCredentials on employeesCredentials (login);
	
	CREATE TABLE IF NOT EXISTS companyEmployees (
		id SERIAL not null
			constraint PK_companyEmployees primary key,
		employeesCode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		name varchar(36) not null,
		lastName varchar(36) not null,
		middleName varchar(36),
		emp_role varchar(50) not null
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_companyEmployees on companyEmployees (id);
	CREATE INDEX IF NOT EXISTS
		Index_employeesCode_companyEmployees on companyEmployees (employeesCode);

	CREATE TABLE IF NOT EXISTS customers (
		id SERIAL not null
			constraint PK_customers primary key,
		OKPO varchar(11) unique not null,
		contactPhone varchar(11) not null unique,
		physicalAddress varchar(255) not null,
		legalAddress varchar(255) not null,
		fullName varchar(255) not null,
		abbreviateName varchar(255) not null
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_customers on customers (id);
	CREATE INDEX IF NOT EXISTS
		Index_OKPO_customers on customers (okpo);
	CREATE INDEX IF NOT EXISTS
		Index_contactPhone_customers on customers (contactphone);
	
	CREATE TABLE IF NOT EXISTS customersEmployees (
		id SERIAL not null
			constraint PK_customersEmployees primary key,
		employeesCode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		customersId int not null
			references customers (id)
			on update cascade on delete cascade,
		name varchar(36) not null,
		lastName varchar(36) not null,
		middleName varchar(36),
		emp_role varchar(50) not null
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_customersEmployees on customersEmployees (id);
	CREATE INDEX IF NOT EXISTS
		Index_employeesCode_customersEmployees on customersEmployees (employeesCode);
	
	CREATE TABLE IF NOT EXISTS agreements (
		id SERIAL not null
			constraint PK_agreements primary key,
		agreementNumber varchar(13) not null unique,
		customerId int not null
			references customers (id)
			on update cascade on delete cascade,
		created_at date,
		expiration date,
		status varchar(10) not null
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_agreements on agreements (id);
	CREATE INDEX IF NOT EXISTS
		Index_agreementNumber_agreements on agreements (agreementNumber);
	CREATE INDEX IF NOT EXISTS
		Index_customerId_agreements on agreements (customerId);

	CREATE TABLE IF NOT EXISTS applications (
		id SERIAL not null 
			constraint PK_applications primary key,
		number varchar(15) unique not null,
		agreementId int not null
			references agreements (id)
			on update cascade on delete cascade,
		applicantcode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		created_at timestamp not null
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_applications on applications (id);
	CREATE INDEX IF NOT EXISTS
		Index_number_applications on applications (number);
	CREATE INDEX IF NOT EXISTS
		Index_agreementId_applications on applications (agreementid);
	CREATE INDEX IF NOT EXISTS
		Index_applicantCode_applications on applications (applicantcode);
	
	CREATE TABLE IF NOT EXISTS equipment (
		code SERIAL not null
			constraint PK_equipment primary key,
		type varchar(36) not null,
		model varchar(36) not null,
		brand varchar(36)
	);

	CREATE INDEX IF NOT EXISTS
		Index_code_equipment on equipment (code);
	
	CREATE TABLE IF NOT EXISTS components (
		code SERIAL not null
			constraint PK_components primary key,
		equipmentCode int not null
			references equipment (code)
			on update cascade on delete cascade,
		type varchar(36) not null,
		name varchar(36) not null
	);

	CREATE INDEX IF NOT EXISTS
		Index_code_components on components (code);
	CREATE INDEX IF NOT EXISTS
		Index_equipmentCode_components on components (equipmentCode);
	
	CREATE TABLE IF NOT EXISTS tasks (
		id SERIAL not null
			constraint PK_tasks primary key,
		applicationId int not null
			references applications (id)
			on update cascade on delete cascade,
		workerCode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		equipmentCode int not null
			references equipment (code)
			on update cascade on delete cascade,
		description varchar(255) not null,
		deadline date not null
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_tasks on tasks (id);
	CREATE INDEX IF NOT EXISTS
		Index_workerCode_tasks on tasks (workerCode);
	CREATE INDEX IF NOT EXISTS
		Index_equipmentCode_tasks on tasks (equipmentCode);
	
	CREATE TABLE IF NOT EXISTS subTasks (
		id SERIAL not null
			constraint PK_subtasks primary key,
		taskId int not null
			references tasks (id)
			on update cascade on delete cascade,
		workerCode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		description varchar(255) not null,
		deadline date not null
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_subTasks on subTasks (id);
	CREATE INDEX IF NOT EXISTS
		Index_taskId_subTasks on subTasks (taskid);

	CREATE TABLE IF NOT EXISTS cars (
		id serial not null
			constraint PK_cars primary key,
		brand varchar(50) not null,
		model varchar(50) not null,
		color varchar(50) not null,
		number varchar(9) not null unique
			check (number ~ '^[АВЕКМНОРСТУХ]{1}[0-9]{3}[АВЕКМНОРСТУХ]{2} [0-9]{2}$')
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_cars on cars (id);
	CREATE INDEX IF NOT EXISTS
		Index_number_cars on cars (number);

	CREATE TABLE IF NOT EXISTS intermediaries (
		id serial not null
			constraint PK_intermediaries primary key,
		fullName varchar(255) not null unique,
		abbreviateName varchar(255) not null,
		address varchar(255) not null,
		contactPhone varchar(18) not null unique
			check (contactPhone ~ '^\+7\([0-9]{3}\)[0-9]{3}-[0-9]{2}-[0-9]{2}$')
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_intermediaries on intermediaries (id);
	CREATE INDEX IF NOT EXISTS
		Index_fullName_intermediaries on intermediaries (fullName);
	CREATE INDEX IF NOT EXISTS
		Index_contactPhone_intermediaries on intermediaries (contactPhone);

	CREATE TABLE IF NOT EXISTS intermediariesDrivers (
		id serial not null
			constraint PK_intermediariesDrivers primary key,
		intermediarieID int not null
			references intermediaries (id)
			on update cascade on delete cascade,
		lastName varchar(50) not null,
		firstName varchar(50) not null,
		middleName varchar(50) default 'Нет данных',
		contactPhone varchar(18) not null unique
			check (contactPhone ~ '^\+7\([0-9]{3}\)[0-9]{3}-[0-9]{2}-[0-9]{2}$'),
		carID int not null
			references cars (id)
			on update cascade on delete cascade
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_intermediariesDrivers on intermediariesDrivers (id);
	CREATE INDEX IF NOT EXISTS
		Index_contactPhone_intermediariesDrivers on intermediariesDrivers (contactPhone);

	CREATE TABLE IF NOT EXISTS intermediariesAgreements (
		id serial not null
			constraint PK_intermediariesAgreements primary key,
		number varchar(20) not null unique
			check (number ~ '^ДОП\/[0-9]{2}-[0-9]{10}$'),
		created_at timestamp default current_timestamp,
		intermediarieID int not null
			references intermediaries (id)
			on update cascade on delete cascade,
		companyEmployeeID int not null
			references companyEmployees (id)
			on update cascade on delete cascade,
		status varchar(20) not null
			check (status in ('Открыт', 'Закрыт', 'Приостановлен'))
	);

	CREATE INDEX IF NOT EXISTS
		Index_id_intermediariesAgreements on intermediariesAgreements (id);
	CREATE INDEX IF NOT EXISTS
		Index_number_intermediariesAgreements on intermediariesAgreements (number);

	GRANT SELECT, INSERT, UPDATE, DELETE ON customers TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON agreements TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON employeesCredentials TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON companyEmployees TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON customersEmployees TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON cars TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON intermediaries TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON intermediariesDrivers TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON intermediariesAgreements TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE cars_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE intermediaries_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE intermediariesDrivers_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE intermediariesAgreements_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE customers_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE agreements_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE employeescredentials_code_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE companyemployees_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE customersemployees_id_seq TO rl_administrator;
	
	GRANT SELECT, INSERT, UPDATE ON applications TO rl_customer;
	GRANT SELECT, INSERT, UPDATE, DELETE ON equipment TO rl_customer;
	GRANT SELECT, INSERT, UPDATE, DELETE ON components TO rl_customer;
	GRANT USAGE, SELECT ON SEQUENCE applications_id_seq TO rl_customer;
	GRANT USAGE, SELECT ON SEQUENCE equipment_code_seq TO rl_customer;
	GRANT USAGE, SELECT ON SEQUENCE components_code_seq TO rl_customer;

	GRANT SELECT ON customers TO rl_distributor;
	GRANT SELECT ON agreements TO rl_distributor;
	GRANT SELECT, UPDATE, DELETE ON applications TO rl_distributor;
	GRANT SELECT ON companyEmployees TO rl_distributor;
	GRANT SELECT ON customersEmployees TO rl_distributor;
	GRANT USAGE, SELECT ON SEQUENCE customers_id_seq TO rl_distributor;
	GRANT USAGE, SELECT ON SEQUENCE agreements_id_seq TO rl_distributor;
	GRANT USAGE, SELECT ON SEQUENCE applications_id_seq TO rl_distributor;
	GRANT USAGE, SELECT ON SEQUENCE companyemployees_id_seq TO rl_distributor;
	GRANT USAGE, SELECT ON SEQUENCE customersemployees_id_seq TO rl_distributor;

	GRANT SELECT, UPDATE, DELETE ON applications TO rl_executor;
	GRANT SELECT, INSERT, UPDATE, DELETE ON tasks TO rl_executor;
	GRANT SELECT, INSERT, UPDATE, DELETE ON subTasks TO rl_executor;
	GRANT SELECT ON customersEmployees TO rl_executor;
	GRANT USAGE, SELECT ON SEQUENCE applications_id_seq TO rl_executor;
	GRANT USAGE, SELECT ON SEQUENCE tasks_id_seq TO rl_executor;
	GRANT USAGE, SELECT ON SEQUENCE subtasks_id_seq TO rl_executor;
	GRANT USAGE, SELECT ON SEQUENCE customersemployees_id_seq TO rl_executor;
$$;

CALL createStructure();