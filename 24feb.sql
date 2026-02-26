# Employee table: FName LName SSN(FK) Address Sex Salary SuperSSN DNO
# Department table: DNo(Primary Key) Dname Mgr MgrStartDate MgrSSN

create database EmpInfo;

use EmpInfo;


CREATE TABLE Department (
    DNo INT PRIMARY KEY,
    Dname VARCHAR(50) NOT NULL,
    Mgr VARCHAR(100),
    MgrStartDate DATE,
    MgrSSN VARCHAR(15)
);

CREATE TABLE Employee (
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    SSN VARCHAR(15) PRIMARY KEY,
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    SuperSSN VARCHAR(15),
    DNO INT,
    
    FOREIGN KEY (SuperSSN) REFERENCES Employee(SSN),
    FOREIGN KEY (DNO) REFERENCES Department(DNo)
);


#Insert Data into Department

INSERT INTO Department (DNo, Dname, Mgr, MgrStartDate, MgrSSN) VALUES
(1, 'HR', 'John Smith', '2020-01-15', '111-11-1111'),
(2, 'IT', 'Alice Brown', '2021-03-10', '222-22-2222'),
(3, 'Finance', 'Robert White', '2019-07-01', '333-33-3333');

#Insert Data into Employee

INSERT INTO Employee (FName, LName, SSN, Address, Sex, Salary, SuperSSN, DNO) VALUES
('John', 'Smith', '111-11-1111', 'New York', 'M', 80000, NULL, 1),
('Alice', 'Brown', '222-22-2222', 'Los Angeles', 'F', 90000, NULL, 2),
('Robert', 'White', '333-33-3333', 'Chicago', 'M', 85000, NULL, 3);



INSERT INTO Employee (FName, LName, SSN, Address, Sex, Salary, SuperSSN, DNO) VALUES
('David', 'Lee', '444-44-4444', 'Houston', 'M', 60000, '222-22-2222', 2),
('Emma', 'Davis', '555-55-5555', 'Boston', 'F', 55000, '111-11-1111', 1);

# Question 1
# How the resulting salaries if every employee working on the "Research" Departments is given a 10 percent raise.

select e.FName,e.LName,
e.salary*1.10 As increased_salary
from Employee e Join
Department D on
e.DNO = D.DNo
Where D.Dname = "Finance";


#Question 2
#Find the sum of the salaries of all employees of the "Accounts" department, as well as the maximum salary, the minimum salary, and the average salary in this department

SELECT 
    SUM(e.Salary) AS TotalSalary,
    MAX(e.Salary) AS MaximumSalary,
    MIN(e.Salary) AS MinimumSalary,
    AVG(e.Salary) AS AverageSalary
FROM Employee e
JOIN Department d ON e.DNO = d.DNo
WHERE d.Dname = 'HR';

#Question 3

#Employees Controlled by Department 5
select FName, LName from Employee
where DNO = 5;

#Using exist

select FName, LName from Employee E
where exists (select 1 from Employee e
where e.DNO = 5 and E.SSN = e.SSN);

#Question 4 Departments Having At Least 2 Employees
SELECT d.DNo, d.Dname, COUNT(e.SSN) AS TotalEmployees
FROM Department d
JOIN Employee e ON d.DNo = e.DNO
GROUP BY d.DNo, d.Dname
HAVING COUNT(e.SSN) >= 2;


#q5 employees born in 1990's 
#between 1990-1999 

SELECT FName, LName, DateOfBirth
FROM Employee
WHERE DateOfBirth BETWEEN '1990-01-01' AND '1999-12-31';
