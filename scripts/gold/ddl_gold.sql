--create customers dimension
create view gold.dim_customer as 
select 
    ROW_NUMBER() over(ORDER BY cst_key) customer_key,
    ci.cst_id customer_id,
    ci.cst_key customer_number,
    ci.cst_firstname first_name,
    ci.cst_lastname last_name,
    case when ci.cst_gndr!='Unknown'
            then ci.cst_gndr
            when c.gen is not null or c.gen!='Unknown'
            then c.gen
            else 'Unknown' end gender,
    l.cntry country,
    ci.cst_marital_status marital_status,
    c.bdate birthdate,
    ci.cst_create_date create_date


from silver.crm_cust_info ci
left join silver.erp_cust c on ci.cst_key=c.cid
left join silver.erp_loc l on ci.cst_key=l.cid;


--create the products dimension
create or alter view gold.dim_products as
select
    ROW_NUMBER() over(ORDER BY prd_key) product_key,
    prd_id product_id,
    prd_key product_number,
    prd_nm product_name,
    cat_id category_id,
    cat category,
    subcat sub_category,
    prd_cost cost,
    prd_line line,
    prd_start_dt start_date,
    prd_end_dt end_date,

    maintenance

from silver.crm_prd_info p
LEFT JOIN silver.erp_px_cat c on p.cat_id=c.id;


--create sales fact table
create or alter view gold.fact_sales as
select 
    sls_ord_num order_number,
    p.product_key product_key,
    c.customer_key customer_key,
    sls_quantity quantity,
    sls_price price,
    sls_sales sales,
    sls_order_dt order_date,
    sls_ship_dt ship_date,
    sls_due_dt due_date
from silver.crm_sales_details s
LEFT JOIN gold.dim_customers c on c.customer_id=s.sls_cust_id
LEFT JOIN gold.dim_products p on p.product_number=s.sls_prd_key;