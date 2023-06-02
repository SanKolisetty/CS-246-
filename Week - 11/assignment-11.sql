-- Task 01
CREATE DATABASE week11;

USE week11;

-- Task 02 a
CREATE TABLE emp_boss_small(
    ename CHAR(50),
    bname CHAR(50),
    PRIMARY KEY(ename, bname)
);

-- Task 02 b
CREATE TABLE emp_boss_large(
    ename CHAR(50),
    bname CHAR(50),
    PRIMARY KEY(ename, bname)
);

SET GLOBAL LOCAL_INFILE=1;

-- Task 03 a
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-11/week-11-emp_small.csv'
INTO TABLE emp_boss_small
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Task 03 b
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-11/week-11-emp_large.csv'
INTO TABLE emp_boss_large
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE  1 ROWS;

-- Task 04
CREATE PROCEDURE sp2 (IN enamepro CHAR(50), IN data_size CHAR(20))
BEGIN
    IF(data_size = "emp_boss_small")
    THEN
        CREATE TABLE if NOT EXISTS output_bosses_small(ename CHAR(50), bname CHAR(20));
        INSERT INTO output_bosses_small WITH RECURSIVE bosses AS(
        SELECT b.ename, b.bname
        FROM emp_boss_small b
        where b.ename = enamepro

        UNION ALL

        SELECT e.ename, e.bname 
        FROM emp_boss_small e
        JOIN bosses s on e.ename = s.bname
        )
        SELECT enamepro AS ename, bname
        FROM bosses;
    END IF;
    
    IF(data_size = "emp_boss_large")
    THEN
        CREATE TABLE if NOT EXISTS output_bosses_large(ename CHAR(50), bname CHAR(20));
        INSERT INTO output_bosses_large WITH RECURSIVE bosses AS(
        SELECT b.ename, b.bname
        FROM emp_boss_large b
        where b.ename = enamepro

        UNION ALL

        SELECT e.ename, e.bname 
        FROM emp_boss_large e
        JOIN bosses s on e.ename = s.bname
        )
        SELECT enamepro AS ename, bname
        FROM bosses;
    END IF;
END;

-- WITH RECURSIVE bosses AS(
--     SELECT b.ename, b.bname
--     FROM emp_boss_small b
--     where b.ename = "Employee 01"

--     UNION ALL

--     SELECT e.ename, e.bname 
--     FROM emp_boss_small e
--     JOIN bosses s on e.ename = s.bname
-- )
-- SELECT "Employee 01" AS ename, bname
-- FROM bosses;


-- Task 05
CREATE PROCEDURE TASK5()
BEGIN
    DECLARE completed INT DEFAULT FALSE;
    declare emp_name char(50);
    DECLARE cursor_na CURSOR FOR SELECT distinct ename FROM emp_boss_small;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET completed = TRUE;
    OPEN cursor_na;
    loop_through_rows: LOOP
    FETCH cursor_na INTO emp_name;
    IF completed THEN
    LEAVE loop_through_rows;
    END IF;
    call sp2(emp_name,'emp_boss_small');
    END LOOP;
    CLOSE cursor_na;
END;

call TASK5();

SELECT * FROM output_bosses_small;

-- Output of Task 05

-- +-------------+-------------+
-- | ename       | bname       |
-- +-------------+-------------+
-- | Employee 02 | Employee 01 |
-- | Employee 03 | Employee 02 |
-- | Employee 03 | Employee 01 |
-- | Employee 04 | Employee 03 |
-- | Employee 04 | Employee 02 |
-- | Employee 04 | Employee 01 |
-- | Employee 05 | Employee 02 |
-- | Employee 05 | Employee 01 |
-- | Employee 06 | Employee 05 |
-- | Employee 06 | Employee 02 |
-- | Employee 06 | Employee 01 |
-- | Employee 07 | Employee 05 |
-- | Employee 07 | Employee 02 |
-- | Employee 07 | Employee 01 |
-- | Employee 08 | Employee 02 |
-- | Employee 08 | Employee 01 |
-- | Employee 09 | Employee 02 |
-- | Employee 09 | Employee 01 |
-- | Employee 10 | Employee 01 |
-- | Employee 11 | Employee 10 |
-- | Employee 11 | Employee 01 |
-- | Employee 12 | Employee 10 |
-- | Employee 12 | Employee 01 |
-- | Employee 13 | Employee 01 |
-- +-------------+-------------+

-- Task 06
CREATE PROCEDURE TASK6()
BEGIN
    DECLARE completed INT DEFAULT FALSE;
    declare emp_name char(50);
    DECLARE cursor_na CURSOR FOR SELECT distinct ename FROM emp_boss_large;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET completed = TRUE;
    OPEN cursor_na;
    loop_through_rows: LOOP
    FETCH cursor_na INTO emp_name;
    IF completed THEN
    LEAVE loop_through_rows;
    END IF;
    call sp2(emp_name,'emp_boss_large');
    END LOOP;
    CLOSE cursor_na;
END;

call TASK6();

SELECT * FROM output_bosses_large;

-- Output of Task 06

