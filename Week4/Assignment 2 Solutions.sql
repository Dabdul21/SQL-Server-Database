--Assignment #2 Solutions
use Cis111_Northwind
------------ Q1 -- If Customers Left table then a Left Join needed -- 830 or distinct 89 rows - 3 pts
SELECT distinct c.CompanyName, c.ContactName, c.ContactTitle, c.Phone
FROM Customers c
	LEFT OUTER JOIN Orders o ON o.CustomerID = c.CustomerID
--FROM Orders o  
	--RIGHT OUTER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE (o.OrderID IS not NULL)
------------ Q2 - self join -- 8 rows ------------3 pts--------------
SELECT Employees.FirstName, Employees.LastName
	,Employees_1.FirstName + ' ' + Employees_1.LastName AS Supervisor
FROM Employees 
	INNER JOIN Employees AS Employees_1 
	  ON Employees.ReportsTo = Employees_1.EmployeeID
Order By Supervisor, Employees.LastName
------------ Q3 - 9 rows -------------4 pts------took out KONBU---------
SELECT	cust.CustomerID, cust.CompanyName 
		,emp.LastName, ord.OrderDate, prod.ProductName 
		,ordDet.Quantity, sup.CompanyName AS SupplierName
FROM Customers cust 
	JOIN Orders ord ON cust.CustomerID = ord.CustomerID 
	JOIN [Order Details] ordDet ON ord.OrderID = ordDet.OrderID 
	JOIN Products prod ON ordDet.ProductID = prod.ProductID 
	/*LEFT*/ JOIN Employees emp ON ord.EmployeeID = emp.EmployeeID 
	/*LEFT*/ JOIN Suppliers sup ON prod.SupplierID = sup.SupplierID
WHERE prod.ProductName in ('Chai','Chang','Tofu') 
  AND MONTH(ord.OrderDate) = 12
------------ Q4 - 27 rows --------------4 pts------added +5 to 50---------------
SELECT distinct prod.ProductName, sup.CompanyName
FROM	Products prod 
		JOIN Suppliers sup ON prod.SupplierID = sup.SupplierID 
		JOIN [Order Details] ordDet ON prod.ProductID = ordDet.ProductID 
		JOIN Categories cat ON prod.CategoryID = cat.CategoryID
WHERE	ordDet.Quantity >= 50 
		AND cat.CategoryName IN ('Beverages','Dairy Products','Meat/Poultry')
Order By prod.ProductName
------------ Q5 - 727 rows -----1st query +40----------4 pts------------------------
SELECT  'Discounted' AS DiscountType, prod.ProductID
		,prod.ProductName, prod.UnitPrice, ordDet.Quantity 
		,(prod.UnitPrice * ordDet.Quantity) * (1 - ordDet.Discount) AS ProductSale
FROM    Products prod 
		JOIN [Order Details] ordDet ON prod.ProductID = ordDet.ProductID
WHERE ordDet.Discount > 0 AND ordDet.Quantity >= 30
UNION
SELECT  'No Discount', prod.ProductID 
		,prod.ProductName, prod.UnitPrice, ordDet.Quantity
		,prod.UnitPrice * ordDet.Quantity AS ProductSale
FROM    Products prod 
		JOIN [Order Details] ordDet ON prod.ProductID = ordDet.ProductID
WHERE  ordDet.Discount = 0 AND ordDet.Quantity >= 20 
Order By prod.ProductName, DiscountType, Quantity desc
------------ Q6 - 5 rows ----------------4 pts-------added x bef Filo Mix------------------
SELECT DISTINCT Employees.FirstName, Employees.LastName --, productname, Employees.Country
FROM	Employees 
		JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID 
		JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID 
		JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE Products.ProductName In('Sir Rodney''s Scones','Filo Mix')
		And Employees.Country = 'USA'
Order By LastName, FirstName
------------ Q7 - 3 rows ----------4 pts---------------
SELECT City FROM Employees
INTERSECT 
SELECT City FROM Customers
------------ Q8 - 20 rows ----------------4 pts----------put a u after the "G"------chg Unit Price to 10----------------
SELECT	emp.FirstName, emp.LastName, ter.TerritoryDescription 
		,ordDet.UnitPrice, ordDet.Quantity 
		,prod.ProductName, reg.RegionDescription
FROM [Order Details] ordDet 
	 JOIN Products prod ON prod.ProductID = ordDet.ProductID 
	 JOIN Orders ord ON ord.OrderID = ordDet.OrderID
	 JOIN Employees emp  ON emp.EmployeeID = ord.EmployeeID
	 JOIN EmployeeTerritories empTer ON emp.EmployeeID = empTer.EmployeeID 
	 JOIN Territories ter ON empTer.TerritoryID = ter.TerritoryID 
	 JOIN Region reg ON reg.RegionID = ter.RegionID 
WHERE ordDet.Quantity BETWEEN 10 AND 25
	AND ter.TerritoryDescription ='Atlanta' 
	AND reg.RegionDescription ='Southern' 
	AND ordDet.UnitPrice >= 10 
	AND prod.ProductName like 'g%'