--- 1.AVERAGE PRICE AND SIZE PER MICRO MARKET ---

USE luxury_housing_Sales;
SELECT
      Micro_Market,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price_Cr,
      ROUND(AVG(Unit_Size_Sqft), 0) AS Avg_Unit_Size
FROM luxury_housing
GROUP BY Micro_Market
ORDER BY Avg_Price_Cr DESC;

--- 2.TOP 5 DEVELOPERS BY TOTAL PROJECT COUNT ---

SELECT
      Developer_Name,
      COUNT(Property_ID) AS Total_Projects,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price_Cr
FROM luxury_housing
GROUP BY Developer_Name
ORDER BY Total_Projects DESC
LIMIT 5;

--- AVERAGE PROPERTY PRICE BY CONFIGURATION ---

SELECT
      Configuration,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price_Cr,
      ROUND(AVG(Unit_Size_Sqft), 0) AS Avg_Unit_Size
FROM luxury_housing
GROUP BY Configuration
ORDER BY Avg_Price_Cr DESC;     

--- 3.PRICE VARIATION BY POSSESSION STATUS ---

SELECT
      Possession_Status,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price_Cr,
      COUNT(*) AS Total_Projects
FROM luxury_housing
GROUP BY Possession_Status;     

--- 4.BUYER TYPE DISTRIBUTION ---

SELECT
      Buyer_type,
      COUNT(*) AS Total_Buyers,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price_Cr
FROM luxury_housing
GROUP BY Buyer_Type
Order BY Total_Buyers DESC;    

--- 5.AVERAGE CONNECTIVITY AND TRAFFIC EFFICIENCY BY AREA ---

SELECT
      Micro_Market,
      ROUND(AVG(Connectivity_Score), 2) AS Avg_Connectivity,
      ROUND(AVG(Locality_Infra_Score), 2) AS Avg_Infra,
      ROUND(AVG(Avg_Traffic_Time_Min), 0) AS Avg_Traffic_Min
FROM luxury_housing
GROUP BY Micro_Market
ORDER BY Avg_Connectivity DESC;

--- 6.QUARTERLY MARKET TREND ---

SELECT
      Purchase_Quarter,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price,
      COUNT(*) AS Total_Projects
FROM luxury_housing
GROUP BY Purchase_Quarter
ORDER BY Purchase_Quarter;    

--- 7.TRANSACTION TYPE DISTRIBUTION ---

SELECT
      Transaction_Type,
      COUNT(*) AS Total_Buyers,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price
FROM luxury_housing
GROUP BY Transaction_Type
ORDER BY Total_Buyers;

--- 8.TOTAL PROJECTS BY YEAR ---

SELECT
      Purchase_Year,
      COUNT(*) AS Total_Projects,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price
FROM luxury_housing
GROUP BY Purchase_Year
ORDER BY Total_Projects DESC;  

--- 9.NUMBER OF PROJECTS SOLD THROUGH SALES CHANNEL ---

SELECT
      Sales_Channel,
      COUNT(*) AS Total_Projects,
      ROUND(AVG(Ticket_Price_Cr), 2) AS Avg_Price
FROM luxury_housing 
GROUP BY Sales_Channel
ORDER BY Total_Projects DESC;      
    
--- 10.NRI BUYERS OVERALL COUNTS ---

SELECT NRI_Buyer, COUNT(*)
FROM luxury_housing
GROUP BY NRI_Buyer;

      
