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

select * from employees where first_name like ('%Jack%');

select * from employees where first_name NOT LIKE ('%jack%');

select * from employees where hire_date between '1990-01-01' and '2000-01-01';

select * from employees where hire_date not between '1990-01-01' and '2000-01-01';