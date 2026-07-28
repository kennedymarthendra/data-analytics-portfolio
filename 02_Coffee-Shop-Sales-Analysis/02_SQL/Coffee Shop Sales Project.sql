CREATE DATABASE coffee_shop_sales_db
;

SELECT * FROM coffee_shop_sales
;

DESCRIBE coffee_shop_sales
;

UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%d/%m/%Y')
;

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_date DATE
;

UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s')
;

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_time TIME
;

ALTER TABLE coffee_shop_sales
CHANGE COLUMN ï»¿transaction_id transaction_id INT
;

SELECT ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
;

SELECT CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
;

SELECT
	MONTH(transaction_date) AS Month,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000), 'K') AS Total_Sales,
    CONCAT(ROUND(((SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1) OVER (ORDER BY MONTH(transaction_date)))
    /
    LAG(SUM(unit_price * transaction_qty),1) OVER (ORDER BY MONTH(transaction_date)) * 100),1), '%') AS MoM_Increase_Percentage
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4,5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date)
;

SELECT DISTINCT(COUNT(transaction_id)) AS Total_Orders
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
;

SELECT
	MONTH(transaction_date) AS Month,
    ROUND(COUNT(transaction_id)) AS Total_Orders,
    CONCAT(ROUND(((COUNT(transaction_id) - LAG(COUNT(transaction_id), 1) OVER (ORDER BY MONTH(transaction_date)))
    /
    LAG(COUNT(transaction_id),1) OVER (ORDER BY MONTH(transaction_date)) * 100),1), '%') AS MoM_Increase_Percentage
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4,5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date)
;

SELECT SUM(transaction_qty) AS Total_Quantity_Sold
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
;

SELECT
	MONTH(transaction_date) AS Month,
    ROUND(SUM(transaction_qty)) AS Total_Quantity_Sold,
    CONCAT(ROUND(((SUM(transaction_qty) - LAG(SUM(transaction_qty), 1) OVER (ORDER BY MONTH(transaction_date)))
    /
    LAG(SUM(transaction_qty),1) OVER (ORDER BY MONTH(transaction_date)) * 100),1), '%') AS MoM_Increase_Percentage
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4,5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date)
;

SELECT
	ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales,
    SUM(transaction_qty) AS Total_Quantity_Sold,
    COUNT(transaction_id) AS Total_Orders
FROM coffee_shop_sales
WHERE transaction_date = '2023-05-18'
;

SELECT
    MTD.Total_Sales AS MTD_Sales,
    PMTD.Total_Sales AS PMTD_Sales,
    CONCAT(ROUND((MTD.Total_Sales - PMTD.Total_Sales)/1000, 1), "K") AS Diff_Sales,
    CONCAT(ROUND((MTD.Total_Sales - PMTD.Total_Sales) / PMTD.Total_Sales * 100, 1), "%") AS Sales_Growth_Percentage
FROM
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE transaction_date BETWEEN '2023-05-01' AND '2023-05-18'
) AS MTD
CROSS JOIN
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE transaction_date BETWEEN '2023-04-01' AND '2023-04-18'
) AS PMTD
;

SELECT
    MTD.Total_Orders AS MTD_Orders,
    PMTD.Total_Orders AS PMTD_Orders,
    CONCAT(ROUND((MTD.Total_Orders - PMTD.Total_Orders)/1000, 1), "K") AS Diff_Orders,
    CONCAT(ROUND((MTD.Total_Orders - PMTD.Total_Orders) / PMTD.Total_Orders * 100, 1), "%") AS Orders_Growth_Percentage
FROM
(SELECT
	DISTINCT(COUNT(transaction_id)) AS Total_Orders
    FROM coffee_shop_sales
    WHERE transaction_date BETWEEN '2023-05-01' AND '2023-05-18'
) AS MTD
CROSS JOIN
(SELECT
	DISTINCT(COUNT(transaction_id)) AS Total_Orders
    FROM coffee_shop_sales
    WHERE transaction_date BETWEEN '2023-04-01' AND '2023-04-18'
) AS PMTD
;

SELECT
    MTD.Total_Quantity AS MTD_Quantity,
    PMTD.Total_Quantity AS PMTD_Quantity,
    CONCAT(ROUND((MTD.Total_Quantity - PMTD.Total_Quantity)/1000, 1), "K") AS Diff_Quantity,
    CONCAT(ROUND((MTD.Total_Quantity - PMTD.Total_Quantity) / PMTD.Total_Quantity * 100, 1), "%") AS Quantity_Growth_Percentage
