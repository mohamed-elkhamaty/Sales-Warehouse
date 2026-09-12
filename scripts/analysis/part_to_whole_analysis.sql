SELECT
    category,
    sum_sales,
    total,
    concat(ROUND((sum_sales/cast(total as float))*100 ,2) ,'%')percntage_of_total
from
(    select 
        p.category category,
        sum(s.sales) sum_sales,
        sum(sum(s.sales))over() total
    from gold.fact_sales s
    LEFT JOIN gold.dim_products p on p.product_key=s.product_key
    GROUP BY p.category)t