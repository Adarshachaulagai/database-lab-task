create database dbemp;
use dbemp;

create table employee(
		employeeID varchar(20) NOT NULL PRIMARY KEY, 
        FirstName varchar (20),
        LastName varchar (20),
        Gender char(1),
        DataofBirth DATE,
        Designation varchar(20),
        managerID varchar(20),
        JoinedDate DATE, 
        Salary decimal(10,0)
        

);

#3. Insert at least two employee records into the employee table 

insert into employee (
