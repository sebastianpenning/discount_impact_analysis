# discount_analysis &middot; [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/your/your-project/blob/master/LICENSE)

A project using SQL, Python, and Tableau in order to create a dashboard which showcases the impact of discounts on operations

## Getting started

First thing to get started is to download the Wide World Importers sample datebases from this link: https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-ver16 

This database works on SQL Server or Azure SQL Database

The minimal setup you need in order to further develop this is to have either SQL Server or Azure SQL Database, a database tool such as SQL Server Management Studio or Azure Database Studio depending on your system, Python together with a IDE, and Tableau. 


## Project  

### SQL

After initially looking through the database. There are several tables that are of interest in this project. These have been identified by using two standard procedures that were already available in the database. These two standard procedures were accesed in the code below. The data from these standard procedures were already interesting, so these queries were also used as the core of the data used for the analysis

```sql
EXEC Integration.GetPurchaseUpdates @LastCutoff = "2012", @NewCutoff = "2018";
EXEC Integration.GetSaleupdates @LastCutoff = "2012", @NewCutoff = "2018";
```

The columns of data that were queried for purchase updates standard procedure:

|Columns|
|-------|
|Date Key|
|WWI Purchase Order ID|
|Ordered Outers|
|Ordered Quantity|
|Received Outers|
|Package|
|Is Order Finalized|
|WWI Supplier ID|
|WWI Stock Item ID|
|Last Modified When|

The columns of data that were queried for sale updates standard procedure:

|Columns|
|-------|
|Invoice Date Key|
|Delivery Date Key|
|WWI Invoice ID|
|Description|
|Package|
|Quantity|
|Unit Price|
|Tax Rate|
|Total Excluding Tax|
|Tax Amount|
|Profit|
|Total Including Tax|
|Total Dry Items|
|Total Chiller Items|
|WWI City ID|
|WWI Customer ID|
|WWI Bill To Customer ID|
|WWI Stock Item ID|
|WWI Saleperson ID|
|Last Modified When|

Both of these standard procedures queries were then downloaded with the option that can be found in Azure Data Studio (the database tool that was used in this project)

(image)

Following a search for which tables the standard procedures used, the utilized tables were queried with the code that can be found below. 

```sql 
SELECT * FROM Purchasing.Suppliers
SELECT * FROM Warehouse.PackageTypes
SELECT * FROM Application.Cities
SELECT * FROM Application.StateProvinces
```

These tables, were then individualy 


### Python


### Tableau


## Database

The database used is the Wide World Importers sample datebases. Below links are provided for the database and its documentation.

Database:         https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-ver16. 
Documentation:    https://www.sqldatadictionary.com/WideWorldImporters.pdf

## Licensing

The license used for this project is the MIT license which can be found in the files of this repository
