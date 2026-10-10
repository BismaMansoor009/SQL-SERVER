-- create DB
create database "2509C2";

-- use DB
use "2509C2";

-- delete database
DROP DATABASE "2509C2";

-- table creation
CREATE TABLE Employee(
	id INT PRIMARY KEY IDENTITY(1,1),
	empName VARCHAR(255) NOT NULL,
	designation VARCHAR(255) NOT NULL,
	salary INT NOT NULL,
	city VARCHAR(255) NOT NULL,
	deptId INT
);
-- Single record insert
INSERT INTO Employee VALUES('Abu Bakar', 'DBA', 128000, 'Hyderabad', null);

-- Read Table records
SELECT * FROM Employee;

-- Single record insert
INSERT INTO Employee(empName, designation, salary, city, deptId) VALUES
('Imran', 'QA Developer', 80000, 'Lahore', null),
('Anwar', 'Backend Developer', 88000, 'Lahore', null),
('Rayyan', 'Product Manager', 128000, 'Islamabad', null),
('Nabeel', 'Frontend Developer', 82000, 'Karachi', null),
('Farmil', 'Senior Marketing Agent', 90000, 'Islamabad', null),
('Fasiha', 'UIUX Designer', 75000, 'Karachi', null),
('Sidrah', 'Mob App Developer', 178000, 'Multan', null);

-- DISTINCT difference
SELECT DISTINCT city FROM Employee;

-- DELETE Record
DELETE FROM Employee where id = 1;

-- Update records
Update Employee set salary = 75000 where city = 'Karachi';

Update Employee set empName='Taha', designation='Product Manager' where id=2;

-- where clause 

SELECT empName, designation from Employee where designation='Product Manager'; 

-- not

SELECT empName, designation from Employee where not designation='Product Manager'; 

-- AND

SELECT empName, designation, salary from Employee where not designation='Product Manager'
AND salary <= 88000; 


-- OR

SELECT id, empName, designation, salary from Employee where not designation='Product Manager'
OR salary <= 88000; 

SELECT id, empName, designation, salary from Employee where designation='Product Manager'
OR salary <= 88000; 

SELECT id, empName, designation, salary from Employee where not designation='Product Manager'
OR salary > 88000;

-- between

SELECT * FROM Employee where id between 2 and 6;

-- like && SEARCH QUERY %K%
SELECT * FROM Employee where city like '%Ka%';

SELECT * FROM Employee where designation like '%Mob%';

SELECT * FROM Employee where city like '%I%' AND designation like '%Senior%';

-- IN
SELECT * FROM Employee where city IN ('Islamabad');

-- Order By
SELECT * FROM Employee order by empName asc;


SELECT * FROM Employee order by salary desc;

-- Top
SELECT top 4 * FROM Employee;

SELECT top 70 percent * FROM Employee;

-- aggregate functions

SELECT COUNT(empName) as total_employees FROM Employee;

SELECT MIN(salary) as min_salary FROM Employee;

SELECT MAX(salary) as max_salary FROM Employee;

SELECT SUM(salary) as total_salary FROM Employee;

SELECT AVG(salary) as avg_salary FROM Employee;

SELECT CONCAT(empName, ' has a designation of ', designation, ' has salary of ', salary)
as EmpDetails from Employee;

-- SUB QUERIES
SELECT empName, salary FROM Employee where salary < (SELECT AVG(salary)
as avg_salary FROM Employee);

--GROUP BY

SELECT city, COUNT(id) as EmpCount FROM Employee GROUP BY city;

SELECT city, MAX(salary) as MaxSalary FROM Employee GROUP BY city;

SELECT city, MIN(salary) as MinSalary FROM Employee GROUP BY city;

SELECT city, SUM(salary) as TotalSalary FROM Employee GROUP BY city;

INSERT INTO Employee(empName, designation, salary, city, deptId) VALUES
('Bisma', 'MANAGER', 265000, 'Karachi', null),
('Iqra', 'MANAGER', 190000, 'Lahore', null),
('Humaira', 'MANAGER', 330000, 'Islamabad', null);

SELECT designation, COUNT(id) as EmpCount FROM Employee
GROUP BY designation having designation = 'MANAGER';

-- NEW TABLE OF DEPARTMENT

CREATE TABLE Department(
deptId INT PRIMARY KEY IDENTITY(1,1),
deptName VARCHAR(50) NOT NULL
);

INSERT INTO Department VALUES 
('Academics'),('SRO'), ('TECH'), ('Marketing'), ('Exam');

SELECT * FROM Department;


INSERT INTO Department VALUES 
('Placement'),('Admin');

SELECT * FROM Employee;

TRUNCATE TABLE Department;

DROP TABLE Employee;

