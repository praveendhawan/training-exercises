CREATE DATABASE vtapp;
-- Query OK, 1 row affected (0.00 sec)
CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY 'PASSWORD';
-- Query OK, 0 rows affected (0.06 sec)
GRANT ALL PRIVILEGES ON vtapp.* TO 'vtapp_user'@'localhost' IDENTIFIED BY'PASSWORD';
-- Query OK, 0 rows affected (0.00 sec)
FLUSH PRIVILEGES;
-- Query OK, 0 rows affected (0.00 sec)

> mysql -u vtapp_user -p
  Enter password: 
-- Welcome to the MySQL monitor.  Commands end with ; or \g.
-- Your MySQL connection id is 61
-- Server version: 5.5.44-0ubuntu0.14.04.1 (Ubuntu)

-- Copyright (c) 2000, 2015, Oracle and/or its affiliates. All rights reserved.

-- Oracle is a registered trademark of Oracle Corporation and/or its
-- affiliates. Other names may be trademarks of their respective
-- owners.

-- Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

USE vtapp;
-- Database changed

CREATE TABLE X(
    -> ID INT(1));
-- Query OK, 0 rows affected (0.11 sec)
