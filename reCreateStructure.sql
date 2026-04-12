CREATE OR REPLACE PROCEDURE reCreateStructure()
LANGUAGE SQL
AS $$
	REVOKE SELECT, INSERT, UPDATE, DELETE ON customers FROM rl_administrator;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON agreements FROM rl_administrator;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON employeesCredentials FROM rl_administrator;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON companyEmployees FROM rl_administrator;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON customersEmployees FROM rl_administrator;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON cars FROM rl_administrator;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON intermediaries FROM rl_administrator;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON intermediariesDrivers FROM rl_administrator;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON intermediariesAgreements FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE cars_id_seq FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE intermediaries_id_seq FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE intermediariesDrivers_id_seq FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE intermediariesAgreements_id_seq FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE customers_id_seq FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE agreements_id_seq FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE employeescredentials_code_seq FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE companyemployees_id_seq FROM rl_administrator;
	REVOKE USAGE, SELECT ON SEQUENCE customersemployees_id_seq FROM rl_administrator;
	
	REVOKE SELECT, INSERT, UPDATE ON applications FROM rl_customer;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON equipment FROM rl_customer;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON components FROM rl_customer;
	REVOKE USAGE, SELECT ON SEQUENCE applications_id_seq FROM rl_customer;
	REVOKE USAGE, SELECT ON SEQUENCE equipment_code_seq FROM rl_customer;
	REVOKE USAGE, SELECT ON SEQUENCE components_code_seq FROM rl_customer;

	REVOKE SELECT ON customers FROM rl_distributor;
	REVOKE SELECT ON agreements FROM rl_distributor;
	REVOKE SELECT, UPDATE, DELETE ON applications FROM rl_distributor;
	REVOKE SELECT ON companyEmployees FROM rl_distributor;
	REVOKE SELECT ON customersEmployees FROM rl_distributor;
	REVOKE USAGE, SELECT ON SEQUENCE customers_id_seq FROM rl_distributor;
	REVOKE USAGE, SELECT ON SEQUENCE agreements_id_seq FROM rl_distributor;
	REVOKE USAGE, SELECT ON SEQUENCE applications_id_seq FROM rl_distributor;
	REVOKE USAGE, SELECT ON SEQUENCE companyemployees_id_seq FROM rl_distributor;
	REVOKE USAGE, SELECT ON SEQUENCE customersemployees_id_seq FROM rl_distributor;

	REVOKE SELECT, UPDATE, DELETE ON applications FROM rl_executor;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON tasks FROM rl_executor;
	REVOKE SELECT, INSERT, UPDATE, DELETE ON subTasks FROM rl_executor;
	REVOKE SELECT ON customersEmployees FROM rl_executor;
	REVOKE USAGE, SELECT ON SEQUENCE applications_id_seq FROM rl_executor;
	REVOKE USAGE, SELECT ON SEQUENCE tasks_id_seq FROM rl_executor;
	REVOKE USAGE, SELECT ON SEQUENCE subtasks_id_seq FROM rl_executor;
	REVOKE USAGE, SELECT ON SEQUENCE customersemployees_id_seq FROM rl_executor;

	DROP INDEX IF EXISTS Index_id_intermediariesAgreements;
	DROP INDEX IF EXISTS Index_number_intermediariesAgreements;
	DROP TABLE IF EXISTS intermediariesAgreements;

	DROP INDEX IF EXISTS Index_id_intermediariesDrivers;
	DROP INDEX IF EXISTS Index_contactPhone_intermediariesDrivers;
	DROP TABLE IF EXISTS intermediariesDrivers;

	DROP INDEX IF EXISTS Index_id_intermediaries;
	DROP INDEX IF EXISTS Index_fullName_intermediaries;
	DROP INDEX IF EXISTS Index_contactPhone_intermediaries;
	DROP TABLE IF EXISTS intermediaries;

	DROP INDEX IF EXISTS Index_id_cars;
	DROP INDEX IF EXISTS Index_number_cars;
	DROP TABLE IF EXISTS cars;
	
	DROP INDEX IF EXISTS Index_id_companyEmployees;
	DROP INDEX IF EXISTS Index_employeesCode_companyEmployees;
	DROP TABLE IF EXISTS companyEmployees;

	DROP INDEX IF EXISTS Index_id_customersEmployees;
	DROP INDEX IF EXISTS Index_employeesCode_customersEmployees;
	DROP TABLE IF EXISTS customersEmployees;

	DROP INDEX IF EXISTS Index_id_subTasks;
	DROP INDEX IF EXISTS Index_taskId_subTasks;
	DROP TABLE IF EXISTS subTasks;

	DROP INDEX IF EXISTS Index_id_tasks;
	DROP INDEX IF EXISTS Index_workerCode_tasks;
	DROP INDEX IF EXISTS Index_equipmentCode_tasks;
	DROP TABLE IF EXISTS tasks;

	DROP INDEX IF EXISTS Index_id_applications;
	DROP INDEX IF EXISTS Index_number_applications;
	DROP INDEX IF EXISTS Index_agreementId_applications;
	DROP INDEX IF EXISTS Index_applicantCode_applications;
	DROP TABLE IF EXISTS applications;

	DROP INDEX IF EXISTS Index_code_components;
	DROP INDEX IF EXISTS Index_equipmentCode_components;
	DROP TABLE IF EXISTS components;

	DROP INDEX IF EXISTS Index_code_equipment;
	DROP TABLE IF EXISTS equipment;

	DROP INDEX IF EXISTS Index_id_agreements;
	DROP INDEX IF EXISTS Index_agreementNumber_agreements;
	DROP INDEX IF EXISTS Index_customerId_agreements;
	DROP TABLE IF EXISTS agreements;

	DROP INDEX IF EXISTS Index_id_customers;
	DROP INDEX IF EXISTS Index_OKPO_customers;
	DROP INDEX IF EXISTS Index_contactPhone_customers;
	DROP TABLE IF EXISTS customers;

	DROP INDEX IF EXISTS Index_code_employeesCredentials;
	DROP INDEX IF EXISTS Index_login_employeesCredentials;
	DROP TABLE IF EXISTS employeesCredentials;

	CALL createStructure();
$$;

CALL reCreateStructure();