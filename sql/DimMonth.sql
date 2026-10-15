
CREATE VIEW [dbo].[vw_DimMonth]
AS
SELECT
    (Year * 100 + Month) AS YearMonthKey,
    Year,
    Month
FROM dbo.vw_DimDate
GROUP BY
    Year,
    Month;
GO


