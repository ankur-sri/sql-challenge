-- --DROP TABLE Titles;
-- --DROP TABLE Salaries;
-- --DROP TABLE Dept_manager;
-- -DROP TABLE Dept_emp;
-- DROP TABLE Departments;
-- DROP TABLE Employees;

------Creating Tables

CREATE TABLE Employees(
    emp_no INT NOT NULL,
	title_id VARCHAR NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(35) NOT NULL,
    last_name VARCHAR(35) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY(emp_no)
);

CREATE TABLE Departments(
    dept_no varchar(30) NOT NULL,
    dept_name varchar(30) NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (dept_no)
);

CREATE TABLE Salaries(
    emp_no int NOT NULL,
    salary int NOT NULL
);

CREATE TABLE Titles(
    title_id varchar(10) NOT NULL,
	title varchar(35) NOT NULL
);

CREATE TABLE Dept_emp(
    emp_no int NOT NULL,
    dept_no varchar(30) NOT NULL
);

CREATE TABLE Dept_manager (
    dept_no varchar(30) NOT NULL,
    emp_no int NOT NULL
);

SELECT * FROM Departments;
SELECT * FROM Dept_emp;
SELECT * FROM Dept_manager;
SELECT * FROM Employees;
SELECT * FROM Salaries;
SELECT * FROM Titles;


ALTER TABLE Dept_emp ADD CONSTRAINT fk_Dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_emp ADD CONSTRAINT fk_Dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

--ALTER TABLE Titles ADD CONSTRAINT fk_Titles_title_id FOREIGN KEY(title_id)
--REFERENCES Employees (title_id);



-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT Employees.emp_no, 
	Employees.last_name, 
	Employees.first_name, 
	Employees.sex, 
	Salaries.salary
FROM Employees
INNER JOIN Salaries ON
Employees.emp_no = Salaries.emp_no;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.



SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	EXTRACT (year FROM hire_date) AS year
FROM employees
WHERE hire_date > '12/31/1985' AND hire_date < '01/01/1987';


-- 3. List the manager of each department with the following information: department number, department name,
--    the manager's employee number, last name, first name, and start and end employment dates.

SELECT * FROM Departments;
SELECT * FROM Dept_manager; 
SELECT * FROM Employees; 

SELECT Employees.emp_no, Dept_manager.dept_no, Employees.first_name, Employees.last_name, Employees.hire_date
FROM Employees 
INNER JOIN Dept_manager 
ON Employees.emp_no = Dept_manager.emp_no;

SELECT Employees.emp_no, Dept_manager.dept_no, Departments.dept_name, Employees.last_name, Employees.first_name,
Employees.hire_date

FROM Employees 
INNER JOIN Dept_manager
ON Employees.emp_no = Dept_manager.emp_no
INNER JOIN Departments 
ON Dept_manager.dept_no = Departments.dept_no;


-- 4. List the department of each employee with the following information: employee number, last name, first name and department name.

SELECT * FROM Departments;
SELECT * FROM Dept_manager; 
SELECT * FROM Employees; 

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Employees INNER JOIN Dept_manager 
ON Employees.emp_no = Dept_manager.emp_no
INNER JOIN Departments 
ON Dept_manager.dept_no = Departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM Employees; 

SELECT Employees.first_name,
	Employees.last_name,
	Employees.sex
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'; 


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Dept_emp;

SELECT Dept_emp.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Dept_emp
JOIN Employees
ON Dept_emp.emp_no = Employees.emp_no
JOIN Departments
ON Dept_emp.dept_no = Departments.dept_no
WHERE Departments.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Dept_emp;

SELECT Dept_emp.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Dept_emp
JOIN Employees
ON Dept_emp.emp_no = Employees.emp_no
JOIN Departments
ON Dept_emp.dept_no = Departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR Departments.dept_name = 'Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT * FROM Employees;

SELECT last_name,
COUNT (last_name) as "Total counts of Employee last names in the database"
FROM Employees
GROUP BY last_name
ORDER BY 
Count(last_name) DESC;


