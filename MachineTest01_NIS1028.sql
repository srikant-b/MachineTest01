CREATE DATABASE MachineTest01;

USE MachineTest01;

CREATE TABLE Tbl_Employee_NIS1028(
  EmployeeId INT PRIMARY KEY IDENTITY,
  EmpName VARCHAR(20),
  Phone VARCHAR(20),
  Email VARCHAR(20)
);

--DROP TABLE Tbl_Employee_NIS1028

ALTER TABLE Tbl_Employee_NIS1028 ADD AreaCode VARCHAR(6)

UPDATE Tbl_Employee_NIS1028
SET AreaCode='234655'
WHERE EmployeeId=5;

CREATE TABLE Tbl_Manufacturer_NIS1028(
  MfName VARCHAR(20) PRIMARY KEY,
  City VARCHAR(20),
  State VARCHAR(20)
);

CREATE TABLE Tbl_Computer_1028(
  MfName VARCHAR(20) 
	CONSTRAINT fk_comp_manu 
	FOREIGN KEY (MfName)
	REFERENCES Tbl_Manufacturer_NIS1028(MfName) ,
 SerialNumber VARCHAR(20),
 Model VARCHAR(20),
 Weight NUMERIC(5,2),
 EmployeeId INT 
	CONSTRAINT fk_comp_emp 
	FOREIGN KEY (EmployeeId)
	REFERENCES Tbl_Employee_NIS1028(EmployeeId)
);
INSERT INTO Tbl_Manufacturer_NIS1028 VALUES    ('Acer', 'Hsinchu', 'Taiwan'),
                                            ('HP', 'California', 'US'),
                                            ('Dell', 'Shanghai', 'China'),
                                            ('Lenovo', 'Beijing', 'China'),
                                            ('Asus', 'South Dakota', 'US');
											

INSERT INTO Tbl_Employee_NIS1028 VALUES
('Saikat','995423','saikat@gmail.com'),
('Bhushan','995424','bhushan@gmail.com'),
('Srikant','995424','srikant@gmail.com'),
('Ajinkiya','995425','ajinkiya@gmail.com'),
('Sameeran','995426','sameeran@gmail.com')

INSERT INTO Tbl_Computer_1028 VALUES   
('Acer','1', 'AC58967TR', 5, 1),
('Asus','2', 'AS48375GF', 3.2, 2),
('Dell','3', 'DL49835TA', 3.5, 3),
('HP','4', 'HP09875KL', 2.8, 4),
('Asus','5', 'AS48645GF', 3.7, 5);
------------------------------------------------------------
/*
1. List the manufacturers’
names that are located in South Dakota
*/
SELECT MfName FROM Tbl_Manufacturer_NIS1028 
    WHERE City='South Dakota'
----	----------------------------------------------------
/*
2. Calculate the average
weight of the computers in use.
*/
SELECT AVG(Weight) AS [Average Weight] 
  FROM  Tbl_Computer_1028 
  -------------------------------------------------
/*
  3. List the employee names
  for employees whose area_code starts with 2
  */
  SELECT EmpName  FROM Tbl_Employee_NIS1028 
  WHERE AreaCode  LIKE  '2%'
  ------------------------------------------------------------
  /*
  4. List the serial numbers for 
  computers that have a weight below
average.
  */
  SELECT SerialNumber
          FROM Tbl_Computer_1028 
  WHERE  Weight<(SELECT AVG(Weight) FROM Tbl_Computer_1028 )
  -----------------------------------------------------------------------------------
  /*
  5. List the manufacturer names of 
  companies that do not have any
computers in use. Use a subquery.
  */
  SELECT MfName 
     FROM Tbl_Manufacturer_NIS1028
  WHERE MfName NOT IN (SELECT MfName FROM Tbl_Computer_1028)
  ---------------------------------------------------------------------------
  /*
  6. Create a VIEW with the list of employee name,
  their computer serial
number,
and the city that they
were manufactured in. Use a join.
  */
CREATE VIEW vw_employee_list
AS
    SELECT emp.EmpName, comp.SerialNumber, manf.City
    FROM Tbl_Employee_NIS1028 AS emp
    INNER JOIN Tbl_Computer_1028 AS comp
    ON emp.EmployeeId = comp.EmployeeID
    INNER JOIN Tbl_Manufacturer_NIS1028 AS manf
    ON comp.MfName = manf.MfName;
	SELECT * FROM  vw_employee_list
	------------------------------------------------------------------
	/*
	7. Write a Stored Procedure to accept EmployeeId as parameter and
List the serial number, manufacturer name, model, and weight of
computer that belong to the specified Employeeid
*/

CREATE PROCEDURE sp_computer_details @EmpId INT
AS
    BEGIN
        SELECT SerialNumber, MfName, Model, Weight
        FROM Tbl_Computer_1028
        WHERE EmployeeID = @EmpId
    END;
	EXEC sp_computer_details 1

DROP DATABASE MachineTest01