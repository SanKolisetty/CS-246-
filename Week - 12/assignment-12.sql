-- Task 01
CREATE DATABASE week12;

USE week12;

-- Task 02 a
CREATE TABLE student(
    name CHAR(50),
    IQ INT,
    gender CHAR(1),
    PRIMARY KEY(name)
);

-- Task 02 b
CREATE TABLE speak(
    name CHAR(50),
    language CHAR(50),
    PRIMARY KEY(name, language)
);

SET GLOBAL LOCAL_INFILE=1;

-- Task 03 a
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-12/student.csv'
INTO TABLE student
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- Task 03 b
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-12/speaks.csv'
INTO TABLE speak
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- Task 04 a
WITH number(lang, num) AS 
(SELECT language, count(name) as cnt
FROM speak
GROUP BY language)
SELECT lang, num FROM number where num = (SELECT min(num) FROM number);

-- Task 04 b 
SELECT Lang.language
FROM (SELECT language, RANK() OVER (ORDER BY count(name)) as ranking
    FROM speak
    GROUP BY language) as Lang 
WHERE Lang.ranking = 1;

-- Task 05 a
with number_lang(student_name, num_lang_spoken) AS 
(SELECT student.name, count(language) as number 
FROM student
JOIN speak ON student.name = speak.name
GROUP BY student.name
ORDER BY number DESC)
SELECT student_name, num_lang_spoken 
FROM number_lang
WHERE num_lang_spoken = (SELECT max(num_lang_spoken) FROM number_lang);

-- Task 05 b
SELECT lang_spoken.stu_name 
FROM (SELECT student.name as stu_name, RANK() OVER (ORDER BY count(language) DESC) as ranking
    FROM student
    JOIN speak ON student.name = speak.name
    GROUP BY student.name) as lang_spoken
WHERE lang_spoken.ranking  = 1;

-- Task 06 a
with iq_gender(gend, avg_iq) AS
(SELECT gender, avg(IQ)
FROM student
GROUP BY gender)
SELECT gend
FROM iq_gender
where avg_iq = (SELECT max(avg_iq) FROM iq_gender);

-- Task 06 b
SELECT gen.gend 
FROM (SELECT gender as gend, RANK() OVER (ORDER BY avg(IQ) DESC) as ranking
    FROM student
    GROUP BY gender) AS gen
WHERE gen.ranking = 1;

-- Task 07
SELECT japanese.jap_name 
FROM (SELECT student.name as jap_name, RANK() OVER (ORDER BY (IQ) DESC) AS ranking
        from student
        JOIN speak on student.name = speak.name
        WHERE speak.language = "Japanese") as japanese
WHERE japanese.ranking = 1 or japanese.ranking = 2;

-- Task 08
SELECT geniq.gen_name 
FROM (SELECT student.name as gen_name, RANK() OVER(PARTITION BY gender ORDER BY (IQ) DESC) as ranking
        from student) geniq
WHERE geniq.ranking = 1;

