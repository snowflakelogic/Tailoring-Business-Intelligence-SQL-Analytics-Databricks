-- Tailoring Management Database Schema
-- Author: snowflakelogic
-- Created: 2024

CREATE DATABASE IF NOT EXISTS tailor;
USE tailor;

-- Customer Information Table
CREATE TABLE customer (
    cid INT PRIMARY KEY,
    cname VARCHAR(50),
    cnumber INT,
    caddress VARCHAR(50)
);

-- Tailor Information Table
CREATE TABLE my_tailor (
    tailor_id INT PRIMARY KEY,
    phone_no INT,
    tailor_name VARCHAR(50)
);

-- Garment Types and Fabric Requirements
CREATE TABLE garment_type (
    fid INT PRIMARY KEY,
    type_name VARCHAR(50),
    fabric_required VARCHAR(100)
);

-- Customer Measurements
CREATE TABLE measurements (
    mid VARCHAR(10) PRIMARY KEY,
    waist VARCHAR(10),
    hip VARCHAR(10),
    armlength VARCHAR(10),
    armround VARCHAR(10),
    blength VARCHAR(10),
    customerid INT,
    FOREIGN KEY (customerid) REFERENCES customer(cid)
);

-- Order Management
CREATE TABLE order_list (
    oid INT PRIMARY KEY,
    deadline VARCHAR(10),
    price VARCHAR(10),
    fid INT,
    status VARCHAR(40),
    tailor_id INT,
    FOREIGN KEY (fid) REFERENCES customer(cid) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Payment Information
CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    mode_of_payment VARCHAR(20),
    price VARCHAR(10)
);

-- Order Status Audit Trail
CREATE TABLE order_status_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    oid INT,
    status VARCHAR(20),
    changed_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_by_tailor INT
);

-- Customer Order Details Junction Table
CREATE TABLE customer_order_details (
    cid INT,
    mid INT,
    oid INT,
    payment_id INT,
    tailor_id INT
);

-- Customer Order Payment Junction Table
CREATE TABLE customer_order_payment (
    cid INT,
    oid INT,
    payment_id INT
);
