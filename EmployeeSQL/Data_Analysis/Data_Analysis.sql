-- Data Analysis

-- Dropping all existing tables:
DROP TABLE IF EXISTS emp_salary, emp_hire_1986,
					 department_emp, emp_hercules_B, 
					 sales_emp, sales_development;

-- ----------------------------------------------------------------------

-- 1.	List the employee number, last name, first name, sex, and salary of each employee.

CREATE TABLE emp_salary AS
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM (
    SELECT *
    FROM employees
    ORDER BY emp_no ASC
	) e
INNER JOIN salaries s ON e.emp_no = s.emp_no;

SELECT * FROM emp_salary LIMIT 100;


-- 2.	List the first name, last name, and hire date for the employees who were hired in 1986.

CREATE TABLE emp_hire_1986 AS
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

SELECT * FROM emp_hire_1986 LIMIT 100;


-- 3.	List the manager of each department along with their 
--     department number, department name, employee number, last name, and first name.

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
INNER JOIN departments d ON dm.dept_no = d.dept_no
INNER JOIN employees e ON dm.emp_no = e.emp_no


-- 4.	List the department number for each employee along with that employee’s 
--      employee number, last name, first name, and department name.

CREATE TABLE department_emp AS
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de 
INNER JOIN employees e ON de.emp_no = e.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no;

SELECT * FROM department_emp LIMIT 100;


-- 5.	List first name, last name, and sex of each employee
--      whose first name is Hercules and whose last name begins with the letter B.

CREATE TABLE emp_hercules_B AS
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT * FROM emp_hercules_B LIMIT 100;


-- 6.	List each employee in the Sales department, 
--      including their employee number, last name, and first name.

CREATE TABLE sales_emp AS
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

SELECT * FROM sales_emp LIMIT 100;


-- 7.	List each employee in the Sales and Development departments, 
-- 		including their employee number, last name, first name, and department name.

CREATE TABLE sales_development AS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

SELECT * FROM sales_development LIMIT 100;

-- Additional exploration:
-- 7a.  The following returns an empty list.
--      No employee is in both "Sales" and in "Development".

SELECT COUNT(DISTINCT e.emp_no) AS employee_count
FROM employees e
INNER JOIN dept_emp de1 ON e.emp_no = de1.emp_no
INNER JOIN departments d1 ON de1.dept_no = d1.dept_no AND d1.dept_name = 'Sales'
INNER JOIN dept_emp de2 ON e.emp_no = de2.emp_no
INNER JOIN departments d2 ON de2.dept_no = d2.dept_no AND d2.dept_name = 'Development';


-- 7b.  Number of employees in "Sales" or "Development".

-- The following shows a table of number of employees in 'Sales' and number of employees in 'Development'.

SELECT 'Sales' AS department, COUNT(*) AS employee_count
FROM dept_emp de
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
UNION
SELECT 'Development' AS department, COUNT(*) AS employee_count
FROM dept_emp de
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Development';


-- 7c.  Total Count of employees in 'Sales' or in Development' departments
SELECT COUNT(*) AS total_employee_count
FROM (
    SELECT emp_no
    FROM dept_emp de
    INNER JOIN departments d ON de.dept_no = d.dept_no
    WHERE d.dept_name = 'Sales'
    UNION
    SELECT emp_no
    FROM dept_emp de
    INNER JOIN departments d ON de.dept_no = d.dept_no
    WHERE d.dept_name = 'Development'
) AS combined_results;


-- 8.	List the frequency counts, in descending order, 
-- 		of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;


