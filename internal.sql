
CREATE TABLE Movie (
    movie_id     NUMBER PRIMARY KEY,
    title        VARCHAR2(100),
    genre        VARCHAR2(50),
    language     VARCHAR2(30),
    duration     NUMBER,
    rating       VARCHAR2(10),
    release_year NUMBER
);


CREATE TABLE Customer (
    customer_id  NUMBER PRIMARY KEY,
    name         VARCHAR2(100),
    email        VARCHAR2(100),
    phone        VARCHAR2(15),
    city         VARCHAR2(50)
);


CREATE TABLE Theatre (
    theatre_id    NUMBER PRIMARY KEY,
    theatre_name  VARCHAR2(100),
    city          VARCHAR2(50),
    screens       NUMBER
);


CREATE TABLE Seat (
    seat_id      NUMBER PRIMARY KEY,
    seat_number  VARCHAR2(10),
    seat_type    VARCHAR2(20)
);


CREATE TABLE Show (
    show_id       NUMBER PRIMARY KEY,
    movie_id      NUMBER REFERENCES Movie(movie_id),
    theatre_id    NUMBER REFERENCES Theatre(theatre_id),
    show_date     DATE,
    show_time     VARCHAR2(10),
    ticket_price  NUMBER
);


CREATE TABLE Booking (
    booking_id      NUMBER PRIMARY KEY,
    customer_id     NUMBER REFERENCES Customer(customer_id),
    show_id         NUMBER REFERENCES Show(show_id),
    seat_id         NUMBER REFERENCES Seat(seat_id),
    booking_date    DATE,
    total_amount    NUMBER,
    payment_status  VARCHAR2(20)
);


CREATE TABLE Booking_Range (
    booking_id      NUMBER PRIMARY KEY,
    customer_id     NUMBER,
    show_id         NUMBER,
    seat_id         NUMBER,
    booking_date    DATE,
    total_amount    NUMBER,
    payment_status  VARCHAR2(20)
)
PARTITION BY RANGE (booking_date) (
    PARTITION bk_2023 VALUES LESS THAN (DATE '2024-01-01'),
    PARTITION bk_2024 VALUES LESS THAN (DATE '2025-01-01'),
    PARTITION bk_2025 VALUES LESS THAN (DATE '2026-01-01'),
    PARTITION bk_future VALUES LESS THAN (MAXVALUE)
);




CREATE TABLE Customer_Hash (
    customer_id  NUMBER PRIMARY KEY,
    name         VARCHAR2(100),
    email        VARCHAR2(100),
    phone        VARCHAR2(15),
    city         VARCHAR2(50)
)
PARTITION BY HASH (customer_id) (
    PARTITION cust_p1,
    PARTITION cust_p2,
    PARTITION cust_p3,
    PARTITION cust_p4
);


INSERT INTO Booking_Range VALUES (1, 101, 201, 301, DATE '2023-06-15', 500, 'PAID');
INSERT INTO Booking_Range VALUES (2, 102, 202, 302, DATE '2024-03-20', 300, 'PAID');
INSERT INTO Booking_Range VALUES (3, 103, 203, 303, DATE '2025-01-10', 450, 'PENDING');
COMMIT;

INSERT INTO Customer_Hash VALUES (1, 'Rahul Sharma', 'rahul@email.com', '9876543210', 'Kolhapur');
INSERT INTO Customer_Hash VALUES (2, 'Priya Patil',  'priya@email.com', '9123456780', 'Pune');
INSERT INTO Customer_Hash VALUES (3, 'Amit Desai',   'amit@email.com',  '9988776655', 'Mumbai');
INSERT INTO Customer_Hash VALUES (4, 'Sneha More',   'sneha@email.com', '9001234567', 'Nashik');
COMMIT;

SELECT * FROM Booking_Range PARTITION (bk_2023);
SELECT * FROM Booking_Range PARTITION (bk_2024);
SELECT * FROM Booking_Range PARTITION (bk_2025);

SELECT * FROM Customer_Hash PARTITION (cust_p1);
SELECT * FROM Customer_Hash PARTITION (cust_p2);
SELECT * FROM Customer_Hash PARTITION (cust_p3);
SELECT * FROM Customer_Hash PARTITION (cust_p4);
