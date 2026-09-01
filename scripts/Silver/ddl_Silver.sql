/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'Silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'Bronze' Tables
===============================================================================
*/

IF OBJECT_ID('Silver.Orders', 'U') IS NOT NULL
    DROP TABLE Silver.Orders;
GO

CREATE TABLE Silver.Orders (
    order_id                       NVARCHAR(50),
    customer_id                    NVARCHAR(50),
    order_status                   NVARCHAR(50),
    order_purchase_timestamp       DATETIME,
    order_approved_at              DATETIME,
    order_delivered_carrier_date   DATETIME,
    order_delivered_customer_date  DATETIME,
    order_estimated_delivery_date  DATETIME,
    dwh_create_date                DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.Order_items', 'U') IS NOT NULL
    DROP TABLE silver.Order_items;
GO

CREATE TABLE silver.Order_items (
    order_id             NVARCHAR(50),
    order_item_id        INT,
    product_id           NVARCHAR(50),
    seller_id            NVARCHAR(50),
    shipping_limit_date  DATETIME,
    price                DECIMAL(10,2),
    freight_value        DECIMAL(10,2),
    dwh_create_date      DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.Order_reviews', 'U') IS NOT NULL
    DROP TABLE silver.Order_reviews;
GO

CREATE TABLE silver.Order_reviews (
    review_id     NVARCHAR(50),
    order_id     NVARCHAR(50),
    review_score     INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('Silver.Order_Payments', 'U') IS NOT NULL
    DROP TABLE silver.Order_Payments;
GO

CREATE TABLE silver.Order_Payments (
    order_id             NVARCHAR(50),
    payment_sequential   INT,
    payment_type         NVARCHAR(50),
    payment_installments INT,
    payment_value        DECIMAL(10,2),
    dwh_create_date       DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.Customers', 'U') IS NOT NULL
    DROP TABLE silver.Customers;
GO

CREATE TABLE silver.Customers (
    customer_id              NVARCHAR(50),
    customer_unique_id       NVARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city            NVARCHAR(50),
    customer_state           NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.Products', 'U') IS NOT NULL
    DROP TABLE silver.Products;
GO

CREATE TABLE silver.Products (
    product_id                 NVARCHAR(50),
    product_category_name      NVARCHAR(50),
    product_name_length        INT,
    product_description_length INT,
    product_photos_qty         INT,
    product_weight_g           INT,
    product_length_cm          INT,
    product_height_cm          INT,
    product_width_cm           INT,
    dwh_create_date            DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.Product_category_name', 'U') IS NOT NULL
    DROP TABLE silver.Product_category_name;
GO

CREATE TABLE silver.Product_category_name (
    product_category_name          NVARCHAR(50),
    product_category_name_english  NVARCHAR(50),
    dwh_create_date                DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.Sellers', 'U') IS NOT NULL
    DROP TABLE silver.Sellers;
GO

CREATE TABLE silver.Sellers (
    seller_id                 NVARCHAR(50),
    seller_zip_code_prefix    NVARCHAR(50),
    seller_city               INT,
    seller_state              INT,
    dwh_create_date           DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.Geolocation', 'U') IS NOT NULL
    DROP TABLE silver.Geolocation;
GO

CREATE TABLE silver.Geolocation (
    geolocation_zip_code_prefix      NVARCHAR(50),
    geolocation_lat                  NVARCHAR(50),
    geolocation_lng                  INT,
    geolocation_city                 INT,
    geolocation_state                INT,
    dwh_create_date                  DATETIME2 DEFAULT GETDATE()
);
GO
