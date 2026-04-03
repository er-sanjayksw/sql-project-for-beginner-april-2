# sql-project-for-beginner-april-2
 
Project Description
This SQL analysis explores the Accounts Payable (AP) database to understand vendor activity, invoice behavior, payment amounts, and vendor distribution across locations. The analysis uses core AP-related tables such as Vendors, Invoices, InvoiceLineItems, GLAccounts, Terms, and others to identify meaningful business insights.

The main objective of this analysis is to answer important business questions related to:
1. Vendor participation
2. Invoice generation
3. Payment trends
4. Inactive vendors
5. Average vendor payments
6. Shared vendor locations 
This type of analysis is useful for finance teams, procurement teams, and business analysts to evaluate vendor engagement, monitor payable activity, and support strategic vendor management.
 
Business Questions / Analytical Questions
The following business questions are addressed through this SQL analysis:
1.	What tables are available in the AP database? 
2.	What are the structures of the key tables and how are they related? 
3.	Which vendors have not generated any invoices? 
4.	How many vendors are inactive (i.e., have no invoice records)? 
5.	Do vendors identified as inactive appear in the Invoices table? 
6.	How many invoice records belong to vendors that exist in both tables? 
7.	What is the total payment amount associated with each vendor? 
8.	What is the average payment amount among active vendors (based on invoice records)? 
9.	What is the average vendor payment when inactive vendors are also included? 
10.	Which invoices have a CreditTotal greater than zero? 
11.	Which vendors share the same city and state location?

What This Analysis Helps a Business Understand
This analysis helps the business identify:
1. Which vendors are inactive
2. Which vendors contribute the highest payable amounts
3. Overall vendor payment trends
4. Whether vendor relationships are being actively used
5. Possible duplicate/local clustering of vendors
6. Credit-related invoice records
7. Average financial exposure to vendors 

These insights are useful for:
1. Vendor relationship management
2. Procurement optimization
3. Finance reporting
4. Accounts payable monitoring
5. Vendor performance review

