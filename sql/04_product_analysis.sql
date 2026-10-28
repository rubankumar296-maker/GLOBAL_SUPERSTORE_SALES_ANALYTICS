USE global_superstore;

-- Q1. Top 10 products by sales
SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Product_ID, Product_Name
ORDER BY total_sales DESC
LIMIT 10;

-- Q2. Top 10 products by profit
SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Product_ID, Product_Name
ORDER BY total_profit DESC
LIMIT 10;

-- Q3. Bottom 10 products by profit
SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Product_ID, Product_Name
ORDER BY total_profit ASC
LIMIT 10;

-- Q4. Products with positive sales but negative total profit
SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Product_ID, Product_Name
HAVING SUM(Sales) > 0
   AND SUM(Profit) < 0
ORDER BY total_sales DESC;

-- Q5. Profit by category and sub-category
SELECT
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0),
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY Category, Sub_Category
ORDER BY total_profit ASC;

WITH product_sales AS (
    SELECT
        Category,
        Product_ID,
        Product_Name,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY Category, Product_ID, Product_Name
),
ranked_products AS (
    SELECT
        Category,
        Product_ID,
        Product_Name,
        total_sales,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE sales_rank <= 3
ORDER BY Category, sales_rank;