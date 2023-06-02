--Task 01
CREATE DATABASE week10;
use week10;

--Task 02 a
create Table student18(
    name char(100),
    roll_number char(10),
    cpi FLOAT DEFAULT 0.0,
    PRIMARY KEY(roll_number)
);

--Task 02 b
create Table course18(
    semester INT,
    cid CHAR(7),
    name CHAR(100),
    l INT,
    t INT,
    p INT,
    c INT,
    PRIMARY KEY(cid)
);

--Task 02 c
create Table grade18(
    roll_number char(10),
    cid CHAR(7),
    letter_grade CHAR(2),
    PRIMARY KEY(roll_number,cid)
);

--Task 02 d
create Table curriculum(
    dept char(4),
    number INT,
    cid CHAR(7)
);

--Task 02 e
CREATE TABLE grade_point(
    letter_grade CHAR(2),
    val INT,
    PRIMARY KEY(letter_grade)
);

--Task 02 f
CREATE TABLE trigger_log(
    my_action CHAR(10),
    roll_number CHAR(10),
    semester INT,
    SPI DECIMAL(4,2),
    CPI DECIMAL(4,2),
    check (my_action in ('INSERT', 'UPDATE', 'DELETE'))
    --Foreign Key (semester) REFERENCES course18(semester) CANNOT DECLARE FOREIGN KEY AS SEMESTER IS NOT PRIMARY KEY IN COURSE18
);

--Task 02 g
CREATE TABLE transcript(
    roll_number CHAR(10),
    semester INT,
    SPI DECIMAL(4,2),
    CPI DECIMAL(4,2)
);

--Task 02 g
create Table u_grade18(
    roll_number char(10),
    cid CHAR(7),
    letter_grade CHAR(2),
    PRIMARY KEY(roll_number,cid)
);


set GLOBAL local_infile=1;

--Task 03 a
LOAD DATA LOCAL INFILE  'Desktop/Lab/CS 246/assignment-10/student18.csv' 
INTO TABLE student18
FIELDS TERMINATED BY ','
LINES TERMINATED by '\n'; 

--Task 03 b
LOAD DATA LOCAL INFILE  'Desktop/Lab/CS 246/assignment-10/course18.csv' 
INTO TABLE course18
FIELDS TERMINATED BY ','
LINES TERMINATED by '\n'; 

--Task 03 c
LOAD DATA LOCAL INFILE  'Desktop/Lab/CS 246/assignment-10/curriculum.csv' 
INTO TABLE curriculum
FIELDS TERMINATED BY ','
LINES TERMINATED by '\n'; 

--Task 03 d
LOAD DATA LOCAL INFILE  'Desktop/Lab/CS 246/assignment-10/u_grade18.csv' 
INTO TABLE u_grade18
FIELDS TERMINATED BY ','
LINES TERMINATED by '\n'; 

--Task 03 e
INSERT INTO grade_point VALUES 
                                ('AS',10),
                                ('AA',10),
                                ('AB',9),
                                ('BB',8),
                                ('BC',7),
                                ('CC',6),
                                ('CD',5),
                                ('DD',4),
                                ('FP',0),
                                ('FA',0),
                                ('I',0),
                                ('X',0),
                                ('PP',0),
                                ('NP',0);

--Task 03 f
LOAD DATA LOCAL INFILE  'Desktop/Lab/CS 246/assignment-10/transcript.csv' 
INTO TABLE transcript
FIELDS TERMINATED BY ','
LINES TERMINATED by '\n'; 

--  Task 04 a i

CREATE Trigger trigger1 
BEFORE INSERT on grade18
FOR EACH ROW
BEGIN
DECLARE trig CONDITION for SQLSTATE '50001';
    IF NEW.letter_grade not in (SELECT letter_grade from grade_point)
    THEN 
    SIGNAL trig
    SET MESSAGE_TEXT='Wrong Grade Entry';
    end IF;
END;

-- Task 04 ii
CREATE Trigger trigger2 AFTER INSERT on grade18
FOR EACH ROW
BEGIN
    DECLARE chec int DEFAULT 0;
    SELECT c FROM course18 WHERE cid = new.cid into chec;
    if( chec > 0) THEN
    UPDATE transcript
    SET CPI=(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=NEW.roll_number and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade )
    WHERE transcript.roll_number=NEW.roll_number ;
    UPDATE transcript
    SET SPI=(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=NEW.roll_number and course.semester=(SELECT semester FROM course18 where course18.cid=NEW.cid)and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade and c != 0)
    WHERE transcript.roll_number=NEW.roll_number and transcript.semester in (SELECT semester FROM course18 where course18.cid=NEW.cid);
    INSERT into trigger_log values('INSERT',new.roll_number,(SELECT semester FROM course18 where course18.cid=NEW.cid),(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=NEW.roll_number and course.semester=(SELECT semester FROM course18 where course18.cid=NEW.cid)and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade),(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=NEW.roll_number and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade));
    END IF;
