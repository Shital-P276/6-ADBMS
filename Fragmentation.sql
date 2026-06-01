CREATE TABLE employee(
 emp_id NUMBER,
 emp_name VARCHAR2(30),
 dept VARCHAR2(20),
 salary NUMBER
);

INSERT INTO employee VALUES(101,'Sam','IT',50000);
INSERT INTO employee VALUES(102,'John','HR',45000);
INSERT INTO employee VALUES(103,'Alice','IT',60000);
INSERT INTO employee VALUES(104,'David','Finance',55000);

--HORIZONTAL FRAGMENTAION
CREATE TABLE emp_it AS
SELECT * FROM employee
WHERE dept = 'IT';

CREATE TABLE emp_hr AS 
SELECT * FROM employee
WHERE dept = 'HR';

SELECT * FROM emp_it;
SELECT * FROM emp_hr;
------------RECONSTRUCTION-------------
SELECT * FROM emp_it
UNION 
SELECT * FROM emp_hr;

---------------------------------------------------------------------------------


--VERTICAL FRAGMENTATION
CREATE TABLE emp_personal AS
SELECT emp_id,emp_name FROM employee;

CREATE TABLE emp_department AS 
SELECT emp_id,dept,salary FROM employee;

SELECT * FROM EMP_PERSONAL;
SELECT * FROM EMP_DEPARTMENT;

--------------------RECONSTRUCTION--------------------
SELECT * FROM EMP_PERSONAL p
JOIN EMP_DEPARTMENT d  ON p.emp_id = d.emp_id;