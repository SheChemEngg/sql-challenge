-- Schema to create tables
-- Company Name: Pewlett Hackard

-- Start afresh!
DROP TABLE IF EXISTS departments, dept_emp, dept_manager, 
					 employees, salaries, titles;

-- ---------------------------------------------------------------------------------------------------------

-- Create tables
-- Table 1
CREATE TABLE dept_emp (
  	emp_no BIGINT NOT NULL,
	dept_no VARCHAR (10) NOT NULL
	);
SELECT * FROM dept_emp;


-- Table 2
CREATE TABLE departments (
  	dept_no VARCHAR (10) NOT NULL,
	dept_name VARCHAR (30) NOT NULL
	);
SELECT * FROM departments;


-- Table 3
CREATE TABLE titles (
	title_id VARCHAR (10) NOT NULL,
	title VARCHAR (30) NOT NULL
	);
SELECT * FROM titles;


-- Table 4
CREATE TABLE salaries (
	emp_no BIGINT NOT NULL,
	salary BIGINT NOT NULL
	);
SELECT * FROM salaries;


-- Table 5
CREATE TABLE employees (
	emp_no BIGINT NOT NULL,
	emp_title_id VARCHAR (10) NOT NULL,
	birth_date DATE,
	first_name VARCHAR (30) NOT NULL,
	last_name VARCHAR (30) NOT NULL,
	sex VARCHAR (1) NOT NULL,
	hire_date DATE
	);
SELECT * FROM employees;


-- Table 6
CREATE TABLE dept_manager (
	dept_no VARCHAR (10) NOT NULL,
	emp_no BIGINT NOT NULL
	);
SELECT * FROM dept_manager;

-- ---------------------------------------------------------------------------------------------------------

-- Import Data
SELECT * FROM departments LIMIT 100;
SELECT * FROM dept_emp LIMIT 100;
SELECT * FROM dept_manager LIMIT 100;
SELECT * FROM employees LIMIT 100;
SELECT * FROM salaries LIMIT 100;
SELECT * FROM titles LIMIT 100;


-- ---------------------------------------------------------------------------------------------------------
-- Checking for duplicates before selecting Primary Key

SELECT title_id, COUNT(*) FROM titles
GROUP BY title_id HAVING COUNT(*) > 1;

SELECT dept_no, COUNT(*) FROM departments
GROUP BY dept_no HAVING COUNT(*) > 1;

SELECT emp_no, COUNT(*) FROM employees
GROUP BY emp_no HAVING COUNT(*) > 1;

-- Duplicate emp_no counts in table: dept_emp
SELECT emp_no, COUNT(*) FROM dept_emp
GROUP BY emp_no HAVING COUNT(*) > 1;

-- No Duplicate count for composite primary key: emp_no, dept_no
SELECT emp_no, dept_no, COUNT(*) AS duplicate_count FROM dept_emp
GROUP BY emp_no, dept_no HAVING COUNT(*) > 1;

SELECT emp_no, COUNT(*) FROM dept_manager
GROUP BY emp_no HAVING COUNT(*) > 1;

SELECT emp_no, COUNT(*) FROM salaries
GROUP BY emp_no HAVING COUNT(*) > 1;

-- ---------------------------------------------------------------------------------------------------------
-- Selecting Primary Key and Foreign Key:

ALTER TABLE titles ADD PRIMARY KEY (title_id);

ALTER TABLE departments ADD PRIMARY KEY (dept_no);

ALTER TABLE employees ADD PRIMARY KEY (emp_no);
ALTER TABLE employees ADD CONSTRAINT emp_title_id_fk FOREIGN KEY (emp_title_id) REFERENCES titles(title_id);

ALTER TABLE dept_emp ADD PRIMARY KEY (emp_no, dept_no);
ALTER TABLE dept_emp ADD CONSTRAINT dept_emp_emp_no_fk FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
ALTER TABLE dept_emp ADD CONSTRAINT dept_emp_dept_no_fk FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

ALTER TABLE dept_manager ADD PRIMARY KEY (emp_no);
ALTER TABLE dept_manager ADD CONSTRAINT dept_manager_emp_no_fk FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
ALTER TABLE dept_manager ADD CONSTRAINT dept_manager_dept_no_fk FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

ALTER TABLE salaries ADD PRIMARY KEY (emp_no);
ALTER TABLE salaries ADD CONSTRAINT salaries_emp_no_fk FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

-- ---------------------------------------------------------------------------------------------------------




