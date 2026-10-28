USE global_superstore;

-- Q1. Which discount bands have the lowest profitability

SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.10 THEN '0-10%'
        WHEN Discount <= 0.20 THEN '10-20%'
        WHEN Discount <= 0.30 THEN '20-30%'
        WHEN Discount <= 0.50 THEN '30-50%'
        ELSE 'Above 50%'
    END AS discount_band,
    COUNT(*) AS total_records,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0),
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY discount_band
ORDER BY MIN(Discount);

-- Q2. Which regions have negative total profit

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Region
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;

-- Q3. Compare sales and profitability by shipping mode

SELECT
    Ship_Mode,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0),
        2
    ) AS profit_margin_pct,
    ROUND(AVG(Shipping_Cost), 2) AS avg_shipping_cost_per_record
FROM superstore
GROUP BY Ship_Mode
ORDER BY total_profit DESC;

-- Q4. Identify high-sales, low-profit sub-categories

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
HAVING SUM(Sales) > 0
ORDER BY profit_margin_pct ASC;

-- Q5. Year-over-year sales growth

WITH yearly_sales AS (
    SELECT
        YEAR(Order_Date) AS order_year,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY YEAR(Order_Date)
),
sales_comparison AS (
    SELECT
        order_year,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY order_year
        ) AS previous_year_sales
    FROM yearly_sales
)
SELECT
    order_year,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(previous_year_sales, 2) AS previous_year_sales,
    ROUND(
        100.0 * (total_sales - previous_year_sales)
        / NULLIF(previous_year_sales, 0),
        2
    ) AS yoy_growth_pct
FROM sales_comparison
ORDER BY order_year;

