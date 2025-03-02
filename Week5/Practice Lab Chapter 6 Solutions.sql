--Chapter 6 Practice Lab Solutions
use Cis111_GuitarShop

--Q1 - 3 rows --------------
SELECT DISTINCT CategoryName
FROM Categories
WHERE CategoryID IN
     (SELECT DISTINCT CategoryID FROM Products)
ORDER BY CategoryName

--Q2 - 2 rows ----------------
SELECT ProductName, ListPrice
FROM Products p
WHERE ListPrice > 
      (SELECT AVG(ListPrice) FROM Products)
ORDER BY ListPrice;

--Q3 - 1 row ---------------------
SELECT CategoryName
FROM Categories c
WHERE NOT EXISTS
    (SELECT * FROM Products
     WHERE CategoryID = c.CategoryID)

--Q4 - 41 rows --------------------------------------
SELECT EmailAddress, MAX(OrderTotal) AS MaxOrderTotal
FROM (
	  SELECT EmailAddress, o.OrderID
	    ,SUM((ItemPrice - DiscountAmount) * Quantity) AS OrderTotal
	  FROM Customers c
		JOIN Orders o ON c.CustomerID = o.CustomerID
		JOIN OrderItems oi ON o.OrderID = oi.OrderID
	  GROUP BY EmailAddress, o.OrderID
	) t
GROUP BY EmailAddress, OrderID

--Q5 - 6 rows ----------------------
SELECT ProductName, DiscountPercent
FROM Products
WHERE DiscountPercent NOT IN 
	(
		SELECT DiscountPercent
		FROM Products
		GROUP BY DiscountPercent
		HAVING count(DiscountPercent) > 1
	)
ORDER BY ProductName;

--Q6 - 35 rows -------------------------
SELECT EmailAddress, OrderID, OrderDate
FROM Customers c
  JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderDate =
  (SELECT MIN(OrderDate)
   FROM Orders
   WHERE CustomerID = o.CustomerID)
GROUP BY EmailAddress, OrderID, OrderDate