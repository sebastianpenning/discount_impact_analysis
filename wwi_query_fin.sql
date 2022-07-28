USE WideWorldImporters

EXEC Integration.GetPurchaseUpdates @LastCutoff = "2012", @NewCutoff = "2018";
EXEC Integration.GetSaleupdates @LastCutoff = "2012", @NewCutoff = "2018";

SELECT * FROM Purchasing.Suppliers
SELECT * FROM Warehouse.PackageTypes
SELECT * FROM Application.Cities
SELECT * FROM Application.StateProvinces

SELECT Warehouse.StockItemStockGroups.*, 
            Warehouse.StockGroups.StockGroupName
FROM Warehouse.StockItemStockGroups
LEFT JOIN Warehouse.StockGroups
ON Warehouse.StockItemStockGroups.StockGroupID = Warehouse.StockGroups.StockGroupID
         
