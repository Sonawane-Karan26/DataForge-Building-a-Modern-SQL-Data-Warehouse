-- Used to create a new table, database, view, stored_procedure etc.

-- Create a new table
CREATE TABLE Employees (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE
);

-- Used to modify an existing table (add, drop, or change columns).
-- Add a new column 
ALTER TABLE Employees
ADD Salary DECIMAL(10, 2);

-- Modify a column's datatype
ALTER TABLE Employees
ALTER COLUMN FirstName VARCHAR(100);


-- Used to delete a table, view, or database permanently.
-- Drop a column
ALTER TABLE Employees
DROP COLUMN HireDate;

-- Drop (delete) a table
DROP TABLE Employees;

-- Drop a database
DROP DATABASE CompanyDB;

-- Used to remove all rows from a table but retain its structure.
-- Delete all records but keep table structure
TRUNCATE TABLE Employees;

========================================================


-- INSERT – Add new records to a table
-- Insert a single row
INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate)
VALUES (1, 'John', 'Doe', '2023-01-15');

-- Insert multiple rows
INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate)
VALUES 
(2, 'Jane', 'Smith', '2023-02-10'),
(3, 'Alice', 'Johnson', '2023-03-05');


-- SELECT – Retrieve records from a table
-- Get all rows and columns
SELECT * FROM Employees;

-- Get specific columns
SELECT FirstName, LastName FROM Employees;

-- Apply conditions
SELECT * FROM Employees
WHERE HireDate > '2023-01-31';


-- UPDATE – Modify existing data
-- Update one employee's salary
UPDATE Employees
SET Salary = 60000
WHERE EmployeeID = 1;

-- Update multiple columns
UPDATE Employees
SET Salary = 65000, HireDate = '2023-02-01'
WHERE EmployeeID = 2;


-- DELETE – Remove data from a table
-- Delete one specific record
DELETE FROM Employees
WHERE EmployeeID = 3;

-- Delete all records (use with caution!)
DELETE FROM Employees;


===============================================================
OPERATORS: 
  -- Comparison Operators

  -- = (Equal to)
SELECT * FROM Employees
WHERE Department = 'IT';

-- != or <> (Not equal to)
SELECT * FROM Employees
WHERE Department <> 'HR';

--> (Greater than)
SELECT * FROM Employees
WHERE Age > 30;

-- < (Less than)
SELECT * FROM Employees
WHERE Salary < 50000;

-- >= (Greater than or equal to)
SELECT * FROM Employees
WHERE Age >= 25;

-- <= (Less than or equal to)
SELECT * FROM Employees
WHERE Salary <= 60000;

-- Logical Operators
-- AND
SELECT * FROM Employees
WHERE Department = 'Sales' AND Age > 28;

-- OR
SELECT * FROM Employees
WHERE Department = 'HR' OR Department = 'IT';

-- NOT
SELECT * FROM Employees
WHERE NOT Department = 'Finance';

-- Range Operator: BETWEEN
SELECT * FROM Employees
WHERE Salary BETWEEN 40000 AND 60000;

-- Membership Operator: IN
SELECT * FROM Employees
WHERE Department IN ('IT', 'HR', 'Sales');

-- Membership Operator: NOT IN
SELECT * FROM Employees
WHERE Department NOT IN ('IT', 'HR', 'Sales');

-- Search Operator: LIKE
-- Starts with 'A'
SELECT * FROM Employees
WHERE FirstName LIKE 'A%';

-- Ends with 'n'
SELECT * FROM Employees
WHERE LastName LIKE '%n';

-- 5-letter name starting with J (e.g., 'James')
SELECT * FROM Employees
WHERE FirstName LIKE 'J____';

-- NULL Checks: IS NULL / IS NOT NULL
-- IS NULL
SELECT * FROM Employees
WHERE ManagerID IS NULL;

-- IS NOT NULL
SELECT * FROM Employees
WHERE ManagerID IS NOT NULL;

=============================================================
JOINS


-- Employees Table
| EmployeeID | Name    | DepartmentID |
| ---------- | ------- | ------------ |
| 1          | Alice   | 10           |
| 2          | Bob     | 20           |
| 3          | Charlie | 30           |
| 4          | David   | NULL         |
| 5          | Emma    | 40           |

-- Departments Table
| DepartmentID | DepartmentName |
| ------------ | -------------- |
| 10           | HR             |
| 20           | IT             |
| 30           | Sales          |
| 50           | Marketing      |



-- 🔸 1. INNER JOIN – Match only common rows in both tables
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 🔸 2. LEFT JOIN – All rows from left table + matched rows from right
SELECT E.Name, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 🔸 3. RIGHT JOIN – All rows from right table + matched rows from left
SELECT E.Name, D.DepartmentName
FROM Employees E
RIGHT JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 🔸 4. FULL JOIN – All rows from both tables (matched or not)
SELECT E.Name, D.DepartmentName
FROM Employees E
FULL OUTER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 🔸 5. LEFT ANTI JOIN – Only rows from Employees that have no match in Departments
SELECT E.*
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentID IS NULL;

-- 🔸 6. RIGHT ANTI JOIN – Only rows from Departments that have no match in Employees
SELECT D.*
FROM Departments D
LEFT JOIN Employees E ON D.DepartmentID = E.DepartmentID
WHERE E.DepartmentID IS NULL;

-- 🔸 7. FULL ANTI JOIN – Unmatched rows from both tables
-- Combine Left Anti and Right Anti
SELECT * FROM (
    SELECT E.EmployeeID AS ID, E.Name, NULL AS DepartmentName
    FROM Employees E
    LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
    WHERE D.DepartmentID IS NULL

    UNION

    SELECT D.DepartmentID AS ID, NULL AS Name, D.DepartmentName
    FROM Departments D
    LEFT JOIN Employees E ON D.DepartmentID = E.DepartmentID
    WHERE E.DepartmentID IS NULL
) AS FullAntiJoin;

-- 🔸 8. CROSS JOIN – All combinations (Cartesian Product)
SELECT E.Name, D.DepartmentName
FROM Employees E
CROSS JOIN Departments D;
-- ⚠️ If Employees has 5 rows and Departments has 4, result = 5 × 4 = 20 rows.


-- 🔸 9. SELF JOIN – Joining a table with itself
-- Let’s say you want to find who reports to whom (requires a ManagerID column in Employees):
-- Modified Employees table includes ManagerID
SELECT E.Name AS Employee, M.Name AS Manager
FROM Employees E
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;


-- 🔸 10. NO JOIN – Just select from one table, no joins
SELECT * FROM Employees;
