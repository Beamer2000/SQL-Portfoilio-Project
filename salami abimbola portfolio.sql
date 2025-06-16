
--Abimbola SQL Project
-- question1 List all employees with their respective job titles and salaries.

SELECT e.BusinessEntityID, e.JobTitle, ep.Rate, ep.RateChangeDate
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeePayHistory AS ep ON e.BusinessEntityID = ep.BusinessEntityID;


--Question 2 Find employees who are not linked to any department
SELECT e.BusinessEntityID, p.FirstName, p.LastName
FROM HumanResources.Employee e
INNER JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.BusinessEntityID NOT IN (
    SELECT BusinessEntityID 
    FROM HumanResources.EmployeeDepartmentHistory);

-- Question 3. Retrieve a list of employees along with their email addresses.
SELECT p.FirstName, p.LastName, e.BusinessEntityID, ea.EmailAddress
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
JOIN Person.EmailAddress ea ON e.BusinessEntityID = ea.BusinessEntityID;

--Question 4.List all employees holding the role of salesperson
SELECT e.BusinessEntityID, p.FirstName, p.LastName
FROM HumanResources.Employee AS e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.BusinessEntityID IN (
    SELECT BusinessEntityID 
    FROM Sales.SalesPerson);

-- Question 5.List employees and their corresponding contact numbers.
SELECT p.FirstName, p.LastName, pp.PhoneNumber, pt.Name AS PhoneType
FROM Person.Person AS p
JOIN Person.PersonPhone AS pp ON p.BusinessEntityID = pp.BusinessEntityID
JOIN Person.PhoneNumberType AS pt ON pp.PhoneNumberTypeID = pt.PhoneNumberTypeID;

--Question 6. Identify employees with multiple department changes.
SELECT e.BusinessEntityID, p.FirstName, p.LastName
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.BusinessEntityID IN (
    SELECT BusinessEntityID
    FROM HumanResources.EmployeeDepartmentHistory
    GROUP BY BusinessEntityID
    HAVING COUNT(DISTINCT DepartmentID) > 1);

-- question 7. List employees paid more than the average rate in their respective departments.
SELECT e.BusinessEntityID, e.JobTitle, ep.Rate
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeePayHistory AS ep ON e.BusinessEntityID = ep.BusinessEntityID
WHERE ep.Rate > (SELECT AVG(Rate) 
FROM HumanResources.EmployeePayHistory);

--Question 8.Identify items that have never been part of any transaction.
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID NOT IN (SELECT DISTINCT ProductID 
FROM Purchasing.PurchaseOrderDetail);

--Question 9. Identify the product with the maximum cost.
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice = (SELECT MAX(ListPrice) FROM Production.Product);

--Question 10. Identify products that have never appeared in a customer order.
SELECT p.ProductID, p.Name
FROM Production.Product p
WHERE p.ProductID NOT IN (
    SELECT ProductID 
    FROM Sales.SalesOrderDetail);

--Question 11. Identify products not stocked in any warehouse or store.
SELECT p.ProductID, p.Name
FROM Production.Product p
WHERE p.ProductID NOT IN (
    SELECT ProductID 
    FROM Production.ProductInventory);

--Question 12. Display purchase orders with vendor names and other relevant details.
SELECT poh.PurchaseOrderID, v.Name AS VendorName, poh.OrderDate
FROM Purchasing.PurchaseOrderHeader AS poh
INNER JOIN Purchasing.Vendor AS v ON poh.VendorID = v.BusinessEntityID;

--questyion13. List all employees with associated phone numbers, email addresses, or other contact data.
SELECT e.BusinessEntityID, p.FirstName, p.LastName, ea.EmailAddress, pp.PhoneNumber
FROM HumanResources.Employee AS e
INNER JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
LEFT JOIN Person.EmailAddress AS ea ON p.BusinessEntityID = ea.BusinessEntityID
LEFT JOIN Person.PersonPhone AS pp ON p.BusinessEntityID = pp.BusinessEntityID;

--Question14.List employees and their salary progression over time.
SELECT e.BusinessEntityID, e.JobTitle, eph.Rate, eph.RateChangeDate
FROM HumanResources.Employee AS e
INNER JOIN HumanResources.EmployeePayHistory AS eph ON e.BusinessEntityID = eph.BusinessEntityID;

--question15.Find sales orders along with the corresponding customer information.
SELECT soh.SalesOrderID, c.CustomerID, p.FirstName, p.LastName
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
INNER JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID;










 











