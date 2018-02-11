CREATE DATABASE sandwich;
-- Query OK, 1 row affected (0.02 sec)

CREATE TABLE tastes (
  -> name VARCHAR(20),
  -> filling VARCHAR(20),
  -> PRIMARY KEY (name, filling)
  -> );
-- Query OK, 0 rows affected (0.09 sec)

INSERT INTO tastes 
  -> values ('Brown', 'Turkey'),
  -> ('Brown', 'Beef'),
  -> ('Brown', 'Ham'),
  -> ('Jones', 'Cheese'),
  -> ('Green', 'Beef'),
  -> ('Green', 'Turkey'),
  -> ('Green','Cheese');
-- Query OK, 7 rows affected (0.06 sec)
-- Records: 7  Duplicates: 0  Warnings: 0

CREATE TABLE locations (
    -> LName VARCHAR(30),
    -> Phone VARCHAR(10),
    -> Address VARCHAR(50),
    -> PRIMARY KEY(LName)
    -> );
-- Query OK, 0 rows affected (0.08 sec)

INSERT INTO locations
    -> VALUES ('Lincoln', '6834523', 'Lincoln Place'),
    -> ('O\'Neill\'s', '674 2134', 'Pearse St'),
    -> ('Old Nag', '767 8132', 'Dame St'),
    -> ('Buttery', '702 3421', 'College St');
-- Query OK, 4 rows affected (0.04 sec)
-- Records: 4  Duplicates: 0  Warnings: 0

CREATE TABLE sandwiches (
    -> Location VARCHAR(30),
    -> Bread VARCHAR(15),
    -> Filling VARCHAR(20),
    -> Price FLOAT(5, 2),
    -> PRIMARY KEY(Location, Bread, Filling),
    -> FOREIGN KEY(Loctaion) REFERENCES locations(LName)
    -> );
-- Query OK, 0 rows affected (0.09 sec)

INSERT INTO sandwiches
    -> VALUES('Lincoln', 'Rye', 'Ham', 1.25),
    -> ('O\'Neill\'s', 'White', 'Cheese', 1.20),
    -> ('O\'Neill\'s', 'Whole', 'Ham', 1.25),
    -> ('Old Nag', 'Rye', 'Beef', 1.35),
    -> ('Buttery', 'White', 'Cheese', 1.00),
    -> ('O\'Neill\'s', 'White', 'Turkey', 1.35),
    -> ('Buttery', 'White', 'Ham', 1.10),
    -> ('Lincoln', 'Rye', 'Beef', 1.35),
    -> ('Lincoln', 'White', 'Ham', 1.30),
    -> ('Old Nag', 'Rye', 'Ham', 1.40);

-- Query OK, 10 rows affected (0.04 sec)
-- Records: 10  Duplicates: 0  Warnings: 0

  
-- (i) places where Jones can eat (using a nested subquery)
SELECT Location FROM sandwiches 
  -> WHERE Filling IN((
    -> SELECT filling FROM tastes
    -> WHERE name = 'Jones')
  -> );

-- +-----------+
-- | Location  |
-- +-----------+
-- | Buttery   |
-- | O'Neill's |
-- +-----------+
-- 2 rows in set (0.00 sec)

-- (ii) places where Jones can eat (without using a nested subquery).
SELECT sandwiches.Location
  -> FROM tastes JOIN sandwiches
  -> USING(filling)
  -> WHERE tastes.name = 'Jones';
-- +-----------+
-- | Location  |
-- +-----------+
-- | Buttery   |
-- | O'Neill's |
-- +-----------+
-- 2 rows in set (0.01 sec)

  
-- (iii) for each location the number of people who can eat there.
SELECT Location, COUNT(DISTINCT name) 
  FROM tastes JOIN sandwiches USING (filling)
  GROUP BY Location;
-- +-----------+----------------------+
-- | Location  | COUNT(DISTINCT name) |
-- +-----------+----------------------+
-- | Buttery   |                    3 |
-- | Lincoln   |                    2 |
-- | O'Neill's |                    3 |
-- | Old Nag   |                    2 |
-- +-----------+----------------------+
-- 4 rows in set (0.00 sec)

