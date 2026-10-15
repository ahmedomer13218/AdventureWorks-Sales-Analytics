UCREATE   VIEW [dbo].[vw_DimDate]
AS
WITH AllDates AS (
    SELECT CAST(OrderDate AS DATE) AS [Date]
    FROM Sales.SalesOrderHeader

    UNION

    SELECT CAST(DueDate AS DATE)
    FROM Sales.SalesOrderHeader

    UNION

    SELECT CAST(ShipDate AS DATE)
    FROM Sales.SalesOrderHeader
),
Bounds AS (
    SELECT 
        MIN([Date]) AS MinDate,
        MAX([Date]) AS MaxDate
    FROM AllDates
),
Numbers AS (
    SELECT TOP (10000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)
SELECT
    DATEADD(DAY, n, MinDate) AS [Date],
    YEAR(DATEADD(DAY, n, MinDate)) AS [Year],
    MONTH(DATEADD(DAY, n, MinDate)) AS [Month],
    DAY(DATEADD(DAY, n, MinDate)) AS [Day],
    CAST(CONVERT(VARCHAR(8), DATEADD(DAY, n, MinDate), 112) AS INT) AS DateKey,
        (YEAR(DATEADD(DAY, n, MinDate)) * 100 
     + MONTH(DATEADD(DAY, n, MinDate))) AS YearMonthKey
FROM Bounds
JOIN Numbers
    ON DATEADD(DAY, n, MinDate) <= MaxDate;
GO


