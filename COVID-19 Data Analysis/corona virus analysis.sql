--count total rows
SELECT COUNT(*) AS TotalRows FROM dbo.co;


-- Check for NULLs in Province
SELECT COUNT(*) AS NullProvinceCount 
FROM dbo.covid19 
WHERE Province IS NULL;


SELECT 
    COUNT(CASE WHEN Province IS NULL THEN 1 END) AS NullProvince,
    COUNT(CASE WHEN [Country/Region] IS NULL THEN 1 END) AS NullCountryRegion,
    COUNT(CASE WHEN Latitude IS NULL THEN 1 END) AS NullLatitude,
    COUNT(CASE WHEN Longitude IS NULL THEN 1 END) AS NullLongitude,
    COUNT(CASE WHEN Date IS NULL THEN 1 END) AS NullDate,
    COUNT(CASE WHEN Confirmed IS NULL THEN 1 END) AS NullConfirmed,
    COUNT(CASE WHEN Deaths IS NULL THEN 1 END) AS NullDeaths,
    COUNT(CASE WHEN Recovered IS NULL THEN 1 END) AS NullRecovered
FROM dbo.covid19;

--to update null values
USE [COVID-19 Analysis];

UPDATE dbo.covid19
SET 
    Province = ISNULL(Province, 0),
    [Country/Region] = ISNULL([Country/Region], '0'),
    Latitude = ISNULL(Latitude, 0),
    Longitude = ISNULL(Longitude, 0),
    Date = ISNULL(Date, 0), 
    Confirmed = ISNULL(Confirmed, 0),
    Deaths = ISNULL(Deaths, 0),
    Recovered = ISNULL(Recovered, 0);







SELECT
	MIN(Date) as start_date,
	MAX(Date) AS end_date
FROM dbo.Sheet1$

--convert the display format
SELECT
    CONVERT(date, MIN(Date)) AS start_date,
    CONVERT(date, MAX(Date)) AS end_date
FROM dbo.Sheet1$;


--total months present

Select 
	Year(Date) as Year,
	COUNT(distinct MONTH(Date)) as total_months
FROM dbo.Sheet1$
GROUP BY Year(Date);

--monthly average for confirmed, deaths, recovered


SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    ROUND(AVG(Confirmed), 2) AS average_confirmed,
	ROUND(AVG(Deaths), 2) AS average_deaths,
	ROUND(AVG(Recovered), 2) AS average_recovered

FROM
    dbo.Sheet1$
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    YEAR(Date),
    MONTH(Date);


--Q7. Find most frequent value for confirmed, deaths, recovered each month 

SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    MAX(Confirmed) as MAX_confirmed,
	MAX(Deaths) as MAX_deaths,
	MAX(Recovered) as Max_recovered
FROM
    dbo.Sheet1$
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    YEAR(Date),
    MONTH(Date);


-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT
    YEAR(Date) AS Year,
    MIN(Confirmed) as MIN_confirmed,
	MIN(Deaths) as MIN_deaths,
	MIN(Recovered) as MIN_recovered
FROM
    dbo.Sheet1$
GROUP BY
    YEAR(Date)
ORDER BY
    YEAR(Date)

--Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT
    YEAR(Date) AS Year,
    MAX(Confirmed) as MAX_confirmed,
	MAX(Deaths) as MAX_deaths,
	MAX(Recovered) as Max_recovered
FROM
    dbo.Sheet1$
GROUP BY
    YEAR(Date)
ORDER BY
    YEAR(Date)

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Confirmed) as total_confirmed,
	SUM(Deaths) as total_deaths,
	SUM(Recovered) as total_recovered
FROM
    dbo.Sheet1$
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    YEAR(Date),
    MONTH(Date);

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT
	YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Confirmed) AS total_confirmed_cases,
    AVG(Confirmed) AS average_confirmed_cases,
    STDEV(Confirmed) AS stdev_confirmed_cases
FROM
    dbo.Sheet1$
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    YEAR(Date),
    MONTH(Date);


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
	YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Deaths) AS total_death_cases,
    AVG(Deaths) AS average_death_cases,
    STDEV(Deaths) AS stdev_death_cases
FROM
    dbo.Sheet1$
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    YEAR(Date),
    MONTH(Date);

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
	YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Recovered) AS total_recovered_cases,
    AVG(Recovered) AS average_recovered_cases,
    STDEV(Recovered) AS stdev_recovered_cases
FROM
    dbo.Sheet1$
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    YEAR(Date),
    MONTH(Date);

-- Q14. Find Country having highest number of the Confirmed case
SELECT TOP 1
    [Country/Region] AS Country,
    SUM(Confirmed) AS TotalConfirmedCases
FROM
    dbo.Sheet1$
GROUP BY
    [Country/Region]
ORDER BY
    TotalConfirmedCases DESC;

-- Q15. Find Country having lowest number of the death case
SELECT TOP 5
	[Country/Region] AS Country,
    SUM(Deaths) AS TotalDeathCases
FROM
    dbo.Sheet1$
GROUP BY
    [Country/Region]
ORDER BY
    TotalDeathCases;

-- Q16. Find top 5 countries having highest recovered case
SELECT TOP 5
	[Country/Region] AS Country,
    SUM(Recovered) AS TotalRecoveredCases
FROM
    dbo.Sheet1$
GROUP BY
    [Country/Region]
ORDER BY
    TotalRecoveredCases DESC;
	
