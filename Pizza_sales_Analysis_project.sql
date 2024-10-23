--PIZZA SALES ANALYSIS PROJECT--
SELECT *FROM[dbo].[pizza_sales];

SELECT SUM(total_price)AS TOTAL_REVENUE FROM[dbo].[pizza_sales];

SELECT SUM(total_price)/COUNT(DISTINCT order_id)AS AVG_ORDER_VALUE FROM[dbo].[pizza_sales];

SELECT SUM(quantity)AS TOTAL_PIZZA_SOLD FROM[dbo].[pizza_sales];

SELECT COUNT(DISTINCT order_id)AS TOTAL_ORDERS FROM[dbo].[pizza_sales];

SELECT CAST(CAST(SUM(quantity)AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2)) AS DECIMAL(10,2))AS AVG_PIZZA_PER_ORDER FROM[dbo].[pizza_sales];
--DAILY TREND
SELECT DATENAME(DW,order_date)AS ORDER_DAY,COUNT(DISTINCT order_id)AS TOTAL_ORDERS
FROM[dbo].[pizza_sales]
GROUP BY DATENAME(DW,order_date);

--HOURLY TREND--
SELECT DATEPART(HOUR,order_time)AS ORDER_HOURS,COUNT(DISTINCT order_id)AS TOTAL_ORDERS
FROM[dbo].[pizza_sales]
GROUP BY DATEPART(HOUR,order_time)
ORDER BY DATEPART(HOUR,order_time);

--% OF SALES BY PIZZA CATEGORY--
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as TOTAL_REVENUE,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

--% OF SALES BY PIZZA SIZE--

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as TOTAL_REVENUE,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

--TOTAL PIZZAS SOLD BY PIZZA CATEGORY--
SELECT pizza_category,SUM(quantity) AS TOTAL_QUANTITY_SOLD
FROM pizza_sales
WHERE MONTH(order_date)=2
GROUP BY pizza_category
ORDER BY  TOTAL_QUANTITY_SOLD DESC;

--TOP 5 BEST SELLERS BY TOTAL PIZZAS SOLD--

SELECT TOP 5 pizza_name,SUM(quantity) AS TOTAL_PIZZA_SOLD
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  TOTAL_PIZZA_SOLD DESC;

--BOTTOM 5 BEST SELLERS BY TOTAL PIZZAS SOLD--

SELECT TOP 5 pizza_name,SUM(quantity) AS TOTAL_PIZZA_SOLD
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  TOTAL_PIZZA_SOLD ASC;

--If you want to apply the Month, Quarter, Week filters to the above queries you can use WHERE clause. Follow some of below examples--
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY DATENAME(DW, order_date)

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY DATENAME(DW, order_date) 
ORDER BY DATENAME(DW, order_date) DESC;


