-- ==========================================
-- APRIL-2, 2026
-- Business Analysis Using SQL
-- AP Database: Vendors and Invoices Analysis
-- ==========================================

-- 1. Selecting the database
-- Purpose: To ensure all queries run on the AP database
USE AP;

-- Q1
-- 2. Listing all tables available in the database
-- Business Question:
-- What tables are available in the AP database?

SELECT name 
FROM sys.tables;

-- Q2
-- 3. Viewing sample rows from each table
-- Purpose: To understand table structure and determine relationships
-- This is helpful when schema design is not available

SELECT TOP 2 * FROM ContactUpdates;
SELECT TOP 2 * FROM GLAccounts;
SELECT TOP 2 * FROM InvoiceArchive;
SELECT TOP 2 * FROM InvoiceLineItems;
SELECT TOP 2 * FROM Invoices;
SELECT TOP 2 * FROM Terms;
SELECT TOP 2 * FROM Vendors;


-- 4. Checking the full Vendors and Invoices tables
-- Purpose: To inspect the raw data before analysis

SELECT * FROM Vendors;
SELECT * FROM Invoices;

-- Q3
-- 5. Finding vendors with no invoices
-- Business Question:
-- Which vendors have not generated any invoices?

SELECT v.VendorID
FROM Vendors v
LEFT OUTER JOIN Invoices i
    ON v.VendorID = i.VendorID
WHERE i.VendorID IS NULL;

-- Q4
-- 6. Counting vendors with no invoices
-- Business Question:
-- How many vendors are inactive (no invoice records)?

SELECT COUNT(*) AS no_order_vendors
FROM Vendors v
LEFT OUTER JOIN Invoices i
    ON v.VendorID = i.VendorID
WHERE i.VendorID IS NULL;

-- Q5
-- 7. Cross-verification of vendors with no invoices
-- Business Question:
-- Do vendors identified as inactive appear in the Invoices table?
-- Expected Result: 0 rows

SELECT *
FROM Invoices
WHERE VendorID IN (
    SELECT v.VendorID
    FROM Vendors v
    LEFT OUTER JOIN Invoices i
        ON v.VendorID = i.VendorID
    WHERE i.VendorID IS NULL
);

-- Q6
-- 8. Cross-verification of vendors that DO appear in invoices
-- Business Question:
-- How many invoice records belong to vendors that exist in both tables?

SELECT COUNT(*) AS No_of_inv
FROM Invoices
WHERE VendorID IN (
    SELECT v.VendorID
    FROM Vendors v
    LEFT OUTER JOIN Invoices i
        ON v.VendorID = i.VendorID
);

-- Q7
-- 9. Find the sum of total amount group by vendors
-- Purpose: To inspect how both tables are related
-- Step-1: join both tables and obseve
SELECT *
FROM Vendors v
INNER JOIN Invoices i
    ON v.VendorID = i.VendorID;


-- Step-2: Viewing vendor IDs with payment totals
-- Purpose: To inspect payment values before aggregation

SELECT v.VendorID, i.PaymentTotal
FROM Vendors v
INNER JOIN Invoices i
    ON v.VendorID = i.VendorID;


-- Step-3: Total payment amount per vendor
-- Business Question:
-- What is the total payment amount associated with each vendor?

SELECT v.VendorID, SUM(i.PaymentTotal) AS totalpayment
FROM Vendors v
INNER JOIN Invoices i
    ON v.VendorID = i.VendorID
GROUP BY v.VendorID
ORDER BY totalpayment DESC;

-- Q8
--10. Find the average of paymenttotal (amount) of active vendors;
-- step-1: find total active vendors
-- Purpose: Vendors appearing in the Invoices table are considered active

SELECT VendorID
FROM Invoices;


-- Step 2 : Count of active vendor invoice records
-- Purpose: To observe invoice-linked vendor entries

SELECT COUNT(VendorID)
FROM Invoices;


-- Step -3: Total payment amount across all invoices
-- Purpose: To calculate total invoice payments

SELECT SUM(PaymentTotal)
FROM Invoices;


-- Step-4: Average payment amount per active vendor (based on invoice rows)
-- Business Question:
-- What is the average payment amount among active vendor invoice records?

SELECT SUM(PaymentTotal) / COUNT(VendorID) AS average_amt_per_vendor
FROM Invoices;

-- Q9
-- (Bonus: Average payment amount across all vendors)
-- Business Question:
-- What is the average vendor payment when inactive vendors are also included?

SELECT SUM(i.PaymentTotal) / COUNT(v.VendorID) AS avg_amt_per_vendor
FROM Vendors v
LEFT JOIN Invoices i
    ON v.VendorID = i.VendorID;

-- Q10
-- 11. Finding invoices with credit balances
-- Business Question:
-- Which invoices have a CreditTotal greater than zero?

SELECT *
FROM Invoices
WHERE CreditTotal > 0;

-- Q11
-- 12. Finding vendors located in the same city and state
-- Business Question:
-- Which vendors share the same city and state location?

SELECT DISTINCT v1.VendorName, v1.VendorCity, v1.VendorState
FROM Vendors v1
JOIN Vendors v2
    ON v1.VendorCity = v2.VendorCity
   AND v1.VendorState = v2.VendorState
   AND v1.VendorID <> v2.VendorID
ORDER BY v1.VendorState, v1.VendorCity;
--on joinging conditions, both should have same city, state but not id, it means in any city have just 1 vendor will not be shown here. 
--thats how we filter the multiple store in same city