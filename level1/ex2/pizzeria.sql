-- Adrià Lorente - Pizzeria DB
-- Database creation and data loading script

CREATE DATABASE pizzeria;
USE pizzeria;

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
image BLOB,
price DECIMAL(5,2) NOT NULL,
product_type ENUM ('pizza', 'hamburguer', 'beverage') NOT NULL
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
