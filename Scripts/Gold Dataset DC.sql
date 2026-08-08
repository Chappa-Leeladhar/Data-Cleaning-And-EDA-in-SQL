SELECT *
FROM gold;

CREATE TABLE gold_staging LIKE gold;

INSERT INTO gold_staging
SELECT * FROM gold;

WITH duplicates AS
(
SELECT *,ROW_NUMBER() 
OVER(PARTITION BY Date, Closing_Price, Highest_Price_Of_the_Day, Lowest_Price_Of_The_Day, Opening_Price_Of_The_Day, Volume_Sold) AS rn
FROM gold_staging)
SELECT * FROM duplicates
WHERE rn=1;

SELECT * FROM gold_staging;

UPDATE gold_staging
SET Closing_Price=ROUND(Closing_Price,2),
Highest_Price_Of_the_Day=ROUND(Highest_Price_Of_the_Day,2),
Lowest_Price_Of_The_Day=ROUND(Lowest_Price_Of_The_Day,2),
Opening_Price_Of_The_Day=ROUND(Opening_Price_Of_The_Day,2);

UPDATE gold_staging
SET Date=STR_TO_DATE(Date,'%d-%m-%Y');

ALTER TABLE gold_staging
MODIFY Date DATE;