PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE patients (
   patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
date_of_birth TEXT NOT NULL,
phone TEXT NOT NULL UNIQUE,
email TEXT
);
INSERT INTO patients VALUES(1,'Thabo','Mokoena','1990-04-12','071 555 0101','thabo@example.com'),
  (2,'Lerato','Dlamini','1985-09-30','072 555 0102','lerato@example.com'),
  (3,'Sipho','Nkosi','2001-01-22','073 555 0103',NULL);
CREATE TABLE doctors (
doctor_id INTEGER PRIMARY KEY AUTOINCREMENT,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
specialty TEXT NOT NULL,
phone TEXT NOT NULL UNIQUE
);
INSERT INTO doctors VALUES(1,'Nomsa','Zulu','General Practitioner','011 555 0201'),
  (2,'Ayesha','Naidoo','Dentist','011 555 0203');
CREATE TABLE appointments (
appointment_id INTEGER PRIMARY KEY AUTOINCREMENT,
patient_id INTEGER NOT NULL,
doctor_id INTEGER NOT NULL,
appointment_date TEXT NOT NULL,
appointment_time TEXT NOT NULL,
reason TEXT NOT NULL,
status TEXT NOT NULL DEFAULT 'Booked',
FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id)
);
INSERT INTO appointments VALUES(1,1,1,'2026-11-02','09:00','Flu symptoms','Completed'),
  (2,2,2,'2026-11-02','10:30','Toothache','Completed'),
  (3,1,1,'2026-11-16','09:30','Follow-up','Completed');
CREATE TABLE medications (
medication_id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL UNIQUE,
unit_price REAL NOT NULL
);
INSERT INTO medications VALUES(1,'Paracetamol 500mg',2.5),
  (2,'Amoxicillin 250mg',6),
  (3,'Cough Syrup 100ml',45);
CREATE TABLE prescriptions (
prescription_id INTEGER PRIMARY KEY AUTOINCREMENT,
appointment_id INTEGER NOT NULL,
medication_id INTEGER NOT NULL,
dosage TEXT NOT NULL,
quantity INTEGER NOT NULL,
FOREIGN KEY (appointment_id) REFERENCES appointments (appointment_id),
FOREIGN KEY (medication_id) REFERENCES medications (medication_id)
);
INSERT INTO prescriptions VALUES(1,1,1,'2 tablets every 6 hours',20),
  (2,1,3,'10ml three times a day',1),
  (3,2,2,'1 capsule every 8 hours',15);
PRAGMA writable_schema=ON;
CREATE TABLE IF NOT EXISTS sqlite_sequence(name,seq);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('patients',3),
  ('doctors',2),
  ('appointments',3),
  ('medications',3),
  ('prescriptions',3);
PRAGMA writable_schema=OFF;
COMMIT;
