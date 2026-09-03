/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'Silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'Silver.Orders'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT order_id,count(*) 
FROM Silver.Orders
GROUP BY order_id --repeat same for customer_id and order_status
HAVING count(*) > 1 or order_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Results
  SELECT 
    order_id --repeat same for customer_id and order_status
FROM Silver.Orders
WHERE order_id != TRIM(order_id);

-- Data Standardization & Consistency
SELECT DISTINCT 
    order_status 
FROM Silver.Orders;

-- Check for Invalid Date Orders (Start Date > End Date)
-- Expectation: No Results
SELECT COUNT(*) AS bad_carrier_date
FROM Silver.Orders
WHERE order_delivered_carrier_date < order_approved_at;

SELECT COUNT(*) AS bad_customer_date
FROM Silver.Orders
WHERE order_delivered_customer_date < order_delivered_carrier_date;

SELECT COUNT(*) AS bad_approved_date
FROM Silver.Orders
WHERE order_approved_at < order_purchase_timestamp;

-- ====================================================================
-- Checking 'Silver.Order_Payments'
-- ====================================================================
--check if there is any order_id which is not present in Silver.Orders but in Silver.Order_Payments
SELECT order_id
FROM Silver.Order_Payments
GROUP BY order_id
HAVING order_id not in (SELECT order_id FROM Silver.Orders)

-- ====================================================================
-- Checking 'Silver.Order_reviews'
-- ====================================================================     
-- Validate score range (should return 0 rows)
SELECT * FROM Silver.Order_Reviews WHERE review_score NOT BETWEEN 1 AND 5;

-- Check nulls (should return 0 rows)
SELECT * FROM Silver.Order_Reviews WHERE order_id IS NULL OR review_score IS NULL;

-- ====================================================================
-- Checking 'Silver.Customers'
-- ====================================================================  
--check if there is any customer_id which is not present in Silver.Orders but in Silver.Customers
SELECT customer_id
FROM Bronze.Customers
GROUP BY customer_id
HAVING customer_id not in (SELECT customer_id FROM Silver.Orders)

--check if there is any duplicates
SELECT customer_id, COUNT(*)
FROM Bronze.Customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

--confirm COUNT(DISTINCT customer_unique_id) < COUNT(DISTINCT customer_id)
--which validates the repeat-customer structure
SELECT
    COUNT(DISTINCT customer_id) AS distinct_customer_ids,
    COUNT(DISTINCT customer_unique_id) AS distinct_unique_customers
FROM Bronze.Customers;

--Brazilian zip prefixes should be numeric and a consistent length
SELECT DISTINCT customer_zip_code_prefix
FROM Bronze.Customers
WHERE ISNUMERIC(customer_zip_code_prefix) = 0;

--Check Distinct cities
SELECT DISTINCT customer_city FROM Bronze.Customers ORDER BY customer_city;

--Check for trailing spaces
SELECT * FROM Bronze.Customers WHERE customer_city <> TRIM(customer_city);

--Check whether city is distinctly paired with the state
SELECT customer_city, COUNT(DISTINCT customer_state) AS state_count
FROM Bronze.Customers
GROUP BY customer_city
HAVING COUNT(DISTINCT customer_state) > 1;

--length of brazilian zip code should be 6 digits
SELECT customer_zip_code_prefix, LEN(CAST(customer_zip_code_prefix AS VARCHAR))
FROM Bronze.Customers
WHERE LEN(CAST(customer_zip_code_prefix AS VARCHAR)) < 5;

-- ====================================================================
-- Checking 'Silver.Order_items'
-- ====================================================================  
-- distinct orders in Order_Items
SELECT COUNT(DISTINCT order_id) FROM Silver.Order_Items;

--check if there is any order_id which is not present in Silver.Orders but in Silver.Order_items
SELECT order_id
FROM Silver.Order_items
GROUP BY order_id
HAVING order_id not in (SELECT order_id FROM Silver.Orders)

--Orders with duplicate product+seller combinations (bulk quantity check)    
SELECT
    order_id,
    product_id,
    seller_id,
    COUNT(*) AS times_repeated
FROM Silver.Order_Items
GROUP BY order_id, product_id, seller_id
HAVING COUNT(*) > 1
ORDER BY times_repeated DESC;

-- ====================================================================
-- Checking 'Silver.Products'
-- ====================================================================  
--check if there is any customer_id which is not present in Silver.Orders but in Silver.Customers
SELECT product_id
FROM Silver.Products
GROUP BY product_id
HAVING product_id not in (SELECT product_id FROM Silver.Order_items)

--check if there is any duplicates
SELECT product_id, COUNT(*)
FROM Silver.Products
GROUP BY product_id
HAVING COUNT(*) > 1;

--check for trailing spaces
SELECT product_category_name
FROM Silver.Products
WHERE product_category_name != TRIM(product_category_name)

-- ====================================================================
-- Checking 'Silver.Sellers'
-- ====================================================================  
--check if there is any seller_id which is not present in Silver.Orders but in Silver.Products
SELECT seller_id
FROM Silver.Sellers
GROUP BY seller_id
HAVING seller_id not in (SELECT seller_id FROM Silver.Order_items)

--check if there is any duplicates
SELECT seller_id, COUNT(*)
FROM Silver.Sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

--check for trailing spaces
SELECT seller_id
FROM Silver.Sellers
WHERE seller_id != TRIM(seller_id)

--Brazilian zip prefixes should be numeric and a consistent length
SELECT seller_zip_code_prefix, LEN(seller_zip_code_prefix) AS zip_length
FROM Bronze.Sellers
WHERE LEN(seller_zip_code_prefix) < 5;





