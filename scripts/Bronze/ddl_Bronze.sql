/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'Bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'Bronze' Tables
===============================================================================
*/

IF OBJECT_ID ('Bronze.Orders' , 'U') IS NOT NULL
	DROP TABLE Bronze.Orders;

CREATE TABLE Bronze.Orders(
	order_id VARCHAR(50),
	customer_id VARCHAR(50),
	order_status VARCHAR(50),
	order_purchase_timestamp VARCHAR(50),
	order_approved_at VARCHAR(50),
	order_delivered_carrier_date VARCHAR(50),
	order_delivered_customer_date VARCHAR(50),
	order_estimated_delivery_date VARCHAR(50)
);

IF OBJECT_ID ('Bronze.Customers' , 'U') IS NOT NULL
	DROP TABLE Bronze.Customers;

CREATE TABLE Bronze.Customers(
	customer_id VARCHAR(50),
	customer_unique_id VARCHAR(50),
	customer_zip_code_prefix VARCHAR(50),
	customer_city VARCHAR(50),
	customer_state VARCHAR(50)
);

IF OBJECT_ID ('Bronze.Order_items' , 'U') IS NOT NULL
	DROP TABLE Bronze.Order_items;

CREATE TABLE Bronze.Order_items(
	order_id VARCHAR(50),
	order_item_id VARCHAR(50),
	product_id VARCHAR(50),
	seller_id VARCHAR(50),
	shipping_limit_date VARCHAR(50),
	price VARCHAR(50),
	freight_value VARCHAR(10)
)

IF OBJECT_ID ('Bronze.Order_reviews' , 'U') IS NOT NULL
	DROP TABLE Bronze.Order_reviews;

CREATE TABLE Bronze.Order_reviews(
	review_id VARCHAR(50),
	order_id VARCHAR(50),
	review_score VARCHAR(50),
	review_creation_date VARCHAR(50),
	review_answer_timestamp VARCHAR(50)
)

IF OBJECT_ID ('Bronze.Products' , 'U') IS NOT NULL
	DROP TABLE Bronze.Products;

CREATE TABLE Bronze.Products(
	product_id VARCHAR(50),
	product_category_name VARCHAR(50),
	product_name_length VARCHAR(50),
	product_description_length VARCHAR(50),
	product_photos_qty VARCHAR(50),
	product_weight_g VARCHAR(50),
	product_length_cm VARCHAR(50),
	product_height_cm VARCHAR(50),
	product_width_cm VARCHAR(50)
);

IF OBJECT_ID ('Bronze.Sellers' , 'U') IS NOT NULL
	DROP TABLE Bronze.Sellers;

CREATE TABLE Bronze.Sellers(
	seller_id VARCHAR(50),
	seller_zip_code_prefix VARCHAR(50),
	seller_city VARCHAR(50),
	seller_state VARCHAR(50)
);

IF OBJECT_ID ('Bronze.Order_Payments' , 'U') IS NOT NULL
	DROP TABLE Bronze.Order_Payments;

CREATE TABLE Bronze.Order_Payments(
	order_id VARCHAR(50),
	payment_sequential VARCHAR(50),
	payment_type VARCHAR(50),
	payment_installments VARCHAR(50),
	payment_value VARCHAR(50)
);

IF OBJECT_ID ('Bronze.Geolocation' , 'U') IS NOT NULL
	DROP TABLE Bronze.Geolocation;

CREATE TABLE Bronze.Geolocation(
	geolocation_zip_code_prefix VARCHAR(50),
	geolocation_lat VARCHAR(50),
	geolocation_lng VARCHAR(50),
	geolocation_city VARCHAR(50),
	geolocation_state VARCHAR(50)
);

IF OBJECT_ID ('Bronze.Product_category_name_translation' , 'U') IS NOT NULL
	DROP TABLE Bronze.Product_category_name_translation;

CREATE TABLE Bronze.Product_category_name_translation(
	product_category_name VARCHAR(50),
	product_category_name_english VARCHAR(50)
)





