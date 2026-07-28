SELECT *
FROM pizza_sales;

ALTER TABLE pizza_sales
MODIFY COLUMN pizza_name_id VARCHAR(50)
;

SELECT order_date
FROM pizza_sales
LIMIT 3
;

UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y')
;

ALTER TABLE pizza_sales
MODIFY COLUMN order_date DATE
;

ALTER TABLE pizza_sales
MODIFY COLUMN order_time TIME
;

ALTER TABLE pizza_sales
MODIFY COLUMN unit_price DECIMAL(10,2)
;

ALTER TABLE pizza_sales
MODIFY COLUMN total_price DECIMAL(10,2)
;

ALTER TABLE pizza_sales
MODIFY COLUMN pizza_size VARCHAR(50)
;

ALTER TABLE pizza_sales
MODIFY COLUMN pizza_category VARCHAR(50)
;

ALTER TABLE pizza_sales
MODIFY COLUMN pizza_ingredients VARCHAR(200)
;

ALTER TABLE pizza_sales
MODIFY COLUMN pizza_name VARCHAR(50)
;

DESCRIBE pizza_sales
;

SELECT *
FROM pizza_sales
;

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales
;

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales
;

SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
;

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
;

SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS Avg_Pizzas_Per_Orders
FROM pizza_sales
;

SELECT DAYNAME(order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY Order_Day, WEEKDAY(order_date)
ORDER BY WEEKDAY(order_date)
;

SELECT MONTHNAME(order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date)
;

SELECT pizza_category, SUM(total_price) AS Total_Sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS DECIMAL(10,2)) AS Percentage_of_Total_Sales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
;

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE QUARTER(order_date) = 1) AS DECIMAL(10,2)) AS Percentage_of_Total_Sales
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY Percentage_of_Total_Sales DESC
;

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5
;

SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5
;

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5
;