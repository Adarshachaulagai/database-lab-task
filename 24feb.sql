create database newdata; 
use newdata;

create table dept(
DEPTNO int primary key,
DNAME varchar(50),
LOC char
);

RENAME table dept TO department;

ALTER TABLE department
ADD COLUMN PINCODE int not null default 0;

select * from department;

alter table department 
change DNAME dept_name varchar(20);

alter table department 
modify loc char(20);
drop table department ;
