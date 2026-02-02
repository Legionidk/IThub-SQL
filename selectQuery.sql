select * from pg_roles 
where rolname in ('adminrole', 'customerrole', 'distributorrole', 'performerrole');
