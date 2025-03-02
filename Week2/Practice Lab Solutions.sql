-- Chapter 4 Practice Lab Query Solutions

--query #1 - 10 rows
SELECT * FROM Categories;
SELECT * FROM PRODUCTS;

SELECT Categories.CategoryName 
		,Products.ProductName, Products.ListPrice
	FROM Categories, Products 
	where Categories.CategoryID = Products.CategoryID
	--INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
	ORDER BY Categories.CategoryName, Products.ProductName;


--query #2 - rows
SELECT * FROM Customers; -- 485 rows
SELECT * FROM Addresses; -- 512 rows

SELECT Customers.FirstName, Customers.LastName
		,Addresses.Line1, Addresses.City
		,Addresses.State, Addresses.ZipCode
	FROM Customers 
	INNER JOIN Addresses ON Customers.CustomerID = Addresses.CustomerID
select * from customers	
WHERE (Customers.EmailAddress = 'allan.sherwood@yahoo.com');


--query #3 - 483 rows 
SELECT Customers.FirstName, Customers.LastName
		,Addresses.Line1, Addresses.City
		,Addresses.State, Addresses.ZipCode
	FROM Customers 
	INNER JOIN Addresses 
		ON dbo.Customers.CustomerID = Addresses.CustomerID
		where Customers.ShippingAddressID = Addresses.AddressID; 

--query #4 - 47 rows
--Use Alias Names for ALL Tables - best practice for readability
SELECT C.LastName, C.FirstName
		,O.OrderDate
		,P.ProductName
		,OI.ItemPrice, OI.DiscountAmount, OI.Quantity
	FROM Customers AS C 
	JOIN Orders AS O ON C.CustomerID = O.CustomerID 
	JOIN OrderItems AS OI ON O.OrderID = OI.OrderID 
	JOIN Products AS P ON OI.ProductID = P.ProductID
	ORDER BY C.LastName, O.OrderDate, P.ProductName;


--query #5 - things that have same list price - 2
-- ProductID <> ProductID
SELECT p1.ProductName, p1.ListPrice
	FROM Products p1 
	INNER JOIN Products AS p2 ON p1.ProductID <> p2.ProductID 
	AND p1.ListPrice = p2.ListPrice
ORDER BY p1.ProductName;


--query #6 - 1 row 
-- If Products is the Left table then a Right Join should be defined
SELECT Categories.CategoryName, Products.ProductID
	FROM Categories 
	LEFT OUTER JOIN Products 
		ON Categories.CategoryID = Products.CategoryID
	WHERE (Products.ProductID IS NULL);

Select distinct CategoryID from products
select CategoryID, CategoryName from Categories order by CategoryID


--query #7
SELECT COUNT(*) as CountAll, Count(ShipDate) as CountShipDate FROM Orders; -- 41 rows, 36 rows

SELECT 'Shipped' AS Status, OrderID, OrderDate, ShippedDate
	FROM Orders
	WHERE NOT (ShipDate IS NULL)
Union
SELECT 'Not Shipped' AS Status, OrderID, OrderDate, 
	FROM  Orders
	WHERE  ShipDate IS NULL
	ORDER BY OrderDate;
-- 41 rows

