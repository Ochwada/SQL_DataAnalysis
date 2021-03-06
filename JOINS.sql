SELECT * FROM employees
    LIMIT 10;

-- JOIN ----------------------------------------------------------------
-- Allows us to construct a relationship between objects

SELECT * FROM departments_dup;

-- use DROP COLUMN to remove the ‘dept_manager’ column from the ‘departments_dup’ table.
ALTER TABLE  departments_dup
DROP COLUMN dept_manager;

-- Then, use CHANGE COLUMN to change the ‘dept_no’ and ‘dept_name’ columns to NULL. 

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

-- Then, insert a record whose department name is “Public Relations”.
SELECT * FROM departments_dup;

INSERT INTO departments_dup(dept_name) VALUES ('Public Relations');
-- Delete the record(s) related to department number two.   
DELETE FROM departments_dup
WHERE dept_no = 'd002';

-- Insert two new records in the “departments_dup” table. Let their values in the “dept_no” column be “d010” and “d011”. 

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

-- Create and fill in the ‘dept_manager_dup’ table, using the following code:

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
);

INSERT INTO dept_manager_dup
select * from dept_manager;

SELECT * FROM dept_manager;


INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES  (999904, '2017-01-01'),
        (999905, '2017-01-01'),
        (999906, '2017-01-01'),
        (999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES  ('Public Relations');

DELETE FROM departments_dup
WHERE
    dept_no = 'd002'; 

SELECT * FROM departments_dup
ORDER BY dept_no;

SELECT * FROM dept_manager_dup
ORDER BY dept_no;

-- INNER JOIN  
-- Extract only records in which the values in the related column match
-- Null values are also not displayed
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN
departments_dup d on m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Extract a list containing information about all managers’ employee number, first and last name, 
-- department number, and hire date. 
SELECT * FROM employees
LIMIT 10;

SELECT * FROM salaries
LIMIT 10;

SELECT * FROM dept_manager
LIMIT 10;

SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e
INNER JOIN
dept_manager dm ON e.emp_no = dm.emp_no
ORDER BY dm.dept_no;

-- DUPLICATE Records
-- Duplicate Rows are not allowed in a database

INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'customer Service');

SELECT * FROM departments_dup
ORDER BY dept_no;

SELECT * FROM dept_manager_dup
ORDER BY dept_no;

SELECT m.dept_no,
    m.emp_no,
    d.dept_name
FROM dept_manager_dup m
    INNER JOIN departments_dup d on m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Handling DUPLICATES
--- GROUP BY the field that differs most among records

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN
departments_dup d on m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

-- LEFT JOIN (interchangable with LEFT OUTER JOIN)
-- All matching values of the two tables + all values from the left table that matches no values

-- Delete DUPLICATES
DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM departments_dup
WHERE dept_no = 'd009';

-- Add back initial records
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'customer Service');

SELECT m.dept_no,
    m.emp_no,
    d.dept_name
FROM dept_manager_dup m
    LEFT JOIN departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

SELECT m.dept_no,
    m.emp_no,
    d.dept_name
FROM 
    dept_manager_dup m
        LEFT JOIN 
    departments_dup d ON m.dept_no = d.dept_no
WHERE dept_name IS NULL
ORDER BY m.dept_no;
=======
SELECT e.emp_no,  
    e.first_name,  
    e.last_name,  
    dm.dept_no,  
    dm.from_date  
FROM  
    employees e  
        LEFT JOIN   
dept_manager dm ON e.emp_no = dm.emp_no  
WHERE  
    e.last_name = 'Markovitch'  
ORDER BY dm.dept_no DESC, e.emp_no;

SELECT * FROM employees
    LIMIT 10;

-- RIGHT JOIN
-- Identical to Left JOINs, with the only difference being that the direction of the 
-- oparetion is inverted. 

SELECT m.dept_no, m.emp_no, m.dept_name
FROM dept_manager_dup m,
     departments_dup d
WHERE m.dept_no = d.dept_no
ORDER BY m.dept_no DESC;

-- Extract a list containing information about all managers’ employee number, first and last name, 
-- department number, and hire date. Use the old type of join syntax to obtain the result.

SELECT m.emp_no, e.first_name, e.last_name, m.dept_no, m.dept_no, e.hire_date
FROM employees e,
    dept_manager m
WHERE m.emp_no = e.emp_no
ORDER BY m.emp_no;

SELECT m.emp_no, e.first_name, e.last_name, m.dept_no, m.dept_no, e.hire_date
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
ORDER BY m.emp_no;


-- JOIN and WHERE
-- JOIN: used to connect TABLEs
-- WHERE: Used to set conditins

SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
    JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE s.salary > 145000;

SELECT * FROM  dept_manager LIMIT 10;
SELECT * FROM  employees LIMIT 10;
SELECT * FROM  salaries LIMIT 10;

>>>>>>> fe9cdf0bd5a790ce33fa9e584024d80165699662

<<<<<<< HEAD
-- CROSS JOIN 
-- Will take the values from a certain table and connect them with all the values from the left
--  tables we want to join 

-- INNER JOIN
-- Connets only matching values 

-- CROSS JOIN 
-- Connect all values, not just matching
-- Useful when the tables in a database arent well connected.


-- CROSS JOIN 
-- All department managers and the department they can be assigned to. 
-- i.e connecting two tables 
SELECT
    dm.*, d.*
FROM
    dept_manager dm
     CROSS JOIN
    departments d
