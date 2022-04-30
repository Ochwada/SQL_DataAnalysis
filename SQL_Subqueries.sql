-- SQL Subqueries with IN Nested Inside WHERE
-- Queries inside quesries 
-- inner queries = nested queries = inner select = outer select

SELECT * FROM
    dept_manager;
-- Select the 1st and last names frpm "employees" tables for the same
-- employee  number that can be found in the Department Manager table
SELECT 
    e.first_name,
    e.last_name
FROM 
    employees e
WHERE 
    e.emp_no IN (
        SELECT dmd.emp_no 
        FROM
            dept_manager_dup dmd 
    );
-- Extract the information about all department managers who were hired between the 1st of 
-- January 1990 and the 1st of January 1995.

SELECT
  *
FROM
   dept_manager_dup
WHERE 
    emp_no IN (
        SELECT emp_no
        FROM 
           employees
        WHERE
                hire_date BETWEEN '1990-01-01' AND '1995-01-01'
    );
-- EXITS Inside WHERE

SELECT 
    e.first_name, 
    e.last_name

FROM 
    employees e
WHERE
    EXISTS (SELECT *
            FROM dept_manager dm
            WHERE dm.emp_no = e.emp_no
            )
ORDER BY first_name DESC;

-- Select the entire information for all employees whose job title is “Assistant Engineer”. 
-- Hint: To solve this exercise, use the 'employees' table.

