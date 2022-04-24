
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

