
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
