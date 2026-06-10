# Oracle ADBMS Lab — Syntax Quick Reference
> Experiments 2, 3, 4 | For external exam recall

---

## EXP 2 — Complex Data Types

### 1. Object Type (UDT)

```sql
-- Step 1: Create the type
CREATE TYPE AddressType AS OBJECT
(
    house_no  VARCHAR2(20),
    street    VARCHAR2(30),
    city      VARCHAR2(20)
);
/

-- Step 2: Create table using that type
CREATE TABLE Student
(
    roll     NUMBER,
    name     VARCHAR2(30),
    address  AddressType          -- column using UDT
);

-- Step 3: Insert
INSERT INTO Student VALUES
(
    101,
    'Shital',
    AddressType('12A', 'MG Road', 'Pune')   -- constructor
);

-- Step 4: Access inner field
SELECT address.city FROM Student;
```

**Memory:** `CREATE TYPE ... AS OBJECT` → use as column → insert with constructor → access with dot

---

### 2. VARRAY

```sql
-- Step 1: Create type
CREATE TYPE PhoneArray AS VARRAY(5)   -- max 5 elements
OF VARCHAR2(15);
/

-- Step 2: Create table
CREATE TABLE Student
(
    roll    NUMBER,
    name    VARCHAR2(30),
    phones  PhoneArray
);

-- Step 3: Insert
INSERT INTO Student VALUES
(
    101,
    'Shital',
    PhoneArray('9876543210', '8765432109')
);
```

**Memory:** `AS VARRAY(n) OF datatype` → ordered, fixed max size

---

### 3. Nested Table

```sql
-- Step 1: Create type
CREATE TYPE SkillTable AS TABLE OF VARCHAR2(20);
/

-- Step 2: Create table  (needs NESTED TABLE ... STORE AS)
CREATE TABLE Employee
(
    empid   NUMBER,
    name    VARCHAR2(30),
    skills  SkillTable
)
NESTED TABLE skills STORE AS skill_storage;   -- ← mandatory extra line

-- Step 3: Insert
INSERT INTO Employee VALUES
(
    1,
    'Rahul',
    SkillTable('Java', 'Python', 'SQL')
);
```

**Memory:** `AS TABLE OF` → needs `NESTED TABLE col STORE AS name` → dynamic, unordered

---

### VARRAY vs Nested Table (Viva Table)

| Feature     | VARRAY          | Nested Table     |
|-------------|-----------------|------------------|
| Order       | Ordered         | Unordered        |
| Size        | Fixed maximum   | Dynamic          |
| Indexed     | Yes             | No               |

---

### 4. REF Type

```sql
-- Step 1: Parent type
CREATE TYPE DepartmentType AS OBJECT
(
    deptid    NUMBER,
    deptname  VARCHAR2(30)
);
/

-- Step 2: Object table from parent type
CREATE TABLE Department OF DepartmentType;

-- Step 3: Child type with REF
CREATE TYPE EmployeeType AS OBJECT
(
    empid  NUMBER,
    name   VARCHAR2(30),
    dept   REF DepartmentType    -- pointer to DepartmentType
);
/
```

**Memory:** `REF TypeName` = pointer/reference to another object

---

## EXP 3 — Inheritance (OODBMS)

```sql
-- Step 1: Parent type  (NOT FINAL = can be extended)
CREATE TYPE PersonType AS OBJECT
(
    pid   NUMBER,
    name  VARCHAR2(30)
)
NOT FINAL;        -- ← mandatory for inheritance
/

-- Step 2: Child type  (UNDER = inherits from)
CREATE TYPE StudentType UNDER PersonType
(
    roll  NUMBER   -- child's own attribute
);
/
-- StudentType now has: pid, name, roll

-- Step 3: Create table of child type
CREATE TABLE Student OF StudentType;

-- Step 4: Insert (all fields: parent first, then child)
INSERT INTO Student VALUES (1, 'Shital', 101);
--                          pid  name    roll
```

**Memory:** Parent needs `NOT FINAL` → Child uses `UNDER ParentType` → Table is `OF ChildType`

### Viva: NOT FINAL vs FINAL
| Keyword   | Meaning                    |
|-----------|----------------------------|
| NOT FINAL | Can have child subtypes    |
| FINAL     | Cannot be extended (default) |

---

## EXP 4 — Partitioning

