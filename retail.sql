create database sql_project_2;


drop table if exists retail;
create table retail
			(
			transactions_id	int primary key ,
			sale_date date,
			sale_time time,
			customer_id int,
			gender varchar(40),
			age int,
			category varchar(40),
			quantity int,
			price_per_unit float,
			cogs float,
			total_sale int
			);

select * from retail
where transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR 
gender IS NULL
OR
age IS NULL
OR 
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR 
total_sale IS NULL;

DELETE FROM retail
where transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR 
gender IS NULL
OR
age IS NULL
OR 
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR 
total_sale IS NULL;

-- Data exploration

-- 1. how many sales we have?

select  count(*) as sales from retail

-- 2. how many unique customer we have?

select count(distinct customer_id) as customer from retail

-- 3. how many category we have?

select count(distinct category) as category_count from retail

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from retail
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-

select *
from retail
where category = 'Clothing' AND quantity > 3 AND to_char(sale_date, 'YYYY-MM') = '2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select distinct category ,sum(total_sale) as total
from retail
group by category
order by total desc;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select distinct category, avg(age) average
from retail
where category = 'Beauty'
group by category
order by average desc;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from retail
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select distinct gender , category,  count(transactions_id) as no_of_transactions
from retail 
group by gender, category
order by 3 desc;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select 
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	round(avg(total_sale),2) as average
	from retail
	group by 1, 2
	order by 1 asc, 2 asc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id , sum(total_sale)
from retail
group by customer_id
order by 2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,   count( distinct customer_id) as customer
from retail
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

select sale_time, quantity
from retail
where
	sale_time <= '12:00:00' as Morning
	sale_time between '12:00:00' and '17:00:00' as Afternoon
	sale_time > '17:00:00' as Evening

select *,
	case
		when extract(hour from sale_time) <= 12 then 'Morning'
		when extract(hour from sale_time) between 12 AND 17 then 'Afternoon'
		when extract(hour from sale_time) > 17 then 'Evening'
	end as shift
from retail

-- End of code
