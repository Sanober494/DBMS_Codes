use dbmslab;
/* lab 7 practice: */

-- question 1

CREATE TABLE Rar1 (
    holidaycode CHAR(4) PRIMARY KEY,
    cost DECIMAL(10,2)
);

CREATE TABLE Rar2 (
    airportcode INT PRIMARY KEY,
    airportname VARCHAR(50)
);

CREATE TABLE Rar3 (
    agentcode INT PRIMARY KEY,
    agentname VARCHAR(50)
);

CREATE TABLE Rar4 (
    batchno INT,
    agentno INT,
    holidaycode CHAR(4),
    airportcode INT,
    quantitybooked INT,
    PRIMARY KEY (batchno, agentno, holidaycode, airportcode),
    FOREIGN KEY (holidaycode) REFERENCES Rar1(holidaycode),
    FOREIGN KEY (airportcode) REFERENCES Rar2(airportcode),
    FOREIGN KEY (agentno) REFERENCES Rar3(agentcode)
);

INSERT INTO Rar1 (holidaycode, cost) VALUES 
('B563', 363),
('B248', 248),
('B428', 322),
('C930', 568),
('A270', 972),
('B728', 248),
('A430', 279);

INSERT INTO Rar2 (airportcode, airportname) VALUES
(1, 'Luton'),
(12, 'Edinburgh'),
(11, 'Glasgow'),
(14, 'Newcastle');

INSERT INTO Rar3 (agentcode, agentname) VALUES
(76, 'Bairns travel'),
(142, 'Active Holidays');

INSERT INTO Rar4 (batchno, agentno, holidaycode, airportcode, quantitybooked) VALUES
(1, 76, 'B563', 1, 10),
(1, 76, 'B248', 12, 20),
(1, 76, 'B428', 11, 18),
(2, 142, 'B563', 1, 15),
(2, 142, 'C930', 14, 2),
(2, 142, 'A270', 14, 1),
(2, 142, 'B728', 12, 5),
(3, 76, 'C930', 1, 11),
(3, 76, 'A430', 11, 15);

CREATE VIEW AgentBookings AS
SELECT Rar3.agentname, Rar4.holidaycode, Rar1.cost, Rar4.quantitybooked, Rar2.airportname, Rar4.batchno, Rar1.cost * Rar4.quantitybooked AS totalcost
FROM Rar3
JOIN Rar4 ON Rar3.agentcode = Rar4.agentno
JOIN Rar1 ON Rar4.holidaycode = Rar1.holidaycode
JOIN Rar2 ON Rar4.airportcode = Rar2.airportcode;

select* from AgentBookings;

-- question 2:

CREATE TABLE COURSESTUDENT (
    CourseID INT,
    StudentID INT,
    PRIMARY KEY (CourseID, StudentID)
);

CREATE TABLE COURSEBOOK (
    CourseID INT,
    RefBook VARCHAR(100),
    PRIMARY KEY (CourseID, RefBook)
);

INSERT INTO COURSESTUDENT (CourseID, StudentID) VALUES 
(101, 1001),
(101, 1002),
(102, 1001),
(102, 1003),
(103, 1002),
(104, 1001);

INSERT INTO COURSEBOOK (CourseID, RefBook) VALUES
(101, 'Book1'),
(101, 'Book2'),
(102, 'Book3'),
(103, 'Book2'),
(104, 'Book4'),
(104, 'Book5');

create view view1 as
select courseid, studentid from COURSESTUDENT;
select * from view1;

create view view2 as 
select courseid, refbook from coursebook;
select* from view2;
