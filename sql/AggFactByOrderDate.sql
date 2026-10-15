CREATE        VIEW [dbo].[vw_AggFactByOrderDate]
AS
SELECT
    f.OrderDateKey / 100 AS OrderYearMonthKey,
    f.ProductID,
    f.TerritoryID,
    f.ShipMethodID,
    f.StatusID,
    sum (f.OrderQty)As TotalQty,
    SUM(f.TotalDue) AS TotalDue,
    SUM(f.Freight) AS TotalFreight,
    SUM(f.TaxAmt) AS TotalTax,
    COUNT(*) AS OrderDetailsCount
FROM vw_FactOrderDetails_Final f
GROUP BY
    f.OrderDateKey / 100, /* will become OrderYearMonthKey */
    f.ProductID,
    f.TerritoryID,
    f.ShipMethodID,
    f.StatusID;
GO


