--1
SELECT ProductName,
CategoryName,
ListPrice
FROM Products JOIN Categories
ON Categories.CategoryID = Products.CategoryID
--WHERE CategoryName = 'Guitars'
ORDER BY CategoryName, ProductName

--2
SELECT [FirstName], LastName,
Line1, City, [State], ZipCode
FROM Customers JOIN Addresses ON
Customers.CustomerID = Addresses.CustomerID
WHERE Customers.EmailAddress = 'allan.sherwood@yahoo.com'

--3
SELECT [FirstName], LastName,
Line1, City, [State], ZipCode
FROM Customers JOIN Addresses ON
Customers.CustomerID = Addresses.CustomerID
AND
Customers.ShippingAddressID = Addresses.AddressID

--4
SELECT c.LastName,
c.FirstName,
OrderDate,
p.ProductName,
ItemPrice,
DiscountAmount,
Quantity
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN OrderItems AS oi ON o.OrderID = oi.OrderID
JOIN Products AS p ON oi.ProductID = p.ProductID
ORDER BY LastName, OrderDate, ProductName

--5
SELECT p1.ProductID,
p1.ProductName,
p1.ListPrice
FROM Products AS p1
JOIN Products AS p2 ON
p1.ProductID <> p2.ProductID
AND
p1.ListPrice = p2.ListPrice

--6
SELECT CategoryName, ProductID
FROM Categories LEFT JOIN Products
ON Categories.CategoryID = Products.CategoryID
WHERE ProductID IS NULL
--7
SELECT 'SHIPPED' AS ShipStatus,
OrderId, OrderDate
FROM Orders
WHERE ShipDate IS NOT NULL
UNION
SELECT 'NOT SHIPPED', OrderID, OrderDate
FROM Orders
WHERE ShipDate IS NULL
ORDER BY OrderDate