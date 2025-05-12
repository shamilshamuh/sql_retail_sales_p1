SELECT * FROM project_1.retail_sale;

SELECT * FROM project_1.retail_sale
where transactions_id is null;
SELECT * FROM project_1.retail_sale
where sale_date is null;
SELECT * FROM project_1.retail_sale
where sale_time  is null;

-- data cleaning 


SELECT * FROM project_1.retail_sale;
delete from project_1.retail_sale 
where
 transactions_id is null
 or
 sale_date is null
 or
 sale_time  is null
 or
 customer_id is null
 or
 gender is null 
 or 
 age is null 
 or 
 category is null 
 or
 quantiy is null 
 or
 price_per_unit is null
 or
 cogs is null 
 or
 total_sale is null ; 
 select count( *)from project_1.retail_sale;
 
 -- data exploration
 
 
 -- how many sales  we have
 SELECT * FROM project_1.retail_sale;
 select count(*) as total_sale  from project_1.retail_sale;
 -- how many unique customers you have 
 
 select count(DISTINCT customer_id) as total_sale  from project_1.retail_sale;
 
  select DISTINCT category  from project_1.retail_sale;
 
 
 -- Data Analysis and Business Problem & Answers
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
 
 select * from project_1.retail_sale
 where sale_date = '2022-11-05' ;
  -- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is greater than 4 in the month of Nov-2022
 
 select * from project_1.retail_sale
 where category = 'Clothing' and quantiy >='4'
 and sale_date between '2022-11-01' and '2022-11-30';
 
 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 select category,sum(total_sale) as net_sales
 from project_1.retail_sale
 group by category;
 
 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as Avg_age ,category from project_1.retail_sale
where category='Beauty';
 

 -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 
 select*from project_1.retail_sale
 where total_sale >'1000';
 
 -- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 
 
select count(*) as total_transaction,gender,category from project_1.retail_sale
group by gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
 
 select years,months,avg_sale from
 (
    select round(avg(total_sale),2) as 'avg_sale',
       year(sale_date)as years,month(sale_date)as months,
      rank() over(partition by year(sale_date) order by avg(total_sale) DESC) as ranks 
      from project_1.retail_sale
       group by years,months
  ) as t1
       where ranks=1;
 
 
 -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
 
 select
 sum(total_sale) as total_sales  , 
 customer_id from project_1.retail_sale
 group by customer_id
 order by total_sales DESC
 LIMIT 5;
 
 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
 select count(distinct customer_id) as customers , category from project_1.retail_sale
 group by category;

 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
 
 select count(*) as total_orders ,shift from
 (
 select *,
 case 
     when hour(sale_time) < 12 then 'Morning'
     when hour(sale_time) between '12' and '17' then 'Afternoon'
     else
     'Evening'
     end as shift
 from project_1.retail_sale
 ) as t1
 group by shift;

 -- select hour(current_time);
 
 -- END OF PROJECT--