CREATE DATABASE multi_branch_library;
-- Query OK, 1 row affected (0.00 sec)

USE multi_branch_library;
-- Database changed

CREATE TABLE Branches(
  -> BCode VARCHAR(2),
  -> Librarian VARCHAR(20),
  -> Address VARCHAR(30),
  -> PRIMARY KEY(BCode)
  -> );
-- Query OK, 0 rows affected (0.09 sec)

CREATE TABLE titles(
  -> Title VARCHAR(20),
  -> Author VARCHAR(20),
  -> Publisher VARCHAR(20),
  -> PRIMARY KEY(Title)
  -> );
-- Query OK, 0 rows affected (0.10 sec)

 CREATE TABLE Holdings(
  -> Branch VARCHAR(2),
  -> Title VARCHAR(20),
  -> `#copies` INT(2),
  -> PRIMARY KEY(Branch, Title),
  -> FOREIGN KEY(Branch) REFERENCES Branches(BCode),
  -> FOREIGN KEY(Title) REFERENCES titles(Title)
  -> );
-- Query OK, 0 rows affected (0.14 sec)

INSERT INTO Branches
  -> VALUES('B1', 'John Smith', '2 Anglessa Rd'),
  -> ('B2', 'Mary Jones', '34 Pearse St'),
  -> ('B3', 'Francis Owens', 'Grange X');
-- Query OK, 3 rows affected (0.03 sec)
-- Records: 3  Duplicates: 0  Warnings: 0

INSERT INTO titles
  -> VALUES('Susannah','Ann Brown','Macmillan'),
  -> ('How to Fish','Amy Fly','Stop Press'),
  -> ('A history of Dublin','David Little','Wiley'),
  -> ('Computers','Blaise Pascal','Applewoods'),
  -> ('The Wife','Ann Brown','Macmillan');
-- Query OK, 5 rows affected (0.06 sec)
-- Records: 5  Duplicates: 0  Warnings: 0

INSERT INTO Holdings
    -> VALUES('B1', 'Susannah', 3), 
    -> ('B1', 'How to Fish', 2), 
    -> ('B1', 'A history of Dublin', 1), 
    -> ('B2', 'How to Fish', 4), 
    -> ('B2', 'Computers', 2), 
    -> ('B2', 'The Wife', 3), 
    -> ('B3', 'A history of Dublin', 1), 
    -> ('B3', 'Computers', 4), 
    -> ('B3', 'Susannah', 3), 
    -> ('B3', 'The Wife', 1); 
-- Query OK, 10 rows affected (0.04 sec)
-- Records: 10  Duplicates: 0  Warnings: 0

-- (i) the names of all library books published by Macmillan.
SELECT Title FROM titles WHERE Publisher = 'Macmillan';
-- +----------+
-- | Title    |
-- +----------+
-- | Susannah |
-- | The Wife |
-- +----------+
-- 2 rows in set (0.00 sec)

-- (ii) branches that hold any books by Ann Brown (using a nested subquery)
 SELECT DISTINCT Branch FROM Holdings
  -> WHERE Title IN ((
    -> SELECT Title FROM titles
    -> WHERE Author = 'Ann Brown'));
-- +--------+
-- | Branch |
-- +--------+
-- | B1     |
-- | B2     |
-- | B3     |
-- +--------+
-- 4 rows in set (0.00 sec)

-- (iii) branches that hold any books by Ann Brown (without using a nested subquery).
 SELECT DISTINCT Branch
  -> FROM Holdings JOIN titles
  -> USING(title)
  -> WHERE titles.Author = 'Ann Brown';
-- +--------+
-- | Branch |
-- +--------+
-- | B1     |
-- | B3     |
-- | B2     |
-- +--------+
-- 3 rows in set (0.00 sec)

-- (iv) the total number of books held at each branch.
 SELECT Branch, SUM(`#copies`) AS TotalBooks
  -> FROM Holdings
  -> GROUP BY Branch;
-- +--------+------------+
-- | Branch | TotalBooks |
-- +--------+------------+
-- | B1     |          6 |
-- | B2     |          9 |
-- | B3     |          9 |
-- +--------+------------+
-- 3 rows in set (0.00 sec)
