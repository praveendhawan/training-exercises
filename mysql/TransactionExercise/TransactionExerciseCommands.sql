CREATE DATABASE bank;
-- Query OK, 1 row affected (0.00 sec)

USE bank;
-- Database changed

CREATE TABLE users(
  -> id VARCHAR(10) NOT NULL UNIQUE,
  -> account_no INT(5) NOT NULL AUTO_INCREMENT,
  -> name VARCHAR(20),
  -> email VARCHAR(30),
  -> PRIMARY KEY(account_no)
  -> );
-- Query OK, 0 rows affected (0.16 sec)
CREATE TABLE accounts(
  -> id VARCHAR(10) NOT NULL UNIQUE,
  -> account_no INT(5),
  -> balance FLOAT(5,2),
  -> PRIMARY KEY(id),
  -> FOREIGN KEY (account_no) REFERENCES users(account_no)
  -> );
-- Query OK, 0 rows affected (0.17 sec)
INSERT INTO users
  -> VALUES('user1', 100, 'Praveen', 'praveen@vinsol.com'),
  -> ('user2', 101, 'Ram', 'ram@gmail.com'),
  -> ('user3', 102, 'Shyam', 'shyam@hotmail.com');
-- Query OK, 3 rows affected (0.11 sec)
-- Records: 3  Duplicates: 0  Warnings: 0
INSERT INTO accounts
  -> VALUES('account1', 100, 3000.00),
  -> ('account2', 101, 2000.00),
  -> ('account3', 102, 1200.00);
-- Query OK, 3 rows affected, 3 warnings (0.10 sec)
-- Records: 3  Duplicates: 0  Warnings: 

SELECT * FROM accounts;
-- +----------+------------+---------+
-- | id       | account_no | balance |
-- +----------+------------+---------+
-- | account1 |        100 | 1300.00 |
-- | account2 |        101 | 2200.00 |
-- | account3 |        102 | 3000.00 |
-- +----------+------------+---------+
-- 3 rows in set (0.00 sec)

-- i) userA is depositing 1000 Rs. his account
-- ii) userA is withdrawing 500 Rs.
-- iii) userA is transferring 200 Rs to userB's account

START TRANSACTION;
-- Query OK, 0 rows affected (0.00 sec)

UPDATE accounts
  -> SET balance = balance + 1000.00
  -> WHERE account_no = 100;
-- Query OK, 1 row affected (0.15 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

UPDATE accounts
  -> SET balance = balance - 500.00
  -> WHERE account_no = 100;
-- Query OK, 1 row affected (0.00 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

SET @amount := 200;
-- Query OK, 0 rows affected (0.00 sec)

UPDATE accounts
  -> SET balance = balance - @amount
  -> WHERE account_no = 100;
-- Query OK, 1 row affected (0.00 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

UPDATE accounts
  -> SET balance = balance + @amount
  -> WHERE account_no = 101;
-- Query OK, 1 row affected (0.00 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

COMMIT;
-- Query OK, 0 rows affected (0.04 sec)

SELECT * FROM accounts;
-- +----------+------------+---------+
-- | id       | account_no | balance |
-- +----------+------------+---------+
-- | account1 |        100 | 1600.00 |
-- | account2 |        101 | 2400.00 |
-- | account3 |        102 | 3000.00 |
-- +----------+------------+---------+
-- 3 rows in set (0.00 sec)
