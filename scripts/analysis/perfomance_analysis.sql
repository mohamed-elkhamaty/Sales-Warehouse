select 
    product_key,
    year,
    current_year_sum_sales,
    previous_year_sum_sales,
    current_year_sum_sales-previous_year_sum_sales performance
from
(    SELECT 
        product_key
        ,year(order_date)year,
        sum(sales) current_year_sum_sales,
        lag(sum(sales)) over (partition  by product_key ORDER by product_key ) previous_year_sum_sales
    from gold.fact_sales
    where order_date is not null
    group by product_key,year(order_date)
)t



select 
    product_key,
    year,
    sum_sales,
    avg_sales,
    sum_sales-avg_sales performance
from
(    SELECT 
        product_key
        ,year(order_date)year,
        sum(sales) sum_sales,
        avg(sales) avg_sales
    from gold.fact_sales
    where order_date is not null
    group by product_key,year(order_date)
)t
ORDER BY product_key,year
