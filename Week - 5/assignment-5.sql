-- Task 00 - Drop Database if it already exists
DROP DATABASE week05;

-- Task 01 - Creating Database named Week05 
CREATE DATABASE week05;

USE week05;

-- Task 02 - Create Tables

-- a
CREATE TABLE student(
    cid CHAR(7),
    roll_number CHAR(10),
    name CHAR(100) NOT NULL,
    approval_status CHAR(20),
    credit_status CHAR(10),
    PRIMARY KEY(roll_number, cid)
);

-- b
CREATE TABLE course(
    cid CHAR(7),
    name CHAR(100) NOT NULL,
    PRIMARY KEY (cid)
);

-- c
CREATE TABLE credit(
    cid CHAR(7),
    l INT NOT NULL, 
    t INT NOT NULL,
    p INT NOT NULL,
    c FLOAT NOT NULL,
    PRIMARY KEY(cid)
);

-- Task 03 - Populate Data

-- a
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-5/students-credits.csv' 
INTO TABLE student 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- b
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-5/courses.csv' 
INTO TABLE course 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- c
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-5/credits.csv' 
INTO TABLE credit
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 04 - Queries involving single table

-- a
SELECT * 
FROM student
WHERE name = 'Adarsh Kumar Udai';
-- 8 rows

-- b
SELECT cid, name, credit_status 
FROM student
WHERE cid = 'EE 390' AND credit_status = 'Credit';
-- 183 rows

-- c
SELECT cid, roll_number, credit_status, approval_status 
FROM student
WHERE approval_status = 'Pending' AND credit_status = 'Credit';
-- 39 rows

-- d
SELECT cid, l, t, p, c 
FROM credit
WHERE c != 6;
-- 81 rows

-- e
SELECT roll_number, name, cid, credit_status, approval_status 
FROM student
WHERE credit_status = 'Audit' AND approval_status = 'Approved';
-- 193 rows

-- Task 05 - Queries involving multiple tables

-- a
SELECT co.name, cr.l, cr.t, cr.p, cr.c
FROM credit cr
JOIN course co
    ON co.cid = cr.cid
WHERE c = 8;
-- 24 rows

-- b
SELECT co.name, cr.l, cr.t, cr.p, cr.c
FROM credit cr
JOIN course co
    ON co.cid = cr.cid
WHERE t > 0;
-- 32 rows

-- c
SELECT co.cid, co.name, cr.l, cr.t, cr.p, cr.c
FROM credit cr
JOIN course co
    ON co.cid = cr.cid
WHERE c = 6 AND NOT (l = 3 AND t = 0 AND p = 0);
-- 31 rows

-- d
SELECT s.cid, c.name, s.name, cr.l, cr.t, cr.p, cr.c 
FROM student s
JOIN course c
    ON s.cid = c.cid
JOIN credit cr
    ON cr.cid = c.cid
WHERE s.name = 'Pasch Paul Ole';
-- 2 rows

-- e
SELECT s.roll_number, s.name, s.cid, c.name, cr.l, cr.t, cr.p, cr.c 
FROM student s
JOIN course c
    ON s.cid = c.cid
JOIN credit cr
    ON cr.cid = c.cid
WHERE s.credit_status = 'Credit' 
    AND cr.l = 3 AND cr.t = 1 AND cr.p = 0 AND cr.c = 8
    AND s.cid REGEXP '^EE';
-- 539 rows

-- Task 06 - String Operations

-- a
SELECT student.cid, student.name
FROM student
WHERE UPPER(name) LIKE '%ATUL%';
-- 22 rows

-- b
SELECT s.roll_number, s.credit_status, c.name
FROM student s
JOIN course c 
    ON c.cid = s.cid
JOIN credit cr 
    ON cr.cid = c.cid
WHERE LOWER(c.name) LIKE 'introduction to%';
-- 572 rows

-- c
SELECT COUNT(DISTINCT roll_number)
FROM student
WHERE student.cid LIKE 'EE 3%';
-- 241 students

-- d
SELECT cid, name
FROM course
WHERE course.cid LIKE '____2_M';
-- 60 rows or courses

-- e
SELECT s.name, s.cid, c.name, s.credit_status
FROM student s
JOIN course c 
    ON c.cid = s.cid 
WHERE UPPER(s.name) LIKE 'A%TA' AND s.credit_status = 'Credit';
-- 195 rows

-- My existence :)
SELECT * FROM student
WHERE name = 'Sanjana Siri Kolisetty';
