-- Task 01
CREATE DATABASE week08;

USE week08;

-- Task 02

-- Task 02 a
CREATE TABLE cs245_student(
    roll_number CHAR(9),
    name CHAR(100),
    reg_status CHAR(20),
    audit_credit CHAR(10),
    email CHAR(50),
    phone CHAR(8),
    PRIMARY KEY(roll_number)
);

-- Task 02 b
CREATE TABLE cs245_marks(
    roll_number CHAR(9),
    marks INT,
    PRIMARY KEY(roll_number),
    Foreign Key (roll_number) REFERENCES cs245_student(roll_number)
);

-- Task 02 c
CREATE TABLE cs245_grade(
    roll_number CHAR(9),
    letter_grade CHAR(2),
    PRIMARY KEY(roll_number),
    Foreign Key (roll_number) REFERENCES cs245_student(roll_number)
);

-- Task 02 d
CREATE TABLE cs246_student(
    roll_number CHAR(9),
    name CHAR(100),
    reg_status CHAR(20),
    audit_credit CHAR(10),
    email CHAR(50),
    phone CHAR(8),
    PRIMARY KEY(roll_number)
);

-- Task 02 e
CREATE TABLE cs246_marks(
    roll_number CHAR(9),
    marks INT,
    PRIMARY KEY(roll_number),
    Foreign Key (roll_number) REFERENCES cs246_student(roll_number)
);

-- Task 02 f
CREATE TABLE cs246_grade(
    roll_number CHAR(9),
    letter_grade CHAR(2),
    PRIMARY KEY(roll_number),
    Foreign Key (roll_number) REFERENCES cs246_student(roll_number)
);

-- Task 03
SET GLOBAL LOCAL_INFILE=1;

-- a
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-8/cs245_student.csv' 
INTO TABLE cs245_student
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- b
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-8/cs245_marks.csv' 
INTO TABLE cs245_marks
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- c
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-8/cs245_grade.csv' 
INTO TABLE cs245_grade
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- d
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-8/cs246_student.csv' 
INTO TABLE cs246_student
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- e
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-8/cs246_marks.csv' 
INTO TABLE cs246_marks
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- f
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-8/cs246_grade.csv' 
INTO TABLE cs246_grade
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 04

-- a
CREATE user 'headTA'@'localhost' IDENTIFIED BY 'headTA1@iitg';

-- b
CREATE user 'saradhi'@'localhost' IDENTIFIED BY 'Saradhi1@iitg';

-- c
CREATE user 'pbhaduri'@'localhost' IDENTIFIED BY 'pbhaduriTA1@iitg';

-- d
CREATE user 'doaa'@'localhost' IDENTIFIED BY 'Doaa1508@iitg';

-- Task 05 a
GRANT SELECT,INSERT,UPDATE on week08.cs245_marks TO 'headTA'@'localhost';
GRANT SELECT,INSERT,UPDATE on week08.cs246_marks TO 'headTA'@'localhost';
GRANT SELECT,UPDATE on week08.cs246_grade TO 'saradhi'@'localhost';
GRANT SELECT,UPDATE on week08.cs245_grade TO 'pbhaduri'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE on week08.cs245_student TO 'doaa'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE on week08.cs246_student TO 'doaa'@'localhost';

-- Task 05 b

-- i
-- As headTA
SELECT marks 
FROM cs246_marks
WHERE roll_number = '270123065';

-- ii
DELETE FROM cs245_marks where roll_number = '210123065';
--DELETE command denied to user 'headTA'@'localhost' for table 'cs245_marks'

-- iii
-- As Saradhi
DELETE FROM cs246_grade WHERE roll_number = '270101005';
-- DELETE command denied to user 'saradhi'@'localhost' for table 'cs246_grade'

-- iv
UPDATE cs246_grade SET letter_grade = 'BC' WHERE roll_number = '270101005';

-- v
-- As PBhaduri
UPDATE cs245_marks SET marks = '95' WHERE roll_number = '270101064'; 
-- UPDATE command denied to user 'pbhaduri'@'localhost' for table 'cs245_marks'

