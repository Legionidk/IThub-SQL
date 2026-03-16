

CREATE OR REPLACE PROCEDURE loadSampleEmployee()
LANGUAGE SQL
AS $$
	insert into equipment (type, model, brand) values
	('Ноутбук', 'RT-1000', 'Asus'),
	('Принтер', 'HP-WV123', null),
	('Сканер', 'SH-200', 'Samsung'),
	('Ноутбук', 'LVT-14000', 'Lenovo'),
	('МФУ', '75-AR-200', 'Xerox');

	-- insert into employeescredentials (login, password) values
	-- ('clt_User_1', 'PaSSw0rd'),
	-- ('clt_User_2', 'PaSSw0rd'),
	-- ('clt_User_3', 'PaSSw0rd'),
	-- ('clt_User_4', 'PaSSw0rd'),
	-- ('clt_User_5', 'PaSSw0rd'),
	-- ('clt_User_6', 'PaSSw0rd'),
	-- ('clt_User_7', 'PaSSw0rd'),
	-- ('clt_User_8', 'PaSSw0rd'),
	-- ('clt_User_9', 'PaSSw0rd'),
	-- ('clt_User_10', 'PaSSw0rd'),
	-- ('User_01', 'PaSSw0rd'),
	-- ('User_02', 'PaSSw0rd'),
	-- ('User_03', 'PaSSw0rd'),
	-- ('User_04', 'PaSSw0rd');

	-- insert into customersemployees (employeescode, name, lastname, middlename) values
	-- (1, 'Георгий', 'Владимиров', 'Алексеевич'),
	-- (2, 'Иван', 'Павлов', null),
	-- (3, 'Егор', 'Дмитриев', 'Алексеевич'),
	-- (4, 'Пётр', 'Иванов', 'Андреевич'),
	-- (5, 'Роман', 'Семёнов', 'Алексеевич'),
	-- (6, 'Андрей', 'Смирнов', 'Павлович'),
	-- (7, 'Олег', 'Петров', 'Геннадьевич'),
	-- (8, 'Кирилл', 'Андреев', 'Николаевич'),
	-- (9, 'Иван', 'Романов', 'Олегович'),
	-- (10, 'Дмитрий', 'Кириллов', 'Дмитриевич');

	-- insert into companyemployees (employeescode, name, lastname, middlename) values
	-- (11, 'Иван', 'Иванов', 'Иванович'),
	-- (12, 'Пётр', 'Петров', 'Петрович'),
	-- (13, 'Алексей', 'Алексеев', 'Алексеевич'),
	-- (14, 'Андрей', 'Андреев', 'Андреевич');
$$;

CALL loadSampleEmployee();