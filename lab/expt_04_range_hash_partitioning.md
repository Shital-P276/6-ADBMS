# Expt 04: Implementation of Range and Hash Partitioning

## Objective
Create partitioned tables and execute sample operations.

## Range Partitioning
```sql
CREATE TABLE sales_range (
  sale_id   NUMBER,
  sale_date DATE,
  amount    NUMBER
)
PARTITION BY RANGE (sale_date) (
  PARTITION p_2024 VALUES LESS THAN (DATE '2025-01-01'),
  PARTITION p_2025 VALUES LESS THAN (DATE '2026-01-01'),
  PARTITION p_max  VALUES LESS THAN (MAXVALUE)
);
```

## Hash Partitioning
```sql
CREATE TABLE orders_hash (
  order_id   NUMBER,
  customer_id NUMBER,
  total_amt   NUMBER
)
PARTITION BY HASH (customer_id)
PARTITIONS 4;
```

## Sample Data + CRUD
```sql
INSERT INTO sales_range VALUES (1, DATE '2024-12-10', 1500);
INSERT INTO sales_range VALUES (2, DATE '2025-03-05', 2200);
INSERT INTO sales_range VALUES (3, DATE '2026-01-11', 1750);

INSERT INTO orders_hash VALUES (101, 11, 800);
INSERT INTO orders_hash VALUES (102, 12, 1200);
INSERT INTO orders_hash VALUES (103, 21, 400);

SELECT * FROM sales_range;
UPDATE orders_hash SET total_amt = 900 WHERE order_id = 101;
DELETE FROM orders_hash WHERE order_id = 103;
```
