# Expt 02: Create Complex Data Types and Perform SQL Operations

## Objective
Create Oracle object types and nested table types, then perform full CRUD + query operations.

## Complete SQL Script
```sql
-- Drop old objects (ignore errors if first run)
DROP TABLE student_obj;
DROP TYPE phone_list_t;
DROP TYPE address_t;

-- 1) Create object and collection types
CREATE OR REPLACE TYPE address_t AS OBJECT (
  street VARCHAR2(60),
  city   VARCHAR2(30),
  pin    NUMBER(6)
);
/

CREATE OR REPLACE TYPE phone_list_t AS TABLE OF VARCHAR2(15);
/

-- 2) Create table with complex columns
CREATE TABLE student_obj (
  roll_no NUMBER PRIMARY KEY,
  name    VARCHAR2(40),
  addr    address_t,
  phones  phone_list_t
)
NESTED TABLE phones STORE AS student_phones_nt;

-- 3) Insert sample rows
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

INSERT INTO student_obj VALUES (
  104,
  'Neha',
  address_t('Ring Rd', 'Hyderabad', 500001),
  phone_list_t('9876500030')
);
COMMIT;

-- 4) Read queries
SELECT s.roll_no, s.name, s.addr.street, s.addr.city, s.addr.pin
FROM student_obj s
ORDER BY s.roll_no;

SELECT s.roll_no, s.name, p.COLUMN_VALUE AS phone
FROM student_obj s, TABLE(s.phones) p
ORDER BY s.roll_no;

-- 5) Update queries
UPDATE student_obj s
SET s.addr = address_t('Brigade Rd', 'Bengaluru', 560025)
WHERE s.roll_no = 101;

UPDATE TABLE(
  SELECT s.phones FROM student_obj s WHERE s.roll_no = 104
) p
SET COLUMN_VALUE = '9999900030'
WHERE COLUMN_VALUE = '9876500030';
COMMIT;

-- 6) Delete query
DELETE FROM student_obj WHERE roll_no = 102;
COMMIT;

-- 7) Final output
SELECT s.roll_no, s.name, s.addr.city FROM student_obj s ORDER BY s.roll_no;
```
