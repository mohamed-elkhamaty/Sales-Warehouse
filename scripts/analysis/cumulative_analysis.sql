SELECT
    month,
    
    totsl_sales,
    avg_price,
    sum(totsl_sales)over(order by month ) running_sales_over_all_month /* cumulative sum, add current value for all previous vlaues*/,
    sum(totsl_sales)over(partition by year order by month ) running_sales_over_year,
    avg(avg_price) over(PARTITION by year order by month) moving_avg_price

from 
(
select DATETRUNC(month,order_date ) month,
    DATETRUNC(year,order_date) year
    ,sum(sales) totsl_sales    ,
    avg(price) avg_price
from fact_sales
where order_date is not null
group by DATETRUNC(year,order_date),DATETRUNC(month,order_date )
)t