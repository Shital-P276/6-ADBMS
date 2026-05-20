CREATE TABLE Movie (
    movie_id NUMBER PRIMARY KEY,
    title VARCHAR2(100),
    genre VARCHAR2(50),
    language VARCHAR2(30),
    duration NUMBER,
    rating NUMBER(2,1),
    release_year NUMBER
);


CREATE TABLE Customer (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    phone VARCHAR2(15),
    city VARCHAR2(50)
);


CREATE TABLE Theatre (
    theatre_id NUMBER PRIMARY KEY,
    theatre_name VARCHAR2(100),
    city VARCHAR2(50),
    screens NUMBER
);


CREATE TABLE Show_Details (
    show_id NUMBER PRIMARY KEY,
    movie_id NUMBER,
    theatre_id NUMBER,
    show_date DATE,
    show_time VARCHAR2(20),
    ticket_price NUMBER(8,2),

    CONSTRAINT fk_movie
        FOREIGN KEY (movie_id)
        REFERENCES Movie(movie_id),

    CONSTRAINT fk_theatre
        FOREIGN KEY (theatre_id)
        REFERENCES Theatre(theatre_id)
)
PARTITION BY RANGE (show_date)
(
    PARTITION p_2024 VALUES LESS THAN (TO_DATE('01-JAN-2025','DD-MON-YYYY')),

    PARTITION p_2025 VALUES LESS THAN (TO_DATE('01-JAN-2026','DD-MON-YYYY')),

    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


CREATE TABLE Booking (
    booking_id NUMBER,
    customer_id NUMBER,
    show_id NUMBER,
    booking_date DATE,
    total_amount NUMBER(10,2),
    payment_status VARCHAR2(20),

    CONSTRAINT pk_booking
        PRIMARY KEY (booking_id, customer_id),

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),

    CONSTRAINT fk_show
        FOREIGN KEY (show_id)
        REFERENCES Show_Details(show_id)
)
PARTITION BY HASH (customer_id)
PARTITIONS 4;

CREATE TABLE Seat (
    seat_id NUMBER PRIMARY KEY,
    seat_number VARCHAR2(10),
    seat_type VARCHAR2(20)
);


INSERT INTO Movie VALUES (1, 'Avengers Endgame', 'Action', 'English', 180, 9.0, 2019);
INSERT INTO Movie VALUES (2, 'KGF 2', 'Action', 'Kannada', 170, 8.5, 2022);
INSERT INTO Movie VALUES (3, 'Interstellar', 'Sci-Fi', 'English', 169, 9.2, 2014);


INSERT INTO Customer VALUES (101, 'Rahul', 'rahul@gmail.com', '9876543210', 'Pune');
INSERT INTO Customer VALUES (102, 'Sneha', 'sneha@gmail.com', '9876543211', 'Mumbai');
INSERT INTO Customer VALUES (103, 'Amit', 'amit@gmail.com', '9876543212', 'Kolhapur');
INSERT INTO Customer VALUES (104, 'Priya', 'priya@gmail.com', '9876543213', 'Delhi');



INSERT INTO Booking VALUES
(1, 101, 1, SYSDATE, 500, 'PAID');

INSERT INTO Booking VALUES
(2, 102, 2, SYSDATE, 300, 'PAID');

INSERT INTO Booking VALUES
(3, 103, 1, SYSDATE, 250, 'PENDING');

INSERT INTO Booking VALUES
(4, 104, 3, SYSDATE, 700, 'PAID');

COMMIT;

SELECT
    table_name,
    partition_name,
    high_value
FROM user_tab_partitions
WHERE table_name = 'SHOW_DETAILS';


SELECT
    partition_name,
    num_rows
FROM user_tab_partitions
WHERE table_name = 'SHOW_DETAILS';


SELECT
    table_name,
    partition_name
FROM user_tab_partitions
WHERE table_name = 'BOOKING';

SELECT * FROM Show_Details
WHERE show_date < TO_DATE('01-JAN-2025','DD-MON-YYYY');


SELECT * FROM Booking
WHERE customer_id = 101;





