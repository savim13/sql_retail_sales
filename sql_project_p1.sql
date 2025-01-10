--SQL Retail Sales Analysis- P1
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
	
	SELECT * FROM retail_sales
	;
	
	SELECT 
	COUNT(*) 
	FROM retail_sales;

-- To identify NULL values
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

--Data Cleaning
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

--Data Exploration
	--How many sales do we have?
	SELECT COUNT (*) as total_sale FROM retail_sales;
	--How many customers do we have?
	SELECT COUNT (DISTINCT customer_id) as total_customers FROM retail_sales;
	--How many unique categories do we have? Name them.
	SELECT COUNT (DISTINCT category) as total_categories FROM retail_sales;
	SELECT DISTINCT category FROM retail_sales;

--Business Key Problems
	--1. Write SQL query to retrieve all columns for sales made on '2022-11-05'.
	SELECT * 
	FROM retail_sales
	WHERE sale_date= '2022-11-05'
	ORDER BY sale_time ASC;
	
	--2. Write SQL query to retrieve all transactions where the category is clothing and
	--the quantity sold is more than 3 in the month of Nov-2022.
	SELECT *
	FROM retail_sales 
		WHERE category= 'Clothing'
		AND TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
		AND quantiy>=4;

	--3. Write SQL query to calculate total sales and number of transactions in each category.
	SELECT 
	category, 
	SUM(total_sale) as Total_Sales,
	COUNT (*) as total_orders
	FROM retail_sales
	GROUP BY category;

	--4. Write SQL query to calculate average age of customers who purchased items from 'Beauty' category.
	SELECT 
		category, 
		ROUND(AVG(age), 2) as average_age
	FROM retail_sales
		WHERE category='Beauty'
		GROUP BY category;

	--5. Write SQL query to find all transactions where total sales is greater than 1000.
	SELECT *
	FROM retail_sales
		WHERE total_sale> 1000;

	--6. Write SQL query to find the total number of transactions made by each gender in each category.
	SELECT 
	category,
	gender,
	COUNT(*) as total_trans
	FROM retail_sales
		GROUP BY category,gender
		ORDER BY category,gender;

	--7. Write SQL query to calculate average sale for each month. Find out best selling month in each year.
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

--8. Write SQL query to find the top 5 customers based on the highest total sales.
	SELECT 
		customer_id,
		SUM(total_sale) as sum_total
	FROM retail_sales
		GROUP BY customer_id
		ORDER BY SUM(total_sale) DESC
		LIMIT 5;

--9. Write SQL query to find the number of unique customers who purchased items from each category.
	SELECT 
		category,
		COUNT(DISTINCT customer_id) as count_unique_customers
	FROM retail_sales
		GROUP BY category;

--10. Write SQL query to create each shift and number of orders (Morning <=12, Afternoon- between 12 &17, Evening>17)
	SELECT shift,COUNT(*) as total_sales
	FROM
	(SELECT * ,
		CASE 
			WHEN EXTRACT (HOUR from sale_time)<12 THEN 'Morning'
			WHEN EXTRACT (HOUR from sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as shift
		FROM retail_sales)
	GROUP BY shift;


	
