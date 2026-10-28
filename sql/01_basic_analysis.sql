
USE global_superstore;

-- Q1. Total number of records
SELECT COUNT(*) AS total_records
FROM superstore;

-- Q2. Total sales, profit and quantity
SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity
FROM superstore;

-- Q3. Total distinct orders and customers
SELECT
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS total_customers,
    COUNT(DISTINCT Product_ID) AS total_products
FROM superstore;

-- Q4. Check date range
SELECT
    MIN(Order_Date) AS first_order_date,
    MAX(Order_Date) AS last_order_date
FROM superstore;

-- Q5. Overall profit margin
SELECT
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(
        100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0),
        2
    ) AS profit_margin_pct
FROM superstore;
