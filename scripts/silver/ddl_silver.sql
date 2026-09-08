use Sales_DW;

--create crm tables


if OBJECT_ID('silver.crm_cust_info','U') is not null
	drop table silver.crm_cust_info
create table silver.crm_cust_info(
	cst_id int,
	cst_key nvarchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date date,
    dwh_create_date datetime2 default  getdate()
	);

if OBJECT_ID('silver.crm_prd_info','U') is not null
	drop table silver.crm_prd_info
create table silver.crm_prd_info(
	prd_id int,
    cat_id nvarchar(10),
	prd_key nvarchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt date,
	prd_end_dt date,
    dwh_create_date datetime2 default  getdate()
	);

if OBJECT_ID('silver.crm_sales_details','U') is not null
	drop table silver.crm_sales_details
create table silver.crm_sales_details(
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt date,
	sls_ship_dt date,
	sls_due_dt date,
	sls_sales int,
	sls_quantity int,
	sls_price int,
    dwh_create_date datetime2 default  getdate()
	);

--create erp tables

if OBJECT_ID('silver.erp_cust','U') is not null
	drop table silver.erp_cust
create table silver.erp_cust(
	cid nvarchar(50),
	bdate date,
	gen nvarchar(50),
    dwh_create_date datetime2 default  getdate()
	);

if OBJECT_ID('silver.erp_loc','U') is not null
	drop table silver.erp_loc
create table silver.erp_loc(
	cid nvarchar(50),
	cntry nvarchar(50),
    dwh_create_date datetime2 default  getdate()
	);

if OBJECT_ID('silver.erp_px_cat','U') is not null
	drop table silver.erp_px_cat
create table silver.erp_px_cat(
	id nvarchar(50),
	cat nvarchar(50),
	subcat nvarchar(50),
	maintenance nvarchar(50),
    dwh_create_date datetime2 default  getdate()
	);

