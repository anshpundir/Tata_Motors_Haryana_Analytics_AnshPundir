-- Create the database
CREATE DATABASE tata_sales_2024_25;

-- Use the database
USE tata_sales_2024_25;

-- Table 1: Cars
CREATE TABLE cars (
    car_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(50) NOT NULL,
    variant VARCHAR(50),
    fuel_type VARCHAR(20),
    transmission VARCHAR(20),
    price DECIMAL(10,2),
    launch_year INT
);

-- Table 2: Dealers
CREATE TABLE dealers (
    dealer_id INT PRIMARY KEY AUTO_INCREMENT,
    dealer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    contact_no VARCHAR(15),
    email VARCHAR(100)
);

-- Table 3: Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    phone_no VARCHAR(15),
    email VARCHAR(100)
);

-- Table 4: Sales
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    car_id INT,
    dealer_id INT,
    sale_date DATE,
    sale_price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (car_id) REFERENCES cars(car_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (dealer_id) REFERENCES dealers(dealer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO dealers (dealer_name, city, contact_no, email) VALUES
('Tata Motors Gurgaon 1', 'Gurgaon', '9812345670', 'gurgaon1@tatamotors.in'),
('Tata Motors Hisar 2', 'Hisar', '9823456789', 'hisar2@tatamotors.in'),
('Tata Motors Rohtak 3', 'Rohtak', '9834567890', 'rohtak3@tatamotors.in'),
('Tata Motors Panipat 4', 'Panipat', '9845678901', 'panipat4@tatamotors.in'),
('Tata Motors Ambala 5', 'Ambala', '9856789012', 'ambala5@tatamotors.in'),
('Tata Motors Rewari 6', 'Rewari', '9867890123', 'rewari6@tatamotors.in'),
('Tata Motors Karnal 7', 'Karnal', '9878901234', 'karnal7@tatamotors.in'),
('Tata Motors Sonipat 8', 'Sonipat', '9889012345', 'sonipat8@tatamotors.in'),
('Tata Motors Yamunanagar 9', 'Yamunanagar', '9890123456', 'yamu9@tatamotors.in'),
('Tata Motors Sirsa 10', 'Sirsa', '9901234567', 'sirsa10@tatamotors.in');

INSERT INTO cars (model_name, variant, fuel_type, transmission, price, launch_year) VALUES
('Tiago', 'XE', 'Petrol', 'Manual', 550000, 2023),
('Tigor', 'XZ+', 'Petrol', 'Manual', 750000, 2024),
('Punch', 'Adventure', 'Petrol', 'Manual', 820000, 2024),
('Altroz', 'XZ Turbo', 'Petrol', 'Manual', 980000, 2023),
('Nexon', 'Smart+', 'Petrol', 'Manual', 1199000, 2024),
('Tiago EV', 'LR XZ+', 'Electric', 'Automatic', 1149000, 2025),
('Tigor EV', 'XZ+', 'Electric', 'Automatic', 1200000, 2024),
('Altroz', 'XZ+', 'Diesel', 'Manual', 999000, 2024),
('Punch', 'Creative', 'Petrol', 'Manual', 865000, 2025),
('Tiago', 'XT', 'Petrol', 'Manual', 610000, 2024);

INSERT INTO customers (name, city, phone_no, email) VALUES
('Rohan Malik', 'Rohtak', '9876543210', 'rohan.malik@gmail.com'),
('Meena Verma', 'Hisar', '9998887776', 'meena.verma@gmail.com'),
('Amit Dabas', 'Gurgaon', '9897765544', 'amit.dabas@gmail.com'),
('Kavita Singh', 'Ambala', '9823456789', 'kavita.singh@gmail.com'),
('Manish Kumar', 'Karnal', '9988776655', 'manish.kumar@gmail.com'),
('Deepak Yadav', 'Panipat', '9812345678', 'deepak.yadav@gmail.com'),
('Neha Sharma', 'Sonipat', '9912345678', 'neha.sharma@gmail.com'),
('Rahul Chaudhary', 'Rewari', '9923456789', 'rahul.chaudhary@gmail.com'),
('Priya Gupta', 'Yamunanagar', '9934567890', 'priya.gupta@gmail.com'),
('Arjun Saini', 'Sirsa', '9945678901', 'arjun.saini@gmail.com');

INSERT INTO sales (customer_id, car_id, dealer_id, sale_date, sale_price) VALUES
(1, 3, 2, '2024-04-15', 820000),
(2, 1, 3, '2024-06-20', 540000),
(3, 5, 1, '2025-01-18', 1185000),
(4, 6, 4, '2024-12-09', 1149000),
(5, 2, 5, '2025-03-25', 730000),
(6, 8, 7, '2024-09-14', 985000),
(7, 4, 8, '2025-05-22', 965000),
(8, 9, 6, '2024-11-11', 860000),
(9, 10, 9, '2024-07-07', 600000),
(10, 7, 10, '2025-02-19', 1200000);

SELECT * FROM dealers LIMIT 10;
SELECT * FROM cars LIMIT 10;
SELECT * FROM customers LIMIT 10;
SELECT * FROM sales LIMIT 10;

SELECT 
    d.dealer_name,
    d.city,
    COUNT(s.sale_id) AS total_cars_sold,
    SUM(s.sale_price) AS total_revenue
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY d.dealer_id
ORDER BY total_cars_sold DESC;

SELECT 
    c.model_name,
    COUNT(s.sale_id) AS total_units_sold,
    ROUND(AVG(s.sale_price)) AS avg_selling_price
FROM sales s
JOIN cars c ON s.car_id = c.car_id
GROUP BY c.model_name
ORDER BY total_units_sold DESC
LIMIT 5;

SELECT 
    d.city,
    ROUND(AVG(s.sale_price), 0) AS avg_sale_price,
    COUNT(s.sale_id) AS total_sales
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY d.city
ORDER BY avg_sale_price DESC;

SELECT 
    d.dealer_name,
    d.city,
    SUM(s.sale_price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(s.sale_price) DESC) AS dealer_rank
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY d.dealer_id;

SELECT 
    c.name AS customer_name,
    c.city,
    COUNT(s.sale_id) AS total_purchases,
    SUM(s.sale_price) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING COUNT(s.sale_id) > 1
ORDER BY total_purchases DESC;

CREATE VIEW top_models AS
SELECT c.model_name, COUNT(s.sale_id) AS total_sold, SUM(s.sale_price) AS total_revenue
FROM sales s
JOIN cars c ON s.car_id = c.car_id
GROUP BY c.model_name
ORDER BY total_sold DESC;

CREATE VIEW city_revenue_summary AS
SELECT d.city, SUM(s.sale_price) AS total_revenue
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY d.city
ORDER BY total_revenue DESC;

SELECT 
    COUNT(s.sale_id) AS total_sales,
    ROUND(SUM(s.sale_price), 0) AS total_revenue,
    ROUND(AVG(s.sale_price), 0) AS avg_sale_price
FROM sales s;

SELECT 
    d.city,
    c.fuel_type,
    COUNT(s.sale_id) AS total_units
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
JOIN cars c ON s.car_id = c.car_id
GROUP BY d.city, c.fuel_type
ORDER BY d.city;

SELECT 
    d.city,
    SUM(s.sale_price) AS total_revenue
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY d.city
ORDER BY total_revenue DESC
LIMIT 3;

SELECT 
    d.dealer_name,
    c.model_name,
    COUNT(s.sale_id) AS total_units_sold,
    SUM(s.sale_price) AS total_revenue
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
JOIN cars c ON s.car_id = c.car_id
GROUP BY d.dealer_name, c.model_name
ORDER BY total_revenue DESC
LIMIT 10;

SELECT 
    c.model_name,
    AVG(s.sale_price) AS avg_price,
    COUNT(s.sale_id) AS units_sold
FROM sales s
JOIN cars c ON s.car_id = c.car_id
GROUP BY c.model_name;

SELECT 
    d.city,
    c.fuel_type,
    COUNT(s.sale_id) AS total_sales
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
JOIN cars c ON s.car_id = c.car_id
GROUP BY d.city, c.fuel_type;

SELECT 
    d.dealer_name,
    SUM(s.sale_price) AS total_revenue
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY d.dealer_name;