FROM
(SELECT
	SUM(transaction_qty) AS Total_Quantity
    FROM coffee_shop_sales
    WHERE transaction_date BETWEEN '2023-05-01' AND '2023-05-18'
) AS MTD
CROSS JOIN
(SELECT
	SUM(transaction_qty) AS Total_Quantity
    FROM coffee_shop_sales
    WHERE transaction_date BETWEEN '2023-04-01' AND '2023-04-18'
) AS PMTD
;

SELECT
    CD.Total_Sales AS CD_Sales,
    PD.Total_Sales AS PD_Sales,
    CONCAT(ROUND((CD.Total_Sales - PD.Total_Sales)/1000, 1), "K") AS Diff_Sales,
    CONCAT(ROUND((CD.Total_Sales - PD.Total_Sales) / PD.Total_Sales * 100, 1), "%") AS Sales_Growth_Percentage
FROM
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE transaction_date = '2023-05-18'
) AS CD
CROSS JOIN
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE transaction_date = '2023-05-17'
) AS PD
;

SELECT
    CD.Total_Orders AS CD_Orders,
    PD.Total_Orders AS PD_Orders,
    CONCAT(ROUND((CD.Total_Orders - PD.Total_Orders)/1000, 1), "K") AS Diff_Orders,
    CONCAT(ROUND((CD.Total_Orders - PD.Total_Orders) / PD.Total_Orders * 100, 1), "%") AS Orders_Growth_Percentage
FROM
(SELECT
	DISTINCT(COUNT(transaction_id)) AS Total_Orders
    FROM coffee_shop_sales
    WHERE transaction_date = '2023-05-18'
) AS CD
CROSS JOIN
(SELECT
	DISTINCT(COUNT(transaction_id)) AS Total_Orders
    FROM coffee_shop_sales
    WHERE transaction_date = '2023-05-17'
) AS PD
;

SELECT
    CD.Total_Quantity AS CD_Quantity,
    PD.Total_Quantity AS PD_Quantity,
    CONCAT(ROUND((CD.Total_Quantity - PD.Total_Quantity)/1000, 1), "K") AS Diff_Quantity,
    CONCAT(ROUND((CD.Total_Quantity - PD.Total_Quantity) / PD.Total_Quantity * 100, 1), "%") AS Quantity_Growth_Percentage
FROM
(SELECT
	SUM(transaction_qty) AS Total_Quantity
    FROM coffee_shop_sales
    WHERE transaction_date = '2023-05-18'
) AS CD
CROSS JOIN
(SELECT
	SUM(transaction_qty) AS Total_Quantity
    FROM coffee_shop_sales
    WHERE transaction_date = '2023-05-17'
) AS PD
;

SELECT
    CS.Total_Sales AS CS_Sales,
    PS.Total_Sales AS PS_Sales,
    CONCAT(ROUND((CS.Total_Sales - PS.Total_Sales)/1000, 1), "K") AS Diff_Sales,
    CONCAT(ROUND((CS.Total_Sales - PS.Total_Sales) / PS.Total_Sales * 100, 1), "%") AS Sales_Growth_Percentage
FROM
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5 
    AND DAYOFWEEK(transaction_date) = 5
    AND HOUR(transaction_time) = 11
) AS CS
CROSS JOIN
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 4
    AND DAYOFWEEK(transaction_date) = 5
    AND HOUR(transaction_time) = 11
) AS PS
;

SELECT
    CS.Total_Orders AS CS_Orders,
    PS.Total_Orders AS PS_Orders,
    CONCAT(ROUND((CS.Total_Orders - PS.Total_Orders)/1000, 1), "K") AS Diff_Orders,
    CONCAT(ROUND((CS.Total_Orders - PS.Total_Orders) / PS.Total_Orders * 100, 1), "%") AS Orders_Growth_Percentage
FROM
(SELECT
	DISTINCT(COUNT(transaction_id)) AS Total_Orders
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5 
    AND DAYOFWEEK(transaction_date) = 5
    AND HOUR(transaction_time) = 11
) AS CS
CROSS JOIN
(SELECT
	DISTINCT(COUNT(transaction_id)) AS Total_Orders
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 4
    AND DAYOFWEEK(transaction_date) = 5
    AND HOUR(transaction_time) = 11
) AS PS
;

