
//Simple Object Type 
CREATE TYPE address_type AS OBJECT (
    house_no VARCHAR(20),
    street VARCHAR(30),
    city VARCHAR(20),
    pincode NUMBER
);
/

//Another object using first object
//object nesting
CREATE TYPE student_type AS OBJECT (
    sid NUMBER,
    name VARCHAR(30),
    age NUMBER,
    address address_type
);
/

//create a table 
CREATE TABLE student_table OF student_type;

//Insert objects
INSERT INTO student_table VALUES (
    student_type(
        101,
        'Amit',
        20,
        address_type('12A', 'MG Road', 'Bangalore', 560001)
    )
);


INSERT INTO student_table VALUES (
    student_type(
        102,
        'Shital',
        21,
        address_type('45B','Station Road','Mumbai', 400001 )
    )
);

COMMIT;

//Select Operations 
SELECT * FROM student_table;

SELECT s.sid, s.name,s.address.city
FROM student_table s;

SELECT name
FROM student_table s
WHERE s.address.city = 'Mumbai';

//update operations 
UPDATE student_table
SET address = address_type('45B','Link Road','Mumbai',400002)
WHERE sid= 102;

//delete operation
DELETE FROM student_table
WHERE sid= 102;

//Drop & cleanup
DROP TABLE student_table;
DROP TYPE student_type;
DROP TYPE address_type;
