CREATE DATABASE HAM;
-- Query OK, 1 row affected (0.03 sec)
USE HAM;
-- Database changed
CREATE TABLE users(
  id INT(5) NOT NULL AUTO_INCREMENT,
  name VARCHAR(20),
  PRIMARY KEY (id)
);
-- Query OK, 0 rows affected (0.11 sec)
CREATE TABLE assets(
  id INT(5) NOT NULL AUTO_INCREMENT,
  model VARCHAR(20),
  make VARCHAR(20),
  price FLOAT(12, 2),
  warranty INT(2),
  year DATE,
  PRIMARY KEY(id)
);
-- Query OK, 0 rows affected (0.08 sec)
CREATE TABLE assetAssignments(
  id INT(5) NOT NULL AUTO_INCREMENT,
  asset_id INT(5) NOT NULL,
  assignment_type ENUM('location', 'user'),
  assigned_to INT(5),
  assigned_on DATE,
  assigned_till DATE,
  PRIMARY KEY(id),
  FOREIGN KEY(asset_id) REFERENCES assets(id)
);
-- Query OK, 0 rows affected (0.10 sec)

CREATE TABLE locations(
  id INT(5) NOT NULL,
  name VARCHAR(20),
  PRIMARY KEY(id)
);
-- Query OK, 0 rows affected (0.09 sec)

CREATE TABLE repairs(
  id INT(5) NOT NULL,
  asset_id INT(5) NOT NULL,
  cost FLOAT(12,2),
  nature VARCHAR(50),
  warranty_status ENUM('T', 'F'),
  PRIMARY KEY(id),
  FOREIGN KEY(asset_id) REFERENCES assets(id)
);
-- Query OK, 0 rows affected (0.12 sec)
INSERT INTO users
  VALUES(1, 'Alice'),
  (2, 'Bob'),
  (3, 'Chris'),
  (4, 'Duke'),
  (5, 'Emily');
-- Query OK, 5 rows affected (0.03 sec)
-- Records: 5  Duplicates: 0  Warnings: 0
INSERT INTO assets
  VALUES(100, 'A', 'laptop', 30000, 1, '2011-01-01'),
  (101, 'B', 'laptop', 32000, 1, '2011-01-01'),
  (102, 'N1', 'laptop', 35000, 1, '2011-01-01'),
  (103, 'N2', 'laptop', 28000, 1, '2011-01-01'),
  (104, 'A', 'iphone', 43000, 1, '2011-01-01'),
  (105, 'B', 'iphone', 45000, 1, '2011-01-01'),
  (106, 'A', 'projector', 32000, 1, '2011-08-15'),
  (107, 'A', 'printer', 32000, 1, '2011-08-15'),
  (108, 'B', 'printer', 32000, 1, '2011-09-10');
-- Query OK, 9 rows affected (0.03 sec)
-- Records: 9  Duplicates: 0  Warnings: 0
INSERT INTO locations
  VALUES(1000, 'Meeting Room');
-- Query OK, 1 row affected (0.05 sec)

INSERT INTO assetAssignments
  VALUES(1, 100, 'user', 1, '2011-01-01', '2011-12-31'),
  (2, 101, 'user', 2, '2011-01-01', '2011-12-31'),
  (3, 100, 'user', 2, '2012-01-01', CURDATE()),
  (4, 104, 'user', 1, '2011-04-01', CURDATE()),
  (5, 105, 'user', 2, '2011-01-01', CURDATE()),
  (6, 106, 'location', 1000, '2011-08-15', CURDATE()),
  (7, 107, 'location', 1000, '2011-08-15', CURDATE());
-- Query OK, 7 rows affected (0.05 sec)
-- Records: 7  Duplicates: 0  Warnings: 0
CREATE INDEX id_index
  ON assetAssignments (id);
-- Query OK, 0 rows affected (0.21 sec)
-- Records: 0  Duplicates: 0  Warnings: 0

-- (i) Find the name of the employee who has been alloted the maximum number of 
--     assets till date


SELECT users.name, COUNT(assetAssignments.asset_id) AS total_assets_assigned
  FROM assetAssignments JOIN users
  ON assetAssignments.assigned_to = users.id
  GROUP BY name
  HAVING total_assets_assigned = (SELECT COUNT(assetAssignments.asset_id) AS assets_assigned 
  FROM assetAssignments
  WHERE assetAssignments.assignment_type = 'user'
  GROUP BY assetAssignments.assigned_to
  ORDER BY assets_assigned DESC
  LIMIT 1);
-- +------+-----------------------+
-- | name | total_assets_assigned |
-- +------+-----------------------+
-- | Bob  |                     3 |
-- +------+-----------------------+
-- 1 row in set (0.00 sec)


-- (ii) Identify the name of the employee who currently has the maximum number of 
--      assets as of today


