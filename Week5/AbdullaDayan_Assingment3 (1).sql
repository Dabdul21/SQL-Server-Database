--1
SELECT 
    ShipCountry AS Country,
    COUNT(OrderID) AS NumberOfOrders,
    MIN(OrderDate) AS EarliestOrderDate,
    MAX(OrderDate) AS LatestOrderDate
FROM Orders
WHERE ShipCountry IN ('Canada', 'United States', 'Mexico')
GROUP BY ShipCountry;

--2
SELECT 
    AVG(UnitPrice) AS AverageUnitPrice,
    AVG(Quantity) AS AverageQuantity,
    AVG(UnitPrice * Quantity * (1 - Discount)) AS AverageProductSales,
    SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalProductSales
FROM [Order Details];

--3
SELECT 
    P.ProductName,
    AVG(OD.Quantity) AS AverageQuantityOrdered,
    MAX(OD.Quantity) AS HighestQuantityOrdered,
    AVG(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS AverageProductSalesAmount,
    SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalProductSalesAmount
FROM [Order Details] OD
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages'
GROUP BY P.ProductName;

--4
SELECT 
    T.TerritoryDescription,
    COUNT(O.OrderID) AS NumberOfOrders
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
JOIN Territories T ON ET.TerritoryID = T.TerritoryID
GROUP BY T.TerritoryDescription
HAVING COUNT(O.OrderID) >= 75;

--5
SELECT 
    CustomerID,
    CompanyName,
    Country
FROM Customers
WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);


--6
SELECT 
    OD.OrderID,
    O.OrderDate,
    OD.ProductID,
    OD.Quantity,
    OD.UnitPrice,
    OD.Discount
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE OD.Quantity > ALL (
    SELECT Quantity FROM [Order Details] 
    WHERE ProductID IN (SELECT ProductID FROM Products WHERE ProductName IN ('Chai', 'Tofu'))
);

--7
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    ShippedDate,
    Freight
FROM Orders
WHERE Freight <= (SELECT AVG(Freight) FROM Orders WHERE CustomerID = 'CHOPS');


--8
WITH CustomerOrderCount AS (
    SELECT 
        CustomerID,
        COUNT(OrderID) AS TotalOrders,
        MIN(OrderDate) AS FirstOrderDate,
        MAX(OrderDate) AS LastOrderDate
    FROM Orders
    GROUP BY CustomerID
)
SELECT TOP 8 
    CustomerID,
    FirstOrderDate,
    LastOrderDate,
    TotalOrders
FROM CustomerOrderCount
ORDER BY TotalOrders DESC;
