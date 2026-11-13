# Clinic Database

A small SQLite database for a clinic, built for Unit Standard 114048 (Create database access for a computer application using SQL).

It stores patients, doctors, appointments, medications and prescriptions.

## Files

| File | What it is |
|---|---|
| `clinic.db` | The database itself |
| `clinic.sql` | Every SQL statement needed to rebuild the database from scratch (tables and data) |
| `queries.sql` | The queries used to read, test and update the data |
| `screenshots/` | Photos of the queries running and their results |

## Tables

| Table | What it stores |
|---|---|
| `patients` | People who visit the clinic |
| `doctors` | Doctors who work at the clinic |
| `appointments` | One row per visit, linking a patient to a doctor |
| `medications` | Medicines the clinic prescribes, with a price in rand |
| `prescriptions` | Which medicine was given at which appointment |

## Relationships

- One patient can have many appointments
- One doctor can have many appointments
- One appointment can have many prescriptions
- One medication can appear in many prescriptions

These links are enforced with foreign keys. For example, an appointment cannot be created for a patient who does not exist.

## How to open the database

You need SQLite. On Windows, install it with:

```
winget install SQLite.SQLite
```

Then, in a terminal inside this folder:

```
sqlite3 clinic.db
```

Inside SQLite, run these to set up and look around:

```
PRAGMA foreign_keys = ON;
.mode box
.tables
SELECT * FROM patients;
```

Type `.quit` to leave.

## How to rebuild the database from scratch

```
sqlite3 new_clinic.db < clinic.sql
```

This creates a fresh database with the same tables and data.

## How to run the queries

Open the database, then either paste queries from `queries.sql` one at a time, or run the whole file:

```
.read queries.sql
```

## Testing done

| Test | Expected result | Actual result |
|---|---|---|
| Insert patients, doctors, appointments, medications and prescriptions | Rows are saved with automatic ID numbers | Passed |
| Insert an appointment without a status | Status defaults to `Booked` | Passed |
| Insert an appointment for patient 99 (does not exist) | Rejected | Passed: `FOREIGN KEY constraint failed` |
| Join appointments to patients and doctors | Names shown instead of ID numbers | Passed |
| Calculate prescription cost (quantity x unit price) | 50, 45 and 90 rand | Passed |
| Update appointment 3 to `Completed` | Only row 3 changes | Passed |

## Tools used

- SQLite 3.54
- Visual Studio Code
- Git and GitHub
