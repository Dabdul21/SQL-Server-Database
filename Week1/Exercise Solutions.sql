/*
	Chapter 03 Exercise Solutions
	Bret Abdullah - 08/29/2019
*/

USE Cis111_AP;

-- Excercise 3-01 -- 122 rows
SELECT VendorContactFName, VendorContactLName, VendorName
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName;


-- Excercise 3-02 -- 114 rows
SELECT InvoiceNumber AS Number,
       InvoiceTotal AS Total,
       PaymentTotal + CreditTotal AS Credits,
       InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
	   --Balance = InvoiceTotal - (PaymentTotal + CreditTotal)
FROM Invoices;


-- Excercise 3-03 -- 122 rows
SELECT VendorContactLName + ', ' + VendorContactFName AS FullName -- concatenation -- don't like[Full Name]
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName;


-- Excercise 3-04 -- 2 rows
SELECT InvoiceTotal, InvoiceTotal / 10 AS [10%], -- preferred 10Pct
       InvoiceTotal * 1.1 AS [Plus 10%]  -- preferred Plus10Pct
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 1000
ORDER BY InvoiceTotal DESC;


-- Excercise 3-05 -- 33 rows
SELECT InvoiceNumber AS Number,
       InvoiceTotal AS Total,
       PaymentTotal + CreditTotal AS Credits,
       InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices
WHERE InvoiceTotal BETWEEN 500 AND 10000;
--WHERE InvoiceTotal >= 500 AND InvoiceTotal <= 10000;  -- also acceptable 


-- Excercise 3-06 -- 41 rows
SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
--WHERE VendorContactLName LIKE '[A-C,E]%'
WHERE VendorContactLName LIKE '[A-E]%' 
AND VendorContactLName NOT LIKE 'D%'   -- also acceptable:
ORDER BY VendorContactLName, VendorContactFName;


-- Excercise 3-07 -- 0 rows 
SELECT *
FROM Invoices
WHERE ((InvoiceTotal - PaymentTotal - CreditTotal <= 0) AND PaymentDate IS NULL) 
OR ((InvoiceTotal - PaymentTotal - CreditTotal > 0) AND PaymentDate IS NOT NULL);
-- checking for errors 