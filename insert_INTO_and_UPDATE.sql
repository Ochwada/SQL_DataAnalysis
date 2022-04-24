
-- SELECT * FROM employees;

-- Inserting Data INTO a new database

CREATE TABLE departments_dup(
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

-- import the data from department to its duplicate
INSERT INTO departments_dup 
    (dept_no, 
    dept_name)
SELECT * FROM departments; 

select * from departments_dup;

-- Create a new department called “Business Analysis”. Register it under number ‘d010’.

INSERT INTO departments
(
    dept_no, dept_name
) VALUES (
    'd010', 'Business Analysis'
);

-- UPDATE STATEMENT

UPDATE employees 
SET
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date= '1990-12-31',
    gender ='F'

WHERE
    emp_no = 999901;

SELECT *
FROM employees
WHERE emp_no = 999901;

SELECT *
FROM employees
ORDER BY emp_no DESC;

COMMIT;
-- Change the “Business Analysis” department name to “Data Analysis”.

UPDATE departments
SET dept_name = 'Data Analysis'
WHERE dept_no = 'd010'

INSERT INTO employees
( emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES (
999903, '1977-09-14', 'Linda', 'Ochwada', 'F', '1997-10-01'
);

SELECT * FROM employees WHERE emp_no = 999903;


INSERT INTO titles
( emp_no, title, from_date, to_date)
VALUES (
999903, 'senior data scientist','1997-10-01','9999-01-01'
);


SELECT * FROM titles WHERE emp_no = 999903; 

commit;

DELETE FROM employees
WHERE emp_no = 999903;

ROLLBACK;

-- DROP vs TRUNCATE vs DELETE
-- COUNT  --> sum(), count(), min(), max(),avg()


SELECT * FROM salaries ORDER BY salary DESC LIMIT 10;

SELECT COUNT(salary) from salaries;

-- How many employees start dates are in the database
SELECT * FROM titles LIMIT 50;

SELECT COUNT(DISTINCT from_date) FROM salaries; 

-- How many departments are there in the “employees” database? Use the ‘dept_emp’ table .

SELECT * FROM dept_emp LIMIT 10;

SELECT COUNT(DISTINCT dept_no) FROM dept_emp;

-- SUM()
 -- How much money does the fir, spend on salaries

 SELECT * FROM salaries LIMIT 10;

 SELECT SUM(salary) FROM salaries; 

-- NOTE: count() return all rowa of the table, NULL values included, applied to both numeric and 
                 -- non numeric
--       sum() goes well with only the COUNT() function

-- What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?

SELECT * FROM salaries LIMIT 10;

SELECT SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01';

-- MAX() and MIN()
-- which is the maximum amount of salary offered 
SELECT  MAX(salary) FROM salaries;
SELECT  MIN(salary) FROM salaries;

-- 1. Which is the lowest employee number in the database?
SELECT MIN(emp_no) FROM employees;

-- 2. Which is the highest employee number in the database?
SELECT MAX(emp_no) FROM employees;

-- AVG() 
-- Avarage annual salary for all employees
SELECT AVG(salary) FROM salaries;

-- What is the average annual salary paid to employees who started after the 1st of January 1997?
SELECT AVG(salary) FROM salaries
WHERE from_date > '1997-01-01';

-- ROUND() --
--Round the average amount of money spent on salaries for all contracts that started after the
-- 1st of January 1997 to a precision of cents.
SELECT ROUND(AVG(salary), 2) FROM salaries
WHERE from_date > '1997-01-01';

-- COALESCE() - Preamble
-- IF NULL() and COALESCE() are among the advanced SQL functions in the toolkit of SQL professionals. They are used when null values are
    -- dispersed in your data table and you would like to substitute the null values with another value.

SELECT * FROM departments_dup
ORDER BY dept_no ASC;

DELETE FROM departments_dup WHERE dept_no = 'd010';

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup(dept_no)
VALUES ('d010'), ('d011');

ALTER TABLE employees.departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL
AFTER dept_name;

COMMIT;

-- IFNULL or COALESCE()
-- IFNULL -> can not contain mre than two parameters
-- COALESCE -> Allows you to insert N arguments in the parentheses

SELECT dept_no,
IFNULL(dept_name, 'Department name not provided') as dept_name
FROM departments_dup;

SELECT dept_no,
COALESCE(dept_name, 'Department name not provided') as dept_name
FROM departments_dup;

SELECT dept_no, dept_name,
       COALESCE(dept_manager, dept_name, 'N/A') as dept_manager
FROM departments_dup 
ORDER BY dept_no ASC;

SELECT  dept_no, dept_name,
    COALESCE('department name not found') as fake_news
FROM departments_dup;

-- Select the department number and name from the ‘departments_dup’ table and add a third column where you name 
-- the department number (‘dept_no’) as ‘dept_info’. If ‘dept_no’ does not have a value, use ‘dept_name’.

SELECT dept_no, dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;

-- Modify the code obtained from the previous exercise in the following way. Apply the IFNULL() function to the 
-- values from the first and second column, so that ‘N/A’ is displayed whenever a department number has no value, 
-- and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.

SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no, 
    IFNULL(dept_name, 'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;





