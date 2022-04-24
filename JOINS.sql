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