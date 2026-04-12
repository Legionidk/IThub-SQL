CREATE OR REPLACE PROCEDURE add_customer (
	p_okpo varchar,
	p_contactphone varchar,
	p_physicaladdress varchar,
	p_legaladdress varchar,
	p_fullname varchar,
	p_abbreviatename varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
	if exists (select 1 from customers where okpo = p_okpo) then
		raise exception 'Указанное ОКПО уже есть в базе данных!';
	end if;

	insert into customers (okpo, contactphone, physicaladdress, legaladdress, fullname, abbreviatename)
	values (p_okpo, p_contactphone, p_physicaladdress, p_legaladdress, p_fullname, p_abbreviatename);
END;
$$;

call add_customer('6683972257', 'test', 'test', 'test', 'test', 'test');