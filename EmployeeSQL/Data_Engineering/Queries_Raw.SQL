-- -- Create the tables that I can import the CSV files into

-- CREATE TABLE "titles" (
--     "title_id" VARCHAR   NOT NULL,
--     "title" VARCHAR   NOT NULL,
--     PRIMARY KEY ("title_id")
-- );


-- CREATE TABLE "departments" (
--     "dept_no" VARCHAR   NOT NULL,
--     "dept_name" VARCHAR   NOT NULL,
--     PRIMARY KEY ("dept_no")
-- );

-- CREATE TABLE "employees" (
--     "emp_no" int   NOT NULL,
--     "emp_title_id" VARCHAR   NOT NULL,
--     "birth_date" VARCHAR   NOT NULL,
--     "first_name" VARCHAR   NOT NULL,
--     "last_name" VARCHAR   NOT NULL,
--     "sex" VARCHAR   NOT NULL,
--     "hire_date" VARCHAR   NOT NULL,
--     PRIMARY KEY ("emp_no"),
--     FOREIGN KEY("emp_title_id") REFERENCES "titles" ("title_id")
-- );

-- CREATE TABLE "dept_emp" (
--     "emp_no" int   NOT NULL,
--     "dept_no" VARCHAR   NOT NULL,
--     PRIMARY KEY ("emp_no","dept_no"),
--     FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
--     FOREIGN KEY("dept_no")REFERENCES "departments" ("dept_no")
-- );

-- CREATE TABLE "salaries" (
--     "emp_no" int   NOT NULL,
--     "salary" int   NOT NULL,
--     CONSTRAINT "pk_salaries" PRIMARY KEY ("emp_no"),
--     FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no")
-- );

-- CREATE TABLE "dept_manager" (
--     "dept_no" VARCHAR   NOT NULL,
--     "emp_no" int   NOT NULL,
--     PRIMARY KEY ("dept_no","emp_no"),
--     FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
--     FOREIGN KEY("dept_no")REFERENCES "departments" ("dept_no")
-- );

-- -- Make sure graphs are appearing and CSV are imported correctly
SELECT * FROM titles
SELECT * FROM departments
SELECT * FROM employees
SELECT * FROM dept_emp
SELECT * FROM salaries
SELECT * FROM dept_manager

-- -- Time to join the CSV files
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
LEFT JOIN salaries as s 
ON e.emp_no = s.emp_no;
-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name,last_name,hire_date
FROM employees
WHERE hire_date like '%1986'
-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments as d
LEFT JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
LEFT JOIN employees as e
ON dm.emp_no= e.emp_no
-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de
LEFT JOIN employees as e
ON de.emp_no = e.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no
-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name like 'Hercules' and last_name like 'B%';
-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no
Where d.dept_no = 'd007'
-- 7 List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no
Where d.dept_no = 'd007' or d.dept_no = 'd005' 
-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT last_name, COUNT(last_name) as "Frequency Count"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Count" DESC
