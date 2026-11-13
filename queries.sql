-- Clinic Database: queries
-- Open the database first:  sqlite3 clinic.db
-- Then run this file with:  .read queries.sql

PRAGMA foreign_keys = ON;   -- enforce the links between tables
.mode box

-- 1. Show all patients
SELECT * FROM patients;

-- 2. Show all doctors
SELECT * FROM doctors;

-- 3. Show all appointments (patients and doctors appear as ID numbers)
SELECT * FROM appointments;

-- 4. Show appointments with patient and doctor names instead of ID numbers
SELECT appointments.appointment_date,
       patients.first_name,
       doctors.last_name,
       appointments.reason,
       appointments.status
FROM appointments
JOIN patients ON patients.patient_id = appointments.patient_id
JOIN doctors  ON doctors.doctor_id   = appointments.doctor_id;

-- 5. Show what each prescription cost (quantity x unit price, in rand)
SELECT patients.first_name,
       medications.name,
       prescriptions.quantity,
       prescriptions.quantity * medications.unit_price AS cost_rand
FROM prescriptions
JOIN appointments ON appointments.appointment_id = prescriptions.appointment_id
JOIN patients     ON patients.patient_id         = appointments.patient_id
JOIN medications  ON medications.medication_id   = prescriptions.medication_id;

-- 6. Mark an appointment as completed
UPDATE appointments SET status = 'Completed' WHERE appointment_id = 3;

-- 7. Integrity test: this must FAIL with "FOREIGN KEY constraint failed"
--    because patient 99 does not exist. Remove the two dashes to try it.
-- INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, reason)
-- VALUES (99, 1, '2026-12-01', '09:00', 'Test');
