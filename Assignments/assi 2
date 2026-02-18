-- Assignment 2: Implementation of Inheritance in OODBMS (Oracle SQL)

-- ==============================
-- 1) Create Parent and Child Types
-- ==============================

CREATE TYPE vehicle_type AS OBJECT (
    vehicle_id NUMBER,
    make       VARCHAR2(30),
    model      VARCHAR2(30),
    year       NUMBER,
    color      VARCHAR2(20),
    mileage    NUMBER
) NOT FINAL;
/

CREATE TYPE car_type UNDER vehicle_type (
    num_doors NUMBER,
    fuel_type VARCHAR2(20)
);
/

CREATE TYPE truck_type UNDER vehicle_type (
    payload_capacity NUMBER,
    num_axles        NUMBER
);
/

-- ==============================
-- 2) Create Tables
-- ==============================

CREATE TABLE car_table OF car_type (
    CONSTRAINT car_pk PRIMARY KEY (vehicle_id)
);

CREATE TABLE truck_table OF truck_type (
    CONSTRAINT truck_pk PRIMARY KEY (vehicle_id)
);

-- ==============================
-- 3) Insert Sample Data
-- ==============================

INSERT INTO car_table VALUES (car_type(1, 'Honda',  'City',   2020, 'White', 18.5, 4, 'Petrol'));
INSERT INTO car_table VALUES (car_type(2, 'Hyundai','i20',    2021, 'Blue',  20.2, 4, 'Petrol'));
INSERT INTO car_table VALUES (car_type(3, 'Tata',   'Nexon',  2022, 'Red',   17.8, 4, 'Diesel'));

INSERT INTO truck_table VALUES (truck_type(101, 'Ashok Leyland', 'Dost',    2019, 'Grey',  11.5, 1800, 2));
INSERT INTO truck_table VALUES (truck_type(102, 'Tata',          'Signa',   2020, 'White',  8.2, 3500, 3));
INSERT INTO truck_table VALUES (truck_type(103, 'Eicher',        'Pro 3015',2021, 'Yellow', 9.0, 2500, 2));

COMMIT;

-- ==============================
-- 4) Required Queries
-- ==============================

-- Q1. List all vehicles with their types (Car or Truck) and mileage.
SELECT vehicle_id, make, model, 'Car' AS vehicle_type, mileage
FROM car_table
UNION ALL
SELECT vehicle_id, make, model, 'Truck' AS vehicle_type, mileage
FROM truck_table
ORDER BY vehicle_id;

-- Q2. List all cars with number of doors, fuel type, and make.
SELECT vehicle_id, make, model, num_doors, fuel_type
FROM car_table
ORDER BY vehicle_id;

-- Q3. Find all trucks with payload capacity greater than 2000 kg.
SELECT vehicle_id, make, model, payload_capacity, num_axles
FROM truck_table
WHERE payload_capacity > 2000
ORDER BY payload_capacity;
