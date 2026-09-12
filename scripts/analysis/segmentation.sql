with fr_t as
(    SELECT distinct
        customer_key ,
        datediff(month,min_order_date,max_order_date) lifespan_of_a_customer
    from
    (    SELECT 
            [s].[order_number],
                    [s].[product_key],
                    [s].[customer_key],
                    [s].[quantity],
                    [s].[price],
                    [s].[sales],
                    [s].[order_date],
                    [s].[ship_date],
                    [s].[due_date],
                    [c].[customer_id],
                    [c].[customer_number],
                    [c].[first_name],
                    [c].[last_name],
                    [c].[gender],
                    [c].[country],
                    [c].[marital_status],
                    [c].[birthdate],
                    [c].[create_date],
            
            min(order_date)over (PARTITION BY c.customer_key ORDER BY c.customer_key) min_order_date,
            max(order_date)over (PARTITION BY c.customer_key ORDER BY c.customer_key) max_order_date
        from gold.fact_sales s
        LEFT JOIN gold.dim_customers c on s.customer_key=c.customer_key
    )t
)
select f.customer_key,
sum_sales,
lifespan_of_a_customer,
case when lifespan_of_a_customer>12 and sum_sales>5000 then 'vip'
    when lifespan_of_a_customer>12 and sum_sales<=5000 then 'standard'
    else 'bad' end seg
from fr_t f
RIGHT JOIN (select customer_key,sum(sales) sum_sales
            from gold.fact_sales
            GROUP BY customer_key) s on f.customer_key=s.customer_key
LEFT JOIN gold.dim_customers c on s.customer_key=c.customer_key
