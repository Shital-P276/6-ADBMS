# Expt 03: Implement the Inheritance Concept in OODBMS (Oracle)

## Objective
Use Oracle object type inheritance (`UNDER`) and run complete create/insert/read/update/delete flow.

## Complete SQL Script
```sql
-- Cleanup old objects (run individually if needed)
DROP TABLE person_store;
DROP TYPE student_t;
DROP TYPE person_t;

-- 1) Base type
CREATE OR REPLACE TYPE person_t AS OBJECT (
  pid   NUMBER,
  pname VARCHAR2(40)
) NOT FINAL;
/

-- 2) Derived type
CREATE OR REPLACE TYPE student_t UNDER person_t (
  branch VARCHAR2(20),
  sem    NUMBER
);
/

-- 3) Object table from base type
CREATE TABLE person_store OF person_t;

-- 4) Insert rows (base + child type)
INSERT INTO person_store VALUES (person_t(1, 'Nikhil'));
INSERT INTO person_store VALUES (student_t(2, 'Sana', 'CSE', 4));
INSERT INTO person_store VALUES (student_t(3, 'Rohit', 'IT', 6));
INSERT INTO person_store VALUES (student_t(4, 'Anu', 'ECE', 2));
COMMIT;

-- 5) Read all
SELECT VALUE(p) FROM person_store p;

-- 6) Read only inherited student objects
SELECT TREAT(VALUE(p) AS student_t).pid    AS pid,
       TREAT(VALUE(p) AS student_t).pname  AS pname,
       TREAT(VALUE(p) AS student_t).branch AS branch,
       TREAT(VALUE(p) AS student_t).sem    AS sem
FROM person_store p
WHERE VALUE(p) IS OF (ONLY student_t)
ORDER BY 1;

-- 7) Update child object attribute
UPDATE person_store p
SET VALUE(p) = student_t(2, 'Sana', 'AIML', 5)
WHERE VALUE(p) IS OF (ONLY student_t)
  AND TREAT(VALUE(p) AS student_t).pid = 2;
COMMIT;

-- 8) Delete one row
DELETE FROM person_store p
WHERE VALUE(p) IS OF (ONLY student_t)
  AND TREAT(VALUE(p) AS student_t).pid = 4;
COMMIT;

-- 9) Final check
SELECT VALUE(p) FROM person_store p;
```
