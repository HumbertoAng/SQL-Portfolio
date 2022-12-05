Homework 1

.open --new "c:/ucf_classes/eco-4444/sql/databases/Global_Superstore.db"

CREATE TABLE People
(
Person  Text,
Region  Text,
PRIMARY KEY (Region)
)
;

.tables

.separator ,
.import --csv --skip 1 "c:/ucf_classes/eco-4444/sql/data/people_global.csv" People

.mode column
.headers on




CREATE TABLE Returned
(
Returned    Text ,
`Order ID`  Text ,
Market      Text ,
PRIMARY KEY (`Order ID`)
)
;

.tables

.import --skip 1 c:/ucf_classes/eco-4444/sql/data/returns_global.csv Returned


CREATE TABLE Orders
(
`Row ID`            Integer ,
`Order ID`          Text ,
`Order Date`        Text ,
`Ship Date`         Text ,
`Ship Mode`         Text ,
`Customer ID`       Text ,
`Customer Name`     Text ,
Segment             Text ,
City                Text ,
`State`             Text ,
Country             Text ,
`Postal Code`       Text ,
Market              Text ,
Region              Text ,
`Product ID`        Text ,
Category            Text ,
`Sub-Category`      Text ,
`Product Name`      Text ,
Sales               Real ,
Quantity            Integer ,
Discount            Real ,
Profit              Real ,
`Shipping Cost`     Real ,
`Order Priority`    Text ,
PRIMARY KEY (`Row ID`)
FOREIGN KEY (Region) REFERENCES People (Region) ,
FOREIGN Key (`Order ID`) REFERENCES Returned (`Order ID`)
)
;

.tables


.import --skip 1 c:/ucf_classes/eco-4444/sql/data/orders_global.csv Orders

Letter C 

SELECT Country ,
COUNT(Sales) AS `Number of Sales` 
FROM Orders
GROUP BY Country
ORDER BY COUNT(Sales) DESC
;


Letter D

SELECT Country ,
COUNT(Sales) AS `Number of Sales` 
FROM Orders
WHERE Country LIKE '%z%'
GROUP BY Country
ORDER BY COUNT(Sales) DESC
;



Letter E

SELECT Country ,
ROUND(SUM(Sales),2) AS `Total Profit` ,
ROUND (Profit / COUNT (Sales) , 2) AS `Profit Per Sale` 
FROM Orders
WHERE Country LIKE '%z%'
GROUP BY Country
ORDER BY ROUND(SUM(Profit) / COUNT (Sales) , 2) DESC
;


Letter F

SELECT Country ,
ROUND(SUM(Sales),2) AS `Total Profit` ,
ROUND(SUM(Profit) / COUNT (Sales) , 2) AS `Profit Per Sale` 
FROM Orders
WHERE Country LIKE '%z%'
GROUP BY Country
HAVING `Profit Per Sale` < 0
ORDER BY ROUND(SUM(Profit) / COUNT (Sales) , 2) DESC
;



Letter G

SELECT Country ,
ROUND(SUM(Quantity) , 2) AS `Quantity of Sales` ,
ROUND(SUM(Sales)    , 2) AS `Total Sales Revenue` ,
ROUND(SUM(Sales) / COUNT (Quantity) , 2) AS `Sale Revenue Per Unit` ,
ROUND(SUM(Profit) , 2) AS `Total Profit` ,
ROUND((Profit) / (Quantity) , 2) AS `Profit Per Unit` 
FROM Orders
WHERE Country LIKE '%Australia%'
OR Country LIKE '%Mexico%'
GROUP BY Country
;



Letter H

SELECT Country ,
SUBSTR(`Order Date`, -4, 4) AS Year ,
ROUND(SUM(Quantity) , 2) AS `Quantity of Sales` ,
ROUND(SUM(Sales)    , 2) AS `Total Sales Revenue` ,
ROUND(SUM(Sales) / COUNT (Quantity) , 2) AS `Sale Revenue Per Unit` ,
ROUND(SUM(Profit) , 2) AS `Total Profit` ,
ROUND(SUM(Profit) / COUNT (Quantity) , 2) AS `Profit Per Unit` 
FROM Orders
WHERE Country LIKE '%Australia%'
OR Country LIKE '%Mexico%'
GROUP BY Country, Year
;



Letter I

SELECT Country ,
SUBSTR(`Order Date`, -4, 4) AS Year ,
CAST(RTRIM(SUBSTR(`Order Date`, 1, 2), '/') AS Integer) AS Month,
ROUND(SUM(Quantity) , 2) AS `Quantity of Sales` ,
ROUND(SUM(Sales)    , 2) AS `Total Sales Revenue` ,
ROUND(SUM(Sales) / COUNT (Quantity) , 2) AS `Sale Revenue Per Unit` ,
ROUND(SUM(Profit) , 2) AS `Total Profit` ,
ROUND(SUM(Profit) / COUNT (Quantity) , 2) AS `Profit Per Unit` 
FROM Orders
WHERE Country LIKE '%Australia%'
OR Country LIKE '%Mexico%'
GROUP BY Country, Year, Month
;



Letter J

SELECT Region ,
ROUND(SUM(Quantity) , 2) AS `Quantity of Sales` ,
ROUND(SUM(Sales)    , 2) AS `Total Sales Revenue` ,
ROUND(SUM(Sales) / COUNT (Quantity) , 2) AS `Sale Revenue Per Unit` ,
ROUND(SUM(Profit) , 2) AS `Total Profit` ,
ROUND(SUM(Profit) / COUNT (Quantity) , 2) AS `Profit Per Unit` 
FROM Orders
GROUP BY Region
;


Letter K

SELECT Region ,
SUBSTR(`Order Date`, -4, 4) AS Year ,
ROUND(SUM(Quantity) , 2) AS `Quantity of Sales` ,
ROUND(SUM(Sales)    , 2) AS `Total Sales Revenue` ,
ROUND(SUM(Sales) / COUNT (Quantity) , 2) AS `Sale Revenue Per Unit` ,
ROUND(SUM(Profit) , 2) AS `Total Profit` ,
ROUND(SUM(Profit) / COUNT (Quantity) , 2) AS `Profit Per Unit` 
FROM Orders
GROUP BY Region, Year
;



Letter L

SELECT Person , People.Region ,
SUBSTR(`Order Date`, -4, 4) AS Year ,
ROUND(SUM(Quantity) , 2) AS `Quantity of Sales` ,
ROUND(SUM(Sales)    , 2) AS `Total Sales Revenue` ,
ROUND(SUM(Sales) / COUNT (Quantity) , 2) AS `Sale Revenue Per Unit` ,
ROUND(SUM(Profit) , 2) AS `Total Profit` ,
ROUND(SUM(Profit) / COUNT (Quantity) , 2) AS `Profit Per Unit` 
FROM Orders
JOIN People
ON People.Region = Orders.Region
GROUP BY People.Region, Year
;






Letter M

SELECT People.Person, Orders.Region ,
COUNT(People.Person) AS `Number of Returns` ,
round(SUM(Sales), 2) AS `Total Lost Revenue` ,
round(SUM(Sales)/COUNT(People.Person), 2) AS `Lost Revenue Per Item` 

FROM Orders
JOIN Returned ON Orders.`Order ID` = Returned.`Order ID`
JOIN People ON People.Region = Orders.Region
GROUP BY People.Region
;

.output c:/ucf_classes/eco-4444/sql/intermediate/lost_profits_by_region.csv

.output stdout

.mode csv
.headers on
