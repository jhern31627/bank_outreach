use Transactions

-- Putting age into bins 

SELECT 
	*,
	CASE 
		WHEN age BETWEEN 17 AND 28 THEN '17-28'
		WHEN age BETWEEN 29 AND 38 THEN '29-38'
		WHEN age BETWEEN 39 AND 48 THEN '39-48'
		WHEN age BETWEEN 49 AND 58 THEN '49-58'
	ELSE '59+'
	END AS age_group
FROM bank


-- Displays the month, age group, count of Subscribers, camapiagns ran for age group and month, and avg  duration of calls

WITH age_demo AS (
SELECT 
	*,
	CASE 
		WHEN age BETWEEN 17 AND 28 THEN '17-28'
		WHEN age BETWEEN 29 AND 38 THEN '29-38'
		WHEN age BETWEEN 39 AND 48 THEN '39-48'
		WHEN age BETWEEN 49 AND 58 THEN '49-58'
	ELSE '59+'
	END AS age_group
FROM bank
)

SELECT 
	age_group,
	month,
	COUNT([BINARY Y/N]) yesCount,
	SUM(campaign) campCount,
	AVG (duration) avgTime
FROM age_demo
WHERE [BINARY Y/N] = 1
GROUP BY age_group, month
ORDER BY age_group



-- Looking into why possible peaks in months 

WITH age_demo AS (
SELECT 
	*,
	CASE 
		WHEN age BETWEEN 17 AND 28 THEN '17-28'
		WHEN age BETWEEN 29 AND 38 THEN '29-38'
		WHEN age BETWEEN 39 AND 48 THEN '39-48'
		WHEN age BETWEEN 49 AND 58 THEN '49-58'
	ELSE '59+'
	END AS age_group
FROM bank
)
SELECT 
	age_group,
	month,
	AVG (duration) avgTime
FROM age_demo
WHERE [BINARY Y/N] = 1
GROUP BY age_group, month
ORDER BY age_group



-- Categoriesing Call frequency (0 = low, 3 = high) 


with yesCount AS (
SELECT 
	campaign, 
	SUM(campaign) campRan
FROM bank
WHERE [BINARY Y/N] = 0
GROUP BY campaign

)

SELECT 
	campaign,
	CAMPRAN,
	CASE 
		WHEN campaign between 1 and 4 THEN 0
		WHEN campaign  between 5 AND 9 THEN 1
		ELSE 3
	END callCat
FROM yesCount
ORDER BY campaign asc


-- check if avg time effects subs (duration, age, month) 
select * from bank

select 
	month,
	CASE 
		WHEN age BETWEEN 17 AND 28 THEN '17-28'
		WHEN age BETWEEN 29 AND 38 THEN '29-38'
		WHEN age BETWEEN 39 AND 48 THEN '39-48'
		WHEN age BETWEEN 49 AND 58 THEN '49-58'
	ELSE '59+'
	END AS age_group, 
	AVG(duration) avgDuration,
	COUNT(y) totalSubs
from bank
WHERE y = 'yes'
GROUP BY 
	Month,
	CASE 
        WHEN age BETWEEN 17 AND 28 THEN '17-28'
        WHEN age BETWEEN 29 AND 38 THEN '29-38'
        WHEN age BETWEEN 39 AND 48 THEN '39-48'
        WHEN age BETWEEN 49 AND 58 THEN '49-58'
        ELSE '59+'
    END
order by age_group