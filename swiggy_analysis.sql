
-- 🔐 Set up role and environment
USE ROLE SYSADMIN;

-- 📁 Create and use database + schema
CREATE OR REPLACE DATABASE swiggy_analysis;
USE DATABASE swiggy_analysis;

CREATE OR REPLACE SCHEMA food_orders;
USE SCHEMA food_orders;

-- 🏗️ Create table for Swiggy order data
CREATE OR REPLACE TABLE swiggy_orders (
    order_id INT,
    customer_name STRING,
    restaurant STRING,
    item STRING,
    price FLOAT,
    quantity INT,
    order_date DATE,
    payment_method STRING,
    delivery_status STRING
);

-- 📥 Insert sample records
INSERT INTO swiggy_orders VALUES
(1001, 'Rahul', 'Domino’s', 'Pizza Margherita', 299.00, 2, '2024-07-01', 'UPI', 'Delivered'),
(1002, 'Neha', 'KFC', 'Zinger Burger', 179.00, 1, '2024-07-01', 'Card', 'Delivered'),
(1003, 'Amit', 'Haldiram’s', 'Chole Bhature', 120.00, 1, '2024-07-01', 'Cash', 'Cancelled'),
(1004, 'Priya', 'Domino’s', 'Farmhouse Pizza', 399.00, 1, '2024-07-02', 'UPI', 'Delivered'),
(1005, 'Sana', 'Subway', 'Veggie Delight', 250.00, 1, '2024-07-03', 'Card', 'Delivered'),
(1006, 'Ravi', 'KFC', 'Chicken Bucket', 599.00, 1, '2024-07-04', 'Card', 'Delivered');

-- 🔍 Query 1: Total revenue by restaurant
-- 📊 Chart: Bar (X: restaurant, Y: total_revenue)
SELECT restaurant, 
       SUM(price * quantity) AS total_revenue
FROM swiggy_orders
WHERE delivery_status = 'Delivered'
GROUP BY restaurant
ORDER BY total_revenue DESC;

-- 🔍 Query 2: Daily revenue trend
-- 📈 Chart: Line chart (X: order_date, Y: daily_revenue)
SELECT order_date,
       SUM(price * quantity) AS daily_revenue
FROM swiggy_orders
WHERE delivery_status = 'Delivered'
GROUP BY order_date
ORDER BY order_date;

-- 🔍 Query 3: Orders by payment method
-- 📊 Chart: Pie or Bar (X: payment_method, Y: total_orders)
SELECT payment_method, 
       COUNT(*) AS total_orders
FROM swiggy_orders
GROUP BY payment_method;

-- 🔍 Query 4: Delivery status breakdown
-- 📊 Chart: Donut or Pie (X: delivery_status, Y: order_count)
SELECT delivery_status, 
       COUNT(*) AS order_count
FROM swiggy_orders
GROUP BY delivery_status;

-- 🔍 Query 5: Top-selling items
-- 📊 Chart: Horizontal bar (X: total_quantity, Y: item)
SELECT item, 
       SUM(quantity) AS total_quantity
FROM swiggy_orders
WHERE delivery_status = 'Delivered'
GROUP BY item
ORDER BY total_quantity DESC;
