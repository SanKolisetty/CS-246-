-- Task 00 Drop Database if it exists
DROP DATABASE week06;

-- Task 01 Create Database
CREATE DATABASE week06;

USE week06;

-- Task 02 a Create student table
CREATE TABLE student(
    cid CHAR(7),
    roll_number CHAR(10),
    name CHAR(100) NOT NULL,
    approval_status CHAR(20),
    credit_status CHAR(10),
    PRIMARY KEY(roll_number, cid)
);

-- Task 02 b Create course table
CREATE TABLE course(
    cid CHAR(7),
    name CHAR(100) NOT NULL,
    PRIMARY KEY(cid)
);

-- Task 02 c Create credit table
CREATE TABLE credit(
    cid CHAR(7),
    l INT NOT NULL,
    t INT NOT NULL,
    p INT NOT NULL,
    c FLOAT NOT NULL,
    PRIMARY KEY(cid)
);

DROP TABLE credit;
-- Task 02 d Create faculty table
CREATE TABLE faculty(
    cid CHAR(7),
    name CHAR(50)
);

-- Task 02 e Create semester table
CREATE TABLE semester(
    dept CHAR(4),
    number CHAR(4),
    cid CHAR(7)
);

-- Task 03 Populate Data

-- Task 03 a
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-6/students-credits (1).csv' 
INTO TABLE student 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 03 b
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-6/courses (1).csv' 
INTO TABLE course
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 03 c
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-6/credits (1).csv' 
INTO TABLE credit 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 03 d
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-6/faculty-course.csv' 
INTO TABLE faculty 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 03 e
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-6/semester.csv' 
INTO TABLE semester
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 4 a
SELECT sum(l) AS total_lectures_offered
FROM credit;
-- 816 lectures

-- Task 4 b
SELECT sum(c) 
FROM credit
WHERE cid LIKE 'EE%';
-- 365 credits

-- Task 4 c
SELECT sum(p) 
FROM credit
WHERE cid LIKE 'DD%';
-- 54 hours

-- Task 5 a
SELECT c.cid, COUNT(roll_number)
FROM student s
JOIN course c ON s.cid = c.cid
WHERE c.cid LIKE '%M' AND s.credit_status = 'Audit'
GROUP BY c.cid;
-- 4 rows

-- Task 5 b
SELECT SUBSTRING(cid,1,2) AS Department, SUM(c) AS total_credits
FROM credit 
GROUP BY SUBSTRING(cid,1,2);
-- 9 depts

-- Task 6 a
SELECT s.cid, count(s.roll_number) AS number_of_students
FROM student s
WHERE s.credit_status = 'Audit' 
GROUP BY s.cid
HAVING number_of_students >= 4;
-- 15 courses

-- Task 6 b
SELECT c.cid, c.name, COUNT(f.cid) AS number_of_faculty
FROM course c
JOIN faculty f ON c.cid = f.cid
GROUP BY c.cid
HAVING number_of_faculty > 1;
-- 7 courses

-- Task 6 c
SELECT f.name, COUNT(f.cid) AS number_of_courses
FROM course c
JOIN faculty f ON c.cid = f.cid
GROUP BY f.name
HAVING number_of_courses > 1;
-- 5 professors

-- Task 7 a
WITH min_credits(creds) AS
(SELECT MIN(c) 
FROM credit)
SELECT c.cid, c.name, cr.c
FROM course c, min_credits, credit cr
WHERE c.cid = cr.cid AND cr.c = min_credits.creds;
-- 12 courses

-- Task 7 b
WITH min_credits(creds) AS
(SELECT MIN(c)
FROM credit cr
WHERE cr.cid LIKE 'CS%')
SELECT f.cid, f.name
FROM credit cr, faculty f, min_credits m
WHERE cr.c = m.creds AND cr.cid LIKE 'CS%' AND cr.cid = f.cid;
-- 6 courses

-- Task 8 a
WITH design_creds(number, total_creds) AS
(SELECT s.number AS number, sum(c) AS total_creds
FROM semester s
JOIN credit cr ON s.cid = cr.cid
WHERE s.dept = 'DD'
GROUP BY s.number),
bsbe_creds(number, total_creds) AS
(SELECT s.number AS number, sum(c) AS total_creds
FROM semester s
JOIN credit cr ON s.cid = cr.cid
WHERE s.dept = 'BSBE'
GROUP BY s.number)
SELECT DISTINCT b.number 
FROM bsbe_creds b, design_creds d
WHERE b.total_creds < ANY(SELECT total_creds FROM design_creds);

-- Task 8 b
WITH design_creds(number, total_creds) AS
(SELECT s.number AS number, sum(c) AS total_creds
FROM semester s
JOIN credit cr ON s.cid = cr.cid
WHERE s.dept = 'DD'
GROUP BY s.number),
bsbe_creds(number, total_creds) AS
(SELECT s.number AS number, sum(c) AS total_creds
FROM semester s
JOIN credit cr ON s.cid = cr.cid
WHERE s.dept = 'BSBE'
GROUP BY s.number)
SELECT DISTINCT b.number 
FROM bsbe_creds b, design_creds d
WHERE b.total_creds >= ALL(SELECT total_creds FROM design_creds);

