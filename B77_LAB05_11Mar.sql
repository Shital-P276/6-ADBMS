-- Shital Patil 
-- B-II Roll.no B-77
-- PRN : 2324001011


-- Experiment No. 4: Implementation of Range and Hash Partition
-- Oracle SQL

-- =====================================================
-- A) RANGE PARTITION
-- =====================================================

-- Table: emp(id, fname, lname, store_id, department_id)
-- 4 partitions:
-- P0: id < 5
-- P1: id < 10
-- P2: id < 15
-- P3: id <= MAXVALUE

CREATE TABLE emp (
    id            NUMBER PRIMARY KEY,
    fname         VARCHAR2(25) NOT NULL,
    lname         VARCHAR2(25) NOT NULL,
    store_id      NUMBER NOT NULL,
    department_id NUMBER NOT NULL
)
PARTITION BY RANGE (id) (
    PARTITION p0 VALUES LESS THAN (5),
    PARTITION p1 VALUES LESS THAN (10),
    PARTITION p2 VALUES LESS THAN (15),
    PARTITION p3 VALUES LESS THAN (MAXVALUE)
);


-- Insert 20 records (id 1 to 20)
INSERT INTO emp VALUES (1,  'Sam',    'Patil',   101, 10);
INSERT INTO emp VALUES (2,  'Amit',   'Rao',     101, 20);
INSERT INTO emp VALUES (3,  'Sneha',  'Kulkarni',102, 10);
INSERT INTO emp VALUES (4,  'Riya',   'Sharma',  102, 30);
INSERT INTO emp VALUES (5,  'Sagar',  'Mehta',   103, 20);
INSERT INTO emp VALUES (6,  'Kiran',  'Nair',    103, 20);
INSERT INTO emp VALUES (7,  'Sonia',  'Gupta',   104, 40);
INSERT INTO emp VALUES (8,  'Neha',   'Iyer',    104, 30);
INSERT INTO emp VALUES (9,  'Siddh',  'Bose',    105, 10);
INSERT INTO emp VALUES (10, 'Rohan',  'Singh',   105, 40);
INSERT INTO emp VALUES (11, 'Sakshi', 'Verma',   106, 30);
INSERT INTO emp VALUES (12, 'Pooja',  'Das',     106, 20);
INSERT INTO emp VALUES (13, 'Shiv',   'Joshi',   107, 10);
INSERT INTO emp VALUES (14, 'Nitin',  'Jain',    107, 40);
INSERT INTO emp VALUES (15, 'Sara',   'Khan',    108, 20);
INSERT INTO emp VALUES (16, 'Om',     'More',    108, 30);
INSERT INTO emp VALUES (17, 'Siya',   'Naik',    109, 40);
INSERT INTO emp VALUES (18, 'Tina',   'Paul',    109, 10);
INSERT INTO emp VALUES (19, 'Suraj',  'Lal',     110, 20);
INSERT INTO emp VALUES (20, 'Anu',    'Roy',     110, 30);

COMMIT;

-- Vertical fragmentation
CREATE TABLE emp_basic AS 
SELECT id,fname,lname FROM emp;

CREATE TABLE emp_dept AS 
SELECT id,store_id,department_id FROM emp;

CREATE OR REPLACE VIEW v_emp_full AS
SELECT b.id,b.fname,b.lname,d.store_id,d.department_id FROM emp_basic b JOIN emp_dept d ON b.id = d.id;

SELECT fname, department_id 
FROM v_emp_full 
WHERE id = 1;

SELECT * FROM v_emp_full WHERE id < 21 ORDER BY id;



-- view of range partition
CREATE OR REPLACE VIEW v_emp_all AS
SELECT id, fname, lname, store_id, department_id
FROM emp;

SELECT * FROM v_emp_all WHERE id < 21 ORDER BY id;




-- =====================================================
-- B) HASH PARTITION
-- =====================================================

-- Table: sales_hash(salesman_id, salesman_name, sales_amount, week_no)
-- 4 hash partitions

CREATE TABLE sales_hash (
    salesman_id   NUMBER(5) PRIMARY KEY,
    salesman_name VARCHAR2(30),
    sales_amount  NUMBER(10),
    week_no       NUMBER(2)
)
PARTITION BY HASH (salesman_id) (
    PARTITION h1,
    PARTITION h2,
    PARTITION h3,
    PARTITION h4
);

-- Insert at least 10 records
INSERT INTO sales_hash VALUES (1,  'Ravi',   1800, 1);
INSERT INTO sales_hash VALUES (2,  'Neha',   2500, 1);
INSERT INTO sales_hash VALUES (3,  'Suresh', 3200, 2);
INSERT INTO sales_hash VALUES (4,  'Asha',   4700, 2);
INSERT INTO sales_hash VALUES (5,  'Mohan',  5100, 3);
INSERT INTO sales_hash VALUES (6,  'Kavya',  2900, 3);
INSERT INTO sales_hash VALUES (7,  'Aman',   4300, 4);
INSERT INTO sales_hash VALUES (8,  'Nita',   3900, 4);
INSERT INTO sales_hash VALUES (9,  'Rohan',  6200, 1);
INSERT INTO sales_hash VALUES (10, 'Seema',  2100, 2);
INSERT INTO sales_hash VALUES (11, 'Tarun',  3400, 3);
INSERT INTO sales_hash VALUES (12, 'Priti',  2800, 4);

COMMIT;

CREATE OR REPLACE VIEW v_sales_summary AS
SELECT
    salesman_id,
    salesman_name,
    sales_amount,
    week_no
FROM sales_hash;

SELECT salesman_name,sales_amount FROM v_sales_summary WHERE sales_amount > 3000;


SELECT * FROM sales_hash PARTITION(h2);

