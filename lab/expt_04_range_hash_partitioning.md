# Expt 04: Implementation of Range and Hash Partitioning

## Objective
Create range and hash partitioned tables, then perform complete CRUD and partition-level verification.

## Complete SQL Script
```sql
-- Cleanup
DROP TABLE sales_range;
DROP TABLE orders_hash;

-- 1) Range partition table
CREATE TABLE sales_range (
  sale_id   NUMBER PRIMARY KEY,
  sale_date DATE,
  amount    NUMBER
)
PARTITION BY RANGE (sale_date) (
  PARTITION p_2024 VALUES LESS THAN (DATE '2025-01-01'),
  PARTITION p_2025 VALUES LESS THAN (DATE '2026-01-01'),
  PARTITION p_max  VALUES LESS THAN (MAXVALUE)
);

-- 2) Hash partition table
CREATE TABLE orders_hash (
  order_id    NUMBER PRIMARY KEY,
  customer_id NUMBER,
  total_amt   NUMBER
)
PARTITION BY HASH (customer_id)
PARTITIONS 4;

-- 3) Insert sample rows
INSERT INTO sales_range VALUES (1, DATE '2024-12-10', 1500);
INSERT INTO sales_range VALUES (2, DATE '2025-03-05', 2200);
INSERT INTO sales_range VALUES (3, DATE '2026-01-11', 1750);
INSERT INTO sales_range VALUES (4, DATE '2025-08-20', 2900);

INSERT INTO orders_hash VALUES (101, 11, 800);
INSERT INTO orders_hash VALUES (102, 12, 1200);
INSERT INTO orders_hash VALUES (103, 21, 400);
INSERT INTO orders_hash VALUES (104, 31, 2000);
COMMIT;

-- 4) Read queries
SELECT * FROM sales_range ORDER BY sale_id;
SELECT * FROM orders_hash ORDER BY order_id;

-- 5) Partition info
SELECT table_name, partition_name, high_value
FROM user_tab_partitions
WHERE table_name = 'SALES_RANGE'
ORDER BY partition_position;

-- 6) Update
UPDATE orders_hash SET total_amt = 900 WHERE order_id = 101;
UPDATE sales_range SET amount = 3000 WHERE sale_id = 4;
COMMIT;

-- 7) Delete
DELETE FROM orders_hash WHERE order_id = 103;
DELETE FROM sales_range WHERE sale_id = 1;
COMMIT;

-- 8) Final output
SELECT * FROM sales_range ORDER BY sale_id;
SELECT * FROM orders_hash ORDER BY order_id;
```
