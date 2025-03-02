-- Query #1
SELECT *
FROM [Order Details]
WHERE OrderID IN (10261, 10268, 10276, 10381)
ORDER BY Quantity DESC;

-- Query #2
SELECT SupplierID, CompanyName, ContactName, ContactTitle 
FROM Suppliers 
WHERE Country IN ('UK', 'USA', 'Japan') 
    AND Fax IS NULL;

-- Query #3
SELECT FirstName, 
       LastName, 
       FirstName + ', ' + LastName AS [Full Name],
       BirthDate, 
       Title
FROM Employees
WHERE Title LIKE '%Sales%' 
  AND (YEAR(BirthDate) BETWEEN 1950 AND 1965)
ORDER BY BirthDate ASC; 

-- Query #4
SELECT CustomerID, OrderDate, Freight, ShipName, ShipAddress
FROM Orders
WHERE CustomerID LIKE 'R%' AND Freight >= 10
ORDER BY ShipCity ASC, ShipPostalCode DESC;

-- Query #5
SELECT CustomerID, OrderDate, ShippedDate, 
       DATEDIFF(DAY, OrderDate, ShippedDate) AS [Days to Process Order]
FROM Orders
WHERE MONTH(OrderDate) IN (4) 
  AND DAY(OrderDate) BETWEEN 1 AND 15
  AND YEAR(OrderDate) = 2017
  AND DATEDIFF(DAY, OrderDate, ShippedDate) BETWEEN 1 AND 10;

-- Query #6
SELECT ContactName, ContactTitle, Country
FROM Customers
WHERE Country IN ('Brazil', 'France', 'Spain')
  AND (ContactTitle LIKE '%Manager%' OR ContactTitle LIKE '%Owner%')
ORDER BY Country;

-- Query #7
SELECT ProductID, ProductName, UnitPrice, 
       UnitPrice * 1.05 AS [UnitPrice_5%_Increase], 
       UnitPrice * 1.15 AS [UnitPrice_15%_Increase]
FROM Products
WHERE UnitPrice BETWEEN 10 AND 30
  AND UnitsInStock BETWEEN 40 AND 100
  AND CategoryID NOT IN (1,8);

-- Query #8
SELECT TOP 15 WITH TIES ProductID, ProductName, SupplierID, UnitPrice, UnitsInStock
FROM Products
ORDER BY UnitPrice DESC;

-- Query #9
SELECT *, 
       FORMAT((UnitPrice * Quantity) * (1 - Discount), 'C', 'en-US') AS [Product Sale]
FROM [Order Details]
WHERE Quantity BETWEEN 20 AND 45
  AND (UnitPrice * Quantity) * (1 - Discount) BETWEEN 500 AND 2000
ORDER BY [Product Sale] DESC; 

-- Query #10
SELECT DISTINCT ContactTitle
FROM Customers
ORDER BY ContactTitle ASC;