### Range Partitioning (Numbers)

```sql
CREATE TABLE Employee
(
    empid   NUMBER,
    salary  NUMBER
)
PARTITION BY RANGE(salary)
(
    PARTITION p1 VALUES LESS THAN (20000),
    PARTITION p2 VALUES LESS THAN (50000),
    PARTITION p3 VALUES LESS THAN (MAXVALUE)   -- catch-all
);
```

### Range Partitioning (Dates) ← Most Common in Exams

```sql
CREATE TABLE Orders
(
    orderid    NUMBER,
    orderdate  DATE
)
PARTITION BY RANGE(orderdate)
(
    PARTITION p2023 VALUES LESS THAN (DATE '2024-01-01'),
    PARTITION p2024 VALUES LESS THAN (DATE '2025-01-01'),
    PARTITION pmax  VALUES LESS THAN (MAXVALUE)
);

-- Insert (auto-goes to correct partition)
INSERT INTO Orders VALUES (1, DATE '2024-05-20');
```

---

### Hash Partitioning

```sql
CREATE TABLE Student
(
    roll  NUMBER,
    name  VARCHAR2(30)
)
PARTITION BY HASH(roll)
PARTITIONS 4;      -- Oracle decides which row goes where
```

---

### List Partitioning

```sql
CREATE TABLE Student
(
    roll  NUMBER,
    name  VARCHAR2(30),
    city  VARCHAR2(20)
)
PARTITION BY LIST(city)
(
    PARTITION pune    VALUES ('Pune'),
    PARTITION mumbai  VALUES ('Mumbai'),
    PARTITION others  VALUES (DEFAULT)    -- catch-all
);
```

---

### Partitioning: Which to Use? (Viva Table)

| Use Case            | Type  |
|---------------------|-------|
| Date, Salary, Marks | RANGE |
| Roll No, ID, EmpID  | HASH  |
| City, State, Dept   | LIST  |

---

## Retrieval Queries (Basic SQL)

```sql
-- All rows
SELECT * FROM Student;

-- Filter
SELECT * FROM Student WHERE marks > 70;
SELECT * FROM Student WHERE city = 'Pune' AND marks > 70;
SELECT * FROM Student WHERE city = 'Pune' OR city = 'Mumbai';
SELECT * FROM Student WHERE marks BETWEEN 70 AND 90;
SELECT * FROM Student WHERE city IN ('Pune', 'Mumbai');

-- Pattern
SELECT * FROM Student WHERE name LIKE 'A%';    -- starts with A
SELECT * FROM Student WHERE name LIKE '%l';    -- ends with l

-- Sort
SELECT * FROM Student ORDER BY marks ASC;
SELECT * FROM Student ORDER BY marks DESC;

-- Date filter
SELECT * FROM Orders WHERE orderdate = DATE '2024-05-20';
SELECT * FROM Orders
WHERE orderdate BETWEEN DATE '2024-01-01' AND DATE '2024-12-31';
```

---

## Aggregates + GROUP BY + HAVING

```sql
SELECT COUNT(*) FROM Student;
SELECT SUM(marks)  FROM Student;
SELECT AVG(marks)  FROM Student;
SELECT MAX(marks)  FROM Student;
SELECT MIN(marks)  FROM Student;

-- Group by city
SELECT city, COUNT(*) FROM Student GROUP BY city;
SELECT city, AVG(marks) FROM Student GROUP BY city;

-- HAVING (filter after grouping)
SELECT city, COUNT(*) FROM Student
GROUP BY city
HAVING COUNT(*) > 1;
```

---

## Query Clause Order (Never Mix Up)

```
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
```

---

## 30-Second Recall

```
UDT:           CREATE TYPE ... AS OBJECT
VARRAY:        AS VARRAY(n) OF dtype
NESTED TABLE:  AS TABLE OF dtype  +  NESTED TABLE col STORE AS name
REF:           REF TypeName
INHERITANCE:   NOT FINAL  →  UNDER ParentType  →  OF ChildType

RANGE:         PARTITION BY RANGE(col) → VALUES LESS THAN(x) → MAXVALUE
HASH:          PARTITION BY HASH(col) PARTITIONS n
LIST:          PARTITION BY LIST(col) → VALUES('x') → DEFAULT

DATE LITERAL:  DATE 'YYYY-MM-DD'
```
