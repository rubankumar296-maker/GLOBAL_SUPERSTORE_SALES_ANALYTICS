
# Global Superstore Sales & Profit Analytics

## 1. Project Overview

This project analyzes Global Superstore sales transactions to understand sales performance, profitability, product performance, regional results, customer segments, and discount patterns.

The project combines Python-based data preparation, SQL business analysis, and an interactive Power BI dashboard.

## 2. Business Problem

A business needs to understand which products and categories generate sales, which regions and customer segments contribute to profit, and where losses or high discounts may require further investigation.

This project uses transaction-level data to turn raw records into useful business insights.

## 3. Project Objectives

- Inspect and prepare the sales dataset.
- Analyze sales and profit trends over time.
- Compare performance across markets, regions, categories, and subcategories.
- Evaluate customer and product performance.
- Investigate discounts and negative-profit transactions.
- Build an interactive Power BI report.
- Validate important dashboard metrics against Python and SQL results.

## 4. Tools and Technologies

- Python
- Pandas and NumPy
- Matplotlib and Seaborn, where used
- Jupyter Notebook
- SQL / MySQL
- Power BI Desktop
- DAX
- Git and GitHub

## 5. Project Workflow

1. Dataset understanding
2. Data cleaning and preparation
3. Exploratory Data Analysis (EDA)
4. SQL business analysis
5. DAX measure development
6. Power BI data modeling
7. Dashboard development
8. Validation and documentation

## 6. Data Preparation

The project contains the original dataset under `data/raw/` and the prepared dataset under `data/processed/`.

Data preparation and quality checks should be documented in the notebooks and Python source code.

Record the actual number of rows, columns, missing values, duplicates, and any data-quality issues from the final processed dataset. Do not assume these values without checking the file.

## 7. SQL Analysis

The SQL scripts are organized in the `sql/` folder.

The analysis covers basic sales performance, sales trends, customer analysis, product analysis, and profitability analysis.

## 8. Power BI Dashboard

The Power BI report is stored at:

`dashboard/Global_Superstore_Analytics.pbix`

The report contains four pages:

1. Executive Overview
2. Sales Analysis
3. Profitability Analysis
4. Customer Analysis

The report uses KPI cards, charts, tables, slicers, and page navigation to support interactive exploration.

## 9. Key Metrics

The report includes measures such as:

- Total Sales
- Total Profit
- Total Quantity
- Total Orders
- Total Customers
- Profit Margin %
- Average Order Value
- Sales Year-over-Year Growth %
- Average Discount %

Definitions and results should be checked against the actual DAX measures and dataset.

## 10. Validation

Compare important Power BI measures with independent Python and SQL calculations using the same dataset, filters, and metric definitions.

Investigate discrepancies before publishing the final results.

## 11. Business Value

The analysis can help users investigate sales trends, compare product and regional performance, identify loss-making areas, and understand differences between sales and profitability.

The dashboard supports analysis; business recommendations should be based on verified results.

## 12. Limitations

- Findings depend on the quality and scope of the supplied dataset.
- Historical transaction data does not automatically establish future performance.
- Customer lifetime value, retention, or churn should not be claimed unless separately calculated using appropriate methods and data.
- Dashboard figures must be validated against the final processed dataset.

## 13. Conclusion

This project demonstrates an end-to-end analytics workflow combining data preparation, SQL analysis, business metrics, data modeling, and interactive Power BI reporting.

The final conclusions and numerical findings should be added after the dashboard and analysis outputs have been validated.
