create database school;
use school;
create table teachers (
TeacherID int primary key,
First_name varchar(50),
Last_name varchar(50),
DOB date, 
salary real, 
address varchar(50),
Phone_no bigint	
);

create table students (
student_id int primary key,
First_name varchar(50),
Last_name varchar(50),
DOB date,  
address varchar(50),
Phone_no bigint, 
section char, 
levels char
);

insert into teachers(
TeacherID ,
First_name,
Last_name,
DOB , 
salary , 
address ,
Phone_no  
)
values (
002,'nimesh','karki','2006-04-02',550000.45,'rani', 912347885

);


select * from teachers;

insert into students(
student_id ,
First_name,
Last_name,
DOB , 
address ,
Phone_no,
section ,
levels 
)
values (
002,'himal','pahad','2005-05-20','bhaktapur', 9123345678,'B','a'

);


Select first_name, last_name
FROM  students 
WHERE levels = 's';

SELECT 
    teachers.first_name,
    teachers.last_name,
    students.first_name,
    students.last_name
FROM teachers
INNER JOIN students
ON teachers.teacherID = students.student_id;


