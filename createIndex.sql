CREATE OR REPLACE PROCEDURE createIndexes()
LANGUAGE SQL
AS $$
	CREATE INDEX IF NOT EXISTS
		Index_OKPO_customers on customers (okpo);
	CREATE INDEX IF NOT EXISTS
		Index_contactPhone_customers on customers (contactphone);

	CREATE INDEX IF NOT EXISTS
		Index_id_agreements on agreements (id);
	CREATE INDEX IF NOT EXISTS
		Index_customerOKPO_agreements on agreements (customerokpo);

	CREATE INDEX IF NOT EXISTS
		Index_number_applications on applications (number);
	CREATE INDEX IF NOT EXISTS
		Index_agreementId_applications on applications (agreementid);
	CREATE INDEX IF NOT EXISTS
		Index_applicantCode_applications on applications (applicantcode);

	CREATE INDEX IF NOT EXISTS
		Index_id_tasks on tasks (id);
	CREATE INDEX IF NOT EXISTS
		Index_workerCode_tasks on tasks (workercode);
	CREATE INDEX IF NOT EXISTS
		Index_equipmentCode_tasks on tasks (equipmentcode);

	CREATE INDEX IF NOT EXISTS
		Index_id_subTasks on subTasks (id);
	CREATE INDEX IF NOT EXISTS
		Index_taskId_subTasks on subTasks (taskid);

	CREATE INDEX IF NOT EXISTS
		Index_code_equipment on equipment (code);

	CREATE INDEX IF NOT EXISTS
		Index_code_components on components (code);
	CREATE INDEX IF NOT EXISTS
		Index_equipmentCode_components on components (equipmentcode);

	CREATE INDEX IF NOT EXISTS
		Index_code_employeesCredentials on employeesCredentials (code);
	CREATE INDEX IF NOT EXISTS
		Index_login_employeesCredentials on employeesCredentials (login);

	CREATE INDEX IF NOT EXISTS
		Index_id_companyEmployees on companyEmployees (id);
	CREATE INDEX IF NOT EXISTS
		Index_employeesCode_companyEmployees on companyEmployees (employeesCode);

	CREATE INDEX IF NOT EXISTS
		Index_id_customersEmployees on customersEmployees (id);
	CREATE INDEX IF NOT EXISTS
		Index_employeesCode_customersEmployees on customersEmployees (employeesCode);
$$;

CALL createIndexes()