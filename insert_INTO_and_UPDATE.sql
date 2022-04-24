
-- SELECT * FROM employees;

-- Inserting Data INTO a new database

CREATE TABLE departments_dup(
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

-- import the data from department to its duplicate
INSERT INTO departments_dup 
(dept_no, dept_name); 