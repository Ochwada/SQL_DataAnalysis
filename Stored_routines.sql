--%%%%%%%%%%%%%%%%%%%%%% -------------------------------------%%%%%%%%%%%%%
-- STORED ROUTINES
--%%%%%%%%%%%%%%%%%%%%%% -------------------------------------%%%%%%%%%%%%%
-- TYPES of STORED ROUTINES : Stored procedures (procedures) AND Functions
-- A procedure can be created without parameters too , nevertheless, the parentheses must always be attached
--to its name. 

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
USE 'employees' $$ 
CREATE PROCEDURE avg_salary() 
BEGIN
    SELECT AVG(salary)
    FROM salaries;
END $$ 
DELIMITER;

CALL avg_salary;
CALL avg_salary();
CALL employees.avg_salary;
CALL employees.avg_salary();