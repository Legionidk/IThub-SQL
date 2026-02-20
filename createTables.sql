CREATE OR REPLACE PROCEDURE createTables()
LANGUAGE SQL
AS $$
	CREATE TABLE IF NOT EXISTS employeesCredentials (
		code SERIAL not null
			constraint PK_employeesCredentials primary key,
		login varchar(36) not null unique,
		password varchar(36) not null
	);
	
	CREATE TABLE IF NOT EXISTS companyEmployees (
		id SERIAL not null
			constraint PK_companyEmployees primary key,
		employeesCode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		name varchar(36) not null,
		lastName varchar(36) not null,
		middleName varchar(36) not null
	);
	
	CREATE TABLE IF NOT EXISTS customersEmployees (
		id SERIAL not null
			constraint PK_customersEmployees primary key,
		employeesCode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		name varchar(36) not null,
		lastName varchar(36) not null,
		middleName varchar(36) not null
	);
	
	CREATE TABLE IF NOT EXISTS customers (
		OKPO SERIAL not null
			constraint PK_customers primary key,
		contactPhone varchar(11) not null unique,
		physicalAddress varchar(255) not null,
		legalAddress varchar(255) not null,
		fullName varchar(255) not null,
		abbreviateName varchar(255) not null
	);
	
	CREATE TABLE IF NOT EXISTS agreements (
		id SERIAL not null
			constraint PK_agreements primary key,
		customerOKPO int not null
			references customers (OKPO)
			on update cascade on delete cascade,
		expiration date,
		status varchar(10) not null
	);
	
	CREATE TABLE IF NOT EXISTS applications (
		number SERIAL not null
			constraint PK_applications primary key,
		agreementId int not null
			references agreements (id)
			on update cascade on delete cascade,
		applicantcode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		expiration date not null
	);
	
	CREATE TABLE IF NOT EXISTS equipment (
		code SERIAL not null
			constraint PK_equipment primary key,
		type varchar(36) not null,
		model varchar(36) not null,
		brand varchar(36)
	);
	
	CREATE TABLE IF NOT EXISTS components (
		code SERIAL not null
			constraint PK_components primary key,
		equipmentCode int not null
			references equipment (code)
			on update cascade on delete cascade,
		type varchar(36) not null,
		name varchar(36) not null
	);
	
	CREATE TABLE IF NOT EXISTS tasks (
		id SERIAL not null
			constraint PK_tasks primary key,
		workerCode int not null
			references employeesCredentials (code)
			on update cascade on delete cascade,
		equipmentCode int not null
			references equipment (code)
			on update cascade on delete cascade,
		description varchar(255) not null,
		deadline date not null
	);
	
	CREATE TABLE IF NOT EXISTS subtasks (
		id SERIAL not null
			constraint PK_subtasks primary key,
		taskId int not null
			references tasks (id)
			on update cascade on delete cascade,
		description varchar(255) not null
	);
$$;

CALL createTables();