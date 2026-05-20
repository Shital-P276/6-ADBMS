# Expt 09: CRUD on Column Family Database using Cassandra Query Language

## Objective
Perform CRUD operations in Cassandra using CQL.

## Keyspace and Table Creation
```sql
CREATE KEYSPACE adbms
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE adbms;

CREATE TABLE student_cf (
  roll int PRIMARY KEY,
  name text,
  dept text,
  cgpa float
);
```

## Sample Data + CRUD
```sql
INSERT INTO student_cf (roll, name, dept, cgpa) VALUES (1, 'Asha', 'CSE', 8.4);
INSERT INTO student_cf (roll, name, dept, cgpa) VALUES (2, 'Ravi', 'ECE', 7.8);
INSERT INTO student_cf (roll, name, dept, cgpa) VALUES (3, 'Ira', 'IT', 8.9);

SELECT * FROM student_cf;

UPDATE student_cf SET cgpa = 8.0 WHERE roll = 2;

DELETE FROM student_cf WHERE roll = 3;
```
