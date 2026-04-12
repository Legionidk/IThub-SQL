create or replace procedure clearAllTables()
language sql
as $$
	delete from components;
	delete from subtasks;
	delete from tasks;
	delete from applications;
	delete from agreements;
	delete from customers;
	delete from intermediariesagreements;
	delete from intermediariesdrivers;
	delete from companyemployees;
	delete from customersemployees;
	delete from employeescredentials;
	delete from equipment;
	delete from intermediaries;
	delete from cars;

	alter sequence components_code_seq restart with 1;
	alter sequence subtasks_id_seq restart with 1;
	alter sequence tasks_id_seq restart with 1;
	alter sequence applications_id_seq restart with 1;
	alter sequence agreements_id_seq restart with 1;
	alter sequence customers_id_seq restart with 1;
	alter sequence intermediariesagreements_id_seq restart with 1;
	alter sequence intermediariesdrivers_id_seq restart with 1;
	alter sequence companyemployees_id_seq restart with 1;
	alter sequence customersemployees_id_seq restart with 1;
	alter sequence employeescredentials_code_seq restart with 1;
	alter sequence equipment_code_seq restart with 1;
	alter sequence intermediaries_id_seq restart with 1;
	alter sequence cars_id_seq restart with 1;
$$;

call clearAllTables();