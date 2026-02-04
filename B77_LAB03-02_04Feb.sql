
CREATE TYPE address_type AS OBJECT (
    house_no VARCHAR2(20),
    street VARCHAR2(30),
    city VARCHAR2(20),
    pincode NUMBER
) NOT FINAL;
/

CREATE TABLE address_table OF address_type;

CREATE OR REPLACE TYPE person_type AS OBJECT (
    name VARCHAR2(30),
    age NUMBER,
    address_ref REF address_type
) NOT FINAL;
/

CREATE OR REPLACE TYPE student_type UNDER person_type (
    sid NUMBER
);
/

CREATE OR REPLACE TYPE teacher_type UNDER person_type (
    emp_id NUMBER,
    subject VARCHAR2(30)
);
/ 


CREATE TABLE student_table OF student_type;

CREATE TABLE teacher_table OF teacher_type;




INSERT INTO address_table VALUES (address_type('12A', 'MG Road', 'Bangalore', 560001));
INSERT INTO address_table VALUES (address_type('17B', 'CSMT', 'Mumbai', 400001));
INSERT INTO address_table VALUES (address_type('45B', 'Station Road', 'Mumbai', 400001));



INSERT INTO student_table SELECT 
'Amit',20,REF(a),101
FROM address_table a WHERE a.city = 'Bangalore';

INSERT INTO student_table SELECT 
'Shital',21,REF(a),102
FROM address_table a WHERE a.street = 'CSMT';

INSERT INTO teacher_table
SELECT 'Dr.Hadimani',45,REF(a),1001,'AIML'
FROM address_table a WHERE a.street = 'Station Road';


COMMIT;


-- This shows the name and the "dereferenced" address object
SELECT s.name, DEREF(s.address_ref) as full_address 
FROM student_table s;

-- Navigational access (Automatic dereferencing)
SELECT s.name, s.address_ref.city, s.address_ref.street 
FROM student_table s;


DROP TABLE teacher_table;
DROP TABLE student_table;
DROP TABLE address_table;
DROP TYPE teacher_type FORCE;
DROP TYPE student_type FORCE;
DROP TYPE person_type FORCE;
DROP TYPE address_type FORCE;

