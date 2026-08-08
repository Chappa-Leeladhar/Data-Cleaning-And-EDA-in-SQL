# Data-Cleaning-And-EDA-in-SQL
This is an end to end SQL project which involves data cleaning, standardization of data, and performing Exploratory Data Analysis in MySQL. The end goal is to transform the raw data to an analysis ready format and perform Exploratory Data Analysis.

---
## Tech Stack:
* **Database Management System:** MySQL
* **SQL Skills Applied:**
  * Data Cleaning: Used ROUND,UPDATE,STR_TO_DATE,ALTER TABLE.
  * EDA: Aggregate Functions('SUM','MIN','MAX'),'GROUP BY','ORDER BY', Window Functions('DENSE_RANK'),CTE.

---
## Dataset Information
* **Source:** gold_stock_2.csv from this repo.
* **Original Records:** 2968 rows.
* **Key Fields**: Date, Closing_Price, Highest_Price_Of_the_Day, Lowest_Price_Of_The_Day, Opening_Price_Of_The_Day, Volume_Sold.

---
## Data Cleaning Process
1. **Duplicate Removal:**
   * Used ROUND function to round-off the values to 2 digits in columns having price.
2. **Standardization & Formatting:**
   * Converted text date strings into proper MySQL 'DATE' objects using 'STR_TO_DATE()' and 'ALTER TABLE'.

---
## Exploratory Data Analysis & Key Questions
### 1. In which month most gold has been traded over the years?
```sql
SELECT MONTH(`Date`) AS mth,SUM(Volume_Sold) as Total_Volume_Sold
FROM gold_staging
GROUP BY mth
ORDER BY 2 DESC;
```
* **Findings:** It is found that 9th month i.e.., September had the most gold traded over the years which is 9% more than the second most gold traded month.

### 2. In which year most gold has been traded?
```sql
SELECT YEAR(Date) AS yr,SUM(Volume_Sold) as Total_Volume_Sold
FROM gold_staging
GROUP BY yr
ORDER BY 2 DESC;
```
* **Findings:** It is found that 2024 had most gold traded than any other year. It's a 50% rise compared to it's previous year's total traded gold and 9% more when compared to it's next yr traded gold.

### 3. In which days most gold has been traded?
```sql
WITH Volume_Ranking AS
(
SELECT *,DENSE_RANK() OVER(ORDER BY Volume_Sold DESC) AS Ranking
FROM gold_staging)
SELECT *
FROM Volume_Ranking
WHERE ranking<=10;
```
* **Findings:** It is found that the most gold traded per day happened on 4th March 2021, which is 55% more from the second most gold traded day.

---
## How to run this project
1. Clone or Download this repository.

2. Open MYSQL workbench or your preferred SQL client.

3. Create a new schema.
```sql
CREATE DATABASE IF NOT EXISTS eg_database;
USE eg_database;
```

5. Right click on the schema and import the raw data file(gold_stock_2.csv) using Table Data Import Wizard.

6. Run the gold dataset DC to clean the data

7. Run the gold dataset EDA to perform Exploratory Data Analysis.
