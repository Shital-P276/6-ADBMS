# Expt 09: Perform CRUD on Column Family Database using Cassandra Query Language

## Objective
Create keyspace + column-family table and run full CRUD commands using CQL.

## Complete CQL Script
```sql
-- 1) Keyspace
CREATE KEYSPACE IF NOT EXISTS adbms
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- 2) Use keyspace
USE adbms;

-- 3) Table
CREATE TABLE IF NOT EXISTS student_cf (
  roll int PRIMARY KEY,
  name text,
  dept text,
  cgpa float
);

-- 4) Insert rows
INSERT INTO student_cf (roll, name, dept, cgpa) VALUES (1, 'Asha', 'CSE', 8.4);
INSERT INTO student_cf (roll, name, dept, cgpa) VALUES (2, 'Ravi', 'ECE', 7.8);
INSERT INTO student_cf (roll, name, dept, cgpa) VALUES (3, 'Ira', 'IT', 8.9);
INSERT INTO student_cf (roll, name, dept, cgpa) VALUES (4, 'Neha', 'MECH', 7.2);

-- 5) Read
SELECT * FROM student_cf;
SELECT * FROM student_cf WHERE roll = 2;

-- 6) Update
UPDATE student_cf SET cgpa = 8.0, dept = 'AIML' WHERE roll = 2;

-- 7) Delete
DELETE FROM student_cf WHERE roll = 4;

-- 8) Final read
SELECT * FROM student_cf;
```

## Useful execution command
```bash
cqlsh -f expt09.cql
```