-- +-------------+-------------+
-- | ename       | bname       |
-- +-------------+-------------+
-- | Employee 02 | Employee 01 |
-- | Employee 03 | Employee 02 |
-- | Employee 03 | Employee 01 |
-- | Employee 04 | Employee 03 |
-- | Employee 04 | Employee 02 |
-- | Employee 04 | Employee 01 |
-- | Employee 05 | Employee 02 |
-- | Employee 05 | Employee 01 |
-- | Employee 06 | Employee 05 |
-- | Employee 06 | Employee 02 |
-- | Employee 06 | Employee 01 |
-- | Employee 07 | Employee 06 |
-- | Employee 07 | Employee 05 |
-- | Employee 07 | Employee 02 |
-- | Employee 07 | Employee 01 |
-- | Employee 08 | Employee 06 |
-- | Employee 08 | Employee 05 |
-- | Employee 08 | Employee 02 |
-- | Employee 08 | Employee 01 |
-- | Employee 09 | Employee 06 |
-- | Employee 09 | Employee 05 |
-- | Employee 09 | Employee 02 |
-- | Employee 09 | Employee 01 |
-- | Employee 10 | Employee 06 |
-- | Employee 10 | Employee 05 |
-- | Employee 10 | Employee 02 |
-- | Employee 10 | Employee 01 |
-- | Employee 11 | Employee 05 |
-- | Employee 11 | Employee 02 |
-- | Employee 11 | Employee 01 |
-- | Employee 12 | Employee 11 |
-- | Employee 12 | Employee 05 |
-- | Employee 12 | Employee 02 |
-- | Employee 12 | Employee 01 |
-- | Employee 13 | Employee 11 |
-- | Employee 13 | Employee 05 |
-- | Employee 13 | Employee 02 |
-- | Employee 13 | Employee 01 |
-- | Employee 14 | Employee 11 |
-- | Employee 14 | Employee 05 |
-- | Employee 14 | Employee 02 |
-- | Employee 14 | Employee 01 |
-- | Employee 15 | Employee 11 |
-- | Employee 15 | Employee 05 |
-- | Employee 15 | Employee 02 |
-- | Employee 15 | Employee 01 |
-- | Employee 16 | Employee 05 |
-- | Employee 16 | Employee 02 |
-- | Employee 16 | Employee 01 |
-- | Employee 17 | Employee 16 |
-- | Employee 17 | Employee 05 |
-- | Employee 17 | Employee 02 |
-- | Employee 17 | Employee 01 |
-- | Employee 18 | Employee 16 |
-- | Employee 18 | Employee 05 |
-- | Employee 18 | Employee 02 |
-- | Employee 18 | Employee 01 |
-- | Employee 19 | Employee 16 |
-- | Employee 19 | Employee 05 |
-- | Employee 19 | Employee 02 |
-- | Employee 19 | Employee 01 |
-- | Employee 20 | Employee 05 |
-- | Employee 20 | Employee 02 |
-- | Employee 20 | Employee 01 |
-- | Employee 21 | Employee 02 |
-- | Employee 21 | Employee 01 |
-- | Employee 22 | Employee 21 |
-- | Employee 22 | Employee 02 |
-- | Employee 22 | Employee 01 |
-- | Employee 23 | Employee 02 |
-- | Employee 23 | Employee 01 |
-- | Employee 24 | Employee 01 |
-- | Employee 25 | Employee 24 |
-- | Employee 25 | Employee 01 |
-- | Employee 26 | Employee 25 |
-- | Employee 26 | Employee 24 |
-- | Employee 26 | Employee 01 |
-- | Employee 27 | Employee 24 |
-- | Employee 27 | Employee 01 |
-- | Employee 28 | Employee 01 |
-- | Employee 29 | Employee 28 |
-- | Employee 29 | Employee 01 |
-- | Employee 30 | Employee 29 |
-- | Employee 30 | Employee 28 |
-- | Employee 30 | Employee 01 |
-- | Employee 31 | Employee 30 |
-- | Employee 31 | Employee 29 |
-- | Employee 31 | Employee 28 |
-- | Employee 31 | Employee 01 |
-- | Employee 32 | Employee 30 |
-- | Employee 32 | Employee 29 |
-- | Employee 32 | Employee 28 |
-- | Employee 32 | Employee 01 |
-- | Employee 33 | Employee 30 |
-- | Employee 33 | Employee 29 |
-- | Employee 33 | Employee 28 |
-- | Employee 33 | Employee 01 |
-- | Employee 34 | Employee 29 |
-- | Employee 34 | Employee 28 |
-- | Employee 34 | Employee 01 |
-- | Employee 35 | Employee 34 |
-- | Employee 35 | Employee 29 |
-- | Employee 35 | Employee 28 |
-- | Employee 35 | Employee 01 |
-- | Employee 36 | Employee 29 |
-- | Employee 36 | Employee 28 |
-- | Employee 36 | Employee 01 |
-- | Employee 37 | Employee 29 |
-- | Employee 37 | Employee 28 |
-- | Employee 37 | Employee 01 |
-- | Employee 38 | Employee 28 |
-- | Employee 38 | Employee 01 |
-- | Employee 39 | Employee 38 |
-- | Employee 39 | Employee 28 |
-- | Employee 39 | Employee 01 |
-- | Employee 40 | Employee 38 |
-- | Employee 40 | Employee 28 |
-- | Employee 40 | Employee 01 |
-- | Employee 41 | Employee 28 |
-- | Employee 41 | Employee 01 |
-- | Employee 42 | Employee 41 |
-- | Employee 42 | Employee 28 |
-- | Employee 42 | Employee 01 |
-- | Employee 43 | Employee 42 |
-- | Employee 43 | Employee 41 |
-- | Employee 43 | Employee 28 |
-- | Employee 43 | Employee 01 |
-- | Employee 44 | Employee 41 |
-- | Employee 44 | Employee 28 |
-- | Employee 44 | Employee 01 |
-- | Employee 45 | Employee 44 |
-- | Employee 45 | Employee 41 |
-- | Employee 45 | Employee 28 |
-- | Employee 45 | Employee 01 |
-- | Employee 46 | Employee 41 |
-- | Employee 46 | Employee 28 |
-- | Employee 46 | Employee 01 |
-- | Employee 47 | Employee 41 |
-- | Employee 47 | Employee 28 |
-- | Employee 47 | Employee 01 |
-- | Employee 48 | Employee 28 |
-- | Employee 48 | Employee 01 |
-- | Employee 49 | Employee 01 |
-- +-------------+-------------+

