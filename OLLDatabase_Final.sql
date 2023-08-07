DROP TABLE IF EXISTS billing;
DROP TABLE IF EXISTS treatments;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS departments;
SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE departments(
departmentID varchar(5),
departmentName varchar(20),
staffCount numeric(5),
PRIMARY KEY(departmentID)
)
;
CREATE TABLE rooms(
roomID varchar(10),
floorNumber numeric(5),
roomStatus varchar(10),
departmentID varchar(5),
PRIMARY KEY(roomID),
FOREIGN KEY(departmentID) REFERENCES departments(departmentID)
)
;
CREATE TABLE staff(
staffID varchar(20),
staffFname varchar(100),
staffLname varchar(100),
jobTitle varchar(100),
departmentID varchar(5),
PRIMARY KEY(staffID),
FOREIGN KEY(departmentID) REFERENCES departments(departmentID)
)
;
CREATE TABLE patients(
patientID varchar(20),
firstName varchar(20),
lastName varchar(20),
gender varchar(5),
age varchar(5),
roomID varchar(10),
staffID varchar(20),
PRIMARY KEY(patientID),
FOREIGN KEY(roomID) REFERENCES rooms(roomID),
FOREIGN KEY(staffID) REFERENCES staff(staffID)
)
;
CREATE TABLE treatments(
treatmentID varchar(20),
endDate date,
staffID varchar(20),
patientID varchar(20),
PRIMARY KEY(treatmentID),
FOREIGN KEY(staffID) REFERENCES staff(staffID),
FOREIGN KEY(patientID) REFERENCES patients(patientID)
)
;
CREATE TABLE billing(
billID varchar(20),
inDate date,
outDate date,
billingAmount varchar(30),
billAddress varchar (250),
patientID varchar(20),
billCity varchar(50),
billState varchar(20),
PRIMARY KEY(billID),
FOREIGN KEY(patientID) REFERENCES patients(patientID)
)
;
INSERT INTO departments(departmentID,departmentName,staffCount)
VALUES('D001','Radiology','87'),
('D002','Cardiology','49'),
('D003','Nuerology','102');

INSERT INTO rooms(roomID,floorNumber,roomStatus,departmentID)
VALUES('A101','1','Filled','D001'),
('B097','2','Filled','D002'),
('C002','3','Empty','D003');

INSERT INTO staff(staffID,staffFname,staffLname,jobTitle,departmentID)
VALUES('S001','John','White','Doctor','D001'),
('S002','Ann','Beech','Nurse','D002'),
('S003','David','Ford','Receptionist','D003');

INSERT INTO patients(patientID,firstName,lastName,gender,age,roomID,staffID)
VALUES('P001','Jane','Smith','F','35','A101','S001'),
('P002','Mark','Johnson','M','46','B097','S005'),
('P003','Liam','Miller','M','18','C002','S007');

INSERT INTO treatments(treatmentID,endDate,staffID,patientID)
VALUES('T001','2020-01-01','S001','P001'),
('T008','2029-01-01','S005','P002'),
('T119','2025-05-19','S001','P171');

INSERT INTO billing(billID,inDate,outDate,billingAmount,billAddress,billCity,billState,patientID)
VALUES('B101','2021-08-17','2021-08-24','7593.67','5445 Moss Side Ln','Baton Rouge','LA','P001'),
('B102','2020-02-01','2021-01-01','5001.00','1118 Morning View Blvd','Slidell','LA','P002'),
('B103','2020-01-10','2020-05-26','2182.73','5120 LSU Student Union Bldg','Baton Rouge','LA','P003');

#How many rooms are the patients of Doctor White occupying?
	#Multiple Join
SELECT COUNT(patientID)
FROM patients
INNER JOIN Staff ON Patients.staffID = Staff.staffID
WHERE patients.staffID='S001';

#Display billing info for patients whose bills are higher than $5000
	#Subquery
SELECT patientID
FROM billing 
WHERE (SELECT billingAmount > 5000);

#In descending order, who are the oldest patients?
	#Order By
SELECT * FROM patients
ORDER BY age DESC;





   

