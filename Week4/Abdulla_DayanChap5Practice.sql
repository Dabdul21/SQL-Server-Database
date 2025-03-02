--Query 1
Select COUNT(OrderID) as OrderCount,
SUM(TaxAmount) AS TaxTotal
From Orders


--Query 2
Select CategoryName, COUNT(*) as ProductCount,
MAX(ListPrice) AS MostExpensiveProduct
FROM Categories c JOIN Products p 
ON c.CategoryID = p.CategoryID
GROUP BY CategoryName 
ORDER BY ProductCount DESC


--Query 3
Select EmailAddress, SUM (ItemPrice * Quantity) AS ItemPriceTotal,
SUM(DiscountAmount * Quantity) AS DiscountAmountTotal
FROM Customers c 
Join Orders o ON c.CustomerID = o.CustomerID
Join Orderitems oi ON o.OrderID = oi.OrderID
Group by EmailAddress 
Order BY ItemPriceTotal DESC


--Query 4
SELECT EmailAddress, COUNT(o.OrderID) AS OrderCount,
SUM((ItemPrice - DiscountAmount) * Quantity) AS OrderTotal
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY EmailAddress
HAVING COUNT(o.OrderID) > 1
ORDER BY OrderTotal DESC


--Query 5
SELECT EmailAddress, COUNT(o.OrderID) AS OrderCount,
SUM((ItemPrice - DiscountAmount) * Quantity) AS OrderTotal
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
WHERE ItemPrice > 400
GROUP BY EmailAddress
HAVING COUNT(o.OrderID) > 1
ORDER BY OrderTotal DESC;


--Query 6
SELECT ProductName, SUM((ItemPrice - DiscountAmount) * Quantity) AS ProductTotal
FROM Products p
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY ProductName WITH ROLLUP


--Query 7
SELECT EmailAddress,
COUNT(DISTINCT oi.ProductID) AS NumberOfProducts
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY EmailAddress
HAVING COUNT(DISTINCT oi.ProductID) > 1
ORDER BY EmailAddress