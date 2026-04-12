-- Данные команды будут также внесены в createStructure, чтобы было удобнее в будущем
-- Поэтому вызывать создание таблиц можно прямо из createStructure, а не отсюда. Данная процедура только по требованию LXP
CREATE OR REPLACE PROCEDURE createAdditionalTables()
LANGUAGE SQL
AS $$
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

	GRANT SELECT, INSERT, UPDATE, DELETE ON cars TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON intermediaries TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON intermediariesDrivers TO rl_administrator;
	GRANT SELECT, INSERT, UPDATE, DELETE ON intermediariesAgreements TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE cars_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE intermediaries_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE intermediariesDrivers_id_seq TO rl_administrator;
	GRANT USAGE, SELECT ON SEQUENCE intermediariesAgreements_id_seq TO rl_administrator;

	-- Как будто для других ролей никакие доступы тут не нужны вообще. Возможно нам нужна новая роль для посредников, а может и не нужна
$$;

CALL createAdditionalTables();