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
--  110039 as a manager to all employees from 10021 to 10040
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
    ) as A
UNION
SELECT B.*
FROM (
        SELECT e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (
                -- 
                SELECT emp_no
                FROM dept_manager
                WHERE emp_no = 110039
            ) AS manager_ID
        FROM employees e
            JOIN dept_emp de ON e.emp_no = de.emp_no
        WHERE e.emp_no > 10020
        GROUP BY e.emp_no
        ORDER BY e.emp_no
        LIMIT 10
    ) as B;

-- Starting your code with “DROP TABLE”, create a table called “emp_manager” 
--(emp_no – integer of 11, not null; 
--dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager(
    emp_no int(11) NOT NULL,
    dept_no char(4) NULL,
    manager_no int (11) NOT NULL
);

-- --Fill emp_manager with data about employees, the number of the department they are working in, 
-- and their managers.

-- Your query skeleton must be:
-- Insert INTO emp_manager SELECT 
-- U.*
-- FROM
--                (A)
-- UNION (B) UNION (C) UNION (D) AS U;

-- A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM)
--. In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 (this 
--must be subset A), and employee number 110039 as a manager to all employees from 10021 to 10040 (this must
-- be subset B).

--Use the structure of subset A to create subset C, where you must assign employee number 110039 as a 
--manager to employee 110022.

-- Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 as 
--a manager to employee 110039.

-- Your output must contain 42 rows.

INSERT INTO emp_manager
SELECT u.*
FROM (
        SELECT a.*
        FROM (
                SELECT e.emp_no AS employee_ID,
                    MIN(de.dept_no) AS department_code,
                    (
                        SELECT emp_no
                        FROM dept_manager
                        WHERE emp_no = 110022
                    ) AS manager_ID
                FROM employees e
                    JOIN dept_emp de ON e.emp_no = de.emp_no
                WHERE e.emp_no <= 10020
                GROUP BY e.emp_no
                ORDER BY e.emp_no
            ) AS a
        UNION
        SELECT b.*
        FROM (
                SELECT e.emp_no AS employee_ID,
                    MIN(de.dept_no) AS department_code,
                    (
                        SELECT emp_no
                        FROM dept_manager
                        WHERE emp_no = 110039
                    ) AS manager_ID
                FROM employees e
                    JOIN dept_emp de ON e.emp_no = de.emp_no
                WHERE e.emp_no > 10020
                GROUP BY e.emp_no
                ORDER BY e.emp_no
                LIMIT 20
            ) AS b
        UNION
        SELECT c.*
        FROM (
                SELECT e.emp_no AS employee_ID,
                    MIN(de.dept_no) AS department_code,
                    (
                        SELECT emp_no
                        FROM dept_manager
                        WHERE emp_no = 110039
                    ) AS manager_ID
                FROM employees e
                    JOIN dept_emp de ON e.emp_no = de.emp_no
                WHERE e.emp_no = 110022
                GROUP BY e.emp_no
            ) AS c
        UNION
        SELECT d.*
        FROM (
                SELECT e.emp_no AS employee_ID,
                    MIN(de.dept_no) AS department_code,
                    (
                        SELECT emp_no
                        FROM dept_manager
                        WHERE emp_no = 110022
                    ) AS manager_ID
                FROM employees e
                    JOIN dept_emp de ON e.emp_no = de.emp_no
                WHERE e.emp_no = 110039
                GROUP BY e.emp_no
            ) AS d
    ) as u;

-- SQL Self Join
-- Applied when a table must join itself (Combining rows OF A TABLE with other rows of same table)

-- From the emp_manager table, extract the record data only of those employees who are managers as well.

SELECT *
FROM emp_manager em
ORDER BY em.emp_no;

SELECT em1.*
FROM emp_manager em1
    JOIN emp_manager em2 ON em1.emp_no = em2.manager_no;

-- SQL VIEW 
SELECT *
FROM dept_emp de
LIMIT 100;

--Create a view that will extract the average salary of all managers registered in the database. Round 
-- this value to the nearest cent.

-- If you have worked correctly, after executing the view from the “Schemas” section in Workbench, 
-- you should obtain the value of 66924.27. 

CREATE OR REPLACE VIEW v_manager_avg_salary AS
SELECT ROUND(AVG(salary), 2)
FROM salaries s
    JOIN dept_manager m ON s.emp_no = m.emp_no;




