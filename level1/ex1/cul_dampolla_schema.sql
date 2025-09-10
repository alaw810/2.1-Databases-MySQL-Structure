--  "Cul d'Ampolla" database creation and data loading script

DROP DATABASE IF EXISTS cul_dampolla_store;
CREATE DATABASE cul_dampolla_store CHARACTER SET utf8mb4;
USE cul_dampolla_store;

-- Create tables

CREATE TABLE suppliers (
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

CREATE TABLE frame_types (
  frame_type_id INT AUTO_INCREMENT PRIMARY KEY,
  frame_type VARCHAR(22) NOT NULL
);

CREATE TABLE employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL
);

CREATE TABLE brands (
  brand_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  supplier_id INT NOT NULL,
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE glasses (
  glasses_id INT AUTO_INCREMENT PRIMARY KEY,
  brand_id INT NOT NULL,
  frame_type_id INT NOT NULL,
  frame_colour VARCHAR(20) NOT NULL,
  grad_left DECIMAL(4,2) NOT NULL DEFAULT 0.00,
  grad_right DECIMAL(4,2) NOT NULL DEFAULT 0.00,
  color_left VARCHAR(20) NOT NULL DEFAULT 'clear',
  color_right VARCHAR(20) NOT NULL DEFAULT 'clear',
  price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
  FOREIGN KEY (frame_type_id) REFERENCES frame_types(frame_type_id)
);

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL,
  street VARCHAR(100),
  number VARCHAR(10),
  floor VARCHAR(10),
  door VARCHAR(10),
  city VARCHAR(50),
  postal_code VARCHAR(10),
  country VARCHAR(50),
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(100),
  register_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  referral_from_customer_id INT,
  FOREIGN KEY (referral_from_customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  employee_id INT NOT NULL,
  customer_id INT NOT NULL,
  glasses_id INT NOT NULL,
  sale_price DECIMAL(10,2) NOT NULL,
  sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (glasses_id)  REFERENCES glasses(glasses_id)
);

-- Insert data into tables

INSERT INTO suppliers
(name, street, number, floor, door, city, postal_code, country, phone, fax, tax_id) VALUES
  ('OptiLux Global', 'Main Street', '123', '2', 'B', 'Barcelona', '08001', 'Spain', '+34 933 111 222', '+34 933 111 223', 'A12345678'),
  ('VisionTech Inc.', 'High Road', '58', '1', 'A', 'Madrid', '28001', 'Spain', '+34 910 222 333', '+34 910 222 334', 'B87654321');

INSERT INTO frame_types (frame_type) VALUES
  ('metal'),
  ('plastic'),
  ('rimless');

INSERT INTO employees (name) VALUES
  ('Laura Fernandez'),
  ('Jordi Sala');

INSERT INTO brands (name, supplier_id) VALUES
  ('RayBan', 1),
  ('Oakley', 1),
  ('Vogue Eyewear', 2),
  ('Persol', 2);

INSERT INTO glasses
(brand_id, frame_type_id, frame_colour, grad_left, grad_right, color_left, color_right, price) VALUES
  (1, 1, 'black', 1.00, 1.00, 'gray', 'gray', 120.00),
  (1, 2, 'tortoise', 2.25, 2.25, 'brown', 'brown', 99.50),
  (2, 3, 'silver', 0.00, 0.00, 'clear', 'clear', 150.00);

INSERT INTO customers
(name, street, number, city, postal_code, country, phone, email) VALUES
  ('Alice Green', 'Calle Mallorca', '123', 'Barcelona', '08029', 'Spain', '+34 600 111 222', 'alice@example.com'),
  ('Bob White', 'Gran Via', '45', 'Barcelona', '08010', 'Spain', '+34 600 333 444', 'bob@example.com');

INSERT INTO customers
(name, street, number, city, postal_code, country, phone, email, referral_from_customer_id) VALUES
  ('Carla Blue', 'Calle Marina', '98', 'Barcelona', '08005', 'Spain', '+34 600 555 666', 'carla@example.com', 1);

INSERT INTO sales (employee_id, customer_id, glasses_id, sale_price)
SELECT 1, 1, g.glasses_id, g.price FROM glasses g WHERE g.glasses_id = 1
UNION ALL
SELECT 2, 1, g.glasses_id, g.price FROM glasses g WHERE g.glasses_id = 3
UNION ALL
SELECT 2, 2, g.glasses_id, g.price FROM glasses g WHERE g.glasses_id = 2
UNION ALL
SELECT 1, 3, g.glasses_id, g.price FROM glasses g WHERE g.glasses_id = 3;
