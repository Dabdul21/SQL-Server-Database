--
-- Chapter 3 Practice Lab Solutions
-- BretAbdullahChap3Practice.sql
-- 09/03/2019
--

Use Cis111_GuitarShop;
--Use Cis11170_GuitarShop;


-- Query #1 - 10 rows
SELECT ProductCode, ProductName, ListPrice, DiscountPercent
FROM  dbo.Products
ORDER BY ListPrice DESC;


-- Query #2 - 227 rows
SELECT LastName + ', ' + FirstName AS FullName
FROM dbo.Customers
WHERE (LastName LIKE '[M-Z]%')
-- or --
--WHERE LastName >= 'm' 
ORDER BY LastName; 


-- Query #3 - 5 rows
SELECT ProductName, ListPrice, DateAdded
FROM dbo.Products
WHERE (ListPrice > 500 AND ListPrice < 2000)  -- why can't we use the BETWEEN clause??
ORDER BY DateAdded DESC;


-- Query #4 - 10 rows
SELECT	ProductName, ListPrice, DiscountPercent 
		,ListPrice * DiscountPercent / 100 AS DiscountAmount
		,ListPrice - ListPrice * DiscountPercent / 100 AS DiscountPrice
FROM  dbo.Products
ORDER BY DiscountPrice DESC;


-- Query #5 - 24 rows
SELECT	TOP (100) PERCENT ItemID, ItemPrice, DiscountAmount, Quantity 
		,ItemPrice * Quantity AS PriceTotal 
		,DiscountAmount * Quantity AS DiscountTotal 
		,(ItemPrice - DiscountAmount) * Quantity AS ItemTotal
FROM dbo.OrderItems
WHERE ((ItemPrice - DiscountAmount) * Quantity > 500)
ORDER BY ItemTotal DESC;


-- Query #6 - 5 rows
SELECT OrderID, OrderDate, ShipDate
FROM dbo.Orders
WHERE (ShipDate IS NULL); 
