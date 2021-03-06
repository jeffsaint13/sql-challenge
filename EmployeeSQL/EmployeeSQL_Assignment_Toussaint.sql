-- Import  data from departments.csv
CREATE TABLE departments (
	dept_no VARCHAR(15) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(25)
);

-- Import  data from titles.csv
CREATE TABLE titles (
	title_id VARCHAR NOT NULL PRIMARY KEY,
	title VARCHAR(25)
);

-- Import  data from salaries.csv
CREATE TABLE salaries (
	emp_no INT NOT NULL PRIMARY KEY,
	salary INT
);


-- Import  data from dept_emp.csv
-- Created composite key
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
 	PRIMARY KEY(emp_no, dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
);

DROP TABLE IF EXISTS dept_manager;
-- Import  data from dept_manager.csv
CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no INT
);

-- Import  data from employees.csv
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE,
	first_name VARCHAR (255),
	last_name VARCHAR (355),
	sex VARCHAR NOT NULL,
	hire_date DATE
);


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
-- Perform an LEFT JOIN on the two tables

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM salaries
LEFT JOIN employees ON
employees.emp_no=salaries.emp_no;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'


-- 3. List the manager of each department with the following information: department number, 
--    department name, the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no,employees.last_name, employees.first_name
FROM departments
LEFT JOIN dept_manager ON departments.dept_no=dept_manager.dept_no
LEFT JOIN employees ON dept_manager.emp_no=employees.emp_no;

-- 4. List the department of each employee with the following information:
--    employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
LEFT JOIN employees ON dept_emp.emp_no = employees.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments,
-- including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Frequency"
FROM Employees
GROUP BY last_name
ORDER BY "Frequency" DESC;