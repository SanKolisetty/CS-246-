-- Task01
CREATE DATABASE week09;

USE week09;

-- Task 02 a
CREATE TABLE student18(
    name CHAR(100),
    roll_number CHAR(10),
    PRIMARY KEY(roll_number)
);

-- Task 02 b
CREATE TABLE course18(
    semester INT,
    cid CHAR(7),
    name CHAR(100),
    l INT,
    t INT,
    p INT,
    c INT,
    PRIMARY KEY(cid)
);

-- Task 02 c
CREATE TABLE grade18(
    roll_number CHAR(10),
    cid CHAR(7),
    letter_grade CHAR(2),
    PRIMARY KEY(roll_number, cid)
);

-- Task 02 d
CREATE TABLE curriculum(
    dept CHAR(3),
    number INT,
    cid CHAR(7)
);

SET GLOBAL LOCAL_INFILE=1;

-- Task 04 a
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-9/student18.csv'
INTO TABLE student18
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- Task 04 b
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-9/course18.csv'
INTO TABLE course18
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- Task 04 c
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-9/grade18.csv'
INTO TABLE grade18
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- Task 04 d
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-9/curriculum.csv'
INTO TABLE curriculum
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

SELECT sum(cou.c * CASE letter_grade WHEN 'AA' then 10 WHEN 'AB' then 9 WHEN
            'BB' then 8 WHEN 'BC' then 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) as creds, sum(cou.c) as total
FROM grade18 g 
JOIN course18 cou ON g.cid = cou.cid
WHERE cou.semester = 1 and roll_number = "180101002";

SELECT cid
FROM curriculum
WHERE number = 2 and (cid not LIKE 'HS101' AND cid NOT LIKE 'SA%' AND cid NOT LIKE 'HS200' AND cid NOT LIKE 'HS1%' AND cid NOT LIKE '%M')
EXCEPT
SELECT cid 
FROM student18 s
JOIN grade18 g ON g.roll_number = s.roll_number
WHERE g.roll_number = "180101023";

SELECT cid
FROM curriculum
WHERE number = 5 and (cid LIKE 'CS5%' OR cid LIKE 'CS6%' OR cid LIKE 'CS7%' OR cid LIKE 'CSXXX')
EXCEPT
SELECT cid 
FROM student18 s
JOIN grade18 g ON g.roll_number = s.roll_number
WHERE g.roll_number = "180101023" ;

SELECT cid
FROM curriculum
WHERE number = 6 and (cid LIKE '%M')
EXCEPT
SELECT cid 
FROM student18 s
JOIN grade18 g ON g.roll_number = s.roll_number
WHERE g.roll_number = "180101052" ;

SELECT cid
FROM curriculum
WHERE number = 1 and (cid LIKE 'HS%')
EXCEPT
SELECT g.cid 
FROM student18 s
JOIN grade18 g ON g.roll_number = s.roll_number
JOIN course18 c ON c.cid = g.cid
WHERE g.roll_number = "180101002" and semester = 1

