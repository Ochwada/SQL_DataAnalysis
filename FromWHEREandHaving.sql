
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

INSERT INTO employees 
(
 emp_no, birth_date, first_name, last_name, gender, hire_date
) VALUE 
(
999901,'1988-09-12','Linda','Ochwada','F','2018-05-01'
);
-- Select 10 records from the "title" table to get a better idea about its content
-- Then, in the same table, insert information about employee number 999903. State that he/she is a "Senior Engineer",
-- who has started working in this position on October 1st 1997. 
-- At the end, sort. the recorsa from the 'titles' table in decreasing order to check if you successfully inserted the new recoerd.
SELECT 
    *
FROM
    titles
LIMIT 10;

--

INSERT INTO employees  -- Employee has to be connected to parent table
(
 emp_no, birth_date, first_name, last_name, gender, hire_date
) VALUE 
(
999903,'1968-09-12','Linda','Ochwada','F','1997-08-01'
);

-- 
INSERT INTO titles
(
emp_no, title, from_date
) VALUES
(
999903, 'Software Engineer', '1997-10-01'
);
-- 
SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC;

-- %% Insert information about individual with employee number 99903 into the 'dept_emp' table. He/ She is working for the department 
-- %% number 5 and has started work on october 1st 1997 contract is foe indefinite period of time.
-- ------------- %% ---- %% --------------- %% ---- %% --------------- %% --
SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;


INSERT INTO dept_emp
(
emp_no, dept_no, from_date, to_date
)VALUES
(
999903, 5, '1997-10-01', '9999-01-01'
);

CREATE TABLE departments_dupt
(
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL   
);