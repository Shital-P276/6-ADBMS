# Expt 01: Installation of Oracle Database and Oracle SQL Developer

## Objective
Install Oracle Database and Oracle SQL Developer, create a user, connect, and run verification SQL.

## Prerequisites
- Windows/Linux/macOS machine with admin/sudo access
- Oracle installer package (XE/Free/Enterprise)
- Oracle SQL Developer ZIP/installer

## Step-by-Step Installation and Setup Commands

### 1) Oracle Database Service Check
```bash
# Linux (service name can vary)
systemctl status oracle-xe || systemctl status oracle-free

# Start if not running
sudo systemctl start oracle-xe || sudo systemctl start oracle-free
```

### 2) Open SQL*Plus as SYSDBA
```bash
sqlplus / as sysdba
```

### 3) Create Lab User + Grant Privileges
```sql
-- Run in SQL*Plus as SYS user
CREATE USER lab_user IDENTIFIED BY lab123;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO lab_user;
GRANT UNLIMITED TABLESPACE TO lab_user;

-- Optional for object type labs
GRANT CREATE TYPE TO lab_user;
```

### 4) Connect as Lab User (SQL*Plus)
```sql
CONNECT lab_user/lab123;
```

### 5) SQL Developer Connection Details
- **Connection Name:** `ADBMS_LAB`
- **Username:** `lab_user`
- **Password:** `lab123`
- **Hostname:** `localhost`
- **Port:** `1521`
- **Service Name:** `XEPDB1` (or your configured PDB service)

## Verification Queries
```sql
SELECT name, open_mode FROM v$database;
SELECT USER FROM dual;
SHOW USER;
SELECT systimestamp FROM dual;
```

## Sample Table + CRUD (Copy Directly)
```sql
CREATE TABLE dept_demo (
  dept_id NUMBER PRIMARY KEY,
  dept_name VARCHAR2(50)
);

INSERT INTO dept_demo VALUES (10, 'CSE');
INSERT INTO dept_demo VALUES (20, 'ECE');
INSERT INTO dept_demo VALUES (30, 'MECH');
INSERT INTO dept_demo VALUES (40, 'CIVIL');
COMMIT;

SELECT * FROM dept_demo;

UPDATE dept_demo
SET dept_name = 'AI & DS'
WHERE dept_id = 10;
COMMIT;

DELETE FROM dept_demo
WHERE dept_id = 40;
COMMIT;

SELECT * FROM dept_demo ORDER BY dept_id;
```
