--- TABLE SCHEMA --- 

CREATE TABLE luxury_housing(
Property_ID VARCHAR(20),
Micro_Market VARCHAR(100),
Project_Name VARCHAR(150),
Developer_Name VARCHAR(100),
Unit_Size_Sqft FLOAT,
Configuration VARCHAR(20),
Ticket_Price_Cr FLOAT,
Transaction_Type VARCHAR (20),
Buyer_Type VARCHAR(50),
Purhase_Quarter VARCHAR(50),
Connectivity_Score FLOAT,
Amenity_Score FLOAT,
Possession_Status VARCHAR(50),
Sales_Channel VARCHAR(50),
NRI_Buyer VARCHAR(10),
Locality_Infra_Score FLOAT,
Avg_Traffic_Time_Min INT,
Buyer_Comments TEXT);

--- INSERTION VALIDATION ---

--- 1. CHECKING TOTAL RECORDS ---

USE luxury_housing_sales;
SELECT COUNT(*) AS Total_Records FROM luxury_housing;

--- 2.HANDLE MISSING VALUES ---

USE luxury_housing_sales;
SELECT
   SUM(CASE WHEN Property_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Property_ID,
   SUM(CASE WHEN Ticket_Price_Cr IS NULL THEN 1 ELSE 0 END) AS Missing_Ticket_Price_Cr,
   SUM(CASE WHEN Unit_Size_Sqft IS NULL THEN 1 ELSE 0 END) AS Missing_Unit_Size_Sqft,
   SUM(CASE WHEN Amenity_Score IS NULL THEN 1 ELSE 0 END) AS Missing_Amenity_Score,
   SUM(CASE WHEN Locality_Infra_Score IS NULL THEN 1 ELSE 0 END) AS Missing_Locality_Infra_Score,
   SUM(CASE WHEN Buyer_Comments IS NULL THEN 1 ELSE 0 END) AS Missing_Buyer_Comments
FROM luxury_housing;

USE luxury_housing_sales;
ALTER TABLE luxury_housing_Sales.luxury_housing
CHANGE COLUMN `ï»¿Property_ID` PROPERTY_ID VARCHAR(50);

--- 3.DUPLICATE VALUES ---

SELECT COUNT(DISTINCT Property_ID) AS Unique_Properties FROM luxury_housing;

--- 4.CATEGORICAL COVERAGE ---

SELECT DISTINCT Configuration FROM luxury_housing;
SELECT DISTINCT Transaction_Type FROM luxury_housing;
SELECT DISTINCT Buyer_Type FROM luxury_housing;
SELECT DISTINCT Sales_Channel FROM luxury_housing;