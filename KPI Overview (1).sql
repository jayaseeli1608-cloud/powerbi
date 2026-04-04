--- KPI OVERVIEW VIEW ---

CREATE OR REPLACE VIEW vw_kpi_overview AS
SELECT
  COUNT(*) AS total_transactions,
  ROUND(SUM(Ticket_Price_Cr),2) AS total_revenue_cr,
  ROUND(AVG(Ticket_Price_Cr),2) AS avg_ticket_price_cr,
  ROUND(AVG(Unit_Size_Sqft),0) AS avg_unit_size_sqft,
  SUM(CASE WHEN NRI_Buyer = 'Yes' THEN 1 ELSE 0 END) AS total_nri_buyers
FROM luxury_housing;
 
--- MARKET TRENDS ---
--- QUESTION 1: How have luxury housing bookings changed quarter by quarter across micro-markets?

CREATE OR REPLACE VIEW vw_quarter_market_trend AS
SELECT
    Purchase_Quarter,
    Micro_Market,
    COUNT(*) AS booking_count
FROM luxury_housing
GROUP BY Purchase_Quarter, Micro_Market
ORDER BY Purchase_Quarter;  

--- BUILDER PERFORMANCE ---
--- QUESTION 2: Which builders have highest total ticket sales & average ticket size? --- 

CREATE OR REPLACE VIEW vw_builder_performance AS
SELECT
    Developer_Name,
    SUM(Ticket_Price_Cr) AS total_revenue,
    ROUND(AVG(Ticket_Price_Cr),2) AS average_ticket
FROM luxury_housing
GROUP BY Developer_Name
ORDER BY total_revenue DESC;

--- AMENITY IMPACT ---
--- QUESTION 3: Is there correlation between amenity score and bookings? ---

CREATE OR REPLACE VIEW vw_amenity_impact AS
SELECT
    Micro_Market,
    AVG(Amenity_Score) AS Amenity_Score,
    COUNT(*) AS bookings
FROM luxury_housing
GROUP BY Micro_Market;

--- BOOKING CONVERSION BY MICRO MARKET ---
--- QUESTION 4: Which micro-markets perform best? ---

CREATE OR REPLACE VIEW vw_booking_conversion AS
SELECT
    Micro_Market,
    COUNT(*) AS total_bookings,
    ROUND(
        (COUNT(*) / (SELECT COUNT(*) FROM luxury_housing)) * 100, 
        2
    ) AS conversion_rate_pct
FROM luxury_housing
GROUP BY Micro_Market
ORDER BY conversion_rate_pct DESC;

--- CONFIGURATION DEMAND ---
--- QUESTION 5: What are the most in-demand housing configurations? ---

CREATE OR REPLACE VIEW vw_config_demand AS
SELECT
    Configuration,
    COUNT(*) AS config_count
FROM luxury_housing
GROUP BY Configuration
ORDER BY config_count DESC;

--- SALES CHANNEL EFFICIENCY ---
--- QUESTION 6: Which sales channels contribute most? ---

CREATE OR REPLACE VIEW vw_sales_channel_perf AS
SELECT
    Sales_Channel,
    COUNT(*) AS bookings
FROM luxury_housing
GROUP BY Sales_Channel;

--- QUARTERLY BUILDER CONTRIBUTION ---
--- QUESTION 7: Which builders dominate each quarter? ---

CREATE OR REPLACE VIEW vw_builder_quarter_contribution_raw AS
SELECT
    Developer_Name AS Builder,
    CONCAT(Purchase_Year, 'Q', Purchase_Qtr) AS Purchase_Quarter,
    Ticket_Price_Cr AS ticket_price_cr
FROM luxury_housing_sales.luxury_housing
WHERE Ticket_Price_Cr IS NOT NULL
  AND Purchase_Year IS NOT NULL
  AND Purchase_Qtr IS NOT NULL;
    
--- POSSESSION STATUS ANALYSIS ---
--- QUESTION 8: How does possession status affect buyer decisions? ---

CREATE OR REPLACE VIEW vw_possession_analysis AS
SELECT
    Possession_Status,
    Buyer_Type,
    COUNT(*) AS buyer_count
FROM luxury_housing
GROUP BY Possession_Status, Buyer_Type;

--- GEOGRAPHICAL INSIGHTS ---
--- QUESTION 9: Where are projects concentrated? ---

CREATE OR REPLACE VIEW vw_market_distribution AS
SELECT
    Micro_Market,
    COUNT(*) AS project_count
FROM luxury_housing
GROUP BY Micro_Market;

--- TOP PERFORMERS ---
--- QUESTION 10: Who are the top 5 builders in terms of revenue and booking success? ---

CREATE OR REPLACE VIEW vw_top5_builders AS
SELECT 
    Developer_Name AS Builder,
    SUM(Ticket_Price_Cr) AS total_revenue
FROM luxury_housing
GROUP BY Builder
ORDER BY total_revenue DESC
LIMIT 5;

CREATE OR REPLACE VIEW vw_builder_booking_success AS
SELECT 
    lh.Developer_Name AS Builder,
    AVG(bc.conversion_rate_pct) AS avg_conversion_rate_pct,
    SUM(bc.total_bookings) AS total_bookings
FROM luxury_housing_sales.luxury_housing lh
JOIN luxury_housing_sales.vw_booking_conversion bc
    ON lh.Micro_Market = bc.Micro_Market
GROUP BY lh.Developer_Name;
