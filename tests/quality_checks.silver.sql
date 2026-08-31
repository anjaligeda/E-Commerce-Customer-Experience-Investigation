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



