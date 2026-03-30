Data Eploration Analysis to get the full understating of the data we will be working with.

Data Exploration Analysis EDA 

SQL Query Checking the Data if it was captured corretly, number of columns 

Select *
From workspace.default.Bright_Coffee_Shop_Project 
limit 10;

The Data is accurate, same data that was inspected 

Checking the date range for the Bright Coffee Shop or period of operation for the Bright Coffee Shop 

SQL Query for Start Date and Last Date 
Select Min(transaction_date) As Start_Date
From workspace.default.Bright_Coffee_Shop_Project;

Select Max (transaction_date) As Last_Date 
From workspace.default.Bright_Coffee_Shop_Project;

The total operation period is 6 months Starting from 01 Janaury 2023 to 30 June 2023

SQL Syntax Checking the operating times of the shop,

select Min (transaction_time) as Start_Time,
       Max (transaction_time) as Closing_Time
from workspace.default.Bright_Coffee_Shop_Project;

The Bright Coffee hop operates from 06h00 to 21h00 15 Hours 

Cheking the total number of store location for Bright Coffee Shop
SQL syntax for Total Store Locations 

select distinct (store_location)
from workspace.default.Bright_Coffee_Shop_Project;

3 store location in total 

checking the all products sold in the all the stores,

select distinct (product_category)
from workspace.default.Bright_Coffee_Shop_Project;

select distinct (product_type)
from workspace.default.Bright_Coffee_Shop_Project;

select product_category As Category,
       product_detail AS Product_name, 
       product_type 
from workspace.default.Bright_Coffee_Shop_Project;

Checking product prices 

select Min(Unit_price) As Cheapest_Price,
       Max(Unit_price) As Expensive_Price
from workspace.default.Bright_Coffee_Shop_Project; 

unique identifiers Count IDs  

select COUNT(*),
       COUNT(DISTINCT transaction_id) As Number_Of_Sales, 
       COUNT(DISTINCT product_id) As Number_of_Products,
       COUNT(DISTINCT store_id) As Number_of_Stores
from workspace.default.Bright_Coffee_Shop_Project;

Day name and Month name functions

select
--Categorical columns
       store_location,
       product_category,
       product_detail,

-- Dates 
        transaction_date,
        transaction_time,
       dayname(transaction_date) As Day_Name,
       Monthname(transaction_date) As Month_Name,
       Dayofmonth(transaction_date) As Day_Of_Month,

       CASE 
           WHEN Day_Name IN ('Sun', 'Sat') THEN 'weekend'
           ELSE 'Weekday'
       END AS Day_Classification,
       date_format(transaction_time, 'HH:mm:ss') As Purchase_time,
      
      CASE 
          WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '01. Morning Rush'
          WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02. Afternoon'
          WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN '03. Evening'
     END AS Time_Buckets,

--Counts of IDs 
       COUNT(*),
       COUNT(DISTINCT transaction_id) As Number_Of_Sales, 
       COUNT(DISTINCT product_id) As Number_of_Products,
       COUNT(DISTINCT store_id) As Number_of_Stores,

--Revenue 
        unit_price,
       SUM(transaction_qty*unit_price) As Revenue_Per_Day,

       CASE 
           WHEN SUM(transaction_qty*unit_price) <= 50 THEN '01. Low Spend'
           WHEN SUM(transaction_qty*unit_price) BETWEEN 51 AND 100 THEN '02. Medium Spend'
      ELSE '03. High Spend'
      END AS Spend_Bucket

from workspace.default.Bright_Coffee_Shop_Project
GROUP BY transaction_date,
         transaction_time,
         store_location,
         product_category,
         product_detail;