-- table creation
CREATE TABLE Employee(
	id INT PRIMARY KEY IDENTITY(1,1),
	empName VARCHAR(255) NOT NULL,
	designation VARCHAR(255) NOT NULL,
	salary INT NOT NULL,
	city VARCHAR(255) NOT NULL,
	deptId INT,
	FOREIGN KEY (deptId) references Department(deptId)
	-- FK     own table key   ref    tablename(tablekey)
);


INSERT INTO Employee(empName, designation, salary, city, deptId) VALUES
('Ahad', 'CAH', 480000, 'Karachi', 1),
('Imran', 'Faculty Member', 80000, 'Karachi', 1),
('Rayyan', 'Admin Manager', 128000, 'Karachi', 7),
('Nabeel', 'SRO Head', 82000, 'Karachi', 2),
('Farmil', 'Senior Marketing Agent', 90000, 'Karachi', 4),
('Fasiha', 'Batch Coordinator', 75000, 'Karachi', 1),
('Sidrah', 'Manager Academics', 178000, 'Karachi', 1),
('Bisma', 'Examination Head', 265000, 'Karachi', 5),
('Iqra', 'DCAH', 190000, 'Karachi', 1),
('Humaira', 'SRO', 330000, 'Karachi', 2);

SELECT empName, designation, deptName, city, salary FROM Employee as emp
INNER JOIN Department as d on emp.deptId = d.deptId;

SELECT empName, designation, deptName, city, salary FROM Employee as emp
LEFT JOIN Department as d on emp.deptId = d.deptId;

SELECT empName, designation, deptName, city, salary FROM Employee as emp
RIGHT JOIN Department as d on emp.deptId = d.deptId;

SELECT empName, designation, deptName, city, salary FROM Department as d 
LEFT JOIN Employee as emp  on  d.deptId = emp.deptId;

SELECT empName, designation, deptName, city, salary FROM Department as d 
RIGHT JOIN Employee as emp  on  d.deptId = emp.deptId;

SELECT empName, designation, deptName, city, salary FROM Department as d 
FULL OUTER JOIN Employee as emp  on  d.deptId = emp.deptId;

INSERT INTO Employee(empName, designation, salary, city) VALUES
('Ahad', 'CAH', 480000, 'Karachi');

-- VIEWS
SELECT empName, designation FROM Employee;

CREATE VIEW [empDeptNames]
AS
SELECT empName, designation FROM Employee;

SELECT * FROM empDeptNames;

CREATE VIEW [deptNames]
AS
SELECT deptName FROM Department;

SELECT * FROM deptNames;

SELECT name, create_date FROM sys.views;

DROP VIEW empDeptNames;

-- DCL: Data Control Language

SELECT * FROM sys.sql_logins;

CREATE LOGIN ACC_EMP WITH PASSWORD= '555';

CREATE USER ACC_EMP FROM LOGIN ACC_EMP;

-- IJAZAT = GRANT
GRANT SELECT on dbo.Employee TO ACC_EMP;

GRANT INSERT, DELETE on dbo.Employee TO ACC_EMP;

-- IJAZAT-WAPIS = REVOKE
REVOKE SELECT on dbo.Employee TO ACC_EMP;

-- LOGIN ACC_EMP
DROP LOGIN ACC_EMP;

-- STORED PROCEDURES
CREATE PROCEDURE SeeEmp
AS 
Begin
SELECT * FROM Employee
END;

--RUN
SeeEmp;

CREATE PROCEDURE SeeEmp6
AS 
Begin
SELECT * FROM Employee WHERE Id=6
END;

--RUN
SeeEmp6;

-- insert 
CREATE PROCEDURE AddEmp @name VARCHAR(255), @desig VARCHAR(255), @sal INT, @city VARCHAR(65), @dId INT
AS
BEGIN
INSERT INTO Employee VALUES (@name, @desig, @sal, @city, @dId)
SELECT * FROM Employee
END;

--RUN
AddEmp @name='Taha', @desig='Manager', @sal=156000, @city='Isl', @dId=6;

AddEmp @name='Maha', @desig='Senior SQA', @sal=96000, @city='Isl', @dId=1;

-- UPDATE
CREATE PROCEDURE UpdateEmp @id INT, @name VARCHAR(255), @desig VARCHAR(255), @sal INT, @city VARCHAR(65), @dId INT
AS
BEGIN
 UPDATE Employee SET EmpName = @name, Designation = @desig, Salary = @sal, City = @city, DeptId = @dId
   WHERE Id = @id;
SELECT * FROM Employee;
END;

-- RUN
UpdateEmp 6, 'Humaira', 'Web Developer', 90000, 'Karachi', 1;

-- DELETE
CREATE PROCEDURE DeleteEmp @id INT
AS
BEGIN
  DELETE FROM Employee WHERE Id = @id;
SELECT * FROM Employee;
END;

-- RUN
DeleteEmp 6;

-- TRIGGER
CREATE TRIGGER AddEmp_trigger
ON Employee FOR INSERT 
AS
BEGIN
print('A new employee added successfully.')
END;

