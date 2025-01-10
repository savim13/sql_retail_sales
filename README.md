# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts and business analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
	(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
	);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT*FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR
	    sale_time IS NULL
		OR
	    sale_date IS NULL
		OR
	    gender IS NULL
		OR
	    category IS NULL
		OR
	    quantiy IS NULL
		OR
	    cogs IS NULL
		OR
	    total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
		transactions_id IS NULL
		OR
	    sale_time IS NULL
		OR
	    sale_date IS NULL
		OR
	    gender IS NULL
		OR
	    category IS NULL
		OR
	    quantiy IS NULL
		OR
	    cogs IS NULL
		OR
	    total_sale IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales 
    WHERE category= 'Clothing'
	AND TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
	AND quantiy>=4;
```

3. **Write SQL query to calculate total sales and number of transactions in each category.**:
```sql
SELECT 
	category, 
	SUM(total_sale) as Total_Sales,
	COUNT (*) as total_orders
FROM retail_sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
    category, 
    ROUND(AVG(age), 2) as average_age
FROM retail_sales
    WHERE category='Beauty'
    GROUP BY category;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions made by each gender in each category.**:
```sql
SELECT 
	category,
	gender,
	COUNT(*) as total_trans
FROM retail_sales
    GROUP BY category,gender
    ORDER BY category,gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
    EXTRACT( YEAR FROM sale_date) as Year,
	EXTRACT( MONTH FROM sale_date) as Month,
	AVG(total_sale) as avg_sale
FROM retail_sales
	GROUP BY Year, Month
	ORDER BY Year, avg_sale DESC;


SELECT 
	year, month, avg_sale
FROM (
	SELECT 
		EXTRACT( YEAR FROM sale_date) as Year,
		EXTRACT( MONTH FROM sale_date) as Month,
		AVG(total_sale) as avg_sale,
		RANK() OVER (PARTITION BY EXTRACT( YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
	FROM retail_sales
	GROUP BY Year, Month
    	) as t1
WHERE RANK=1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as sum_total
FROM retail_sales
    GROUP BY customer_id
    ORDER BY SUM(total_sale) DESC
    LIMIT 5;

```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,
	COUNT(DISTINCT customer_id) as count_unique_customers
FROM retail_sales
	GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT
    shift,
    COUNT(*) as total_sales
FROM
	(SELECT * ,
		CASE 
			WHEN EXTRACT (HOUR from sale_time)<12 THEN 'Morning'
			WHEN EXTRACT (HOUR from sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as shift
		FROM retail_sales)
GROUP BY shift;

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project presents a comprehensive understanding of SQL covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Savi Modi

This project is part of my portfolio, showcasing the SQL skills essential for data analyst and business analyst roles. Please connect at **savi.savimodi@gmail.com** regarding any potential opportunities.

