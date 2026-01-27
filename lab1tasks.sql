#1. Create a db named dbemp and switch to it.
#2. Create an employee table with appropriate data types and constaints for employee details.

create database dbemp;
use dbemp;

create table employee(
EmpID int NOT NULL PRIMARY KEY,
FirstName varchar(20),
LastName varchar(20),
Gender char(1),
DateOfBirth DATE,
Designation varchar(50),
DepartmentName varchar(20),
ManagerID varchar(20),
JoinedDate DATE,
EmpSalary decimal(10,0),
EmpAddress varchar(200)

);
#3. Insert at least two emloyee records into the employee table

insert into employee(
EmpId,FirstName,LastName,Gender,DateOfBirth,Designation,DepartmentName,ManagerID,JoinedDate,EmpSalary,EmpAddress)
VALUES('001','Himal','Adhikari','M','2007-06-17','Engineer','Software Engineering','0005','2022-04-01','500000','Sanothimi-Bhaktapur')
,('002','Ram','Thapa','M','2009-06-17','Engineer','Software Engineering','0007','2022-04-05','5250000','Lokanthali-Bhaktapur');

insert into employee(
EmpId,FirstName,LastName,Gender,DateOfBirth,Designation,DepartmentName,ManagerID,JoinedDate,EmpSalary,EmpAddress)
VALUES('003','Sita','Shrestha','F','2003-06-18','Manager','Software Engineering','0008','2021-05-12','600000','Sanepa-Lalitpur');


#4. Update the gender of an employee whose EmployeeID is 002.

update employee
SET Gender ="F"
where EmpID = 002;

select * from employee;

#5. Display the first name, current date, date of birth, and age
# of the employees who are older than 30 years.

select FirstName, curdate() as CurrentDate,
DateofBirth,
timestampdiff(YEAR, DateOfBirth, CURDATE()) as Age from employee 
where
timestampdiff(YEAR, DateofBirth, CURDATE())>25;

#6. Write a query to find the oldest employye.

select * from employee 
where DateOfBirth=(select MIN(DateOfBirth)
from employee);

#7. youngest employee

select * from employee 
where DateOfBirth=(select MAX(DateOfBirth)
from employee); 

#8. Display the maximum salary department-wise.

select DepartmentName, Max(EmpSalary) as MaxEmpSalary 
from employee Group by DepartmentName;


#9. List the employees who act as managers.
select * from employee;
select FirstName from employee where 
EmpID in (Select ManagerID from employee); 





#10. Display the details of the most recently joined 
#employee.

select * from employee where
JoinedDate=(select Max(JoinedDate) from employee);