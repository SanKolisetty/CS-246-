-- Task 00 Drop Database
DROP DATABASE week07;

-- Task 01 - Create Database
CREATE DATABASE week07;

-- Use Database
USE week07;

-- Task 02 a
CREATE TABLE student18a(
    name CHAR(100),
    roll_number CHAR(10),
    PRIMARY KEY(roll_number)
);

-- Task 02 b
CREATE TABLE course18a(
    semester INT,
    cid CHAR(7),
    name CHAR(100),
    l INT,
    t INT,
    p INT,
    c INT,
    PRIMARY KEY(cid)
);

-- Task 2 c
CREATE TABLE grade18a(
    roll_number CHAR(10),
    cid CHAR(7),
    letter_grade CHAR(2),
    PRIMARY KEY(roll_number,cid)
);

SET GLOBAL LOCAL_INFILE=1;

-- Task 03 - Populating data
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/student18.csv' 
INTO TABLE student18a
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/course18.csv' 
INTO TABLE course18a
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/grade18.csv' 
INTO TABLE grade18a
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 04 a
CREATE VIEW minor_courses AS
    SELECT  *
    FROM grade18a
    WHERE cid LIKE '%M';

SELECT * FROM minor_courses;
-- 790 rows

INSERT INTO grade18a VALUES('180101000', 'CS 101', 'AB');

SELECT * FROM minor_courses WHERE roll_number = '180101000';
--INo, it's not materialized

-- Task 04 b
CREATE VIEW distinct_values AS
    SELECT cid, letter_grade 
    FROM grade18a
    GROUP BY cid, letter_grade;

SELECT * FROM distinct_values;
-- 442 rows

INSERT INTO distinct_values VALUES('CS101', 'PM');
-- It doesn't even insert
-- The view is not updatable

-- Task 04 c
CREATE VIEW number_of_students AS
    SELECT cid, letter_grade, count(letter_grade) 
    FROM grade18a
    GROUP BY cid, letter_grade;

SELECT * FROM number_of_students;
-- 442 ROWS

INSERT INTO number_of_students VALUES('CS 101', 'NP', '17');
-- It's not insertable in to the view

-- Task 05 a i
CREATE TABLE course18b(
    semester INT,
    cid CHAR(7),
    name CHAR(100),
    l INT,
    t INT,
    p INT,
    c INT,
    PRIMARY KEY(cid),
    check (semester in (1,2,3,4,5,6,7,8))
);

-- Task 05 a ii
INSERT INTO course18b VALUES(10, 'CS 777', 'Introduction to Chat GPT', 3, 0, 0, 6);
-- Can't be inserted because check is violated

-- Task 05 b 
CREATE TABLE allowable_letter_grade(
    grade CHAR(2),
    value INT
);

INSERT INTO allowable_letter_grade VALUES('AS',10);
INSERT INTO allowable_letter_grade VALUES('AA',10);
INSERT INTO allowable_letter_grade VALUES('AB',9);
INSERT INTO allowable_letter_grade VALUES('BB',8);
INSERT INTO allowable_letter_grade VALUES('BC',7);
INSERT INTO allowable_letter_grade VALUES('CC',6);
INSERT INTO allowable_letter_grade VALUES('CD',5);
INSERT INTO allowable_letter_grade VALUES('DD',4);
INSERT INTO allowable_letter_grade VALUES('FP',0);
INSERT INTO allowable_letter_grade VALUES('FA',0);
INSERT INTO allowable_letter_grade VALUES('NP',0);
INSERT INTO allowable_letter_grade VALUES('PP',0);
INSERT INTO allowable_letter_grade VALUES('I',0);
INSERT INTO allowable_letter_grade VALUES('X',0);

SELECT * FROM allowable_letter_grade;

-- Task 05 c i
CREATE TABLE grade18b(
    roll_number CHAR(10),
    cid CHAR(7),
    letter_grade CHAR(2),
    PRIMARY KEY(roll_number,cid),
    check(letter_grade in ('AS', 'AB', 'BB', 'BC', 'CC', 'CD', 'DD','FP', 'FA', 'NP', 'PP', 'I', 'X'))
);

-- Task 05 c ii
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/grade18.csv' 
INTO TABLE grade18b
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';
-- 8531 rows

-- Task 05 c iii
UPDATE grade18b
    set letter_grade = 'MP'
    WHERE letter_grade = 'DD' AND cid = 'XX102M';
-- Can't be updated since the check constraint is violated

-- Task 06 a
CREATE TABLE student18c(
    name CHAR(100),
    roll_number CHAR(10),
    constraint stu18b_constr PRIMARY KEY(roll_number)
);

-- Task 06 b
CREATE TABLE grade18c(
    roll_number CHAR(10),
    cid CHAR(7),
    letter_grade CHAR(2),
    constraint gra18b_constr PRIMARY KEY(roll_number,cid),
    constraint gra18b_foreign FOREIGN KEY(roll_number) REFERENCES student18c(roll_number)
);

-- Task 06 c
ALTER TABLE grade18c
DROP constraint gra18b_foreign;

-- Task 07 a
CREATE TABLE student18d(
    name CHAR(100),
    roll_number CHAR(10),
    PRIMARY KEY(roll_number)
);

-- Task 07 b
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/student18.csv' 
INTO TABLE student18d
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 07 c
SELECT sum(convert(roll_number,UNSIGNED INT)) AS sum, min(convert(roll_number,UNSIGNED INT)) AS minimum, max(convert(roll_number,UNSIGNED INT)) AS maximum, avg(convert(roll_number,UNSIGNED INT)) AS average
FROM student18d;

-- Task 07 d
SELECT convert(roll_number, DATETIME) 
FROM student18d;

-- Task 08 a
CREATE TABLE course18e LIKE course18a;

-- Task 08 b
INSERT INTO course18e 
SELECT * FROM course18a;

-- Task 09 a i
CREATE TABLE student18f(
    roll_number CHAR(10),
    name CHAR(100),
    redundant01 INT DEFAULT 10,
    PRIMARY KEY(roll_number)
);

-- Task 09 a ii
CREATE TABLE course18f(
    semester INT,
    cid CHAR(7),
    name CHAR(100),
    l INT,
    t INT,
    p INT,
    c INT,
    redundant01 INT DEFAULT 10,
    PRIMARY KEY(cid)
);

-- Task 09 a iii
CREATE TABLE grade18f(
    roll_number CHAR(10),
    cid CHAR(7),
    letter_grade CHAR(2),
    redundant01 INT DEFAULT 10,
    PRIMARY KEY(roll_number,cid)
);

-- Task 09 b i
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/student18.csv' 
INTO TABLE student18f 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(name, roll_number);

-- Task 09 b ii
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/course18.csv' 
INTO TABLE course18f
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(semester, cid, name, l, t, p, c);

-- Task 09 b iii
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/grade18.csv' 
INTO TABLE grade18f
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(roll_number, cid, letter_grade);

-- Task 09 c
SELECT s.roll_number, s.name, g.letter_grade
FROM student18f s
JOIN grade18f g USING (roll_number)
JOIN course18f c USING (cid)
WHERE c.l = 3 AND c.t = 1 AND c.p = 0 AND c.c = 8;
-- 948 rows

-- Task 09 d
DELETE FROM grade18f;

-- Task 09 e
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-7/cs570.csv' 
INTO TABLE grade18f
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

-- Task 09 f
SELECT s.roll_number, s.name, g.letter_grade
FROM student18f s
LEFT OUTER JOIN grade18f g ON s.roll_number = g.roll_number;
-- 160 rows
