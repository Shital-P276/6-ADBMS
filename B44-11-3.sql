CREATE TABLE employeedb(
id INTEGER PRIMARY KEY,
name VARCHAR(10),
contact_no INTEGER,
PAN VARCHAR(15)
);

INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(101, 'sam', 9876543210, 'AIFPW1917');

INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(102, 'ghan', 9876543210, 'AIFPW2345');
INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(103, 'ghaam', 9876543210, 'YGVUDFG1917');
INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(104, 'rasam', 9876543210, 'YIW4234FV');
INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(105, 'wam', 9876543210, 'FJUGIO378');
INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(106, 'bam', 9876543210, 'HGRFUG783');
INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(107, 'tam', 9876543210, 'HNFUW8221');
INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(108, 'ram', 9876543210, 'HNUJIOGK72');
INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(109, 'gam', 9876543210, 'HEDFI3183');
INSERT INTO employeedb (id, name, contact_no, PAN) 
VALUES(110, 'sham', 9876543210, 'OQURY4763');

SELECT * FROM employeedb;


CREATE VIEW  emp_pan AS 
SELECT id,PAN FROM employeedb;

SELECT * FROM emp_pan;