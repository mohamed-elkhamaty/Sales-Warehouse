create or alter procedure bronze.load_bronze as 
begin
	begin try
		print 'loading bronze layer'
		declare @start_time datetime, @end_time datetime, @st datetime, @et datetime;
		set @st=GETDATE()
		set @start_time=GETDATE();
		truncate table bronze.crm_cust_info;
		bulk insert bronze.crm_cust_info
		from 'D:\projects\Sales Warehousing\datasets\source_crm\cust_info.csv'
		with (
			firstrow=2,
			fieldterminator =',',
			tablock
			);
		print 'cust info loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';

		set @start_time=GETDATE();
		truncate table bronze.crm_prd_info;
		bulk insert bronze.crm_prd_info
		from 'D:\projects\Sales Warehousing\datasets\source_crm\prd_info.csv'
		with (
			firstrow=2,
			fieldterminator =',',
			tablock
			);
		print 'prd info loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';

		set @start_time=GETDATE();
		truncate table bronze.crm_sales_details;
		bulk insert bronze.crm_sales_details
		from 'D:\projects\Sales Warehousing\datasets\source_crm\sales_details.csv'
		with (
			firstrow=2,
			fieldterminator =',',
			tablock
			);
		print 'sales details loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';

		set @start_time=GETDATE();
		truncate table bronze.erp_cust;
		bulk insert bronze.erp_cust
		from 'D:\projects\Sales Warehousing\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow=2,
			fieldterminator =',',
			tablock
			);
		print 'cust loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';

		set @start_time=GETDATE();
		truncate table bronze.erp_loc;
		bulk insert bronze.erp_loc
		from 'D:\projects\Sales Warehousing\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow=2,
			fieldterminator =',',
			tablock
			);
		print 'loc loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';

		set @start_time=GETDATE();
		truncate table bronze.erp_px_cat;
		bulk insert bronze.erp_px_cat
		from 'D:\projects\Sales Warehousing\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow=2,
			fieldterminator =',',
			tablock
			);
		print 'px cat loaded'
		set @end_time=GETDATE();
		print 'load duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds';
		set @et=GETDATE();
		print 'whole load duration: '+cast(datediff(second,@st,@et) as nvarchar)+' seconds';
	end try
	begin catch
		print 'error during loading bronze layer'
	end catch

end