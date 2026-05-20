# Expt 02: Create Complex Data Types and Perform SQL Operations

## Objective
Use Oracle object types and nested table type, then run SQL operations.

## Table / Type Creation Syntax
```sql
CREATE OR REPLACE TYPE address_t AS OBJECT (
  street VARCHAR2(60),
  city   VARCHAR2(30),
  pin    NUMBER(6)
);
/

CREATE OR REPLACE TYPE phone_list_t AS TABLE OF VARCHAR2(15);
/

CREATE TABLE student_obj (
  roll_no NUMBER PRIMARY KEY,
  name    VARCHAR2(40),
  addr    address_t,
  phones  phone_list_t
)
NESTED TABLE phones STORE AS student_phones_nt;
```

## Sample Data
```sql
INSERT INTO student_obj VALUES (
  101,
  'Asha',
  address_t('MG Road', 'Bengaluru', 560001),
  phone_list_t('9876500001', '9876500002')
);

INSERT INTO student_obj VALUES (
  102,
  'Ravi',
  address_t('Nehru St', 'Chennai', 600001),
  phone_list_t('9876500010')
);

INSERT INTO student_obj VALUES (
  103,
  'Ira',
  address_t('Station Rd', 'Pune', 411001),
  phone_list_t('9876500020', '9876500021')
);
```

## Operations (CRUD + Queries)
```sql
-- Read
SELECT s.roll_no, s.name, s.addr.city FROM student_obj s;

-- Update
UPDATE student_obj s
SET s.addr = address_t('Brigade Rd', 'Bengaluru', 560025)
WHERE s.roll_no = 101;

-- Delete
DELETE FROM student_obj WHERE roll_no = 102;

-- Flatten nested table
SELECT s.roll_no, s.name, p.COLUMN_VALUE AS phone
FROM student_obj s, TABLE(s.phones) p;
```
