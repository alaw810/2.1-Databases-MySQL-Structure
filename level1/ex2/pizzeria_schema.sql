-- Pizzeria database creation and data loading script

DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

-- Create tables

CREATE TABLE provinces (
province_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(80) NOT NULL
);

CREATE TABLE localities (
locality_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(120) NOT NULL,
province_id INT NOT NULL,
FOREIGN KEY (province_id) REFERENCES provinces(province_id)
);

CREATE TABLE customers (
customer_id  INT AUTO_INCREMENT PRIMARY KEY,
first_name   VARCHAR(60)  NOT NULL,
last_name    VARCHAR(100) NOT NULL,
address      VARCHAR(150) NOT NULL,
postal_code  VARCHAR(10)  NOT NULL,
locality_id  INT NOT NULL,
phone        VARCHAR(20)  NOT NULL,
FOREIGN KEY (locality_id) REFERENCES localities(locality_id)
);

CREATE TABLE stores (
store_id INT AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(100) NOT NULL,
postal_code VARCHAR(5) NOT NULL,
locality_id INT NOT NULL,
FOREIGN KEY (locality_id) REFERENCES localities(locality_id)
);

CREATE TABLE employees (
employee_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(60)  NOT NULL,
last_name VARCHAR(100) NOT NULL,
nif VARCHAR(20)  NOT NULL,
phone VARCHAR(20)  NOT NULL,
role ENUM('cook','delivery') NOT NULL,
store_id INT NOT NULL,
FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE pizza_categories (
category_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(80) NOT NULL
);

CREATE TABLE products (
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_type ENUM ('pizza', 'burger', 'drink') NOT NULL,
name VARCHAR(120) NOT NULL,
description TEXT,
image_URL VARCHAR(255),
price DECIMAL(10,2) NOT NULL,
category_id INT NULL,
FOREIGN KEY (category_id) REFERENCES pizza_categories(category_id)
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  store_id INT NOT NULL,
  order_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
  order_type ENUM ('delivery', 'pickup') NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  delivered_by_employee_id INT NULL,
  delivered_at DATETIME NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (delivered_by_employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE order_items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT UNSIGNED NOT NULL DEFAULT 1,
  unit_price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into tables

INSERT INTO provinces (province_id, name) VALUES
  (1, 'Barcelona'),
  (2, 'Madrid');

INSERT INTO localities (locality_id, name, province_id) VALUES
  (1, 'Barcelona', 1),
  (2, 'L\'Hospitalet de Llobregat', 1),
  (3, 'Madrid', 2),
  (4, 'Alcobendas', 2);

INSERT INTO stores (store_id, address, postal_code, locality_id) VALUES
  (1, 'Carrer Mallorca 200', '08036', 1),
  (2, 'Av. Carrilet 12', '08902', 2),
  (3, 'Calle Atocha 45', '28012', 3);

INSERT INTO employees (employee_id, first_name, last_name, nif, phone, role, store_id) VALUES
  (1, 'Ana', 'Pérez', '11111111A', '+34 600 000 001', 'cook', 1),
  (2, 'Luis', 'Gómez', '22222222B', '+34 600 000 002', 'delivery', 1),
  (3, 'Marta', 'Ruiz', '33333333C', '+34 600 000 003', 'cook', 2),
  (4, 'Jorge', 'López', '44444444D', '+34 600 000 004', 'delivery', 2),
  (5, 'Sara', 'Díaz', '55555555E', '+34 600 000 005', 'cook', 3),
  (6, 'Pablo', 'Martín', '66666666F', '+34 600 000 006', 'delivery', 3);

INSERT INTO pizza_categories (category_id, name) VALUES
  (1, 'Classics'),
  (2, 'Specials'),
  (3, 'Veggies');

INSERT INTO products (product_id, product_type, name, description, image_url, price, category_id) VALUES
  (1, 'pizza', 'Margherita', 'Tomato, mozzarella y basil', NULL, 8.50, 1),
  (2, 'pizza', 'Pepperoni', 'Tomato, mozzarella y pepperoni', NULL, 9.50, 1),
  (3, 'pizza', 'BBQ Chicken', 'Chicken, barbecue sauce, onion', NULL,11.00, 2),
  (4, 'pizza', '4 Cheeses', 'Mozzarella, gorgonzola, parmesano, emmental', NULL, 10.00, 1),
  (5, 'pizza', 'Vegan', 'Roasted veggies and vegan cheese', NULL, 10.50, 3),
  (6, 'burger', 'Cheese Burger', 'Classic with cheese', NULL, 7.50, NULL),
  (7, 'burger', 'Double Burger', 'Double meat and cheese', NULL, 9.00, NULL),
  (8, 'drink', 'Cola 330ml', 'Cola soda', NULL, 2.00, NULL),
  (9, 'drink', 'Water 500ml', 'Spring water', NULL, 1.50, NULL),
  (10,'drink', 'Beer 330ml', 'Lager', NULL, 2.50, NULL);

INSERT INTO customers (customer_id, first_name, last_name, address, postal_code, locality_id, phone) VALUES
  (1, 'Carlos', 'Sánchez', 'C/ Provença 10', '08029', 1, '+34 600 111 111'),
  (2, 'Laura', 'Martínez','C/ Enric Prat de la Riba 5', '08901', 2, '+34 600 222 222'),
  (3, 'Pedro', 'García',  'C/ Alcalá 200', '28028', 3, '+34 600 333 333'),
  (4, 'Ana', 'López', 'Av. Olímpica 3', '28100', 4, '+34 600 444 444');

INSERT INTO orders (order_id, customer_id, store_id, order_datetime, order_type, total_price, delivered_by_employee_id, delivered_at) VALUES
  (1, 1, 1, '2025-09-03 20:05:00', 'delivery', 21.00, 2, '2025-09-03 20:40:00'),
  (2, 2, 2, '2025-09-03 13:15:00', 'pickup', 11.00, NULL, NULL),
  (3, 3, 3, '2025-09-04 21:10:00', 'delivery', 25.00, 6, '2025-09-04 21:55:00'),
  (4, 1, 1, '2025-09-05 12:30:00', 'pickup', 12.00, NULL, NULL),
  (5, 4, 3, '2025-09-05 19:20:00', 'delivery', 13.50, 6, '2025-09-05 20:00:00'),
  (6, 2, 2, '2025-09-06 20:00:00', 'delivery', 32.00, 4, '2025-09-06 20:35:00'),
  (7, 3, 3, '2025-09-06 13:00:00', 'pickup', 10.50, NULL, NULL),
  (8, 1, 1, '2025-09-07 21:00:00', 'delivery', 34.00, 2, '2025-09-07 21:30:00');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  -- Order 1: 2x Margherita + 2x Cola = 17 + 4 = 21
  (1, 1, 1, 2, 8.50),
  (2, 1, 8, 2, 2.00),

  -- Order 2: 1x Pepperoni + 1x Water = 9.5 + 1.5 = 11
  (3, 2, 2, 1, 9.50),
  (4, 2, 9, 1, 1.50),

  -- Order 3: 1x BBQ Chicken + 1x Double Burger + 2x Beer = 11 + 9 + 5 = 25
  (5, 3, 3, 1, 11.00),
  (6, 3, 7, 1, 9.00),
  (7, 3,10, 2, 2.50),

  -- Order 4: 1x 4 Cheeses + 1x Cola = 10 + 2 = 12
  (8, 4, 4, 1, 10.00),
  (9, 4, 8, 1, 2.00),

  -- Order 5: 1x Vegan + 2x Water = 10.5 + 3 = 13.5
  (10, 5, 5, 1, 10.50),
  (11, 5, 9, 2, 1.50),

  -- Order 6: 2x Cheese Burger + 1x Pepperoni + 3x Beer = 15 + 9.5 + 7.5 = 32
  (12, 6, 6, 2, 7.50),
  (13, 6, 2, 1, 9.50),
  (14, 6,10, 3, 2.50),

  -- Order 7: 1x Margherita + 1x Cola = 8.5 + 2 = 10.5
  (15, 7, 1, 1, 8.50),
  (16, 7, 8, 1, 2.00),

  -- Order 8: 2x BBQ Chicken + 1x Vegan + 1x Water = 22 + 10.5 + 1.5 = 34
  (17, 8, 3, 2, 11.00),
  (18, 8, 5, 1, 10.50),
  (19, 8, 9, 1, 1.50);
