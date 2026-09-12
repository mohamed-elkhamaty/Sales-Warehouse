select order_date 
    ,sum(sales) totsl_sales
    ,count(distinct customer_key) total_customers
    ,sum(quantity)
from fact_sales
where order_date is not null
group by order_date
order by order_date

select year(order_date)
    ,sum(sales) totsl_sales
    ,count(distinct customer_key) total_customers
from fact_sales
where year(order_date) is not null
group by year(order_date)
order by year(order_date)

select month(order_date ) month
    ,sum(sales) totsl_sales
    ,count(distinct customer_key) total_customers
    ,sum(quantity)
from fact_sales
where month(order_date ) is not null
group by month(order_date )
order by month(order_date )

select day(order_date ) day
    ,sum(sales) totsl_sales
    ,count(distinct customer_key) total_customers
    ,sum(quantity)
from fact_sales
where day(order_date ) is not null
group by day(order_date )
order by day(order_date )

SELECT
    year(order_date) year,
    month(order_date) month,
    sum(sales) totsl_sales
    ,count(distinct customer_key) total_customers
    ,sum(quantity) total_quantity
from fact_sales
where year(order_date) is NOT NULL
group by year(order_date),month(order_date)
order by year(order_date),month(order_date)

