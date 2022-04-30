-- SQL Subqueries with IN Nested Inside WHERE
-- Queries inside quesries 
-- inner queries = nested queries = inner select = outer select

SELECT *
FROM dept_manager;
-- Select the 1st and last names frpm "employees" tables for the same
-- employee  number that can be found in the Department Manager table
SELECT e.first_name,
    e.last_name
FROM employees e
WHERE e.emp_no IN (
        SELECT dmd.emp_no
        FROM dept_manager_dup dmd
    );
-- Extract the information about all department managers who were hired between the 1st of 
-- January 1990 and the 1st of January 1995.
SELECT *
FROM dept_manager_dup
WHERE emp_no IN (
        SELECT emp_no
        FROM employees
        WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01'
    );
-- EXITS Inside WHERE

SELECT e.first_name,
    e.last_name
FROM employees e
WHERE EXISTS (
        SELECT *
        FROM dept_manager dm
        WHERE dm.emp_no = e.emp_no
    )
ORDER BY first_name DESC;

-- Select the entire information for all employees whose job title is “Assistant Engineer”. 
-- Hint: To solve this exercise, use the 'employees' table.
SELECT *
FROM employees e
WHERE EXISTS (
        SELECT *
        FROM titles t
        WHERE t.emp_no = e.emp_no
            AND title = 'Assistant Engineer'
    )
ORDER BY first_name
LIMIT 10;

-- SQL Subqueries NESTED IN SELECT and FROM
-- EXERCISE
-- Assign employee number 110022 as a manager to all employees from 10001 to 10020, and employee number
--  11022 as a manager to all employees from 10021 to 10040
SELECT A.*
FROM (
        SELECT e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (
                -- 
                SELECT emp_no
                FROM dept_manager
                WHERE emp_no = 110022
            ) AS manager_ID
        FROM employees e
            JOIN dept_emp de ON e.emp_no = de.emp_no
        WHERE e.emp_no <= 10020
        GROUP BY e.emp_no
        ORDER BY e.emp_no
    ) as A;

