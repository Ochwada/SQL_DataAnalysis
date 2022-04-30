-- %%%%%%%%%%%%%%%%%%%%%% -------------------------------------%%%%%%%%%%%%%
-- STORED ROUTINES
-- %%%%%%%%%%%%%%%%%%%%%% -------------------------------------%%%%%%%%%%%%%
-- TYPES of STORED ROUTINES : Stored procedures (procedures) AND Functions
-- A procedure can be created without parameters too , nevertheless, the parentheses must always be attached
-- to its name. 

-- Return 1000 rows
USE employees;

DELIMITER $$
DROP PROCEDURE IF EXISTS  select_employees $$

CREATE PROCEDURE select_employees()
BEGIN
    SELECT *
    FROM employees
    LIMIT 1000;
END$$
DELIMITER ;
-- 
call employees.select_employees(); -- return 1000 records

-- Create a procedure that will provide the average salary of all employees.
-- Then, call the procedure. 
USE employees;

DELIMITER $$ 
USE employees $$ 
CREATE PROCEDURE avg_salary() 
BEGIN
    SELECT AVG(salary)
    FROM salaries;
END $$ 
DELIMITER;

CALL avg_salary; -- not exist
CALL avg_salary();
CALL employees.avg_salary;  -- already exist
CALL employees.avg_salary();   -- already exis

-- Create a procedure called ‘emp_info’ that uses as parameters the first and the last 
-- name of an individual, and returns their employee number
DELIMITER $$
USE employees $$ 
CREATE PROCEDURE emp_info(
		in p_first_name varchar(255),
		in p_last_name varchar(255),
		out p_emp_no integer
	) BEGIN
	SELECT e.emp_no INTO p_emp_no
	FROM employees e
	WHERE e.first_name = p_first_name
		AND e.last_name = p_last_name;
END $$ 
DELIMITER ;

-- SQL VARIABLES
-- Create a variable, called ‘v_emp_no’, where you will store the output of the procedure +
-- 	you created in the last exercise.
-- Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last
--  name respectively.

SET@v_emp_no = 0;
CALL emp_info('Aruna', 'Journel', @v_mp_no);
SELECT@v_emp_no;

-- Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee.
-- Hint: In the BEGIN-END block of this program, you need to declare and use two variables – v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.

DELIMITER $$ 
CREATE FUNCTION emp_info(
			p_first_name varchar(255),
			p_last_name varchar(255)
		) RETURNS decimal(10, 2) DETERMINISTIC NO SQL READS SQL DATA BEGIN
		DECLARE v_max_from_date date;
		DECLARE v_salary decimal(10, 2);
		SELECT MAX(from_date) INTO v_max_from_date
		FROM employees e
			JOIN salaries s ON e.emp_no = s.emp_no
		WHERE e.first_name = p_first_name
			AND e.last_name = p_last_name;
		SELECT s.salary INTO v_salary
		FROM employees e
			JOIN salaries s ON e.emp_no = s.emp_no
		WHERE e.first_name = p_first_name
			AND e.last_name = p_last_name
			AND s.from_date = v_max_from_date;
		RETURN v_salary;
END $$ 
DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');

-- %%%%%%%%%%%%%%%%%%%%%% -------------------------------------%%%%%%%%%%%%%
-- ADVANCE SQL Topic
-- %%%%%%%%%%%%%%%%%%%%%% -------------------------------------%%%%%%%%%%%%%

-- SCOPE (VISIBILITY): the region of a computer program where a phenomenon e.g. a variable
-- 	is valid
--  MySQL Variables --> Local,  Session, global 
-- Local -- Variable visible only in the BEGIN - END block in which it was created.


-- Create a trigger that checks if the hire date of an employee is higher than the current date. 
-- If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
DELIMITER $$ 
CREATE TRIGGER trig_hire_date BEFORE
	INSERT ON employees 
		FOR EACH ROW BEGIN IF NEW.hire_date > date_format(sysdate(),
		'%Y-%m-%d') THEN
		SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');
		END IF;
END $$ 
DELIMITER ;

INSERT employees
VALUES (
        '999904',
        '1970-01-31',
        'John',
        'Johnson',
        'M',
        '2025-01-01'
    );
SELECT *
FROM employees
ORDER BY emp_no DESC; 

-- INDEXES
-- Drop the ‘i_hire_date’ index.
ALTER TABLE employees
DROP INDEX i_hire_date; 

-- Similar to the exercises done in the lecture, obtain a result set containing the employee number, 
-- first name, and last name of all employees with a number higher than 109990. Create a fourth column 
-- in the query, indicating whether this employee is also a manager, according to the data provided in
-- the dept_manager table, or a regular employee. 

SELECT e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM employees e
    LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990;

-- Extract a dataset containing the following information about the managers: employee number, 
-- first name, and last name. Add two columns at the end – one showing the difference between 
-- the maximum and minimum salary of that employee, and another one saying whether this salary 
-- raise was higher than $30,000 or NOT.
USE employees;

SELECT dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
        ELSE 'Salary was NOT raised by more then $30,000'
    END AS salary_raise
FROM dept_manager dm
    JOIN employees e ON e.emp_no = dm.emp_no
    JOIN salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(
        MAX(s.salary) - MIN(s.salary) > 30000,
        'Salary was raised by more then $30,000',
        'Salary was NOT raised by more then $30,000'
    ) AS salary_increase
FROM dept_manager dm
    JOIN employees e ON e.emp_no = dm.emp_no
    JOIN salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

-- Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, 
-- called “current_employee” saying “Is still employed” if the employee is still working in the company, or
--  “Not an employee anymore” if they aren’t.

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;