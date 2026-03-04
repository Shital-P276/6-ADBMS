CREATE TABLE employees (
    emp_id      INT PRIMARY KEY,
    fname    VARCHAR(25),
    lname VARCHAR(25),
    store_id int not null,
    department_id int not null
)

PARTITION BY RANGE (emp_id) (
    
    PARTITION p0 VALUES LESS THAN (5),
    PARTITION p1 VALUES LESS THAN (10),
    PARTITION p2 VALUES LESS THAN (15),
    PARTITION p3 VALUES LESS THAN MAXVALUE


);


SELECT * FROM employees;
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(1,'sam','wadmare',101,201);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(2,'sham','chavan',102,202);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(3,'ram','powar',103,203);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(4,'gham','wick',101,204);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(5,'dam','bahubali',104,205);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(6,'adi','gherade',105,201);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(7,'padi','wadke',101,202);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(8,'vishu','upte',103,203);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(9,'shirt','shete',107,204);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(10,'pant','kale',102,205);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(11,'shital','mule',108,201);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(12,'gomu','mulla',103,202);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(13,'sonu','karkar',104,203);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(14,'somu','patil',101,204);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(15,'babdy','dabdy',109,205);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(16,'bunty','shunty',110,201);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(17,'john','karma',106,202);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(18,'abel','wasd',107,203);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(19,'babel','shakur',102,204);
INSERT INTO employees(emp_id,fname,lname,store_id,department_id) VALUES(20,'weeknd','babel',103,205);






