create database if not exists salesdatawalmart;

use salesdatawalmart;

create table sales2(
invoice_id varchar(30) not null primary key,
branch varchar(30) not null  ,
customer_type varchar(30) not null,
city varchar(30) not null ,
gender varchar(10) not null ,
prodcut_line varchar(30) not null,
unit_price decimal(10,2) not null,
quantity int not null,
vat float not null,
total decimal(10,2) not null,
date date not null,
time  time not null,
 payment_method varchar(20) not null,
 cogs decimal(10,2) not null,
 gross_margin_percentage decimal(11,9) not null,
 gross_income decimal(12,4) not null,
 rating float
 
 );

select time,
(case 
    when time between "00:00:00" and "12:00:00" then "Morning"
     when time between "12:01:00" and "16:00:00" then "Afternoon"
     else "Evining"
 end
) as time_day
from sales;
 
 alter table sales
 add column time_of_day varchar(20);
 
 update sales
 set time_of_day= (case 
    when time between "00:00:00" and "12:00:00" then "Morning"
     when time between "12:01:00" and "16:00:00" then "Afternoon"
     else "Evining"
 end);


 
 -- 2 day name
 select dayname(date)
 from sales;
 
 alter table sales add column day_name varchar(15);
 update sales
 set day_name =dayname(date);
 
 -- 3
 select monthname(date)
 from sales;
 
  alter table sales add column Month_name varchar(20);
   update sales
 set Month_name =monthname(date);
  
---------------------------------------------  BASIC QUASTIONS ----------------------------------------------------------------------------- 
 -- 1) How many unique cities does the data have?
       select distinct city from sales;

-- 2 In which city is each branch?
       select distinct city, branch
       from sales;
       
----------------------------------------- PRODUCT -----------------------------------------------------------------------------------------      
-- 1) How many unique product lines does the data have?
     select count(distinct product_line) from sales;

-- 2 What is the most common payment method?     
    select payment_method, count(payment_method ) as countt
    from sales
    group by payment_method
    order by countt desc
    limit 1;
-- 3 What is the most selling product line?
    select * from sales;
    select  product_line, count(product_line) as qty
    from sales
    group by product_line
    order by qty desc;
    
-- 4 What is the total revenue by month? 
    select month_name, sum(total) as total_revenue
    from sales
    group by month_name
    order by total_revenue desc;
    
-- 5 What month had the largest COGS?
     select month_name, sum(cogs) as total_cogs
     from sales
     group by month_name
     order by total_cogs desc;
     
-- 6 What product line had the largest revenue?
       select * from sales;
    select  product_line, sum(total) as qty
    from sales
    group by product_line
    order by qty desc
    limit 1 ;
    
-- 7 What is the city with the largest revenue?
    select city, sum(total) as revenue
    from sales
    group by city
    order by revenue desc;
    
-- 8  What product line had the largest VAT?
    select city, sum( vat)as vat
    from sales
    group by city
    order by vat desc;
    
    
-- 9 Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales?
select  product_line, avg(quantity)
from sales 
group by product_line;
select product_line,
(case
    when  avg(quantity) > 5.5 then "Good"
    else "Bad"
 end
) as quality
from sales
group by product_line;

-- 10 Which branch sold more products than average product sold? 
select branch, sum(quantity) as qty
from sales
group by branch
having sum(quantity) > (select avg(quantity) from sales);

-- 11 What is the most common product line by gender?
select  gender, product_line, count(gender) as cnt
from sales
group by gender, product_line
order by cnt desc;

-- 12 What is the average rating of each product line?
select product_line, round(avg(rating),1)
from sales
group by product_line;

-------------------------------------------------- SALES -------------------------------------------------------------------------------------- 
-- 1 Number of sales made in each time of the day per weekday?
select * from sales;
select time_of_day, count(*) as total_Sales 
from sales
where day_name = "Sunday"
group by time_of_day
order by  total_Sales desc;

-- 2 Which of the customer types brings the most revenue?
select customer_type, sum(total) as total_revenue
 from sales
 group by  customer_type
 order by total_revenue desc;
 
-- 3 Which city has the largest tax percent/ VAT (Value Added Tax)? 
select 
city, 
concat(round(avg(vat),0),'%') as tax_pct
from sales
group by city
order by tax_pct desc;

-- 4 Which customer type pays the most in VAT?
select
 customer_type,  round(avg(vat),0) as total_tax
from sales
group by  customer_type
order by  total_tax desc;

------------------------------------------------ CUSTOMER ------------------------------------------------------------------------ 
-- 1 How many unique customer types does the data have?
select distinct customer_type from sales;

-- 2 How many unique payment methods does the data have?
 select distinct payment_method from sales;
 
-- 3 What is the most common customer type? 
 select customer_type, count(*) as type_of_customer
 from sales
 group by customer_type
 order by type_of_customer desc;
 
-- 4  Which customer type buys the most?
 SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type
order by   COUNT(*) desc;

-- 5 What is the gender of most of the customers?
   SELECT
	gender,
    COUNT(*)
FROM sales
GROUP BY gender
order by   COUNT(*) desc;

-- 6 What is the gender distribution per branch?
 SELECT
    branch,
    gender,
	COUNT(*)
FROM sales

GROUP BY branch, gender;
 /* OR*/
 SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
where branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- 7 Which time of the day do customers give most ratings?
select time_of_day,  round(avg(rating),2) as avg_rating
from sales
group by time_of_day
order by avg_rating desc;

-- 8 Which time of the day do customers give most ratings per branch?
select time_of_day, branch,  round(avg(rating),2) as avg_rating
from sales
group by time_of_day, branch
order by avg_rating desc;

-- 9 Which day fo the week has the best avg ratings?

select day_name, round(avg(rating),2) as avg_rating
from sales
group by day_name
order by avg_rating desc;
    
-- 10 Which day of the week has the best average ratings per branch?
select day_name,  round(avg(rating),2) as avg_rating
from sales
where branch = "A"
group by day_name
order by avg_rating desc;

	
