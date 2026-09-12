--check if there are any duplicated rows produced during the join
select *
from (
    select 
    ci.cst_id,
    ci.cst_key,
    ci.cst_firstname,
    ci.cst_lastname,
    ci.cst_marital_status,
    ci.cst_gndr,
    ci.cst_create_date,
    c.bdate,
    c.gen,
    l.cntry,
    row_number() over(partition by ci.cst_key order by ci.cst_create_date desc) dup

from silver.crm_cust_info ci
left join silver.erp_cust c on ci.cst_key=c.cid
left join silver.erp_loc l on ci.cst_key=l.cid
)t
where dup!=1

select distinct
    ci.cst_gndr,
    c.gen
from silver.crm_cust_info ci
left join silver.erp_cust c on ci.cst_key=c.cid
left join silver.erp_loc l on ci.cst_key=l.cid
group by ci.cst_gndr, c.gen

select distinct
    ci.cst_gndr,
    c.gen,
    case when ci.cst_gndr!='Unknown'
            then ci.cst_gndr
            when c.gen is not null or c.gen!='Unknown'
            then c.gen
            else 'Unknown' end final_gender
from silver.crm_cust_info ci
left join silver.erp_cust c on ci.cst_key=c.cid
left join silver.erp_loc l on ci.cst_key=l.cid


select * from silver.crm_prd_info
select * from silver.erp_px_cat

select * from gold.dim_customer
select*from gold.fact_sales
SELECT*from gold.dim_products