--1
SELECT DISTINCT CategoryName
FROM Categories
WHERE CategoryID IN (SELECT CategoryID FROM Products)
ORDER BY CategoryName;

--2
SELECT ProductName, ListPrice
FROM Products
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Products)
ORDER BY ListPrice DESC;

--3
SELECT CategoryName
FROM Categories c
WHERE NOT EXISTS (
    SELECT 1
    FROM Products p
    WHERE p.CategoryID = c.CategoryID
);

--4
SELECT c.EmailAddress, o.OrderID,
       SUM(oi.ItemPrice * oi.Quantity * (1 - oi.DiscountAmount)) AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.EmailAddress, o.OrderID;


SELECT EmailAddress, MAX(OrderTotal) AS LargestOrder
FROM (
    SELECT c.EmailAddress, o.OrderID,
           SUM(oi.ItemPrice * oi.Quantity * (1 - oi.DiscountAmount)) AS OrderTotal
    FROM Orders o
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    GROUP BY c.EmailAddress, o.OrderID
) AS OrderTotals
GROUP BY EmailAddress;


--5
SELECT ProductName, DiscountPercent
FROM Products
WHERE DiscountPercent IN (
    SELECT DiscountPercent
    FROM Products
    GROUP BY DiscountPercent
    HAVING COUNT(*) = 1
)
ORDER BY ProductName;

--6
SELECT c.EmailAddress, o.OrderID, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate = (
    SELECT MIN(o2.OrderDate)
    FROM Orders o2
    WHERE o2.CustomerID = o.CustomerID
);
