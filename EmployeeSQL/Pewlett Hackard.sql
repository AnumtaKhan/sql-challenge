-- Dropping Tables
drop table if exists departments;
drop table if exists dept_emp;
drop table if exists dept_manager;
drop table if exists employees;
drop table if exists salaries;
drop table if exists titles;

-- Set the date style to ISO, MDY
ALTER DATABASE "Pewlett Hackard" SET datestyle TO "ISO, MDY";


-- Create all the tables
CREATE TABLE departments (
  dept_no VARCHAR(5) NOT NULL,
  dept_name VARCHAR(25) NOT NULL,
  primary key(dept_no)
);

select * from departments;


CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR(5) NOT NULL,
  foreign key(dept_no) references departments(dept_no)
);

select * from dept_emp;


CREATE TABLE dept_manager (
  dept_no VARCHAR(5) NOT NULL,
  emp_no INT NOT NULL,
  foreign key(dept_no) references departments(dept_no)
);

select * from dept_manager;


CREATE TABLE titles (
  title_id VARCHAR(5) NOT NULL,
  title VARCHAR(20) NOT NULL,
  primary key(title_id)
);

select * from titles;


CREATE TABLE employees (
  emp_no INT NOT NULL,
  emp_title_id VARCHAR(5) NOT NULL,
  birth_date DATE NOT NULL,
  first_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(25) NOT NULL,
  sex VARCHAR(1) NOT NULL,
  hire_date DATE NOT NULL,
  primary key(emp_no),
  foreign key(emp_title_id) references titles(title_id)
);

select * from employees;


CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  foreign key(emp_no) references employees(emp_no)	
);

select * from salaries;


-- List the employee number, last name, first name, sex, and salary of each employee.
select employees.emp_no as "Employee Number", last_name as "Last Name", first_name as "First Name", sex as "Sex", salary as "Salary" 
from employees
join salaries
on employees.emp_no = salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name as "First Name", last_name as "Last Name", hire_date as "Hire Date"
from employees 
where hire_date between '1986-01-01' AND '1986-12-31'
order by hire_date;

-- List the manager of each department with their department number, department name, employee number, last name, and first name.
select departments.dept_no as "Department Number", dept_name as "Department Name", employees.emp_no as "Employee Number", last_name as "Last Name", first_name as "First Name"
from departments
join dept_manager
on departments.dept_no = dept_manager.dept_no
join employees
on dept_manager.emp_no = employees.emp_no;

-- List the department number for each employee with that employee’s employee number, last name, first name, and department name.
select dept_emp.dept_no as "Department Number", employees.emp_no as "Employee Number", last_name as "Last Name", first_name as "First Name", departments.dept_name as "Department Name"
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
order by dept_emp.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select first_name as "First Name", last_name as "Last Name", sex as "Sex" 
from employees 
where first_name = 'Hercules' and last_name like 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
select dept_emp.dept_no as "Department Number", employees.emp_no as "Employee Number", last_name as "Last Name", first_name as "First Name"
from employees 
join dept_emp 
on employees.emp_no = dept_emp.emp_no
join departments 
on departments.dept_no = dept_emp.dept_no
where departments.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select dept_emp.dept_no as "Department Number", dept_name as "Department Name", employees.emp_no as "Employee Number", last_name as "Last Name", first_name as "First Name"
from employees 
join dept_emp 
on employees.emp_no = dept_emp.emp_no
join departments 
on departments.dept_no = dept_emp.dept_no
where departments.dept_name in ('Sales', 'Development')
order by departments.dept_no;

-- List the frequency counts, in descending order, of all the employee last names.
select last_name as "Last Name", COUNT(*) AS "Frequency Count"
from employees
group by last_name
order by "Frequency Count" DESC;