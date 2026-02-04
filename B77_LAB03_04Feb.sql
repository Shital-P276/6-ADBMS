-- 1. FORCE delete everything to break the stuck dependencies
DROP TABLE student_table CASCADE CONSTRAINTS;
DROP TYPE student_type FORCE;
DROP TYPE address_type FORCE;

-- Address remains a simple object
CREATE TYPE address_type AS OBJECT (
    house_no VARCHAR2(20),
    street VARCHAR2(30),
    city VARCHAR2(20),
    pincode NUMBER
) NOT FINAL;
/

-- Create a Parent Type: person_type
-- NOT FINAL allows other types to inherit from this
CREATE TYPE person_type AS OBJECT (
    name VARCHAR2(30),
    age NUMBER,
    address address_type
) NOT FINAL;
/

-- Create a Subtype: student_type 
-- It inherits name, age, and address from person_type
CREATE TYPE student_type UNDER person_type (
    sid NUMBER
);
/

-- Create the table using the subtype
CREATE TABLE student_table OF student_type;

-- Insert using the subtype constructor
-- Note: Subtype constructors take parent attributes first, then subtype attributes
-- Format: student_type(name, age, address, sid)
INSERT INTO student_table VALUES (
    student_type(
        'Amit', 
        20, 
        address_type('12A', 'MG Road', 'Bangalore', 560001),
        101
    )
);

INSERT INTO student_table VALUES (
    student_type(
        'Shital', 
        21, 
        address_type('45B', 'Station Road', 'Mumbai', 400001),
        102
    )
);

COMMIT;

-- Accessing inherited and nested attributes
SELECT s.sid, s.name, s.address.city 
FROM student_table s;

-- Filtering by inherited attributes
SELECT s.name 
FROM student_table s 
WHERE s.age > 18;




-- Create Teacher Subtype
-- Inherits name, age, address from person_type
CREATE OR REPLACE TYPE teacher_type UNDER person_type (
    emp_id NUMBER,
    subject VARCHAR2(30)
);
/

-- Create a table specifically for Teachers
CREATE TABLE teacher_table OF teacher_type;

INSERT INTO teacher_table VALUES (
    teacher_type(
        'Dr. Smith', 
        45, 
        address_type('101', 'University Ave', 'Pune', 411007),
        5001,       -- emp_id
        'Mathematics' -- subject
    )
);

COMMIT;

SELECT t.emp_id, t.name, t.subject, t.address.city 
FROM teacher_table t;






DROP TABLE teacher_table;
DROP TABLE student_table;
DROP TYPE teacher_type;
DROP TYPE student_type;
DROP TYPE person_type;
DROP TYPE address_type FORCE;