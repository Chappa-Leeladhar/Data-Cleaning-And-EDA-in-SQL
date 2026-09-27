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
* **Source:** data/gold_stock_2.csv from this repo.
* **Original Records:** 2968 rows.
* **Key Fields**: Date, Closing_Price, Highest_Price_Of_the_Day, Lowest_Price_Of_The_Day, Opening_Price_Of_The_Day, Volume_Sold.

---
## Data Cleaning Process
1. **Duplicate Removal:**
   * Used ROUND function to round-off the values to 2 digits in columns having price.
2. **Standardization & Formatting:**
   * Converted text date strings into proper MySQL 'DATE' objects using 'STR_TO_DATE()' and 'ALTER TABLE'.

---
## Business Problem
Gold traders and investors need to know when trading activity is unusually high, and whether 
there are recurring seasonal patterns — to time decisions and flag days worth investigating 
further. This project cleans raw gold price/volume data and analyzes it in MySQL to surface 
those patterns.

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
* **Recommendation**: Check whether this aligns with known seasonal demand drivers (e.g., 
festival or fiscal year-end buying) a repeating pattern like this is useful for timing 
decisions, not just a curiosity.

### 2. In which year most gold has been traded?
```sql
SELECT YEAR(Date) AS yr,SUM(Volume_Sold) as Total_Volume_Sold
FROM gold_staging
GROUP BY yr
ORDER BY 2 DESC;
```
* **Findings:** It is found that 2024 had most gold traded than any other year. It's a 50% rise compared to it's previous year's total traded gold and 9% more when compared to it's next yr traded gold.
* **Recommendation**: A jump this large is a signal, not just a stat worth investigating what 
changed that year (rates, inflation, geopolitical events) before assuming it's a trend that 
continues.


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
* **Recommendation**: Use this kind of outlier detection as the basis for a simple alert system flagging any day where volume crosses a set threshold for manual review, since spikes this large are usually tied to specific market news.

---
## How to run this project
1. Clone or Download this repository.

2. Open MYSQL workbench or your preferred SQL client.

3. Create a new schema.
```sql
CREATE DATABASE IF NOT EXISTS eg_database;
USE eg_database;
```

5. Right click on the schema and import the raw data file(data/gold_stock_2.csv) using Table Data Import Wizard.

6. Run the scripts/gold dataset DC.sql to clean the data

7. Run the scripts/gold dataset EDA.sql to perform Exploratory Data Analysis.
