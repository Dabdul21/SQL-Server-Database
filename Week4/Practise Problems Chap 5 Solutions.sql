-- Chapter 5 Practice Problems
USE Cis111_GuitarShop;

--Q1 - 1 row - grouped the whole table
SELECT	COUNT(OrderID) as OrderCount
		,SUM(TaxAmount) AS TaxTotal
	FROM Orders;


--Q2 - 3 rows
SELECT	CategoryName, COUNT(*) AS ProductCount
		,MAX(ListPrice) AS MostExpensiveProduct
	FROM Products p  
		JOIN Categories c ON c.CategoryID = p.CategoryID
	GROUP BY CategoryName
	ORDER BY ProductCount DESC; --can use alias in oder by


--Q3 - 35 rows
SELECT c.EmailAddress   
	,SUM(oi.ItemPrice * oi.Quantity) AS ItemPriceTotal
	,SUM(oi.DiscountAmount * oi.Quantity) AS DiscountAmountTotal
FROM OrderItems oi 
  JOIN Orders o ON o.OrderID = oi.OrderID
  JOIN Customers c ON c.CustomerID = o.CustomerID 
GROUP BY c.EmailAddress
ORDER BY ItemPriceTotal DESC;


--Q4 - 9 rows
SELECT c.EmailAddress, COUNT(o.OrderID) AS OrderCount, 
  SUM((oi.ItemPrice - oi.DiscountAmount) * oi.Quantity) AS OrderTotal
FROM OrderItems oi 
  JOIN Orders o ON o.OrderID = oi.OrderID
  JOIN Customers c ON c.CustomerID = o.CustomerID 
GROUP BY c.EmailAddress
HAVING COUNT(o.OrderID) > 1  -- only w aggregates
ORDER BY OrderTotal DESC;


--Q5 - 9 rows - why same number of rows w where
SELECT c.EmailAddress, COUNT(o.OrderID) AS OrderCount, 
  SUM((oi.ItemPrice - oi.DiscountAmount) * oi.Quantity) AS OrderTotal
FROM OrderItems oi 
  JOIN Orders o ON o.OrderID = oi.OrderID
  JOIN Customers c ON c.CustomerID = o.CustomerID 
WHERE oi.ItemPrice > 400 -- filter rows before grouping
GROUP BY c.EmailAddress
HAVING  COUNT(o.OrderID) > 1 -- filter after groupings
ORDER BY OrderTotal DESC; 


--Q6 - 11 rows
SELECT p.ProductName 
	,SUM((oi.ItemPrice - oi.DiscountAmount) * oi.Quantity) AS ProductTotal
FROM OrderItems oi 
  JOIN Products p ON p.ProductID = oi.ProductID
GROUP BY p.ProductName WITH ROLLUP; -- adds one column 


--Q7 - 9 rows 
SELECT c.EmailAddress, 
       COUNT(DISTINCT oi.ProductID) AS NumberOfProducts
FROM OrderItems oi 
  JOIN Orders o ON o.OrderID = oi.OrderID
  JOIN Customers c ON c.CustomerID = o.CustomerID 
GROUP BY c.EmailAddress
HAVING COUNT(DISTINCT oi.ProductID) > 1  -- why distinct
ORDER BY c.EmailAddress