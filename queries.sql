-- ==========================================================
-- Fuel Price Analysis - SQL Script (PostgreSQL)
-- This script designs the schema and performs various analyses
-- ==========================================================

-- 1. Create Table Schema
-- Using appropriate data types for storage efficiency and query performance
CREATE TABLE fuel_prices (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    state VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    fuel_type VARCHAR(20) NOT NULL,
    price_per_liter DECIMAL(10, 2) NOT NULL
);

-- 2. Insert Data
-- Method to import CSV into PostgreSQL
-- Run this command in your terminal or SQL tool:
-- \copy fuel_prices(date, state, city, fuel_type, price_per_liter) FROM 'fuel_data_enriched.csv' WITH (FORMAT csv, HEADER true);

-- ==========================================================
-- SQL Queries
-- ==========================================================

-- ----------------------------------------------------------
-- 3.1 Basic Queries
-- ----------------------------------------------------------

-- Select all data (limit for preview)
SELECT * FROM fuel_prices LIMIT 10;

-- Filter by specific state
SELECT * FROM fuel_prices 
WHERE state = 'Maharashtra' 
ORDER BY date DESC 
LIMIT 10;

-- Find global average fuel price
SELECT AVG(price_per_liter) as avg_price 
FROM fuel_prices;

-- ----------------------------------------------------------
-- 3.2 Intermediate Queries
-- ----------------------------------------------------------

-- State-wise average fuel price
SELECT state, ROUND(AVG(price_per_liter), 2) as avg_state_price
FROM fuel_prices
GROUP BY state
ORDER BY avg_state_price DESC;

-- Highest and Lowest fuel prices recorded
SELECT 
    MAX(price_per_liter) as highest_price,
    MIN(price_per_liter) as lowest_price
FROM fuel_prices;

-- Monthly price trends (average price per month)
SELECT 
    DATE_TRUNC('month', date) as month,
    ROUND(AVG(price_per_liter), 2) as avg_monthly_price
FROM fuel_prices
GROUP BY month
ORDER BY month DESC;

-- ----------------------------------------------------------
-- 3.3 Advanced Queries (Window Functions & Analysis)
-- ----------------------------------------------------------

-- Rank states based on current fuel prices (latest date)
SELECT 
    state, 
    price_per_liter,
    RANK() OVER (PARTITION BY fuel_type ORDER BY price_per_liter DESC) as price_rank
FROM fuel_prices
WHERE date = (SELECT MAX(date) FROM fuel_prices)
AND fuel_type = 'Petrol';

-- Moving Average of fuel prices over 3 months per state
SELECT 
    date,
    state,
    fuel_type,
    price_per_liter,
    AVG(price_per_liter) OVER (
        PARTITION BY state, fuel_type 
        ORDER BY date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as mobile_avg_3m
FROM fuel_prices;

-- Price difference between Petrol and Diesel per State (Latest)
WITH LatestPrices AS (
    SELECT state, fuel_type, price_per_liter
    FROM fuel_prices
    WHERE date = (SELECT MAX(date) FROM fuel_prices)
)
SELECT 
    p.state,
    p.price_per_liter as petrol_price,
    d.price_per_liter as diesel_price,
    (p.price_per_liter - d.price_per_liter) as price_gap
FROM LatestPrices p
JOIN LatestPrices d ON p.state = d.state
WHERE p.fuel_type = 'Petrol' AND d.fuel_type = 'Diesel'
ORDER BY price_gap DESC;

-- Identify top 5 most expensive regions (Cities)
SELECT city, state, AVG(price_per_liter) as avg_price
FROM fuel_prices
GROUP BY city, state
ORDER BY avg_price DESC
LIMIT 5;

-- ----------------------------------------------------------
-- 4. Optimization
-- ----------------------------------------------------------

-- Create index on Date for fast time-series filtering
CREATE INDEX idx_fuel_date ON fuel_prices(date);

-- Create composite index on State and Fuel Type for better aggregation
CREATE INDEX idx_state_fuel ON fuel_prices(state, fuel_type);
