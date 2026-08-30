/* 
================================================
CREATE DATABASE AND SCHEMAS
================================================
Script Purpose: 
  This script creates new database name 'Olist_Database' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three 
  schemas within databases: 'bronze','silver' and 'gold'.

WARNING:
  Running this script will drop the entire 'Olist_Database' database if it exists.
  All data in the database will be permanantly deleted. Proceed with caution and 
  ensure you have proper backups before running this script.
*/

USE master;
GO

--Drop and recreate the 'Olist_Database' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name='Olist_Database')
BEGIN
	ALTER DATABASE Olist_Database SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Olist_Database;
END;
GO

--Create the 'Olist_Database' database
CREATE DATABASE Olist_Database;
GO

USE Olist_Database

--Create Schemas
CREATE SCHEMA Bronze
GO

CREATE SCHEMA Silver
GO

CREATE SCHEMA Gold
GO