-- vi
SELECT letter_grade FROM cs245_grade WHERE roll_number = '270101064';

-- vii
-- As DOAA
INSERT INTO cs245_student VALUES ('270123089', 'Alex', 'Approved', 'Credit', 'alex@protonmail.edu', '960-7830');

-- viii
INSERT INTO cs245_marks VALUES('270123089', '67');
-- INSERT command denied to user 'doaa'@'localhost' for table 'cs245_marks'

-- As saradhi
-- ix
UPDATE cs245_grade SET letter_grade = 'DD' WHERE roll_number = '270101053';
-- UPDATE command denied to user 'saradhi'@'localhost' for table 'cs245_grade'

-- x
-- As pbhaduri
DELETE FROM CS246_grade WHERE roll_number in  ('270101004',
'270101019', '270101029', '270101039', '270101049', '270101059');
-- DELETE command denied to user 'pbhaduri'@'localhost' for table 'CS246_grade'

-- Task 06 

-- a

GRANT SELECT (roll_number, name, email) on week08.cs245_student TO 'headTA'@'localhost';
GRANT SELECT (roll_number, name, email) on week08.cs246_student TO 'headTA'@'localhost';

GRANT SELECT (roll_number, name, email) on week08.cs245_student TO 'pbhaduri'@'localhost';

GRANT SELECT (roll_number, name, email) on week08.cs246_student TO 'saradhi'@'localhost';

GRANT SELECT (roll_number, name, reg_status, audit_credit),
    INSERT (roll_number, name, reg_status, audit_credit),
    UPDATE (roll_number, name, reg_status, audit_credit) on cs246_student
    TO 'doaa'@'localhost';

-- vii
-- As PBhaduri
UPDATE cs245_student SET reg_status = 'Approved' and audit_credit = 'Audit' WHERE email LIKE '%icloud.couk';
-- UPDATE command denied to user 'pbhaduri'@'localhost' for table 'cs245_student'

-- viii
SELECT email,letter_grade
FROM cs245_student
JOIN cs245_grade ON cs245_grade.roll_number = cs245_student.roll_number
WHERE name LIKE 'Benedict Warren';

-- As Saradhi
-- v
UPDATE cs246_student SET roll_number = '290101051' WHERE roll_number = '270101051';
-- UPDATE command denied to user 'saradhi'@'localhost' for table 'cs246_student'

-- vi
SELECT email, marks 
FROM cs246_student c
JOIN cs246_marks s ON s.roll_number = c.roll_number
WHERE name = 'Garrison Donovan'
-- SELECT command denied to user 'saradhi'@'localhost' for table 'cs246_marks'

-- As headTA
-- i
SELECT email, phone 
FROM cs245_student
WHERE name = 'Craig Salazar';
-- SELECT command denied to user 'headTA'@'localhost' for table 'cs246_student'

-- ii
SELECT roll_number, email 
FROM cs245_student
WHERE name = 'Lionel Battle';

-- iii
DELETE FROM cs246_student WHERE name = 'Jenette Parks';
-- DELETE command denied to user 'headTA'@'localhost' for table 'cs246_student'

-- iv
UPDATE cs246_student SET email = 'jparks@aol.ca' WHERE name = 'Jenette Parks';
-- UPDATE command denied to user 'headTA'@'localhost' for table 'cs246_student'

-- As doaa
-- ix
INSERT INTO cs246_student(roll_number, name,reg_status, phone) VALUES('270123436', 'Anjali', 'Pending', '844-5838');

-- x
UPDATE cs245_student SET audit_credit = 'Audit' WHERE email = 'semper.tellus.id@google.net';

-- Task 07

-- As headTA
-- b
CREATE VIEW headTA1 AS
    SELECT roll_number, name, email, marks
    FROM cs245_student s
    JOIN cs245_marks c ON c.roll_number = s.roll_number;
-- CREATE VIEW command denied to user 'headTA'@'localhost' for table 'headTA1'

-- c
CREATE VIEW headTA2 AS
    SELECT roll_number, name, email, letter_grade
    FROM cs245_student s
    JOIN cs245_grade c ON c.roll_number = s.roll_number;
