-- Create base table
CREATE TABLE Employee_Master (
    eid NUMBER(5) PRIMARY KEY,
    ename VARCHAR2(20),
    dept VARCHAR2(10),
    city VARCHAR2(15),
    salary NUMBER(10,2)
);

-- Insert dummy data
INSERT INTO Employee_Master VALUES (101, 'Amit', 'IT', 'Mumbai', 90000);
INSERT INTO Employee_Master VALUES (102, 'Sita', 'HR', 'Pune', 75000);
INSERT INTO Employee_Master VALUES (103, 'Rahul', 'IT', 'Bangalore', 95000);
INSERT INTO Employee_Master VALUES (104, 'Priya', 'Sales', 'Mumbai', 60000);
INSERT INTO Employee_Master VALUES (105, 'Vikas', 'HR', 'Delhi', 72000);
COMMIT;

-- Horizontal Fragmentation
-- Fragment 1: IT Department
CREATE TABLE Emp_H_IT AS 
SELECT * FROM Employee_Master WHERE dept = 'IT';

-- Fragment 2: Non-IT Departments
CREATE TABLE Emp_H_Other AS 
SELECT * FROM Employee_Master WHERE dept != 'IT';

-- Reconstruction (Union)
SELECT * FROM Emp_H_IT 
UNION ALL 
SELECT * FROM Emp_H_Other;


-- Vertical Fragmentation
-- Fragment 1: Name and Dept
CREATE TABLE Emp_V_Name AS 
SELECT eid, ename, dept FROM Employee_Master;

-- Fragment 2: Financial and Location info
CREATE TABLE Emp_V_Sal AS 
SELECT eid, city, salary FROM Employee_Master;

-- Reconstruction (Join)
SELECT a.eid, a.ename, a.dept, b.city, b.salary
FROM Emp_V_Name a
JOIN Emp_V_Sal b ON a.eid = b.eid;


-- Partitioning
-- Range Partitioning
CREATE TABLE Emp_Range_Part (
    eid NUMBER,
    ename VARCHAR2(20),
    salary NUMBER
)
PARTITION BY RANGE (salary) (
    PARTITION p_low VALUES LESS THAN (70000),
    PARTITION p_mid VALUES LESS THAN (90000),
    PARTITION p_high VALUES LESS THAN (MAXVALUE)
);

-- Insert data into partitioned table
INSERT INTO Emp_Range_Part SELECT eid, ename, salary FROM Employee_Master;

-- Query specific partition
SELECT * FROM Emp_Range_Part PARTITION (p_high);
SELECT * FROM Emp_Range_Part PARTITION (p_mid);
SELECT * FROM Emp_Range_Part PARTITION (p_low);


-- Hash Partitioning
-- Create Table with Hash Partitioning
CREATE TABLE Emp_Hash_Part (
    eid NUMBER,
    ename VARCHAR2(20),
    dept VARCHAR2(10)
)
PARTITION BY HASH (eid)
PARTITIONS 4;

-- Insert data from your Master table
INSERT INTO Emp_Hash_Part (eid, ename, dept)
SELECT eid, ename, dept FROM Employee_Master;

-- Check row counts in each hash partition
SELECT partition_name, high_value 
FROM user_tab_partitions 
WHERE table_name = 'EMP_HASH_PART';

-- To see actual data in one of the partitions (Names are usually SYS_P...)
-- Replace SYS_P21 with a name found in the query above
SELECT * FROM Emp_Hash_Part PARTITION (SYS_P441);
SELECT * FROM Emp_Hash_Part PARTITION (SYS_P442);
SELECT * FROM Emp_Hash_Part PARTITION (SYS_P443);
SELECT * FROM Emp_Hash_Part PARTITION (SYS_P444);


-- Explain Plan
-- Generate Plan
EXPLAIN PLAN FOR
SELECT /*+ USE_NL(a b) */ a.ename, b.salary
FROM Emp_V_Name a
JOIN Emp_V_Sal b ON a.eid = b.eid
WHERE a.eid = 101;

-- Display Plan (Check for 'NESTED LOOPS')
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Generate Plan
EXPLAIN PLAN FOR
SELECT /*+ USE_HASH(a b) */ a.ename, b.salary
FROM Emp_V_Name a
JOIN Emp_V_Sal b ON a.eid = b.eid;

-- Display Plan (Check for 'HASH JOIN')
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);




-- Dropping
-- 1. Drop Partitioned Tables
DROP TABLE Emp_Range_Part;
DROP TABLE Emp_Hash_Part;

-- 2. Drop Horizontal Fragments
DROP TABLE Emp_H_IT;
DROP TABLE Emp_H_Other;

-- 3. Drop Vertical Fragments
DROP TABLE Emp_V_Name;
DROP TABLE Emp_V_Sal;

-- 4. Drop Master Table
DROP TABLE Employee_Master;

-- 5. Clear Explain Plan Table (Optional, but keeps things clean)
DELETE FROM PLAN_TABLE;

COMMIT;