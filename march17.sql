# 1 Create database and table

CREATE DATABASE BankDB;
USE BankDB;

CREATE TABLE accounts(
account_id INT PRIMARY KEY,
account_holder VARCHAR(100),
balance DECIMAL(10,2)
);


# 2 Insert records

INSERT INTO accounts VALUES
(1,'Ram',50000),
(2,'Shyam',40000),
(3,'Hari',20000);


# 3 Transaction Example (Transfer 5000 from account 1 to 2)

START TRANSACTION;

UPDATE accounts 
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

COMMIT;


# 4 Transaction with rollback

START TRANSACTION;

UPDATE accounts
SET balance = balance - 10000
WHERE account_id = 2;

UPDATE accounts
SET balance = balance + 10000
WHERE account_id = 3;

ROLLBACK;

SELECT * FROM accounts;


# 5 Transaction using SAVEPOINT

START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 1;

SAVEPOINT sp1;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 2;

ROLLBACK TO sp1;

COMMIT;


# 6 Employees table

CREATE TABLE employees(
emp_id INT PRIMARY KEY,
name VARCHAR(100),
salary DECIMAL(10,2)
);


# 7 Salary log table

CREATE TABLE salary_log(
log_id INT AUTO_INCREMENT PRIMARY KEY,
emp_id INT,
old_salary DECIMAL(10,2),
new_salary DECIMAL(10,2),
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


# 8 BEFORE INSERT trigger (salary validation)

DELIMITER $$

CREATE TRIGGER check_salary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 10000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 10000';
    END IF;
END $$

DELIMITER ;


# 9 AFTER UPDATE trigger (log salary changes)

DELIMITER $$

CREATE TRIGGER log_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_log(emp_id, old_salary, new_salary)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary);
END $$

DELIMITER ;


# 10 Stored Procedure to retrieve employees

DELIMITER $$

CREATE PROCEDURE getEmployees()
BEGIN
    SELECT * FROM employees;
END $$

DELIMITER ;

CALL getEmployees();


# 11 Stored Procedure to insert employee

DELIMITER $$

CREATE PROCEDURE addEmployees(
IN p_id INT,
IN p_name VARCHAR(100),
IN p_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO employees(emp_id,name,salary)
    VALUES (p_id,p_name,p_salary);
END $$

DELIMITER ;

CALL addEmployees(3,'Hari',20000);

# create a stored procedure that updates the salary of an employee based on employee id
DELIMITER $$

CREATE PROCEDURE updateSalary(
    IN p_id INT,
    IN new_salary DECIMAL(10,2)
)
BEGIN
    UPDATE employees
    SET salary = new_salary
    WHERE emp_id = p_id;
END $$

DELIMITER ;

CALL updateSalary(1,20000);



#4 create a stored procedure that transfers money between teo accounts using a transaction.


DELIMITER $$

CREATE PROCEDURE transferMoney(
IN from_acc INT,
IN to_acc INT,
IN amount DECIMAL(10,2)
)
BEGIN

START TRANSACTION;

UPDATE accounts
SET balance = balance - amount
WHERE account_id = from_acc;

UPDATE accounts
SET balance = balance + amount
WHERE account_id = to_acc;

COMMIT;

END $$

DELIMITER ;

CALL transferMoney(1,2,5000);