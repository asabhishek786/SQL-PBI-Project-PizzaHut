-- DATA VIEW
SELECT * FROM pizza_sales;

-- TOTAL REVENUE
SELECT CAST(SUM(total_price) AS DECIMAL(10,2))
AS TOTAL_REVENUE
FROM pizza_sales;

-- AVERAGE ORDER VALUE
SELECT CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
FROM pizza_sales;

-- TOTAL PIZZA SOLD
SELECT CAST(SUM(quantity) AS DECIMAL(10,2))
AS TOTAL_PIZZA_SOLD
FROM pizza_sales;

-- TOTAL ORDERS
SELECT CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
FROM pizza_sales;

-- AVERAGE PIZZA PER ORDER
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
FROM pizza_sales;

--------------------------------------------------------------------

-- DAILY TREND FOR TOTAL ORDERS
SELECT DATENAME(WEEKDAY, order_date) AS WEEK_NAME,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS_PER_DAY,
CAST(SUM(total_price) AS DECIMAL(10,2)) AS TOTAL_PRICE_PER_DAY
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY TOTAL_ORDERS_PER_DAY DESC;

-- MONTHLY TREND FOR TOTAL ORDERS
SELECT DATENAME(MONTH, order_date) AS MONTH_NAME,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS_PER_MONTH,
CAST(SUM(total_price) AS DECIMAL(10,2)) AS TOTAL_PRICE_PER_MONTH
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY TOTAL_ORDERS_PER_MONTH DESC;

-- HOURLY TREND FOR TOTAL SALES
SELECT DATEPART(HOUR, order_time) AS HOURLY,
DATEPART(MINUTE, order_time) AS MINUT,
COUNT(DISTINCT order_id) AS TOTAL_ORDER
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time), DATEPART(MINUTE, order_time)
ORDER BY HOURLY;

-- TOTAL PRICE & PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS TOTAL_REVENUE,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PERCENTAGE_OF_SALES
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PERCENTAGE_OF_SALES DESC;

-- TOTAL PRICE & PERCENTAGE OF SALES BY PIZZA SIZE
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS TOTAL_REVENUE,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PERCENTAGE_OF_SALES
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PERCENTAGE_OF_SALES DESC;

-- TOTAL PIZZA SOLD BY PIZZA CATEGORY
SELECT pizza_category, SUM(quantity) AS TOTAL_SALES , CAST(SUM(total_price) AS DECIMAL(10,2)) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY pizza_category
ORDER BY TOTAL_SALES DESC;

-- TOP 5 BEST SELLER BY REVENUE, TOTAL QUANTITY & TOTAL ORDERS
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE DESC;
/*OFFSET 0 ROW FETCH NEXT 5 ROWS ONLY;*/

SELECT TOP 5 pizza_name, SUM(quantity) AS TOTAL_QUANTITY
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_QUANTITY DESC;
/*OFFSET 0 ROW FETCH NEXT 5 ROWS ONLY;*/

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_ORDERS DESC;
/*OFFSET 0 ROW FETCH NEXT 5 ROWS ONLY;*/

-- BOTTOM 5 BEST SELLER BY REVENUE, TOTAL QUANTITY & TOTAL ORDERS
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE DESC;
/*OFFSET 27 ROW FETCH NEXT 5 ROWS ONLY;*/

SELECT TOP 5 pizza_name, SUM(quantity) AS TOTAL_QUANTITY
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_QUANTITY ASC;
/*OFFSET 27 ROW FETCH NEXT 5 ROWS ONLY;*/

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_ORDERS ASC;
/*OFFSET 27 ROW FETCH NEXT 5 ROWS ONLY;*/
