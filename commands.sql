alter table appointments alter column patient_id set not null;
alter table appointments alter column doctor_id set not null;
alter table appointments alter column department_id set not null;
alter table hospital_stays alter column patient_id set not null;
alter table hospital_stays alter column attending_doctor_id set not null;
alter table lab_tests alter column appointment_id set not null;
alter table medical_records alter column patient_id set not null;
alter table medical_records alter column doctor_id set not null;
alter table payments alter column patient_id set not null;
alter table payments alter column appointment_id set not null;
alter table prescriptions alter column appointment_id set not null;
alter table staff_schedule alter column doctor_id set not null;

alter table payments add constraint chk_payment_amount check (amount > 0);

select * from hospital_stays where discharge_date < admit_date;
update hospital_stays set discharge_date = admit_date + INTERVAL '3 days' where discharge_date < admit_date;
alter table hospital_stays add constraint chk_hospital_dates check (discharge_date is null or discharge_date >= admit_date);

alter table staff_schedule add constraint chk_schedule_time check (end_time > start_time);

create index idx_appointments_patient_id on appointments(patient_id);
create index idx_appointments_doctor_id on appointments(doctor_id);
create index idx_appointments_department_id on appointments(department_id);
create index idx_payments_patient_id on payments(patient_id);
create index idx_medical_records_patient_id on medical_records(patient_id);
create index idx_staff_schedule_doctor_id on staff_schedule(doctor_id);
create index idx_staff_schedule_work_date on staff_schedule(work_date);
create index idx_hospital_stays_patient_id on hospital_stays(patient_id);

create or replace function prevent_schedule_overlap()
returns trigger as $$
begin
	if exists (
		select 1
		from staff_schedule
		where doctor_id = NEW.doctor_id
		and work_date = NEW.work_date
		and id <> NEW.id
		and start_time < NEW.end_time
		and NEW.start_time < end_time
	) then
		raise exception 'Смены не могут пересекаться с друг другом';
	end if;
	return NEW;
end;
$$ language plpgsql;

create trigger trg_prevent_schedule_overlap
before insert or update
on staff_schedule
for each row
execute function prevent_schedule_overlap();

create or replace view monthly_revenue as
select
	date_trunc('month', payment_date::timestamp with time zone) as month,
	SUM(amount) as total_revenue
from payments
where LOWER(status) = 'paid'
group by
	date_trunc('month', payment_date::timestamp with time zone);

create or replace procedure cancel_appointment(in p_appointment_id integer)
language plpgsql
as $$
begin
	update appointments
	set status = 'cancelled'
	where id = p_appointment_id;
	if not found then
		raise exception 'Запись не найдена';
	end if;
end;
$$;