-- CREATE VIEW command denied to user 'headTA'@'localhost' for table 'headTA2'

-- d ii
UPDATE cs245_grade SET leter_grade = 'AA' WHERE NAME LIKE 'Zenainda Fleming';
-- UPDATE command denied to user 'headTA'@'localhost' for table 'cs245_grade'

-- As saradhi
-- a
CREATE View saradhi1 AS
    SELECT roll_number, name,email, letter_grade
    FROM cs246_student c 
    JOIN cs246_grade s ON c.roll_number = s.roll_number;
-- CREATE VIEW command denied to user 'saradhi'@'localhost' for table 'saradhi1'

-- d i
DELETE FROM saradhi1 WHERE mail = 'quisque.porttitor@google.couk';
-- DELETE command denied to user 'saradhi'@'localhost' for table 'saradhi1'

-- Task 08

-- As root
-- a
GRANT GRANT OPTION on cs246_grade TO 'saradhi'@'localhost';
-- successful

-- As saradhi
-- b
GRANT SELECT on cs246_grade to 'headTA'@'localhost';
-- successful

-- As headTA
-- c
SELECT a.roll_number, name, email, marks, letter_grade
FROM cs246_student a
JOIN cs246_marks b ON a.roll_number = b.roll_number
JOIN cs246_grade c ON a.roll_number = c.roll_number;
-- successful

-- Task 09

-- As saradhi
-- a
REVOKE SELECT on cs246_grade FROM 'headTA'@'localhost';
--successful

-- As headTA
-- b
SELECT a.roll_number, name, email, marks, letter_grade
FROM cs246_student a
JOIN cs246_marks b ON a.roll_number = b.roll_number
JOIN cs246_grade c ON a.roll_number = c.roll_number;
-- SELECT command denied to user 'headTA'@'localhost' for table 'cs246_grade'

-- As Doaa
-- c
-- Assumed to revoke from headTA
REVOKE SELECT(roll_number, name, reg_status, audit_credit),
    INSERT(roll_number, name, reg_status, audit_credit),
    UPDATE(roll_number, name, reg_status, audit_credit)
    ON cs246_student
    FROM 'headTA'@'localhost';
-- GRANT command denied to user 'doaa'@'localhost' for table 'cs246_student'

-- d
REVOKE SELECT (roll_number, name, email) on week08.cs245_student FROM 'headTA'@'localhost';
REVOKE SELECT (roll_number, name, email) on week08.cs246_student FROM 'headTA'@'localhost';

REVOKE SELECT (roll_number, name, email) on week08.cs245_student FROM 'pbhaduri'@'localhost';

REVOKE SELECT (roll_number, name, email) on week08.cs246_student FROM 'saradhi'@'localhost';

REVOKE SELECT (roll_number, name, reg_status, audit_credit),
    INSERT (roll_number, name, reg_status, audit_credit),
    UPDATE (roll_number, name, reg_status, audit_credit) on cs246_student
    FROM 'doaa'@'localhost';

-- e
REVOKE SELECT, INSERT, UPDATE on week08.cs245_marks FROM 'headTA'@'localhost';

REVOKE SELECT, INSERT, UPDATE on week08.cs246_marks FROM 'headTA'@'localhost';

REVOKE SELECT, UPDATE on week08.cs246_grade FROM 'saradhi'@'localhost';

REVOKE SELECT, UPDATE on week08.cs245_grade FROM 'pbhaduri'@'localhost';

REVOKE SELECT, INSERT, UPDATE, DELETE on week08.cs245_student FROM 'doaa'@'localhost';

REVOKE SELECT, INSERT, UPDATE ,DELETE on week08.cs246_student FROM 'doaa'@'localhost';

-- Task 10

-- a
DROP user 'headTA'@'localhost';

-- b
DROP user 'pbhaduri'@'localhost';

-- c
DROP user 'saradhi'@'localhost';

--d
DROP user 'doaa'@'localhost';

-- e
SELECT user FROM mysql.user;

