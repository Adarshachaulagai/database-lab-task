-- Delete old tables if they exist
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;

-- Create Departments Table
CREATE TABLE departments (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(50)
);

-- Create Employees Table
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(50),
    department_id NUMBER,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

-- Insert Data into Departments
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
INSERT INTO departments VALUES (3, 'Human Resources');
INSERT INTO departments VALUES (4, 'Customer Service');
INSERT INTO departments VALUES (5, 'Research And Development');

-- Insert Data into Employees
INSERT INTO employees VALUES (1, 'Ram Shrestha', 1);
INSERT INTO employees VALUES (2, 'Sita Karki', 2);
INSERT INTO employees VALUES (3, 'Bikash Thapa', 2);
INSERT INTO employees VALUES (4, 'Nabin Gurung', 3);
INSERT INTO employees VALUES (5, 'Pooja Rai', NULL);

COMMIT;

-- INNER JOIN Query
SELECT 
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- LEFT JOIN (to also show employees without department)
SELECT 
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;