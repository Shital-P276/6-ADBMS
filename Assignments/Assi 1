-- Assignment 1 (Simple Oracle SQL version)
-- Book Store database using:
-- 1) STRUCTURE  -> OBJECT types
-- 2) ARRAY      -> VARRAY
-- 3) SET        -> NESTED TABLE

-- =====================
-- 1) Create Types
-- =====================
CREATE TYPE name_type AS OBJECT (
    fname VARCHAR2(30),
    lname VARCHAR2(30)
);
/

CREATE TYPE publisher_type AS OBJECT (
    pub_id   VARCHAR2(10),
    pub_name VARCHAR2(50),
    branch   VARCHAR2(20)
);
/

CREATE TYPE author_id_array AS VARRAY(10) OF VARCHAR2(10);
/

CREATE TYPE phone_set AS TABLE OF VARCHAR2(15);
/

CREATE TYPE keyword_set AS TABLE OF VARCHAR2(30);
/

-- =====================
-- 2) Create Tables
-- =====================
CREATE TABLE author (
    author_id VARCHAR2(10) PRIMARY KEY,
    name      name_type,
    phone_no  phone_set
)
NESTED TABLE phone_no STORE AS author_phone_nt;

CREATE TABLE book (
    isbn      NUMBER PRIMARY KEY,
    title     VARCHAR2(30),
    author_id author_id_array,
    category  VARCHAR2(20),
    publisher publisher_type,
    keywords  keyword_set,
    price     NUMBER(10,2)
)
NESTED TABLE keywords STORE AS book_keywords_nt;

CREATE TABLE customer (
    customer_id VARCHAR2(10) PRIMARY KEY,
    name        name_type,
    phone_no    phone_set
)
NESTED TABLE phone_no STORE AS customer_phone_nt;

CREATE TABLE book_sale (
    sale_id     VARCHAR2(10) PRIMARY KEY,
    customer_id VARCHAR2(10) REFERENCES customer(customer_id),
    isbn        NUMBER REFERENCES book(isbn)
);

-- =====================
-- 3) Insert Data (6 rows each main table)
-- =====================
-- AUTHOR
INSERT INTO author VALUES ('A001', name_type('Ramesh', 'Kulkarni'), phone_set('9876500001'));
INSERT INTO author VALUES ('A002', name_type('Sneha',  'Patil'),    phone_set('9876500002'));
INSERT INTO author VALUES ('A003', name_type('Amit',   'Sharma'),   phone_set('9876500003'));
INSERT INTO author VALUES ('A004', name_type('Priya',  'Nair'),     phone_set('9876500004'));
INSERT INTO author VALUES ('A005', name_type('Vikas',  'Gupta'),    phone_set('9876500005'));
INSERT INTO author VALUES ('A006', name_type('Neha',   'Rao'),      phone_set('9876500006'));

-- BOOK
INSERT INTO book VALUES (
    1001,
    'Database Systems',
    author_id_array('A001','A003'),
    'Education',
    publisher_type('P001','Tata McGraw Hill','India'),
    keyword_set('SQL','DBMS'),
    799.00
);

INSERT INTO book VALUES (
    1002,
    'Advanced PL/SQL',
    author_id_array('A002'),
    'Education',
    publisher_type('P001','Tata McGraw Hill','India'),
    keyword_set('PLSQL','Trigger'),
    699.00
);

INSERT INTO book VALUES (
    1003,
    'Cloud Patterns',
    author_id_array('A004','A005'),
    'Technology',
    publisher_type('P002','Pearson','UK'),
    keyword_set('Cloud','Design'),
    899.00
);

INSERT INTO book VALUES (
    1004,
    'AI Basics',
    author_id_array('A006'),
    'Technology',
    publisher_type('P003','OReilly','US'),
    keyword_set('AI','ML'),
    999.00
);

INSERT INTO book VALUES (
    1005,
    'Business Analytics',
    author_id_array('A003'),
    'Management',
    publisher_type('P004','Wiley','US'),
    keyword_set('Analytics','BI'),
    749.00
);

INSERT INTO book VALUES (
    1006,
    'Operating Systems',
    author_id_array('A001','A002'),
    'Education',
    publisher_type('P005','Springer','UK'),
    keyword_set('OS','Kernel'),
    820.00
);

-- CUSTOMER
INSERT INTO customer VALUES ('C001', name_type('Anita', 'Desai'),  phone_set('9000000001'));
INSERT INTO customer VALUES ('C002', name_type('Rohit', 'Mehta'),  phone_set('9000000002'));
INSERT INTO customer VALUES ('C003', name_type('Kiran', 'Joshi'),  phone_set('9000000003'));
INSERT INTO customer VALUES ('C004', name_type('Meera', 'Iyer'),   phone_set('9000000004'));
INSERT INTO customer VALUES ('C005', name_type('Siddh', 'Kapoor'), phone_set('9000000005'));
INSERT INTO customer VALUES ('C006', name_type('Nidhi', 'Bose'),   phone_set('9000000006'));

-- BOOK_SALE
INSERT INTO book_sale VALUES ('S001','C001',1001);
INSERT INTO book_sale VALUES ('S002','C001',1003);
INSERT INTO book_sale VALUES ('S003','C002',1002);
INSERT INTO book_sale VALUES ('S004','C003',1004);
INSERT INTO book_sale VALUES ('S005','C004',1005);
INSERT INTO book_sale VALUES ('S006','C005',1003);
INSERT INTO book_sale VALUES ('S007','C006',1006);
INSERT INTO book_sale VALUES ('S008','C002',1001);

COMMIT;

-- =====================
-- 4) Required Queries
-- =====================

-- Q1: List all titles with ISBN and author full name
SELECT b.isbn,
       b.title,
       a.name.fname || ' ' || a.name.lname AS author_name
FROM book b,
     TABLE(b.author_id) aid,
     author a
WHERE a.author_id = aid.COLUMN_VALUE
ORDER BY b.isbn, author_name;

-- Q2: Customers who purchased books published by Tata McGraw Hill
SELECT DISTINCT
       c.customer_id,
       c.name.fname || ' ' || c.name.lname AS customer_name
FROM book_sale bs
JOIN customer c ON c.customer_id = bs.customer_id
JOIN book b ON b.isbn = bs.isbn
WHERE UPPER(b.publisher.pub_name) = 'TATA MCGRAW HILL'
ORDER BY customer_name;

-- Q3: Customers who purchased books published in UK or US,
--     include title and publisher name, order by customer last name
SELECT c.name.fname || ' ' || c.name.lname AS customer_name,
       b.title,
       b.publisher.pub_name AS publisher_name
FROM book_sale bs
JOIN customer c ON c.customer_id = bs.customer_id
JOIN book b ON b.isbn = bs.isbn
WHERE UPPER(b.publisher.branch) IN ('UK','US')
ORDER BY c.name.lname, c.name.fname;

-- Q4: Distinct categories and number of books per category
SELECT b.category,
       COUNT(*) AS no_of_books
FROM book b
GROUP BY b.category
ORDER BY b.category;

-- Q5: Number of books sold written by each author (group by first name)
SELECT a.name.fname AS author_first_name,
       COUNT(*) AS books_sold
FROM book_sale bs
JOIN book b ON b.isbn = bs.isbn
JOIN TABLE(b.author_id) aid ON 1=1
JOIN author a ON a.author_id = aid.COLUMN_VALUE
GROUP BY a.name.fname
ORDER BY a.name.fname;
