/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time=GETDATE();
		PRINT'===================================='
		PRINT 'Loading Bronze layer'
		PRINT'====================================' 

		PRINT'------------------------------------'
		PRINT'Loading Tables'
		PRINT'------------------------------------'
		
		SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Orders'
        TRUNCATE TABLE Bronze.Orders

        PRINT'>>Inserting Data Into:Bronze.Orders'
        BULK INSERT Bronze.Orders
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\olist_orders_dataset.csv'
        WITH(
		        FIRSTROW =2,
		        FIELDTERMINATOR = ',',
		        TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'
		
		SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Order_reviews'
        TRUNCATE TABLE Bronze.Order_reviews

        PRINT'>>Inserting Data Into:Bronze.Order_reviews'
        BULK INSERT Bronze.Order_reviews
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\olist_order_reviews_dataset.csv'
        WITH(
		        FIRSTROW =2,
		        FIELDTERMINATOR = ',',
		        TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Order_items'
        TRUNCATE TABLE Bronze.Order_items;

        PRINT'>>Inserting Data Into:Bronze.Order_items'
        BULK INSERT Bronze.Order_items
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\olist_order_items_dataset.csv'
        WITH (
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',--Follows UTF-8 rules
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Order_Payments'
        TRUNCATE TABLE Bronze.Order_Payments;

        PRINT'>>Inserting Data Into:Bronze.Order_Payments'
        BULK INSERT Bronze.Order_Payments
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\olist_order_payments_dataset.csv'
        WITH (
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'
		
        SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Customers'
        TRUNCATE TABLE Bronze.Customers;

        PRINT'>>Inserting Data Into:Bronze.Customers'
        BULK INSERT Bronze.Customers
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\olist_customers_dataset.csv'
        WITH (
            FIRSTROW = 2,
            FORMAT = 'CSV',--a specific SQL Server parsing mode setting
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'
		
        SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Products'
        TRUNCATE TABLE Bronze.Products;

        PRINT'>>Inserting Data Into:Bronze.Products'
        BULK INSERT Bronze.Products
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\olist_products_dataset.csv'
        WITH (
            FIRSTROW = 2,
            FORMAT = 'CSV',--a specific SQL Server parsing mode setting
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'
		
        SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Sellers'
        TRUNCATE TABLE Bronze.Sellers;

        PRINT'>>Inserting Data Into:Bronze.Sellers'
        BULK INSERT Bronze.Sellers
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\olist_sellers_dataset.csv'
        WITH (
            FIRSTROW = 2,
            FORMAT = 'CSV',--a specific SQL Server parsing mode setting
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'
		
        SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Geolocation'
        TRUNCATE TABLE Bronze.Geolocation;

        PRINT'>>Inserting Data Into:Bronze.Geolocation'
        BULK INSERT Bronze.Geolocation
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\olist_geolocation_dataset.csv'
        WITH (
            FIRSTROW = 2,
            FORMAT = 'CSV',--a specific SQL Server parsing mode setting
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'
		
        SET @start_time = GETDATE();
        PRINT'>>Truncating Table:Bronze.Product_category_name_translation'
        TRUNCATE TABLE Bronze.Product_category_name_translation;

        PRINT'>>Inserting Data Into:Bronze.Product_category_name_translation'
        BULK INSERT Bronze.Product_category_name_translation
        FROM 'C:\Users\anjal\Dropbox\SQL Projects\OLIST_DATAPROJECT\product_category_name_translation.csv'
        WITH (
            FIRSTROW = 2,
            FORMAT = 'CSV',--a specific SQL Server parsing mode setting
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT'-------------------------------------------------------------------------------------------'
		PRINT'>> Load Duration: ' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'
		SET @batch_end_time=GETDATE();
		PRINT'-------------------------------------------------------------------------------------------'
		PRINT'Loading Bronze Layer is Completed';
		PRINT'Total Load Duration: ' +CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+' seconds';
		PRINT'-------------------------------------------------------------------------------------------'
		END TRY
		BEGIN CATCH
			PRINT'======================================================='
			PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
			PRINT'Error Message' + ERROR_MESSAGE();
			PRINT'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT'======================================================='
		END CATCH 
END
