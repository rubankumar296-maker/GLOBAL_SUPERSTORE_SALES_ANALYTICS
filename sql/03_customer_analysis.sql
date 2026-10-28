USE global_superstore;

-- Q1. Sales and profit by customer segment
SELECT
    Segment,
    COUNT(DISTINCT Customer_ID) AS total_customers,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Segment
ORDER BY total_sales DESC;

-- Q2. Top 10 customers by sales
SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM superstore
GROUP BY Customer_ID, Customer_Name
ORDER BY total_sales DESC
LIMIT 10;

-- Q3. Top 10 customers by profit
SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY Customer_ID, Customer_Name
ORDER BY total_profit DESC
LIMIT 10;

-- Q4. Customers with negative total profit
SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Customer_ID, Customer_Name
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;