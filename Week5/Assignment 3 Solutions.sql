-- Solutions for Assignment #3 - Chapters 5 and 6
Use Cis111_Northwind
------------------------------------------added extra a after canada----took out Brazil-----------
--Q1 3 rows - two ways to skin this cat
SELECT		C.Country, Count(*) AS OrderCount, MIN(o.OrderDate) AS EarliestOrder, MAX(o.OrderDate) AS LatestOrder
FROM		Orders o
			INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY	c.Country
HAVING		(c.Country IN (N'USA', N'Mexico',N'Canada'))
----OR
SELECT		C.Country, Count(*) AS OrderCount, MIN(o.OrderDate) AS EarliestOrder, MAX(o.OrderDate) AS LatestOrder
FROM		Orders o
			INNER JOIN Customers c ON o.CustomerID = c.CustomerID
Where c.Country IN('USA','Mexico','Canada')
GROUP BY	c.Country
---------------------------------------------------------
--Query #2 - 1 row - aggregate funtions need to work w a group
--what is our group by, everything
SELECT AVG(od.Quantity) AS AverageQuantity, AVG(od.UnitPrice) AS AverageUnitPrice 
	  ,AVG((p.UnitPrice * od.Quantity) * (1 - od.Discount)) AS AverageProductSale
	  ,sum((p.UnitPrice * od.Quantity) * (1 - od.Discount)) AS TotalProductSale
FROM [Order Details] od  
	 INNER JOIN Products p ON od.ProductID = p.ProductID
---------------------------------------------------------
--Query #3     12 rows
SELECT	ProductName, AVG(od.Quantity) AS AverageQuantity
		,MAX(od.Quantity) AS TotalQuantity 
		,AVG((od.UnitPrice * od.Quantity) * (1 - od.Discount)) AS AverageProductSale
		,SUM((od.UnitPrice * od.Quantity) * (1 - od.Discount)) AS TotalProductSale
FROM Products p  
	 INNER JOIN [Order Details] od ON p.ProductID = od.ProductID 
	 INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = N'Beverages' -- why join Categories
GROUP BY p.ProductName
--------------------------sub -9 from 75------------------------------
--Query #4    21 rows
-- look at db diagram to see relationships
SELECT	ter.TerritoryDescription, Count(*) AS OrderCount
FROM Territories ter 
	 INNER JOIN EmployeeTerritories empTer ON ter.TerritoryID = empTer.TerritoryID 
	 INNER JOIN Employees emp ON empTer.EmployeeID = emp.EmployeeID 
	 INNER JOIN Orders ord ON emp.EmployeeID = ord.EmployeeID
GROUP BY ter.TerritoryDescription
HAVING (Count(ord.OrderID) >= 75)
---------------------------------------------------------
--Query #5   89 rows -- use sub-select
SELECT	CustomerID, CompanyName, Country
FROM	Customers
WHERE	(CustomerID IN 
			(SELECT	CustomerID
			 FROM Orders))
---------------------------------------------------------
--Query #6    30 rows
SELECT	o.OrderID, o.OrderDate, od.ProductID, od.Quantity, od.UnitPrice, od.Discount
FROM	Orders o 
		INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE	(od.Quantity > ALL (
							SELECT Quantity
							FROM [Order Details] 
							Join Products on [Order Details].ProductID = Products.ProductID
							WHERE ProductName in ('Tofu','Chai') 
							--Order By Quantity Desc
							))
-------------------------------added *10 to freight-----------changed from RATTC to CHOPS---------------
--Query #7  446 rows
SELECT	OrderID, CustomerID, OrderDate, ShippedDate, Freight
FROM	Orders
WHERE	(Freight <= ALL (SELECT	AVG(Freight) FROM Orders Where CustomerID = 'CHOPS'))  -- 45.905 avg
--WHERE	(Freight > ALL (SELECT	Freight FROM Orders Where CustomerID = 'ERNSH')) --max freight 789.95
--WHERE	Freight > (SELECT AVG(Freight) FROM Orders )
---------------------------------------------------------
--Query #8 - 8 rows
WITH TopEightCustomers AS -- Common Table Expression CTE
	(SELECT	TOP 8 CustomerID, Count(OrderID) AS OrderCount
	 FROM Orders
	 GROUP BY CustomerID
	 ORDER BY OrderCount DESC)

--Select * From TopEightCustomers 

SELECT Orders.CustomerID, MIN(OrderDate) AS FirstOrder 
	   ,MAX(OrderDate) AS LastOrder, Count(*) AS OrderCnt
FROM Orders 
	JOIN TopEightCustomers ON Orders.CustomerID=TopEightCustomers.CustomerID
GROUP BY Orders.CustomerID
ORDER BY OrderCnt DESC 