SELECT name, COUNT(assetAssignments.asset_id) as total_assets_currently_owned
  FROM assetAssignments JOIN users
  ON assetAssignments.assigned_to = users.id 
  WHERE assetAssignments.assigned_till = CURDATE()
  GROUP BY name
  HAVING total_assets_currently_owned = ( SELECT COUNT(asset_id) AS assets_assigned 
    FROM assetAssignments
    WHERE assetAssignments.assignment_type = 'user'
    AND assetAssignments.assigned_till = CURDATE()
    GROUP BY assetAssignments.assigned_to
    ORDER BY assets_assigned DESC
    LIMIT 1);

-- +------+------------------------------+
-- | name | total_assets_currently_owned |
-- +------+------------------------------+
-- | Bob  |                            2 |
-- +------+------------------------------+
-- 1 row in set (0.00 sec)

-- (iii) Find name and period of all the employees who have used a Laptop - let’s say 
--       laptop A - since it was bought by the company.
SELECT name, DATEDIFF(assetAssignments.assigned_till, assetAssignments.assigned_on) AS timeUsed_in_days
  FROM assetAssignments JOIN users
  ON assetAssignments.assigned_to = users.id AND assetAssignments.asset_id = 100
  GROUP BY timeUsed_in_days;
-- +-------+------------------+
-- | name  | timeUsed_in_days |
-- +-------+------------------+
-- | Alice |              364 |
-- | Bob   |             1360 |
-- +-------+------------------+
-- 2 rows in set (0.00 sec)



-- (iv) Find the list of assets that are currently not assigned to anyone hence 
--      lying with the asset manage (HR)
SELECT id, model, make
  FROM assets LEFT JOIN assetAssignments
  ON assets.id = assetAssignments.asset_id
  WHERE assetAssignments.asset_id IS NULL;
-- +-----+-------+---------+
-- | Id  | model | make    |
-- +-----+-------+---------+
-- | 102 | N1    | laptop  |
-- | 103 | N2    | laptop  |
-- | 108 | B     | printer |
-- +-----+-------+---------+
-- 3 rows in set (0.00 sec)


-- (v) An employee say Bob is leaving the company, write a query to get the list of 
--      assets he should be returning to the company.

SELECT assetAssignments.asset_id, model, make
FROM assetAssignments JOIN assets JOIN users
ON assetAssignments.asset_id = assets.id
AND assetAssignments.assigned_till = CURDATE()
AND assetAssignments.assigned_to = users.id
WHERE users.name = 'Bob';
-- +----------+-------+--------+
-- | asset_Id | model | make   |
-- +----------+-------+--------+
-- |      100 | A     | laptop |
-- |      105 | B     | iphone |
-- +----------+-------+--------+
-- 2 rows in set (0.01 sec)

-- (vi) Write a query to find assets which are out of warranty (Do using subquery also).
SELECT *
FROM assets
WHERE DATEDIFF(CURDATE(), assets.year) > assets.warranty * 365;
-- +-----+-------+-----------+----------+----------+------------+
-- | Id  | model | make      | price    | warranty | year       |
-- +-----+-------+-----------+----------+----------+------------+
-- | 100 | A     | laptop    | 30000.00 |        1 | 2011-01-01 |
-- | 101 | B     | laptop    | 32000.00 |        1 | 2011-01-01 |
-- | 102 | N1    | laptop    | 35000.00 |        1 | 2011-01-01 |
-- | 103 | N2    | laptop    | 28000.00 |        1 | 2011-01-01 |
-- | 104 | A     | iphone    | 43000.00 |        1 | 2011-01-01 |
-- | 105 | B     | iphone    | 45000.00 |        1 | 2011-01-01 |
-- | 106 | A     | projector | 32000.00 |        1 | 2011-08-15 |
-- | 107 | A     | printer   | 32000.00 |        1 | 2011-08-15 |
-- | 108 | B     | printer   | 32000.00 |        1 | 2011-09-10 |
-- +-----+-------+-----------+----------+----------+------------+
-- 9 rows in set (0.00 sec)



-- (vii) Return a list of Employee Names who do not have any asset assigned to them 
--       (Do using subquery also).
SELECT DISTINCT name
FROM users LEFT JOIN assetAssignments
ON users.id = assetAssignments.assigned_to
WHERE assetAssignments.assigned_to IS NULL;
-- +-------+
-- | name  |
-- +-------+
-- | Chris |
-- | Duke  |
-- | Emily |
-- +-------+
-- 3 rows in set (0.00 sec)

SELECT name
FROM users
WHERE id IN(
  SELECT users.id
  FROM users LEFT JOIN assetAssignments 
  ON users.id = assetAssignments.assigned_to
  WHERE assetAssignments.assigned_to IS NULL
);
-- +-------+
-- | name  |
-- +-------+
-- | Chris |
-- | Duke  |
-- | Emily |
-- +-------+
-- 3 rows in set (0.00 sec)