-- ALTER
ALTER TRIGGER AddEmp_trigger
ON Employee FOR INSERT 
AS
BEGIN
SELECT * FROM inserted
END;


INSERT INTO Employee(empName, designation, salary, city) VALUES
('Saad', 'Frontend Developer', 880000, 'Karachi');

-- DELETE TRIGGER
DROP TRIGGER AddEmp_trigger;

CREATE TABLE EmpLogs(
   logid INT PRIMARY KEY IDENTITY(1,1),
   ActionPerformed NVARCHAR(255)
);

SELECT * FROM EmpLogs;

SELECT * INTO Test FROM Employee;

SELECT * FROM Test;

-- TRIGGER WITH CAST INSERT DATA
CREATE TRIGGER AddEmp_trigger
ON Employee AFTER INSERT 
AS
BEGIN
DECLARE @Id INT, @name VARCHAR(65)
SELECT @Id=id , @name =empName FROM inserted 
INSERT INTO EmpLogs VALUES (@name + 'having ID = '
+ CAST(@Id AS VARCHAR(6)) + 'is added at' + 
CAST(GETDATE() AS VARCHAR(30)))
END;

-- SOFT DELETE
SELECT * FROM Employee WHERE emp_status=1;

ALTER TABLE Employee ADD emp_status INT DEFAULT(1) NOT NULL;

--TRIGGER
CREATE TRIGGER soft_delete
ON Employee
INSTEAD OF DELETE
AS 
BEGIN
DECLARE @ID INT
SELECT @ID=id FROM Deleted
UPDATE Employee SET emp_status=0 WHERE id=@ID
END;

DELETE FROM Employee WHERE id = 5;

-- see trash data
SELECT * FROM Employee WHERE emp_status=0;

-- UPDATE TRIGGER
CREATE Trigger Update_Employee
ON Employee
FOR Update
AS
BEGIN
DECLARE @Id INT
DECLARE @Newname VARCHAR(60), @Oldname VARCHAR(60)
DECLARE @Newsalary INT, @Oldsalary INT
DECLARE @NewDesignation VARCHAR(60), @OldDesignation VARCHAR(60)
DECLARE @Newdeptid INT, @Olddeptid INT
DECLARE @Newcity VARCHAR(60), @Oldcity VARCHAR(60)
DECLARE @AuditString VARCHAR(255)

SELECT * INTO #Temptable FROM inserted
WHILE(EXISTS (SELECT id FROM #Temptable))
BEGIN
SELECT @Id=id, @Newname=empName, @Newsalary=salary, @NewDesignation=designation,
@Newcity=city, @Newdeptid=deptid FROM #Temptable
SELECT @oldname=empName, @Oldsalary=salary, @OldDesignation=designation,
@Oldcity=city, @Olddeptid=deptID FROM deleted WHERE id=@Id

SET @AuditString=''
SET @AuditString = 'An employee having id = ' + CAST(@Id as varchar(6)) + ' on ' + CAST(GETDATE() as varchar(30)) + ' is changed '
SET @AuditString = @AuditString + ' its name from '+@Oldname +' to '+ @Newname

if(@Oldsalary <> @Newsalary)
SET @AuditString = @AuditString + ' its salary from '+CAST(@Oldsalary as varchar(10))+' to '+CAST(@Newsalary as varchar(10))

if(@OldDesignation <> @NewDesignation)
SET @AuditString = @AuditString + ' its designation from '+@OldDesignation + ' to '+@NewDesignation

if(@Oldcity <> @Newcity)
SET @AuditString = @AuditString + ' its city from '+@Oldcity + ' to '+@Newcity

if(@Olddeptid <> @Newdeptid)
SET @AuditString = @AuditString + ' its deptid from '+CAST(@Olddeptid as varchar(10))+' to '+CAST(@Newdeptid as varchar(10))
Insert into Emplogs values(@AuditString)
DELETE FROM #Temptable where id=@id
end
end;

SELECT * FROM Employee;
UPDATE Employee SET city = 'Lahore' where id > 7;
SELECT * FROM Emplogs;

-- transactions
-- DDL: data definition language
-- DML: data manipulation language
-- DCL: data control laguage
-- TCL: transaction controol laguage 

-- ACID PROPERTIES
-- A => Automicity -- all the steps are fully completed or not a single step will execute.
-- C => Consistancy -- all the nodes in a network should be aware of the transaction.
-- I => Isolation -- one transaction's info should not be known to anotyher transaction.
-- D => Durability -- changes after transaction should be saved.


-- Integrity
Begin Transaction
Update Employee set empName='Khurram' where id= 1;
Commit Transaction;-- save permantetly changes

Rollback Transaction;-- cnt + z / undo

BEGIN TRANSACTION
BEGIN try 
Update Employees set empName='chakwal' where id= 1/0;
print('Commited Successfully.')
COMMIT TRANSACTION
End try
BEGIN catch
print('Rolled back Successfully.')
Rollback Transaction
END catch;
