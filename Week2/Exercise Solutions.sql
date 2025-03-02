Select count(*) From Vendors; -- 122 rows
Select count(*) From Invoices; -- 114 rows
Select count(*) From GLAccounts; -- 75 rows
Select count(*) From InvoiceLineItems; -- 118 rows


--Q1 - 114 rows
SELECT * 
FROM Vendors 
JOIN Invoices ON Vendors.VendorID = Invoices.VendorID;

--Q2 - 11 rows
SELECT VendorName, InvoiceNumber, InvoiceDate 
       ,InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM Vendors JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName;

--Q3 - 122 rows 
SELECT VendorName, DefaultAccountNo, AccountDescription
FROM Vendors as v JOIN GLAccounts as gl ON v.DefaultAccountNo = gl.AccountNo
ORDER BY AccountDescription, VendorName;

--Q4 - 11 rows - DON'T USE THIS METHOD
SELECT VendorName, InvoiceNumber, InvoiceDate 
       ,InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM Vendors, Invoices
WHERE Vendors.VendorID = Invoices.VendorID
  AND InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName;

--Q5 - 118 rows
SELECT VendorName AS Vendor, InvoiceDate AS Date,
       InvoiceNumber AS Number, InvoiceSequence AS [#],
       InvoiceLineItemAmount AS LineItem
FROM Vendors AS v JOIN Invoices AS i  ON v.VendorID = i.VendorID
 JOIN InvoiceLineItems AS li   ON i.InvoiceID = li.InvoiceID
ORDER BY Vendor, Date, Number, [#];

--Q6 - 6 rows
SELECT DISTINCT v1.VendorID, v1.VendorName,
       v1.VendorContactFName + ' ' + v1.VendorContactLName AS Name
FROM Vendors AS v1 JOIN Vendors AS v2 ON (v1.VendorID <> v2.VendorID) AND
		(v1.VendorContactFName = v2.VendorContactFName)
ORDER BY Name;

--Q7 - 54 rows
SELECT GLAccounts.AccountNo, AccountDescription
FROM GLAccounts LEFT JOIN InvoiceLineItems ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
WHERE InvoiceLineItems.AccountNo IS NULL
ORDER BY GLAccounts.AccountNo;

--Q8 - 122 rows
  SELECT VendorName, VendorState
  FROM Vendors
  WHERE VendorState = 'CA'
UNION
  SELECT VendorName, 'Outside CA'
  FROM Vendors
  WHERE VendorState <> 'CA'
ORDER BY VendorName;


Chapter 4 Exercise Solutions
