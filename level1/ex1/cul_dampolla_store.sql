-- Adrià Lorente – Optician DB "Cul d'Ampolla"
-- Database creation and data loading script

CREATE DATABASE cul_dampolla_store;
USE cul_dampolla_store;

-- Create tables

-- Suppliers
CREATE TABLE supplier (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  street VARCHAR(100) NOT NULL,
  number VARCHAR(10) NOT NULL,
  floor VARCHAR(10),
  door VARCHAR(10),
  city VARCHAR(50),
  postal_code VARCHAR(10),
  country VARCHAR(50),
  phone VARCHAR(20),
  fax VARCHAR(20),
  tax_id VARCHAR(20) UNIQUE NOT NULL
);

-- Frame types
CREATE TABLE frame_types (
  frame_type_id INT AUTO_INCREMENT PRIMARY KEY,
  frame_type VARCHAR(10) NOT NULL
);

-- Employees
CREATE TABLE employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20)
);

-- Brands (depends on supplier)
CREATE TABLE brand (
  brand_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  supplier_id INT NOT NULL,
  FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

-- Glasses (depends on brand and frame_types)
CREATE TABLE glasses (
  glasses_id INT AUTO_INCREMENT PRIMARY KEY,
  graduation INT NOT NULL,
  frame_type_id INT NOT NULL,
  brand_id INT NOT NULL,
  frame_colour VARCHAR(20) NOT NULL,
  lens_colour VARCHAR(20) NOT NULL,
  price DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
  FOREIGN KEY (frame_type_id) REFERENCES frame_types(frame_type_id)
);

-- Customers (self-referencing foreign key)
CREATE TABLE customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  address VARCHAR(100),
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(50),
  register_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  referral_from_customer_id INT,
  FOREIGN KEY (referral_from_customer_id) REFERENCES customer(customer_id)
);

-- Sales (depends on customer, employee and glasses)
CREATE TABLE sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  employee_id INT NOT NULL,
  customer_id INT NOT NULL,
  glasses_id INT NOT NULL,
  sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
  FOREIGN KEY (glasses_id) REFERENCES glasses(glasses_id)
);

-- Insert data into tables

-- Suppliers
INSERT INTO supplier (name, street, number, floor, door, city, postal_code, country, phone, fax, tax_id)
VALUES
  ('OptiLux Global', 'Main Street', '123', '2', 'B', 'Barcelona', '08001', 'Spain', '+34 933 111 222', '+34 933 111 223', 'A12345678'),
  ('VisionTech Inc.', 'High Road', '58', '1', 'A', 'Madrid', '28001', 'Spain', '+34 910 222 333', '+34 910 222 334', 'B87654321');

-- Frame types
INSERT INTO frame_types (frame_type) VALUES
  ('metal'),
  ('plastic'),
  ('rimless');

-- Employees
INSERT INTO employees (name)
VALUES
  ('Laura Fernandez'),
  ('Jordi Sala');

-- Brands
INSERT INTO brand (name, supplier_id)
VALUES
  ('RayBan', 1),
  ('Oakley', 1),
  ('Vogue Eyewear', 2),
  ('Persol', 2);

-- Glasses
INSERT INTO glasses (graduation, frame_type_id, brand_id, frame_colour, lens_colour, price)
VALUES
  (1, 1, 1, 'black', 'gray', 120.00),
  (2, 2, 1, 'tortoise', 'brown', 99.50),
  (0, 3, 2, 'silver', 'clear', 150.00);

-- Customers
INSERT INTO customer (name, address, phone, email)
VALUES
  ('Alice Green', 'Calle Mallorca 123', '+34 600 111 222', 'alice@example.com'),
  ('Bob White', 'Calle Gran Via 45', '+34 600 333 444', 'bob@example.com');

INSERT INTO customer (name, address, phone, email, referral_from_customer_id)
VALUES
  ('Carla Blue', 'Calle Marina 98', '+34 600 555 666', 'carla@example.com', 1);
  

-- Sales
INSERT INTO sales (employee_id, customer_id, glasses_id)
VALUES
  (1, 1, 1),  -- Laura sells to Alice
  (2, 2, 2),  -- Jordi sells to Bob
  (1, 3, 3);  -- Laura sells to Carla