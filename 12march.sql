CREATE DATABASE TechSolutionsDB;
USE TechSolutionsDB;

CREATE TABLE DEPARTMENT(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

CREATE TABLE EMPLOYEE(
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender CHAR(1),
    Salary REAL,
    HireDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

CREATE TABLE PROJECT(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    Budget REAL
);

CREATE TABLE WORKS_ON(
    EmpID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES PROJECT(ProjectID)
);

INSERT INTO DEPARTMENT VALUES
(1, 'Human Resources', 'Kathmandu'),
(2, 'IT', 'Lalitpur'),
(3, 'Finance', 'Bhaktapur'),
(4, 'Marketing', 'Pokhara'),
(5, 'Research', 'Chitwan');

INSERT INTO EMPLOYEE VALUES
(101, 'Samar', 'Shakya', 'M', 55000, '2022-01-10', 2),
(102, 'Swodesh', 'Shakya', 'M', 48000, '2021-05-12', 1),
(103, 'Anita', 'Sharma', 'F', 60000, '2020-03-15', 3),
(104, 'Ramesh', 'Adhikari', 'M', 52000, '2023-02-20', 2),
(105, 'Sita', 'Karki', 'F', 47000, '2022-11-05', 4);

INSERT INTO PROJECT VALUES
(1, 'Website Development', '2026-05-01', '2026-10-01', 150000),
(2, 'Mobile App', '2026-06-15', '2026-12-15', 200000),
(3, 'Accounting System', '2026-07-20', '2026-11-20', 120000),
(4, 'Marketing Campaign', '2026-04-10', '2026-08-10', 90000),
(5, 'AI Research', '2026-09-01', '2026-12-30', 300000);

INSERT INTO WORKS_ON VALUES
(101, 1, 40),
(101, 2, 25),
(102, 3, 30),
(103, 4, 35),
(104, 1, 20);

UPDATE EMPLOYEE
SET Salary = Salary * 1.10
WHERE EmpID = 102;

DELETE FROM PROJECT
WHERE ProjectID = 5;

SELECT *
FROM EMPLOYEE
WHERE Salary > 50000;

SELECT FirstName, LastName, Salary
FROM EMPLOYEE
ORDER BY Salary DESC;

SELECT E.FirstName, E.LastName, D.DeptName
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DeptID = D.DeptID
WHERE D.DeptName = 'IT';

SELECT DeptID, COUNT(*) AS TotalEmployees
FROM EMPLOYEE
GROUP BY DeptID;

SELECT *
FROM EMPLOYEE
WHERE HireDate > '2022-01-01';

SELECT E.FirstName, E.LastName, D.DeptName
FROM Employee E
JOIN Department D
ON E.DeptID = D.DeptID;

SELECT E.FirstName, E.LastName, P.ProjectName
FROM Employee E
JOIN Works_On W ON E.EmpID = W.EmpID
JOIN Project P ON W.ProjectID = P.ProjectID;

SELECT P.ProjectName, SUM(W.HoursWorked) AS TotalHours
FROM Project P
JOIN Works_On W ON P.ProjectID = W.ProjectID
GROUP BY P.ProjectName;

SELECT DeptID, AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptID;

SELECT DeptID, COUNT(*) AS TotalEmployees
FROM Employee
GROUP BY DeptID
ORDER BY TotalEmployees DESC
LIMIT 1;

SELECT FirstName, LastName, Salary
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
);



CREATE VIEW HighSalaryEmployees AS
SELECT EmpID, FirstName, LastName, Salary, DeptID
FROM employee
WHERE Salary > 60000;


CREATE INDEX idx_LastName
ON employee (LastName);