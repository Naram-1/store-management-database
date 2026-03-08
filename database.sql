-- Create database if it does not exist
CREATE DATABASE IF NOT EXISTS store_management;
USE store_management;

-- Tables

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    contact_info VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    sku VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT,
    category_id INT,
    supplier_id INT,
    active BOOLEAN,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    payment_method VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE IF NOT EXISTS OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE IF NOT EXISTS StockLogs (
    stock_log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    change_amount INT,
    change_reason VARCHAR(50),
    change_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Categories

INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Office Supplies'),
('Accessories'),
('Furniture'),
('Computer Components');

-- Suppliers

INSERT INTO Suppliers (name, contact_info) VALUES
('Nordic Tech AB', 'contact@nordictech.com'),
('OfficePro Ltd', 'sales@officepro.com'),
('Global Electronics', 'support@globalelec.com'),
('DeskWorld Sweden', 'info@deskworld.se'),
('Accessory Planet', 'sales@accessoryplanet.com');

-- Customers

INSERT INTO Customers (name, email, phone) VALUES
('Liam Andersson', 'liam.andersson@email.com', '0701234567'),
('Emma Johansson', 'emma.johansson@email.com', '0709876543'),
('Noah Karlsson', 'noah.karlsson@email.com', '0723456789'),
('Olivia Nilsson', 'olivia.nilsson@email.com', '0731122334'),
('Lucas Eriksson', 'lucas.eriksson@email.com', '0745566778'),
('Maja Lindberg', 'maja.lindberg@email.com', '0769988776'),
('William Svensson', 'william.svensson@email.com', '0704433221');

-- Products

INSERT INTO Products (name, sku, price, stock_quantity, category_id, supplier_id, active) VALUES
('Laptop Pro 15', 'ELEC1001', 1350.00, 12, 1, 1, TRUE),
('Wireless Mouse', 'ELEC1002', 24.99, 55, 1, 5, TRUE),
('Mechanical Keyboard', 'ELEC1003', 79.99, 40, 1, 3, TRUE),
('Office Chair Ergonomic', 'FURN2001', 189.00, 6, 4, 4, TRUE),
('Adjustable Desk Lamp', 'OFF3001', 34.50, 18, 2, 2, TRUE),
('USB-C Charging Cable', 'ACC4001', 12.99, 95, 3, 5, TRUE),
('Laptop Stand Aluminum', 'ACC4002', 29.90, 14, 3, 5, TRUE),
('Notebook Pack A4', 'OFF3002', 9.50, 70, 2, 2, TRUE),
('External SSD 1TB', 'ELEC1004', 149.99, 22, 1, 3, TRUE),
('Gaming Headset', 'ELEC1005', 89.90, 25, 1, 3, TRUE),
('Office Desk Large', 'FURN2002', 320.00, 4, 4, 4, TRUE);

-- Orders

INSERT INTO Orders (customer_id, order_date, status, payment_method) VALUES
(1, '2025-04-10', 'Completed', 'Card'),
(2, '2025-04-11', 'Completed', 'Swish'),
(3, '2025-04-13', 'Completed', 'Card'),
(4, '2025-04-15', 'Completed', 'Cash'),
(5, '2025-04-18', 'Completed', 'Card'),
(6, '2025-04-19', 'Completed', 'Card');

-- Order Items

INSERT INTO OrderItems (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1350.00),
(1, 2, 2, 24.99),
(2, 3, 1, 79.99),
(2, 6, 3, 12.99),
(3, 4, 1, 189.00),
(3, 7, 1, 29.90),
(4, 8, 4, 9.50),
(5, 9, 1, 149.99),
(5, 10, 1, 89.90),
(6, 11, 1, 320.00);

-- Stock Logs

INSERT INTO StockLogs (product_id, change_amount, change_reason, change_date) VALUES
(1, -1, 'Sale', '2025-04-10'),
(2, -2, 'Sale', '2025-04-10'),
(3, -1, 'Sale', '2025-04-11'),
(6, -3, 'Sale', '2025-04-11'),
(4, -1, 'Sale', '2025-04-13'),
(7, -1, 'Sale', '2025-04-13'),
(8, -4, 'Sale', '2025-04-15'),
(9, -1, 'Sale', '2025-04-18'),
(10, -1, 'Sale', '2025-04-18'),
(11, -1, 'Sale', '2025-04-19');