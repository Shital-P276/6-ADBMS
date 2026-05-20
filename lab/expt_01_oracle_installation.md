# Expt 01: Installation of Oracle Database and Oracle SQL Developer

## Objective
Install Oracle Database and Oracle SQL Developer, then verify connectivity.

## Software
- Oracle Database (XE or Enterprise)
- Oracle SQL Developer

## Installation Steps
1. Install Oracle Database.
2. Create or unlock a sample user (for example `LAB_USER`).
3. Install Oracle SQL Developer.
4. Open SQL Developer and create a new connection.

## Verification Commands (SQL)
```sql
-- Check database name and open mode
SELECT name, open_mode FROM v$database;

-- Check current user
SELECT USER FROM dual;
```

## Sample Setup
```sql
CREATE TABLE dept_demo (
  dept_id NUMBER PRIMARY KEY,
  dept_name VARCHAR2(50)
);

INSERT INTO dept_demo VALUES (10, 'CSE');
INSERT INTO dept_demo VALUES (20, 'ECE');
INSERT INTO dept_demo VALUES (30, 'MECH');
COMMIT;

SELECT * FROM dept_demo;
```
