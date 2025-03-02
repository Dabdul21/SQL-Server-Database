-- Assignment 1 Solutions
Use Cis111_Northwind
------------------Q1 -- 10 rows --------took out 10266----------
SELECT * 
--SELECT  OrderID, ProductID, UnitPrice, Quantity, Discount
	FROM [Order Details]
	WHERE OrderID IN (10248, 10250, 10258, 10371)
	ORDER BY UnitPrice DESC;
-------------- Q2 --7 rows ------put a bef UK---------
SELECT  SupplierID, CompanyName, ContactName, ContactTitle, Country, Fax
	FROM    Suppliers
	WHERE   Country in ('Spain', 'Japan', 'USA', 'UK') AND (Fax IS NULL);
-------------- Q3 -- 7 rows -------------
SELECT  LastName + ', ' + FirstName AS 'Full Name' 
		,BirthDate, Title
	FROM Employees
	WHERE Title like ('%Sales%') 
	--WHERE Title = 'Sales Representative' 
		--AND BirthDate between '1950-1-1' and '1965-12-31';
		AND BirthDate >= '1945-1-1' and BirthDate < '1966-1-1';
----------------Q4--52 rows----put a 0 after 10--------------------
SELECT CustomerID, OrderDate, Freight, ShipName, ShipAddress
	FROM Orders
	WHERE CustomerID LIKE 'R%' 
		AND Freight >= 10
	ORDER BY ShipCity, ShipPostalCode DESC;
----------------------Q5 -- 14 rows ------------------------
SELECT CustomerID, OrderDate, ShippedDate 
		,DATEDIFF(day, OrderDate, ShippedDate) AS 'Days to Process Order'
	FROM Orders
	WHERE OrderDate BETWEEN '2017-4-01' AND '2017-4-15' 
		AND DATEDIFF(day, OrderDate, ShippedDate) BETWEEN 1 AND 10;
--------------Q6 -- 9 rows ------------------
  --should first run this query
Select distinct ContactTitle From Customers order by ContactTitle
SELECT ContactName, ContactTitle, Country 
	FROM Customers
	--WHERE (Country IN ('Brazil', 'France')) AND (ContactTitle = N'Marketing Manager') 
		--OR (Country IN (N'Brazil', N'France')) AND (ContactTitle = N'Accounting Manager') 
		--OR (Country IN (N'Brazil', N'France')) AND (ContactTitle = N'owner')
	WHERE Country IN ('Brazil', 'Canada', 'Spain') 
		-- AND ContactTitle IN ('Sales Manager','Marketing Manager', 'Accounting Manager', 'owner')
		AND (ContactTitle Like '%Manager%' or ContactTitle like '%owner%')
	ORDER BY Country;
---------------------Q7 -- 4 rows ----put an 8 for 88 in in clause and 0 in 30 to make 300--------chg from 10%  to 15%----------------
SELECT	ProductID, ProductName, UnitPrice, CategoryID 
		,UnitPrice * 1.15 AS ' UnitPrice with a 15% increase' 
		,UnitPrice * 1.05 AS 'UnitPrice with a 5% increase'
	FROM Products
	WHERE UnitPrice BETWEEN 10 AND 30
		AND UnitsInStock BETWEEN 40 AND 100 
		--AND NOT CategoryID = 1 AND NOT CategoryID = 8;
		AND CategoryID NOT IN (1, 8);
---------------------Q8 --16 rows --------------------------
SELECT TOP (15) WITH TIES ProductID, ProductName, SupplierID, UnitPrice
	FROM Products
	ORDER BY UnitPrice Desc;
-----------------------Q9 --425 rows -------put 0 next to 45-----------------------------
SELECT	OrderID, ProductID, UnitPrice, Quantity, Discount 
		,(UnitPrice * Quantity) * (1 - Discount) AS 'ProductSale'
	FROM [Order Details]
	WHERE Quantity BETWEEN 20 AND 45
	AND (UnitPrice * Quantity) * (1 - Discount) Between 500 and 2000
	Order By ProductSale desc;
-------------------------Q10 --12 rows -----------------------
SELECT DISTINCT ContactTitle
	FROM Customers
	Order By ContactTitle;