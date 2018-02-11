Create a table named "testing_table" with following fields:

  CREATE DATABASE alterTableExercise;  
    -- Query OK, 1 row affected (0.02 sec)
  USE alterTableExercise;
    -- Database changed
  CREATE TABLE testing_table (
    -> name VARCHAR(20) DEFAULT NULL,
    -> contact_name VARCHAR(20) DEFAULT NULL,
    -> roll_no VARCHAR(10) NOT NULL
    -> );
    -- Query OK, 0 rows affected (0.17 sec)

Delete column name, rename column contact_name to username, add two columns first_name 
and last_name, change the type of roll_no to integer.

 ALTER TABLE testing_table
    -> DROP name,
    -> CHANGE contact_name username VARCHAR(20) DEFAULT NULL,
    -> ADD first_name VARCHAR(20) DEFAULT NULL,
    -> ADD last_name VARCHAR(20) DEFAULT NULL,
    -> MODIFY roll_no INT(10);
    -- Query OK, 0 rows affected (0.30 sec)
    -- Records: 0  Duplicates: 0  Warnings: 0
