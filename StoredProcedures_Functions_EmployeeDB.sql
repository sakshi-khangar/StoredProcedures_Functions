CREATE DATABASE employee;
USE employee;
CREATE TABLE employees(emp_ID INT PRIMARY KEY,Name varchar(50),Department varchar(50),Salary DECIMAL(10,2),Joining_Date DATE);
INSERT INTO employees VALUES (1,'Sneha Singh','IT',50000,'2022-01-15'),(2,'Priya Waghmare','HR',45000,'2023-03-01'),
(3,'Neha Singh','IT',60000,'2021-07-20'),(4,'Rajesh Kumar','Finance',55000,'2022-10-05'),
(5,'Riya Verma','IT',70000,'2020-05-12'),(6,'Sachi Patil','HR',48000,'2021-09-09');

#Stored Procedure (With Parameter and Conditional logic)
DELIMITER //

CREATE PROCEDURE GetEmployeesInfo (
    IN deptName VARCHAR(50),
    IN minSalary DECIMAL(10,2)
)
BEGIN
    IF deptName IS NOT NULL AND minSalary IS NOT NULL THEN
        SELECT * 
        FROM employees 
        WHERE department = deptName 
          AND salary >= minSalary;
    ELSEIF deptName IS NOT NULL THEN
        SELECT * 
        FROM employees 
        WHERE department = deptName;
    ELSE
        SELECT * FROM employees;
    END IF;
END //
DELIMITER ;
CALL GetEmployeesInfo('IT', 55000); -- IT employees with salary >= 55000
CALL GetEmployeesInfo('HR', NULL);  -- All HR employees
CALL GetEmployeesInfo(NULL, NULL);  -- All employees

DELIMITER //

#Function (with Parameters)
DELIMITER //

CREATE FUNCTION CalculateBonus(
    salary DECIMAL(10,2),
    bonusPercent DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10,2);
    SET bonus = salary * (bonusPercent / 100);
    RETURN bonus;
END //

DELIMITER ;
SELECT name, salary, CalculateBonus(salary, 12) AS Bonus
FROM employees;

#Find employees who joined after 2022
SELECT * FROM employees WHERE joining_date > '2022-01-01';

#Find highest paid employee in IT department
SELECT name, salary AS HighestSalary
FROM employees
WHERE department = 'IT'
AND salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department = 'IT'
);




