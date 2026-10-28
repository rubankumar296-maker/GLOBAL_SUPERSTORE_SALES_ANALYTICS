USE global_superstore;

-- Q1. Sales by year
SELECT
    YEAR(Order_Date) AS order_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY YEAR(Order_Date)
ORDER BY order_year;

-- Q2. Sales by category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC;

-- Q3. Sales by sub-category
SELECT
    Sub_Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Sub_Category
ORDER BY total_sales DESC;

-- Q4. Sales by market
SELECT
    Market,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Market
ORDER BY total_sales DESC;

-- Q5. Sales by region
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;

-- Q6. Top 10 months by sales
SELECT
    YEAR(Order_Date) AS order_year,
    MONTH(Order_Date) AS order_month,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY total_sales DESC
LIMIT 10;