ORDER BY dm.emp_no, d.dept_no;  

SELECT 
        dm.*, d.*
    FROM
    dept_manager dm
    JOIN
    departments d
ORDER BY dm.emp_no, d.dept_no;

SELECT
    dm.*, d.*
FROM
    dept_manager dm
     CROSS JOIN
    departments d
WHERE 
    d.dept_no <> dm.dept_no -- department but where the manager is head of.
ORDER BY dm.emp_no, d.dept_no;  

-- JOIN * ON Clause = CROSS JOIN * WHERE 

--Use a CROSS JOIN to return a list with all possible combinations between managers from 
--the dept_manager table and department number 9.
SELECT * FROM dept_manager WHERE dept_no = 'd009' LIMIT 9;
SELECT * FROM departments  LIMIT 9;

SELECT 
    dm.*, d.*
FROM 
   departments d 
        CROSS JOIN
    dept_manager dm 
WHERE d.dept_no = 'd0009'
ORDER BY d.dept_no;

-- Return a list with the first 10 employees with all the departments they can be assigned to.
--Hint: Don’t use LIMIT; use a WHERE clause. #
SELECT * FROM employees LIMIT 9;
SELECT * FROM departments  LIMIT 9;

SELECT 
    e.*, d.*  -- No column displayed 
FROM
    employees e
        CROSS JOIN
    departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

-- Find the avarage salaries of men and women in the company
-- Agrregate fuction hence data is grouped by field of interest

SELECT * FROM employees LIMIT 10;
SELECT * FROM salaries  LIMIT 10;

SELECT 
    e.gender, AVG(s.salary) AS avarage_salary -- column of displayed
FROM
    employees e
        JOIN 
    salaries s on e.emp_no = s.emp_no
GROUP BY gender;

--Know how many women and men are there.
SELECT
   gender, COUNT(gender) AS fre_gender
FROM employees
GROUP BY gender;

-- JOIN More than Two TABLES in SQL
SELECT * FROM employees LIMIT 10;
SELECT * FROM departments LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;

DESCRIBE departments;

SELECT
    e.first_name, 
    e.last_name, 
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    employees e
    JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
    JOIN 
    departments d ON dm.dept_no = d.dept_no;

-- Select all managers’ first and last name, hire date, job title, 
-- start date, and department name.

-- primary key- employees - emp_no;
-- primary key - title -- emp_no, title, from_date 
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title AS job_title,
    dm.from_date,
    d.dept_name

FROM
    employees e
    JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
    JOIN
    departments d ON dm.dept_no = d.dept_no
    JOIN
    titles t ON e.emp_no =t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;
    
SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title AS job_title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
            AND m.from_date = t.from_date
ORDER BY e.emp_no;

-- EXERCISE
-- Obtain the names of all the departments, calculate the avarage salary paid to the 
-- managers in each of them

SELECT
    d.dept_name, 
    AVG(salary) as avarage_salary    
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
    GROUP BY d.dept_name
   -- HAVING avarage_salary > 60000
    ORDER BY avarage_salary;

-- How many male and how many female managers do we have in the ‘employees’ database?
SELECT
    e.gender, 
    COUNT(e.gender),
    dm.dept_no
FROM 
    employees e
    JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;
-- 
SELECT
    e.gender, 
    COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender; 

-- UNION vs UNION ALL
DROP TABLE IF EXISTS employees_dup;
CREATE TABLE
    employees_dup
    	(
            emp_no INT(11), 
            birth_date DATE, 
            first_name varchar(16), 
            last_name varchar(16), 
            gender enum('M','F'), 
            hire_date DATE
        );

INSERT INTO
    employees_dup
SELECT  e.*
FROM
    employees e LIMIT 50;

SELECT * FROM employees_dup;
INSERT INTO 
    employees_duP 
    VALUES('10001', '1964-09-12', 'Linda','Ochwada','F','1988-10-01' );


-- 
DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11), 
    dept_no char(4),
    from_date date,
    to_date date
);

INSERT INTO 
    dept_manager_dup 
SELECT dm.*
FROM dept_manager dm 
LIMIT 20;
--
-- UNION ALL
-- Used to combine a few SELECT statements in a single output
--      MUST select same number of columns from each table 
--      Columns have to be same, same order, contain related data type

-- Add missing columns (employees_dup), dept_manager_dup
SELECT * FROM dept_manager_dup LIMIT 10;

SELECT
    e.emp_no, 
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001
UNION ALL
    SELECT 
        NULL AS emp_no, 
        NULL AS first_name,
        NULL AS last_name,
        dmd.dept_no,
        dmd.from_date
FROM
    dept_manager_dup dmd; -- 22 entry 
-- 
    SELECT
    e.emp_no, 
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001
UNION  -- difference
    SELECT 
        NULL AS emp_no, 
        NULL AS first_name,
        NULL AS last_name,
        dmd.dept_no,
        dmd.from_date
FROM
    dept_manager_dup dmd;

-- When uniting two identically organised tables: 
-- UNION. Dispay only distict values in the output; UNION ALL - All including duplicates

--Go forward to the solution and execute the query. What do you think is the meaning of the minus sign before 
--subset A in the last row (ORDER BY -a.emp_no DESC)?  

SELECT * FROM
    (SELECT
        e.emp_no,
        e.first_name,
        e.last_name,
        NULL AS dept_no,
        NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) as a
ORDER BY -a.emp_no DESC;