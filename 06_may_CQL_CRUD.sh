-- Switch to your Astra Keyspace (Replace 'bank_keyspace' with your actual keyspace name)
USE bank_keyspace;

-- 1. Create Customer Table
CREATE TABLE customer (
    customer_id UUID PRIMARY KEY,
    name TEXT,
    address TEXT,
    phone TEXT,
    email TEXT
);

-- 2. Create Account Table
CREATE TABLE account (
    account_no UUID PRIMARY KEY,
    customer_id UUID,
    account_type TEXT,
    balance DECIMAL,
    branch TEXT
);

-- To satisfy the queries "View all accounts of a customer" and "List accounts by branch"
-- using this specific table structure, we must create Secondary Indexes. 
CREATE INDEX IF NOT EXISTS ON account (customer_id);
CREATE INDEX IF NOT EXISTS ON account (branch);

-- 3. Create Transactions Table
-- Here we implement partitioning by 'account_no' and clustering by 'txn_date' and 'txn_id'
-- Sorting by 'txn_date DESC' ensures we can efficiently fetch recent transactions.
CREATE TABLE transactions (
    account_no UUID,
    txn_date TIMESTAMP,
    txn_id TIMEUUID,
    txn_type TEXT,
    amount DECIMAL,
    PRIMARY KEY ((account_no), txn_date, txn_id)
) WITH CLUSTERING ORDER BY (txn_date DESC, txn_id ASC);






-- ==========================================
-- CREATE (Insert Data)
-- ==========================================

-- Insert Customers
INSERT INTO customer (customer_id, name, address, phone, email) 
VALUES (11111111-1111-1111-1111-111111111111, 'Alice Smith', '123 Main St, Mumbai', '9876543210', 'alice@example.com');

INSERT INTO customer (customer_id, name, address, phone, email) 
VALUES (22222222-2222-2222-2222-222222222222, 'Bob Johnson', '456 Park Ave, Pune', '9123456789', 'bob@example.com');

-- Insert Accounts
INSERT INTO account (account_no, customer_id, account_type, balance, branch) 
VALUES (aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa, 11111111-1111-1111-1111-111111111111, 'Savings', 50000.00, 'Andheri');

INSERT INTO account (account_no, customer_id, account_type, balance, branch) 
VALUES (bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb, 11111111-1111-1111-1111-111111111111, 'Current', 15000.50, 'Andheri');

INSERT INTO account (account_no, customer_id, account_type, balance, branch) 
VALUES (cccccccc-cccc-cccc-cccc-cccccccccccc, 22222222-2222-2222-2222-222222222222, 'Savings', 75000.00, 'Shivajinagar');

-- Insert Transactions (Using toTimestamp(now()) and now() for current time)
INSERT INTO transactions (account_no, txn_date, txn_id, txn_type, amount) 
VALUES (aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa, toTimestamp(now()), now(), 'Deposit', 10000.00);

INSERT INTO transactions (account_no, txn_date, txn_id, txn_type, amount) 
VALUES (aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa, toTimestamp(now()), now(), 'Withdrawal', 2000.00);

-- ==========================================
-- UPDATE 
-- ==========================================
-- Update a customer's phone number
UPDATE customer SET phone = '9999999999' WHERE customer_id = 11111111-1111-1111-1111-111111111111;

-- Update an account balance (Simulating the end of a transaction)
UPDATE account SET balance = 58000.00 WHERE account_no = aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa;

-- ==========================================
-- DELETE
-- ==========================================
-- Delete a customer (Note: In a real system, you'd also delete their accounts/transactions)
DELETE FROM customer WHERE customer_id = 22222222-2222-2222-2222-222222222222;






-- 1. Retrieve customer details by ID
SELECT * FROM customer 
WHERE customer_id = 11111111-1111-1111-1111-111111111111;

-- 2. View all accounts of a customer
-- (This works because we created a secondary index on customer_id)
SELECT * FROM account 
WHERE customer_id = 11111111-1111-1111-1111-111111111111;

-- 3. Check account balance
SELECT balance FROM account 
WHERE account_no = aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa;

-- 4. Fetch recent transactions
-- (Because of our clustering order `txn_date DESC`, this automatically returns the newest first)
SELECT * FROM transactions 
WHERE account_no = aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa 
LIMIT 5;

-- 5. List accounts by branch
-- (This works because we created a secondary index on branch)
SELECT * FROM account 
WHERE branch = 'Andheri';
