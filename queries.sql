CREATE DATABASE IF NOT EXISTS sales_analysis;
USE sales_analysis;

-- Import sales_dataset.csv into a table named sales_data using MySQL Workbench:
-- Right-click Tables > Table Data Import Wizard.

SELECT * FROM sales_data LIMIT 10;

SELECT ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM sales_data;

SELECT region, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

SELECT customer_id, customer_name, ROUND(SUM(sales), 2) AS total_spent
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 10;

SELECT product_name, category, ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY product_name, category
ORDER BY total_sales DESC
LIMIT 10;

SELECT customer_id, customer_name, ROUND(SUM(sales), 2) AS total_spent,
CASE
    WHEN SUM(sales) >= 300000 THEN 'High Value'
    WHEN SUM(sales) >= 150000 THEN 'Medium Value'
    ELSE 'Low Value'
END AS customer_segment
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY total_spent DESC;

SELECT product_name, category, total_sales,
RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT product_name, category, ROUND(SUM(sales), 2) AS total_sales
    FROM sales_data
    GROUP BY product_name, category
) product_sales;

SELECT category, ROUND(SUM(sales), 2) AS category_sales,
ROUND(SUM(sales) * 100 / (SELECT SUM(sales) FROM sales_data), 2) AS sales_percentage
FROM sales_data
GROUP BY category
ORDER BY category_sales DESC;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY total_sales DESC
LIMIT 1;
