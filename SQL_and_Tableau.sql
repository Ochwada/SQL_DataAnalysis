-- Create Visualisation that provides a breakdown between the male and female employees working in 
-- the company each year, starting from 1990

SELECT emp_no,
    from_date,
    to_date
FROM t_dept_emp
LIMIT 100;

SELECT DISTINCT emp_no,
    from_date,
    to_date
FROM t_dept_emp
LIMIT 100;

SELECT YEAR(from_date) AS calender_year,
    e.gender,
    COUNT(e.emp_no) AS num_of_employees
FROM t_employees e
    JOIN t_dept_emp d on d.emp_no = e.emp_no
GROUP BY calender_year, e.gender
HAVING calender_year >= 1990;