SELECT
    CS.Total_Quantity AS CS_Quantity,
    PS.Total_Quantity AS PS_Quantity,
    CONCAT(ROUND((CS.Total_Quantity - PS.Total_Quantity)/1000, 1), "K") AS Diff_Quantity,
    CONCAT(ROUND((CS.Total_Quantity - PS.Total_Quantity) / PS.Total_Quantity * 100, 1), "%") AS Quantity_Growth_Percentage
FROM
(SELECT
	SUM(transaction_qty) AS Total_Quantity
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5 
    AND DAYOFWEEK(transaction_date) = 5
    AND HOUR(transaction_time) = 11
) AS CS
CROSS JOIN
(SELECT
	SUM(transaction_qty) AS Total_Quantity
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 4
    AND DAYOFWEEK(transaction_date) = 5
    AND HOUR(transaction_time) = 11
) AS PS
;

SELECT
	CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
    ELSE 'Weekdays'
    END AS Day_Type,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY Day_Type
;

SELECT
	store_location,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,2), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 4
GROUP BY store_location
ORDER BY Total_Sales DESC
;

SELECT AVG(unit_price * transaction_qty) AS Average_Sales -- GA DIPAKE
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
;

SELECT CONCAT(ROUND(AVG(Total_Sales)/1000,1), 'K') AS Average_Sales
FROM
	(
    SELECT SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5
    GROUP BY transaction_date
    ) AS Internal_Query
;

SELECT
	DAY(transaction_date) AS Day_Of_Month,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY Day_Of_Month
ORDER BY Day_Of_Month
;

SELECT
	Day_Of_Month,
    CASE
		WHEN Total_Sales > Average_Sales THEN 'Above Average'
        WHEN Total_Sales < Average_Sales THEN 'Below Average'
        ELSE 'Equal to Average'
	END AS Sales_Status,
    Total_Sales
FROM (
	SELECT
		DAY(transaction_date) AS Day_Of_Month,
        SUM(unit_price * transaction_qty) AS Total_Sales,
        AVG(SUM(unit_price * transaction_qty))OVER () AS Average_Sales
	FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5
    GROUP BY Day_Of_Month
    ) AS Sales_Data
ORDER BY Day_Of_Month
;

SELECT
	product_category,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,2), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_category
ORDER BY SUM(unit_price * transaction_qty) DESC
;

SELECT
	product_type,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,2), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
LIMIT 10
;

SELECT
	product_type,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,2), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 AND product_category = 'Coffee'
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
;

SELECT
	ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales,
    SUM(transaction_qty) AS Total_Quantity_Sold,
    COUNT(*) AS Total_Orders
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
AND DAYOFWEEK(transaction_date) = 1
AND HOUR(transaction_time) = 14
;

SELECT
	HOUR(transaction_time) AS Hour_Number,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY Hour_Number
ORDER BY Hour_Number
;

SELECT
	CASE
		WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
	END AS Day_Of_Week,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1), 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY Day_Of_Week
;

SELECT
    CM.Total_Sales AS CM_Sales,
    PM.Total_Sales AS PM_Sales,
    ROUND((CM.Total_Sales - PM.Total_Sales) / PM.Total_Sales * 100, 2) AS Sales_Growth_Percentage
FROM
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5 AND store_location = "Astoria"
) AS CM
CROSS JOIN
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 4 AND store_location = "Astoria"
) AS PM
;

SELECT
    CM.Total_Sales AS CM_Sales,
    PM.Total_Sales AS PM_Sales,
    ROUND((CM.Total_Sales - PM.Total_Sales) / PM.Total_Sales * 100, 2) AS Sales_Growth_Percentage
FROM
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5 AND product_category = "Bakery"
) AS CM
CROSS JOIN
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 4 AND product_category = "Bakery"
) AS PM
;

SELECT
    CM.Total_Sales AS CM_Sales,
    PM.Total_Sales AS PM_Sales,
    ROUND((CM.Total_Sales - PM.Total_Sales) / PM.Total_Sales * 100, 2) AS Sales_Growth_Percentage
FROM
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5 AND product_type = "Scone"
) AS CM
CROSS JOIN
(SELECT
	SUM(unit_price * transaction_qty) AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 4 AND product_type = "Scone"
) AS PM
;

SELECT SUM(transaction_qty * unit_price) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 AND DAYOFWEEK(transaction_date) = 5
;