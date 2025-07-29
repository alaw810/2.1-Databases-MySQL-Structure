-- Adrià Lorente - Pizzeria DB
-- Database creation and data loading script

CREATE DATABASE pizzeria;
USE pizzeria;

-- Create tables

CREATE TABLE province (
province_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL
);

CREATE TABLE city (
city_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
province_id INT NOT NULL,
FOREIGN KEY (province_id) REFERENCES province(province_id)
);

CREATE TABLE store (
store_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
address VARCHAR(100) NOT NULL,
postal_code VARCHAR(5) NOT NULL,
city_id INT NOT NULL,
FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE employee (
employee_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
surname VARCHAR(50) NOT NULL,
nif VARCHAR(9) UNIQUE NOT NULL,
phone VARCHAR(15) NOT NULL,
store_id INT NOT NULL,
role ENUM('cook', 'delivery') NOT NULL,
FOREIGN KEY (store_id) REFERENCES store(store_id)
);

CREATE TABLE customer (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
surname VARCHAR(50) NOT NULL,
address VARCHAR(100) NOT NULL,
postal_code VARCHAR(5) NOT NULL,
city_id INT NOT NULL,
phone VARCHAR(15) UNIQUE NOT NULL,
FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE pizza_category (
category_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL
);

CREATE TABLE product (
product_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
description VARCHAR(100) NOT NULL,
image_path VARCHAR(255),
price DECIMAL(5,2) NOT NULL,
product_type ENUM ('pizza', 'hamburger', 'beverage') NOT NULL
);

-- Only products with product_type = 'pizza' should be listed here

CREATE TABLE pizza (
pizza_id INT PRIMARY KEY,
category_id INT NOT NULL,
FOREIGN KEY (pizza_id) REFERENCES product(product_id),
FOREIGN KEY (category_id) REFERENCES pizza_category(category_id)
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  store_id INT NOT NULL,
  order_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
  delivery BOOLEAN NOT NULL,
  delivery_employee_id INT, -- To be filled only if 'delivery' = true
  delivery_datetime DATETIME, -- To be filled only if 'delivery' = true
  total_price DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (store_id) REFERENCES store(store_id),
  FOREIGN KEY (delivery_employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE order_details (
  order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Insert data into tables

INSERT INTO province (name) VALUES 
('Barcelona'),
('Girona');

INSERT INTO city (name, province_id) VALUES 
('Barcelona', 1),
('Badalona', 1),
('Girona', 2);

INSERT INTO store (name, address, postal_code, city_id) VALUES 
('Central Pizzeria', 'Carrer Gran Via 1', '08001', 1),
('Girona Pizzeria', 'Rambla de Girona 10', '17001', 3);

INSERT INTO employee (name, surname, nif, phone, store_id, role) VALUES 
('Laura', 'Martínez', '12345678A', '600111222', 1, 'cook'),
('Marc', 'Solé', '87654321B', '600333444', 1, 'delivery'),
('Júlia', 'Pérez', '11223344C', '600555666', 2, 'cook');

INSERT INTO customer (name, surname, address, postal_code, city_id, phone) VALUES 
('Carla', 'Ribas', 'Carrer Marina 55', '08005', 1, '699111222'),
('Pol', 'Costa', 'Passeig Marítim 77', '08911', 2, '699333444');

INSERT INTO pizza_category (name) VALUES 
('Classics'),
('Specialties');

INSERT INTO product (name, description, image, price, product_type) VALUES 
('Margherita', 'Classic tomato and mozzarella', NULL, 7.50, 'pizza'),
('Pepperoni', 'Spicy pepperoni with cheese', NULL, 8.50, 'pizza'),
('Cheeseburger', 'Beef, cheddar, pickles', NULL, 6.00, 'hamburguer'),
('Cola', 'Refreshing soft drink', NULL, 1.80, 'beverage');

INSERT INTO pizza (pizza_id, category_id) VALUES 
(1, 1),
(2, 2);

INSERT INTO orders (customer_id, store_id, order_datetime, delivery, total_price, delivery_employee_id, delivery_datetime) VALUES 
(1, 1, NOW(), TRUE, 17.80, 2, NOW()),
(2, 2, NOW(), FALSE, 8.50, NULL, NULL);

-- Order 1: Carla buys 1 Pepperoni and 1 Cola
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES 
(1, 2, 1, 8.50),
(1, 4, 1, 1.80);

-- Order 2: Pol buys 1 Margherita
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES 
(2, 1, 1, 7.50);

