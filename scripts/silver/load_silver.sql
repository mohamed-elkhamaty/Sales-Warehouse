--transform and load crm_cust_info into silver layer

create or alter procedure silver.load_silver as 
begin
	begin try
		print 'loading silver layer'
		declare @start_time datetime, @end_time datetime, @st datetime, @et datetime;
		set @st=GETDATE()
		set @start_time=GETDATE();
		truncate table silver.crm_cust_info;

        insert into silver.crm_cust_info(
            cst_id,
            cst_key,
            cst_firstname,
            cst_lastname,
            cst_marital_status,
            cst_gndr,
            cst_create_date
        )
        select
            cst_id,
            cst_key,
            cst_firstname,
            cst_lastname,
            cst_marital_status,
            cst_gndr,
            cst_create_date
        from 
        (
            select
            cst_id,
            cst_key,
            --standardize firstname
            trim(cst_firstname) cst_firstname,
            --standardize lastname
            trim(cst_lastname) cst_lastname,
            --standardize marital status
            case when upper(trim(cst_marital_status)) ='M' then 'Married'
                    when upper(trim(cst_marital_status)) ='S' then 'Single'
                    else 'Unknown' end cst_marital_status,
            --standardize gender
            case when upper(trim(cst_gndr)) ='F' then 'Female'
                    when upper(trim(cst_gndr)) ='M' then 'Male'
                    else 'Unknown' end cst_gndr,
            cst_create_date,
            --rank duplicated rows to remove it
            row_number() over(partition by cst_id order by cst_create_date desc) last_record
            from bronze.crm_cust_info
        ) as configured
        where last_record=1 and cst_id is not null;

        print 'cust info loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';



        --transform and load crm_prd_info into silver layer

		set @start_time=GETDATE();
		truncate table silver.crm_prd_info;

        insert into silver.crm_prd_info(
            prd_id,
            cat_id,
            prd_key,
            prd_nm,
            prd_cost,
            prd_line,
            prd_start_dt,
            prd_end_dt
        )
        select
            prd_id,
            replace(substring(prd_key,1,5),'-','_') cat_id,
            substring(prd_key,7,len(prd_key)) prd_key,
            trim(prd_nm) prd_nm,
            isnull(prd_cost,0) prd_cost,
            case    when upper(trim(prd_line)) ='M' then 'Mountain'
                    when upper(trim(prd_line)) ='S' then 'Other Sales'
                    when upper(trim(prd_line)) ='R' then 'Road'
                    when upper(trim(prd_line)) ='T' then 'Touring'
                    else 'Unknown' 
            end prd_line,
            prd_start_dt,
            dateadd(day, -1, lead(prd_start_dt) over(partition by prd_key order by prd_start_dt asc )) prd_end_dt_
        from bronze.crm_prd_info;
        
		print 'prd info loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';


        -- transform and load crm_sales_details into silver layer

		set @start_time=GETDATE();
		truncate table silver.crm_sales_details;
        insert into silver.crm_sales_details(
            sls_ord_num,
            sls_prd_key,
            sls_cust_id,
            sls_order_dt,
            sls_ship_dt,
            sls_due_dt,
            sls_quantity,
            sls_price,
            sls_sales
        )
        select 
            sls_ord_num,
            sls_prd_key,
            sls_cust_id,
            cast(cast(sls_order_dt as varchar(10)) as date) sls_order_dt,
            cast(cast(sls_ship_dt as varchar(10)) as date) sls_ship_dt,
            cast(cast(sls_due_dt as varchar(10)) as date) sls_due_dt,
            sls_quantity,
            sls_price,
            sls_sales
        from
        (
            select
            sls_ord_num,
            sls_prd_key,
            sls_cust_id,
            CASE WHEN len(sls_order_dt)>8 then NULL
                WHEN len(sls_order_dt)<8 then NULL
                ELSE sls_order_dt END sls_order_dt,

            CASE WHEN len(sls_ship_dt)>8 then NULL
                WHEN len(sls_ship_dt)<8 then NULL
                ELSE sls_ship_dt END sls_ship_dt,

            CASE WHEN len(sls_due_dt)>8 then NULL
                WHEN len(sls_due_dt)<8 then NULL
                ELSE sls_due_dt END sls_due_dt,
            
            sls_quantity,
            case when (sls_sales is null or sls_price>0 or sls_sales<0) then sls_price*sls_quantity
            else sls_sales end sls_sales,

            case when (sls_price<0 or sls_sales>0) then sls_sales/sls_quantity
            else sls_price end sls_price
            
            from bronze.crm_sales_details
        )t
		print 'sales details loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';


        -- transform and load erp_cust into silver layer

		set @start_time=GETDATE();
		truncate table silver.erp_cust;
        insert into silver.erp_cust(
            cid,
            bdate,
            gen
        )
        select
            case when cid like 'NAS%' then replace(cid,'NAS','')
            else cid end cid,
            bdate,
            case when gen='' or gen is null then 'Unknown'
                    when gen='F' then 'Female'
                    when gen='M' then 'Male'
                    else gen end gen
        from bronze.erp_cust
		print 'cust loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';

		set @start_time=GETDATE();
		truncate table silver.erp_loc;
        --- transform and load erp_loc into silver layer

        insert into silver.erp_loc(
            cid,
            cntry
        )
        select 
            case when cid like '%-%' then replace(cid,'-','')
            else cid end cid,
            case when cntry='US' or cntry ='USA' then 'United States'
                    when cntry='DE' then 'Germany'
                    when cntry='' or cntry is null then 'Unknown'
                    else cntry end cntry
        from bronze.erp_loc
		print 'loc loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';

		set @start_time=GETDATE();
		truncate table silver.erp_px_cat;
        --- transform and load erp_px_cat into silver layer

        insert into silver.erp_px_cat(
            id,
            cat,
            subcat,
            maintenance
        )
        select
            id,
            cat,
            subcat,
            maintenance
        from bronze.erp_px_cat
		print 'px cat loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';
		set @et=GETDATE();
		print 'whole load duration: '+cast(datediff(second,@st,@et) as nvarchar)+' seconds';
	end try
	begin catch
		print 'error occured during loading bronze layer'
	end catch

end