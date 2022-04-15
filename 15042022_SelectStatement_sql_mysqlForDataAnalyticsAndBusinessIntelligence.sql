SELECT  * FROM employees.employees WHERE first_name IN ('Denis' , 'Elvis'); -- List of names with the first names indicated there 

use employees;

SELECT  * FROM employees WHERE first_name NOT IN ('John' , 'Mark', 'Jacob'); -- List of names without the said names 

SELECT * FROM employees WHERE first_name LIKE ('Mar%');-- List with Names starting with Mar

SELECT * FROM employees WHERE first_name LIKE ('%rk');-- list with NAMES ENDING WITH 'rk'

SELECT * FROM employees WHERE first_name LIKE ('Mar_');-- List of names with 4 letters starting with 'mar'

SELECT * FROM employees WHERE first_name NOT LIKE ('%Mar%'); -- list with names not containing 'mar'

select * from employees where first_name LIKE ('Mark%'); -- Names starting with 'Mark'

select * from employees where hire_date LIKE ('%2000%'); -- employees hired in 2000

select * from employees where emp_no LIKE ('1000_'); -- Employees with emp_no starting with 1000 but containing 5 digits

select * from employees where first_name like ('%Jack%'); -- Employees with names containing 'jack'

select * from employees where first_name NOT LIKE ('%jack%'); -- Employees with names not containing 'Jack'

select * from employees where hire_date between '1990-01-01' and '2000-01-01'; -- Employees hired between the said date

select * from employees where hire_date not between '1990-01-01' and '2000-01-01'; -- employees hired outside the said dates

select * from salaries where salary between 66000 and 70000; -- salaries between the said values

select  * from employees where emp_no not between 10004 and 10012; -- individuals whose employee number is not between ‘10004’ and ‘10012’

select dept_name from departments where dept_no between  'd003' and 'd006'; -- names of all departments with numbers between ‘d003’ and ‘d006’. 

select * from employees where first_name is not null; -- employ not missing first name 

select * from employees where first_name is null; -- employ  missing first name

select * from departments;

select dept_name from departments where dept_no is not null; --  names of all departments whose department number value is not null

select * from employees where first_name <> 'mark';  -- list of employees whose first name is not Mark

select * from employees where first_name != 'mark'; -- list of employees whose first name is not Mark

select * from employees where hire_date >= '2000-01-01' and gender ="F" ; -- a list with data about all female employees who were hired in the year 2000 or after.

select * from salaries where salary > 15000; -- a list with all employees’ salaries higher than $150,000 per annum.

select distinct gender from employees; --  distinct values in a row

select * from employees;

select distinct hire_date from employees;

## Aggregate function
-- They are applied on multiple rows of a single column of a table return an output of single value. 
-- COUNT; SUM; MIN, MAX, AVG

-- COUNT --> nO WHITE SPACE
use employees;

select count(emp_no) from employees; -- How many employees 

select count(distinct first_name) from employees; -- How many different names are there in the employees table

select * from salaries;

select count(*) from salaries where salary >= 100000;-- annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table

select * from dept_manager;

select count(emp_no) from dept_manager;