END;

-- Task 04 b 
CREATE Trigger trigger3 BEFORE UPDATE on grade18
for each row 
BEGIN
DECLARE trig CONDITION for SQLSTATE '50001';
    IF NEW.letter_grade not in (SELECT letter_grade from grade_point)
    THEN 
    SIGNAL trig
    SET MESSAGE_TEXT='Wrong Grade Entry';
    end IF;
END;

-- Task 04b ii
CREATE Trigger trigger4 AFTER UPDATE on grade18
FOR EACH ROW
BEGIN
    DECLARE chec int DEFAULT 0;
    SELECT c FROM course18 WHERE cid = new.cid into chec;
    if( chec > 0) THEN
    UPDATE transcript
    SET CPI=(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=NEW.roll_number and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade )
    WHERE transcript.roll_number=NEW.roll_number ;
    UPDATE transcript
    SET SPI=(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=NEW.roll_number and course.semester=(SELECT semester FROM course18 where course18.cid=NEW.cid)and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade ) 
    WHERE transcript.roll_number=NEW.roll_number and transcript.semester in (SELECT semester FROM course18 where course18.cid=NEW.cid);
    INSERT into trigger_log values('UPDATE',new.roll_number,(SELECT semester FROM course18 where course18.cid=NEW.cid),(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=NEW.roll_number and course.semester=(SELECT semester FROM course18 where course18.cid=NEW.cid)and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade),(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=NEW.roll_number and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade));
    END if;
END;

--Task 04 c i

CREATE Trigger trigger5 BEFORE DELETE on grade18
for each row 
BEGIN
DECLARE trig CONDITION for SQLSTATE '50001';
    IF OLD.letter_grade not in (SELECT letter_grade from grade_point)
    THEN 
    SIGNAL trig
    SET MESSAGE_TEXT='Wrong Grade Entry';
    end IF;
END;

-- Task 04 c ii
CREATE Trigger trigger6 AFTER DELETE on grade18
FOR EACH ROW
BEGIN
    if( SELECT sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=OLD.roll_number and course.semester=(SELECT semester FROM course18 where course18.cid=OLD.cid)and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade  > 0) THEN
    UPDATE transcript
    SET CPI=(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=OLD.roll_number and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade and c != 0)
    WHERE transcript.roll_number=OLD.roll_number ;
    UPDATE transcript
    SET SPI=(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=OLD.roll_number and course.semester=(SELECT semester FROM course18 where course18.cid=OLD.cid)and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade and c != 0)
    WHERE transcript.roll_number=OLD.roll_number and transcript.semester in (SELECT semester FROM course18 where course18.cid=OLD.cid and c != 0);
    INSERT into trigger_log values('DELETE',OLD.roll_number,(SELECT semester FROM course18 where course18.cid=OLD.cid),(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=OLD.roll_number and course.semester=(SELECT semester FROM course18 where course18.cid=OLD.cid)and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade),(SELECT sum(grade.val*course.c)/sum(course.c)
                FROM course18 as course,grade_point as grade,grade18 
                WHERE grade18.roll_number=OLD.roll_number and grade18.cid=course.cid and grade.letter_grade=grade18.letter_grade and c != 0));
    end if;
END;

-- Task 05 
LOAD DATA LOCAL INFILE  'Desktop/Lab/CS 246/assignment-10/grade18.csv' 
INTO TABLE grade18
FIELDS TERMINATED BY ','
LINES TERMINATED by '\n';

-- Task 06
update grade18 set grade18.letter_grade = (select u_grade18.letter_grade from u_grade18 where u_grade18.roll_number = grade18.roll_number and u_grade18.cid = grade18.cid) 
WHERE EXISTS (select u_grade18.letter_grade from u_grade18 where u_grade18.roll_number = grade18.roll_number and u_grade18.cid = grade18.cid);

SELECT * FROM trigger_log;

-- Task 07
DELETE from grade18;


