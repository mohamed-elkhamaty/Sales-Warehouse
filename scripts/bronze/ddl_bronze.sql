--create crm tables

if OBJECT_ID('bronze.crm_cust_info','U') is not null
	drop table bronze.crm_cust_info
create table bronze.crm_cust_info(
	cst_id int,
	cst_key nvarchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date date
	);

if OBJECT_ID('bronze.crm_prd_info','U') is not null
	drop table bronze.crm_prd_info
create table bronze.crm_prd_info(
	prd_id int,
	prd_key nvarchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt date,
	prd_end_dt date
	);

if OBJECT_ID('bronze.crm_sales_details','U') is not null
	drop table bronze.crm_sales_details
create table bronze.crm_sales_details(
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt date,
	sls_due_dt date,
	sls_sales int,
	sls_quantity int,
	sls_price int
	);

--create erp tables

if OBJECT_ID('bronze.erp_cust','U') is not null
	drop table bronze.erp_cust
create table bronze.erp_cust(
	cid nvarchar(50),
	bdate date,
	gen nvarchar(50)
	);

if OBJECT_ID('bronze.erp_loc','U') is not null
	drop table bronze.erp_loc
create table bronze.erp_loc(
	cid nvarchar(50),
	cntry nvarchar(50)
	);

if OBJECT_ID('bronze.erp_px_cat','U') is not null
	drop table bronze.erp_px_cat
create table bronze.erp_px_cat(
	id nvarchar(50),
	cat nvarchar(50),
	subcat nvarchar(50),
	maintenance nvarchar(50)
	);