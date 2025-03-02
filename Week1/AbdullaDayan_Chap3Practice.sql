--query 1
SELECT 
    ProductCode, ProductName, ListPrice, DiscountPercent
FROM 
    Products
ORDER BY 
    ListPrice DESC;

--query 2
SELECT 
    LastName + ', ' + FirstName AS FullName
FROM
    Customers
WHERE 
    LastName >= 'M'
ORDER BY   
    LastName ASC;

--query 3
SELECT
    ProductName,
    ListPrice,
    DateAdded
From Products
WHERE ListPrice >500 AND ListPrice <2000
ORDER By
    DateAdded DESC;
--query 4
SELECT 
    ProductName,
    ListPrice,
    DiscountPercent,
    ListPrice * DiscountPercent / 100 AS DiscountAmount,
    ListPrice - (ListPrice * DiscountPercent / 100) AS DiscountPrice
FROM Products
ORDER BY
    DiscountPrice DESC;

--query 5
SELECT
    ItemID,
    ItemPrice,
    DiscountAmount,
    Quantity,
    ItemPrice * Quantity AS PriceTotal,
    DiscountAmount * Quantity AS DiscountTotal,
    (ItemPrice - DiscountAmount) * Quantity AS ItemTotal

FROM OrderItems
WHERE 
(ItemPrice - DiscountAmount) * Quantity > 500
ORDER BY 
    ItemTotal DESC;

--query6
SELECT
    OrderID,
    OrderDate,
    ShipDate
FROM Orders
WHERe 
    ShipDate IS NULL;