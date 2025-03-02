--1
SELECT DISTINCT 
    C.CompanyName,
    C.ContactName,
    C.ContactTitle,
    C.Phone
FROM Customers C
LEFT OUTER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NOT NULL;

--2
SELECT 
    CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeFullName,
    CONCAT(S.FirstName, ' ', S.LastName) AS SupervisorFullName
FROM Employees E
JOIN Employees S ON E.ReportsTo = S.EmployeeID
ORDER BY SupervisorFullName, E.LastName;


--3
SELECT 
    C.CustomerID,
    C.CompanyName AS CustomerCompany,
    E.LastName AS EmployeeLastName,
    O.OrderDate,
    P.ProductName AS OrderProductName,
    OD.Quantity AS OrderProductQuantity,
    S.CompanyName AS SupplierCompany
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID  -- Enclosed in brackets
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE P.ProductName IN ('Chai', 'Chang', 'Tofu')
AND MONTH(O.OrderDate) = 12
ORDER BY O.OrderDate;


--4
SELECT DISTINCT 
    P.ProductName,
    S.CompanyName AS SupplierName
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN Suppliers S ON P.SupplierID = S.SupplierID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.Quantity >= 50
AND C.CategoryName IN ('Beverages', 'Meat/Poultry', 'Dairy Products')
ORDER BY P.ProductName;


--5
SELECT 
    'Discounted' AS DiscountType,
    P.ProductID,
    P.ProductName,
    P.UnitPrice,
    OD.Quantity,
    (P.UnitPrice * OD.Quantity) * (1 - OD.Discount) AS ProductSale
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.Discount > 0
AND OD.Quantity >= 30

UNION

SELECT 
    'No Discount' AS DiscountType,
    P.ProductID,
    P.ProductName,
    P.UnitPrice,
    OD.Quantity,
    (P.UnitPrice * OD.Quantity) AS ProductSale
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.Discount = 0
AND OD.Quantity >= 20

ORDER BY P.ProductName ASC, DiscountType ASC, OD.Quantity DESC;

--6
SELECT DISTINCT 
    E.FirstName,
    E.LastName
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE E.Country = 'USA'
AND P.ProductName IN ('Filo Mix', 'Sir Rodney’s Scones');

--7
SELECT City 
FROM Employees 

INTERSECT

SELECT City 
FROM Customers;

--8
SELECT 
    E.FirstName,
    E.LastName,
    T.TerritoryDescription,
    OD.UnitPrice AS UnitPriceAtOrder,
    OD.Quantity AS QuantityOrdered,
    P.ProductName,
    R.RegionDescription
FROM Employees E
JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
JOIN Territories T ON ET.TerritoryID = T.TerritoryID
JOIN Region R ON T.RegionID = R.RegionID
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID  -- Enclosing table name in square brackets
JOIN Products P ON OD.ProductID = P.ProductID
WHERE OD.Quantity BETWEEN 10 AND 25
AND T.TerritoryDescription = 'Atlanta'
AND R.RegionDescription = 'Southern'
AND OD.UnitPrice <= 10
AND P.ProductName LIKE '%G%'
ORDER BY P.ProductName;
