SELECT * FROM gold_staging
WHERE Date LIKE '2021%';

SELECT MONTH(`Date`) AS mth,SUM(Volume_Sold) as Total_Volume_Sold
FROM gold_staging
GROUP BY mth
ORDER BY 2 DESC;

SELECT YEAR(Date) AS yr,SUM(Volume_Sold) as Total_Volume_Sold
FROM gold_staging
GROUP BY yr
ORDER BY 2 DESC;

SELECT SUBSTRING(Date,1,7) AS yr_mth,SUM(Volume_Sold)
FROM gold_staging
GROUP BY yr_mth
ORDER BY 2 DESC;

SELECT MIN(Closing_Price),MAX(Closing_Price) FROM gold_staging;

SELECT MIN(Highest_Price_Of_the_Day),MAX(Highest_Price_Of_the_Day) FROM gold_staging;

SELECT MIN(Lowest_Price_Of_The_Day),MAX(Lowest_Price_Of_The_Day) FROM gold_staging;

SELECT MIN(Opening_Price_Of_The_Day),MAX(Opening_Price_Of_The_Day) FROM gold_staging;

WITH Volume_Ranking AS
(
SELECT *,DENSE_RANK() OVER(ORDER BY Volume_Sold DESC) AS Ranking
FROM gold_staging)
SELECT *
FROM Volume_Ranking
WHERE ranking<=10;