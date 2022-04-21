
-- WHERE and HAVING
-- Extract a list of all names that are encountered less than 200 times. 
-- Let the data refer to people hired after the 1st of January 1999

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

-- Aggregate fuctions use GROUP BY and HAVING
-- General conditions - WHERE


SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;-- Limits are put at the end of sentences

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 100;

-- %% INSER Statement %% ---- %% --------------- %% ---- %% --------------- %% --
-- %% INSER Statement %% ---- %% --------------- %% ---- %% --------------- %% --
-- %% --------------- %% ---- %% --------------- %% ---- %% --------------- %% --

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

insert into employees 
(
 emp_no, birth_date, first_name, last_name, gender, hire_date
) value 
(
999901,'1988-09-12','Linda','Ochwada','F','2018-05-01'
)
