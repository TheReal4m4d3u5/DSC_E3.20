-- a. Suppose you want to delete all employees who work for "First Bank Corporation."
-- What happens if an employee who works for "First Bank Corporation" also manages other employees? 
-- Explain how you would ensure that such deletions do not result in dangling references in the Manages table.

-- Delete entries in the Manages table where the employee is either a manager or being
--  managed before deleting the employee from the Works table.
-- Alternatively, use ON DELETE CASCADE in the Manages table's foreign key constraints to automatically
--  remove related entries in the Manages table when an employee is deleted.



-- b. Write the SQL statements to delete employees of "First Bank Corporation" while ensuring referential integrity is maintained.

-- Delete References in the Manages Table First:
DELETE FROM Manages
WHERE Employee_name IN (
    SELECT Employee_name
    FROM Works
    WHERE company_name = 'First Bank Corporation'
)
OR Manager_name IN (
    SELECT Employee_name
    FROM Works
    WHERE company_name = 'First Bank Corporation'
);

-- Delete Employees from the Works Table:
DELETE FROM Works
WHERE company_name = 'First Bank Corporation';

-- Delete Employees from the Employee Table:
DELETE FROM Employee
WHERE Employee_name NOT IN (SELECT Employee_name FROM Works);