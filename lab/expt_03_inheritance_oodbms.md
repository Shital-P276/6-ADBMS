# Expt 03: Implement Inheritance Concept in OODBMS (Oracle Object Types)

## Objective
Demonstrate inheritance using `UNDER` in Oracle object types.

## Type and Table Creation
```sql
CREATE OR REPLACE TYPE person_t AS OBJECT (
  pid   NUMBER,
  pname VARCHAR2(40)
) NOT FINAL;
/

CREATE OR REPLACE TYPE student_t UNDER person_t (
  branch VARCHAR2(20),
  sem    NUMBER
);
/

CREATE TABLE person_store OF person_t;
```

## Sample Data
```sql
INSERT INTO person_store VALUES (person_t(1, 'Nikhil'));
INSERT INTO person_store VALUES (student_t(2, 'Sana', 'CSE', 4));
INSERT INTO person_store VALUES (student_t(3, 'Rohit', 'IT', 6));
```

## Queries
```sql
-- All objects
SELECT VALUE(p) FROM person_store p;

-- Only inherited student objects
SELECT TREAT(VALUE(p) AS student_t).pid    AS pid,
       TREAT(VALUE(p) AS student_t).pname  AS pname,
       TREAT(VALUE(p) AS student_t).branch AS branch,
       TREAT(VALUE(p) AS student_t).sem    AS sem
FROM person_store p
WHERE VALUE(p) IS OF (ONLY student_t);
```
