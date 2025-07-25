CREATE DATABASE cul_dampolla_store;

USE cul_dampolla_store;

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

CREATE TABLE brand (
brand_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
supplier_id INT NOT NULL,
FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

INSERT INTO supplier (name, street, number, floor, door, city, postal_code, country, phone, fax, tax_id)
VALUES
('OptiLux Global', 'Main Street', '123', '2', 'B', 'Barcelona', '08001', 'Spain', '+34 933 111 222', '+34 933 111 223', 'A12345678'),
('VisionTech Inc.', 'High Road', '58', '1', 'A', 'Madrid', '28001', 'Spain', '+34 910 222 333', '+34 910 222 334', 'B87654321');

INSERT INTO brand (name, supplier_id)
VALUES
('RayBan', 1),
('Oakley', 1),
('Vogue Eyewear', 2),
('Persol', 2);

CREATE TABLE frame_types (
frame_type_id INT AUTO_INCREMENT PRIMARY KEY,
frame_type VARCHAR(10) NOT NULL
);

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
