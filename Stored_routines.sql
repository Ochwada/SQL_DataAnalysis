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