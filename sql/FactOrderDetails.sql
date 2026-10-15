
CREATE VIEW [dbo].[vw_FactOrderDetails_Final]
AS
SELECT 
      od.SalesOrderID AS OrdersID,
      od.SalesOrderDetailID AS OrdersDetailID,

      CAST(od.OrderQty AS INT) AS OrderQty,
      od.ProductID,
      od.UnitPrice,
      od.LineTotal,

      -- Date Keys as INT (YYYYMMDD)
      CAST(CONVERT(VARCHAR(8), o.OrderDate, 112) AS INT) AS OrderDateKey,
      CAST(CONVERT(VARCHAR(8), o.DueDate, 112)   AS INT) AS DueDateKey,
      CAST(CONVERT(VARCHAR(8), o.ShipDate, 112)  AS INT) AS ShipDateKey,

      -- Status as Whole Number
      CAST(o.[Status] AS INT) AS StatusID,

      o.OnlineOrderFlag,
      o.CustomerID,
      o.SalesPersonID,
      o.TerritoryID,
      o.ShipMethodID,

      -- Allocations
      (CAST(od.[LineTotal] AS DECIMAL(18,5)) / NULLIF(o.SubTotal,0)) * o.TaxAmt     AS TaxAmt,
      (CAST(od.[LineTotal] AS DECIMAL(18,5)) / NULLIF(o.SubTotal,0)) * o.Freight    AS Freight,
      (CAST(od.[LineTotal] AS DECIMAL(18,5)) / NULLIF(o.SubTotal,0)) * o.TotalDue   AS TotalDue

FROM Sales.SalesOrderDetail od
LEFT JOIN Sales.SalesOrderHeader o 
    ON o.SalesOrderID = od.SalesOrderID;
GO


