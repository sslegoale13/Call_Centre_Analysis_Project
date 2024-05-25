SET sql_safe_updates = 0;

SET sql_mode = "Traditional";

-- Call Centre Initial Data Analysis.

CREATE DATABASE call_centre;

-- Imported Call Centre data into MySQL using SQLAlchemy.

USE call_centre;

SELECT *
FROM calls;

-- 1. Removing Duplicates

SELECT *,
ROW_NUMBER() OVER(PARTITION BY `Id`) AS "Row Number"
FROM calls;

WITH Calls_CTE AS
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY `Id`) AS "Row Number"
FROM calls)
SELECT *
FROM Calls_CTE
WHERE `Row Number` >1;

-- 2. Data Formatting & Standardisation

DESCRIBE calls;

SELECT `Id`
FROM calls;

UPDATE calls
SET `Id` = upper(`Id`);

SELECT DISTINCT `Call Timestamp`
FROM calls;

SELECT `Call Timestamp`,
date_format(str_to_date(`Call Timestamp`, "%d-%m-%Y"), "%Y/%m/%d")
FROM calls;

UPDATE calls
SET `Call Timestamp` = date_format(str_to_date( `Call Timestamp`, "%Y-%m-%d") "%Y/%m/%d");

ALTER TABLE calls
CHANGE COLUMN `Call Timestamp` `Date` DATE NULL;

SELECT `Date`,
date_format(`Date`, "%Y/%m/%d")
FROM calls;

UPDATE calls
SET `Date` = date_format(`Date`, "%Y/%m/%d");

SELECT DISTINCT `Date`
FROM calls;

SELECT DISTINCT `Call-Centres City`
FROM calls;

ALTER TABLE calls
CHANGE COLUMN `Call-Centres City` `Call Centre City` TEXT NULL;

SELECT DISTINCT `Channel`
FROM calls;

SELECT DISTINCT `Channel`
FROM calls
WHERE `Channel` = "Call-Center";

UPDATE calls
SET `Channel` = "Call Centre"
WHERE `Channel` LIKE "Call-Center";

SELECT DISTINCT `Channel`
FROM calls;

SELECT DISTINCT `City`
FROM calls;

SELECT DISTINCT `Reason`
FROM calls;

SELECT DISTINCT `Response Time`
FROM calls;

SELECT DISTINCT `Sentiment`
FROM calls;

SELECT DISTINCT `State`
FROM calls
ORDER BY `State`;

SELECT DISTINCT `Csat Score`
FROM calls;

ALTER TABLE calls
CHANGE COLUMN `Csat Score` `CSAT Score` INT NULL;

SELECT *
FROM calls;

-- 3. Imputing null/blank values

SELECT `Sentiment`,
`CSAT Score`
FROM calls;
