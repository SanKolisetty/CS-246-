CREATE DATABASE week04 ;

CREATE TABLE hss_table01(
    sno INT,
    roll_number CHAR(50),
    sname CHAR(50),
    cid CHAR(10),
    cname char(60)
);

CREATE TABLE hss_table02(
    sno INT,
    roll_number CHAR(50),
    sname CHAR(50),
    cid CHAR(10),
    cname char(60),
    PRIMARY KEY(cname)
);

CREATE TABLE hss_table03(
    sno INT,
    roll_number CHAR(50),
    sname CHAR(50),
    cid CHAR(10),
    cname char(60),
    PRIMARY KEY(roll_number, cid)
);

CREATE TABLE hss_table04(
    sno INT,
    roll_number CHAR(50),
    sname CHAR(50),
    cid CHAR(10),
    cname char(60),
    PRIMARY KEY(roll_number)
);

ALTER TABLE hss_table04
ADD PRIMARY KEY (sno);

CREATE Table hss_course01(
    cid CHAR(10),
    cname char(60),
    PRIMARY KEY (cid)
);

CREATE TABLE hss_table05(
    sno INT,
    roll_number CHAR(50),
    sname CHAR(50),
    cid CHAR(10),
    cname char(60),
    PRIMARY KEY(roll_number),
    Foreign Key (cid) REFERENCES hss_course01(cid)
);

CREATE Table hss_course02(
    cid CHAR(10),
    cname char(60),
    PRIMARY KEY (cname)
);

CREATE TABLE hss_table06(
    sno INT,
    roll_number CHAR(50),
    sname CHAR(50),
    cid CHAR(10),
    cname char(60),
    PRIMARY KEY(roll_number),
    Foreign Key (cid) REFERENCES hss_course02(cid)
    -- Failed to add the foreign key constraint. Missing index for constraint 'hss_table06_ibfk_1' in the 
    -- referenced table 'hss_course02'
);

CREATE Table hss_course03(
    cid CHAR(10),
    cname char(60)
);

CREATE TABLE hss_table07(
    sno INT,
    roll_number CHAR(50),
    sname CHAR(50),
    cid CHAR(10),
    cname char(60),
    PRIMARY KEY(roll_number),
    Foreign Key (cid) REFERENCES hss_course03(cid)
    -- Failed to add the foreign key constraint. Missing index for constraint 'hss_table07_ibfk_1' 
    -- in the referenced table 'hss_course03'
);
