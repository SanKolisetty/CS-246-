-- Task 01
CREATE DATABASE week14a;

USE week14a;

-- Task 02 a
CREATE TABLE account(
    account_number CHAR(5),
    balance INT,
    original_balance INT,
    PRIMARY KEY(account_number)
);

-- Task 02 b
CREATE TABLE move_funds(
    from_acc CHAR(5),
    to_acc CHAR(5),
    transfer_amount INT
);

-- Task 02 c
CREATE TABLE move_funds_log(
    account_number char(5),
    move_fund_type CHAR(10),
    amount INT,
    timestamp DATETIME,
    Foreign Key (account_number) REFERENCES account(account_number),
    constraint chk check (move_fund_type in ('deposit', 'withdraw'))
);

SET GLOBAL LOCAL_INFILE=1;

-- Task 03 a
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-14/account.csv'
INTO TABLE account
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Task 03 b
LOAD DATA LOCAL INFILE 'Desktop/Lab/CS 246/assignment-14/trnx.csv'
INTO TABLE move_funds
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Task 04 a
CREATE USER 'saradhi'@'localhost' IDENTIFIED BY 'Iamsaradhi1!';

-- Task 04 b
CREATE USER 'pbhaduri'@'localhost' IDENTIFIED BY 'Iambhadurii1!';

-- Task 05 a
GRANT SELECT, INSERT, UPDATE, DELETE on week14a.account TO 'saradhi'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE on week14a.move_funds TO 'saradhi'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE on week14a.move_funds_log TO 'saradhi'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE on week14a.account TO 'pbhaduri'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE on week14a.move_funds TO 'pbhaduri'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE on week14a.move_funds_log TO 'pbhaduri'@'localhost';

-- Task 05 b
GRANT lock TABLES on week14a.* to 'saradhi'@'localhost';
GRANT lock TABLES on week14a.* to 'pbhaduri'@'localhost';

-- Task 06 a
CREATE PROCEDURE transfer_funds_1 (IN from_acc CHAR(5), IN to_acc char(5), IN transfer_amount INTEGER)
BEGIN
    DECLARE amount int;
    SELECT balance FROM account WHERE account_number = from_acc into amount;
    if(amount - transfer_amount >= 0) THEN
    UPDATE account set balance = balance - transfer_amount WHERE account_number = from_acc;
    UPDATE account set balance = balance + transfer_amount WHERE account_number = to_acc;
    end if;
END;

-- Task 05 c
GRANT EXECUTE on procedure week14a.transfer_funds_1 to 'saradhi'@'localhost';

GRANT EXECUTE on procedure week14a.transfer_funds_1 to 'pbhaduri'@'localhost';

-- Task 06 b as saradhi
-- Task 06 i
LOCK TABLES account READ;
-- Task 06 ii
call transfer_funds_1('52149','15873',250);
-- Task 06 iii
UNLOCK TABLES;

-- Task 06 c as pbhaduri
-- Task 06 i
LOCK TABLES account READ;
-- Task 06 ii
call transfer_funds_1('52149','15873',250);
-- Task 06 iii
UNLOCK TABLES;

-- Task 07
CREATE PROCEDURE transfer_funds_2 (IN from_acc CHAR(5), IN to_acc char(5), IN transfer_amount INTEGER)
BEGIN
    START TRANSACTION;
    UPDATE account set balance = balance - transfer_amount WHERE account_number = from_acc;
    UPDATE account set balance = balance + transfer_amount WHERE account_number = to_acc;
    INSERT INTO move_funds_log VALUES(from_acc, 'withdraw', transfer_amount, now());
    INSERT INTO move_funds_log VALUES(to_acc, 'deposit', transfer_amount, now());
    if( (SELECT balance FROM account WHERE account_number = from_acc) >= 100)
    THEN
    COMMIT;
    ELSE
    ROLLBACK;
    END if;
END;

-- Task 05 e
GRANT EXECUTE on PROCEDURE transfer_funds_2 to 'saradhi'@'localhost';
GRANT EXECUTE on PROCEDURE transfer_funds_2 to 'pbhaduri'@'localhost';

-- Task 08
CREATE PROCEDURE main_transfer_2()
BEGIN
    DECLARE cursor_ID INT DEFAULT FALSE;
    DECLARE cursor_from_acc CHAR(5);
    DECLARE cursor_to_acc CHAR(5);
    DECLARE cursor_transfer_amount INT DEFAULT FALSE;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cursor_i CURSOR FOR SELECT from_acc, to_acc, transfer_amount FROM move_funds;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_i;
    read_loop: LOOP
        FETCH cursor_i INTO cursor_from_acc, cursor_to_acc, cursor_transfer_amount;
        IF done THEN
        LEAVE read_loop;
        END IF;
        call transfer_funds_2(cursor_from_acc, cursor_to_acc, cursor_transfer_amount);
    END LOOP;
    CLOSE cursor_i;
END;

-- Task 05 d
GRANT EXECUTE on PROCEDURE main_transfer_2 to 'saradhi'@'localhost';
GRANT EXECUTE on PROCEDURE main_transfer_2 to 'pbhaduri'@'localhost';

-- Task 09 a as saradhi
call main_transfer_2();

-- Task 09 b as pbhaduri
call main_transfer_2();

-- Check
SELECT * FROM move_funds_log;

-- Task 10
CREATE TABLE integrity_check
SELECT account.account_number, account.balance, account.original_balance,
sum(case when move_fund_type = 'withdraw' THEN amount else 0 end) AS total_deposit,
sum(case when move_fund_type = 'deposit' THEN amount else 0 end) AS total_withdraw
FROM account
JOIN move_funds_log ON account.account_number = move_funds_log.account_number
group by account_number;

-- Check;
SELECT * FROM integrity_check;

DROP DATABASE week14a;