-- Task 05
-- call sp2("Employee 01", "emp_boss_small");
-- call sp2("Employee 02", "emp_boss_small");
-- call sp2("Employee 03", "emp_boss_small");
-- call sp2("Employee 04", "emp_boss_small");
-- call sp2("Employee 05", "emp_boss_small");
-- call sp2("Employee 06", "emp_boss_small");
-- call sp2("Employee 07", "emp_boss_small");
-- call sp2("Employee 08", "emp_boss_small");
-- call sp2("Employee 09", "emp_boss_small");
-- call sp2("Employee 10", "emp_boss_small");
-- call sp2("Employee 11", "emp_boss_small");
-- call sp2("Employee 12", "emp_boss_small");
-- call sp2("Employee 13", "emp_boss_small");

-- Task 06

-- call sp2("Employee 01", "emp_boss_large");
-- call sp2("Employee 02", "emp_boss_large");
-- call sp2("Employee 03", "emp_boss_large");
-- call sp2("Employee 04", "emp_boss_large");
-- call sp2("Employee 05", "emp_boss_large");
-- call sp2("Employee 06", "emp_boss_large");
-- call sp2("Employee 07", "emp_boss_large");
-- call sp2("Employee 08", "emp_boss_large");
-- call sp2("Employee 09", "emp_boss_large");
-- call sp2("Employee 10", "emp_boss_large");
-- call sp2("Employee 11", "emp_boss_large");
-- call sp2("Employee 12", "emp_boss_large");
-- call sp2("Employee 13", "emp_boss_large");
-- call sp2("Employee 14", "emp_boss_large");
-- call sp2("Employee 15", "emp_boss_large");
-- call sp2("Employee 16", "emp_boss_large");
-- call sp2("Employee 17", "emp_boss_large");
-- call sp2("Employee 18", "emp_boss_large");
-- call sp2("Employee 19", "emp_boss_large");
-- call sp2("Employee 20", "emp_boss_large");
-- call sp2("Employee 21", "emp_boss_large");
-- call sp2("Employee 22", "emp_boss_large");
-- call sp2("Employee 23", "emp_boss_large");
-- call sp2("Employee 24", "emp_boss_large");
-- call sp2("Employee 25", "emp_boss_large");
-- call sp2("Employee 26", "emp_boss_large");
-- call sp2("Employee 27", "emp_boss_large");
-- call sp2("Employee 28", "emp_boss_large");
-- call sp2("Employee 29", "emp_boss_large");
-- call sp2("Employee 30", "emp_boss_large");
-- call sp2("Employee 31", "emp_boss_large");
-- call sp2("Employee 32", "emp_boss_large");
-- call sp2("Employee 33", "emp_boss_large");
-- call sp2("Employee 34", "emp_boss_large");
-- call sp2("Employee 35", "emp_boss_large");
-- call sp2("Employee 36", "emp_boss_large");
-- call sp2("Employee 37", "emp_boss_large");
-- call sp2("Employee 38", "emp_boss_large");
-- call sp2("Employee 39", "emp_boss_large");
-- call sp2("Employee 40", "emp_boss_large");
-- call sp2("Employee 41", "emp_boss_large");
-- call sp2("Employee 42", "emp_boss_large");
-- call sp2("Employee 43", "emp_boss_large");
-- call sp2("Employee 44", "emp_boss_large");
-- call sp2("Employee 45", "emp_boss_large");
-- call sp2("Employee 46", "emp_boss_large");
-- call sp2("Employee 47", "emp_boss_large");
-- call sp2("Employee 48", "emp_boss_large");
-- call sp2("Employee 49", "emp_boss_large");











