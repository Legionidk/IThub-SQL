

CREATE OR REPLACE PROCEDURE loadSampleEmployee()
LANGUAGE SQL
AS $$
	-- insert into equipment (type, model, brand) values
	-- ('Ноутбук', 'RT-1000', 'Asus'),
	-- ('Принтер', 'HP-WV123', 'HP'),
	-- ('Сканер', 'SH-200', 'Samsung'),
	-- ('Ноутбук', 'LVT-14000', 'Lenovo'),
	-- ('МФУ', '75-AR-200', 'Xerox');

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

	insert into customersemployees (employeescode, name, lastname, middlename) values
	(1, 'Георгий', 'Владимиров', 'Алексеевич'),
	(2, 'Георгий', 'Владимиров', 'Алексеевич'),
	(3, 'Георгий', 'Владимиров', 'Алексеевич'),
	(4, 'Георгий', 'Владимиров', 'Алексеевич'),
	(5, 'Георгий', 'Владимиров', 'Алексеевич'),
	(6, 'Георгий', 'Владимиров', 'Алексеевич'),
	(7, 'Георгий', 'Владимиров', 'Алексеевич'),
	(8, 'Георгий', 'Владимиров', 'Алексеевич'),
	(9, 'Георгий', 'Владимиров', 'Алексеевич'),
	(10, 'Георгий', 'Владимиров', 'Алексеевич');
$$;

CALL loadSampleEmployee();