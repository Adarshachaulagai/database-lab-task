-- Delete old tables if they exist
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Create Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT
);

-- Create Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Insert Data into Employees
INSERT INTO employees VALUES
(1, 'Ram Shrestha', 1),
(2, 'Sita Karki', 2),
(3, 'Bikash Thapa', 2),
(4, 'Nabin Gurung', 3),
(5, 'Pooja Rai', NULL);

-- Insert Data into Departments
INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'Human Resources'),
(4, 'Customer Service'),
(5, 'Research And Development');

-- Join Tables
SELECT 
    employees.employee_id,
    employees.employee_name,
    departments.department_name
FROM employees
inner JOIN departments
ON employees.department_id = departments.department_id;
