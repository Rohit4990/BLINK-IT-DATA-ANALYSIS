CREATE DATABASE BLINKIT;

USE BLINKIT;


CREATE TABLE products (
    id INT PRIMARY KEY,
    category VARCHAR(50),
    name VARCHAR(100),
    brand VARCHAR(50),
    price DECIMAL(10,2),
    unit VARCHAR(20),
    stock INT
);


INSERT INTO products (id, category, name, brand, price, unit, stock) VALUES
(1,'Dairy & Bakery','Amul Milk','Amul',54,'Litre',120),
(2,'Dairy & Bakery','Britannia Bread','Britannia',45,'Pack',80),
(3,'Dairy & Bakery','Paneer','Amul',85,'200g',60),
(4,'Fruits & Vegetables','Apple','Fresho',120,'Kg',90),
(5,'Fruits & Vegetables','Banana','Fresho',50,'Dozen',100),
(6,'Fruits & Vegetables','Onion','Local',40,'Kg',150),
(7,'Snacks & Beverages','Lays Chips','Lays',20,'Pack',300),
(8,'Snacks & Beverages','Coca Cola','Coca Cola',40,'Bottle',200),
(9,'Snacks & Beverages','Maggi Noodles','Nestle',15,'Pack',400),
(10,'Foodgrains & Oil','Rice (Basmati)','India Gate',120,'Kg',70),
(11,'Foodgrains & Oil','Wheat Flour','Aashirvaad',45,'Kg',100),
(12,'Foodgrains & Oil','Soyabean Oil','Fortune',160,'Litre',50),
(13,'Household','Cleaning Spray','Harpic',99,'Bottle',60),
(14,'Household','Detergent Powder','Surf Excel',210,'Kg',75),
(15,'Household','Toilet Paper','Softex',60,'Roll',120),
(16,'Personal Care','Shampoo','Head & Shoulders',180,'Bottle',90),
(17,'Personal Care','Toothpaste','Colgate',95,'Pack',110),
(18,'Personal Care','Soap','Dove',40,'Bar',200),
(19,'Baby Care','Baby Powder','Johnson’s',160,'Bottle',50),
(20,'Baby Care','Diapers','Pampers',450,'Pack',40);



SELECT * FROM PRODUCTS;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    qty INT,
    total DECIMAL(10,2),
    order_date datetime,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO orders (id, product_id, qty, total, order_date) VALUES
(1, 1, 2, 108.00, '2025-09-20 10:15:00'),   -- Amul Milk
(2, 4, 1, 120.00, '2025-09-20 11:05:00'),   -- Apple
(3, 7, 5, 100.00, '2025-09-20 12:30:00'),   -- Lays Chips
(4, 10, 3, 360.00, '2025-09-20 14:45:00'),  -- Rice
(5, 17, 2, 190.00, '2025-09-20 16:10:00'),  -- Colgate Toothpaste
(6, 2, 4, 180.00, '2025-09-20 17:20:00'),   -- Britannia Bread
(7, 5, 2, 100.00, '2025-09-20 18:40:00'),   -- Banana
(8, 8, 6, 240.00, '2025-09-20 19:25:00'),   -- Coca Cola
(9, 12, 1, 160.00, '2025-09-21 09:00:00'),  -- Soyabean Oil
(10, 18, 10, 400.00, '2025-09-21 09:30:00'),-- Dove Soap
(11, 3, 2, 170.00, '2025-09-21 10:15:00'),  -- Paneer
(12, 6, 5, 200.00, '2025-09-21 11:00:00'),  -- Onion
(13, 9, 12, 180.00, '2025-09-21 11:45:00'), -- Maggi Noodles
(14, 11, 4, 180.00, '2025-09-21 13:20:00'), -- Wheat Flour
(15, 15, 3, 180.00, '2025-09-21 14:00:00'); -- Toilet Paper


SELECT * FROM ORDERS;

SELECT COUNT(ID) AS TOTAL_ORDERS FROM ORDERS;

#1----All Orders with Product Details

SELECT O.ID AS ORDERS , NAME , CATEGORY , PRICE , QTY , TOTAL , ORDER_DATE FROM ORDERS AS O
JOIN PRODUCTS AS P
ON O.PRODUCT_ID = P.ID;


#2----Total Sales (₹) from All Orders

SELECT SUM(TOTAL) AS TOTAL_SALES 
FROM ORDERS;


#3----Most Ordered Products (Top 10)

SELECT O.ID ,NAME , SUM(QTY) AS TOTAL_QUANTITY FROM ORDERS AS O
JOIN PRODUCTS AS P
ON O.PRODUCT_ID = P.ID
GROUP BY NAME , O.ID 
ORDER BY TOTAL_QUANTITY DESC
LIMIT 10;


#4----Revenue by Product:-

SELECT NAME , SUM(TOTAL) AS REVENUE FROM ORDERS AS O
JOIN PRODUCTS AS P
ON O.PRODUCT_ID = P.ID
GROUP BY NAME 
ORDER BY REVENUE DESC
limit 5;



#5-----Orders per Day (Sales Trend)

SELECT DATE(ORDER_DATE) AS DAY , COUNT(ID) , SUM(TOTAL) AS TOTAL_SALES FROM ORDERS AS O
GROUP BY DATE(ORDER_DATE)
ORDER BY DAY;


#6-----Revenue by Category:-

SELECT CATEGORY , SUM(TOTAL) AS REVENUE FROM ORDERS AS O
JOIN PRODUCTS AS P
ON O.PRODUCT_ID = P.ID
GROUP BY CATEGORY
ORDER BY REVENUE DESC;


#7-----Average Order Value (AOV):-

SELECT SUM(TOTAL) * 1.0 / COUNT(DISTINCT ID) AS AOV
FROM ORDERS;

