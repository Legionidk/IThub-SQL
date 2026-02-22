CREATE OR REPLACE PROCEDURE createRoles()
LANGUAGE SQL
AS $$
	CREATE ROLE rl_administrator;
	CREATE ROLE rl_customer;
	CREATE ROLE rl_distributor;
	CREATE ROLE rl_executor;
$$;

CALL createRoles();