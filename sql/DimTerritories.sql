
CREATE VIEW [dbo].[vw_DimTerritories] AS
SELECT TerritoryID
      ,[Name] Territory
      ,CountryRegionCode
      ,[Group]
FROM Sales.SalesTerritory
GO


