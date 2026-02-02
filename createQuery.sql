create role adminRole with password 'C00lbo1';
alter role adminRole LOGIN;
grant connect on database "support_db" to adminRole;

create role customerRole with password 'C00lbo1';
alter role customerRole LOGIN;
grant connect on database "support_db" to customerRole;

create role distributorRole with password 'C00lbo1';
alter role distributorRole LOGIN;
grant connect on database "support_db" to distributorRole;


create role performerRole with password 'C00lbo1';
alter role performerRole LOGIN;
grant connect on database "support_db" to performerRole;
