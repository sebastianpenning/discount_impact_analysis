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

![download option csv azure](https://github.com/sebastianpenning/discount_impact_analysis/blob/main/download_option_azure.png)

What followed was a search for the extra tables which contained additional information referrenced in the standard procedures that was also useful for this analyse, the utilized tables were queried with the code that can be found below. These tables, were then individualy downloaded which the same process as described before.

```sql 
SELECT * FROM Purchasing.Suppliers
SELECT * FROM Warehouse.PackageTypes
SELECT * FROM Application.Cities
SELECT * FROM Application.StateProvinces
```
Finally one left join was done in order to have the names of "StockGroupName" together with the "StockItemStockGroupID", "StockItemID", and "StockGroupID". 

```sql
SELECT Warehouse.StockItemStockGroups.*, 
            Warehouse.StockGroups.StockGroupName
FROM Warehouse.StockItemStockGroups
LEFT JOIN Warehouse.StockGroups
ON Warehouse.StockItemStockGroups.StockGroupID = Warehouse.StockGroups.StockGroupID
```

### Python

Afterwards, the data was cleaned and reformatted using Pandas with python. The steps that were taken are described below. 

First, the libraries neccessary were loaded in. 

```python
import pandas as pd
import random
```

Next, the data itself 

```python
df = pd.read_csv("Path/to/csv")
```

It was decided to remove some of the data that was necessary for the analysis or which seemed not useful. This was done by dropping some of the columns of data 

```python
df.drop("Tax Rate", axis=1, inplace=True)
df.drop("Profit", axis =1, inplace=True)
df.drop("Tax Amount", axis=1, inplace=True)
df.drop("Total Including Tax", axis=1, inplace=True)
df.drop("Total Dry Items", axis=1, inplace=True)
df.drop("Total Chiller Items", axis=1, inplace=True)
```

Also one column was renamed for clarification purposes

```python
df.rename(columns = {"Total Excluding Tax" : "Full Price Value"}, inplace=True)
```

Then a new column was created and data was created with some calculations to simulate the effect of discounts

```python
discount_value = []

for sale in df["Discount"]:
    discount_value.append(random.randint(1,15))
    
df["Discount"] = discount_value
```

And this was duely translated in other columns as well

```python
strike_price = df["Full Price Value"] * (1 - df["Discount"] / 100)

df['transaction_price'] = strike_price
value_lost = df["Full Price Value"] - df['transaction_price']

df['value_lost'] = value_lost
df['cogs'] = df["Full Price Value"] * 0.4
df['actual_margin_multipier'] = df['transaction_price'] /  df['cogs']
```

Finally, the dataframe was saved back into a csv file

```python 
df.to_csv("Path/to/csv")
```

### Tableau

This then translated into a visualization of on tableau, where first a general overview is given 


Followed by a more indepth analysis of the impact of discounts on certain processes.


The overal Viz can be found with this link: 


## Database

The database used is the Wide World Importers sample datebases. Below links are provided for the database and its documentation.

Database:         https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-ver16. 
Documentation:    https://www.sqldatadictionary.com/WideWorldImporters.pdf

## Licensing

The license used for this project is the MIT license which can be found in the files of this repository
