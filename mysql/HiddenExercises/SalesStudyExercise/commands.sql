CREATE DATABASE company;
-- Query OK, 1 row affected (0.15 sec)
USE company;
-- Database changed
CREATE TABLE salespersons(
  id INT(5) NOT NULL AUTO_INCREMENT,
  name VARCHAR(20),
  age INT(3),
  salary FLOAT(10,2),
  PRIMARY KEY(id)
);
-- Query OK, 0 rows affected (0.22 sec)
 INSERT INTO salespersons
  VALUES(1, "Abe", 61, 140000),
  (2, 'Bob', 34, 44000),
  (3, 'Chris', 34, 40000),
  (4, 'Dan', 41, 52000),
  (5, 'Ken', 57, 115000),
  (6, 'Joe', 38, 38000);
-- Query OK, 6 rows affected (0.06 sec)
-- Records: 6  Duplicates: 0  Warning: 0
CREATE TABLE customers(
  id INT(5) NOT NULL AUTO_INCREMENT,
  name VARCHAR(20),
  city VARCHAR(30),
  industry_type ENUM('J', 'B'),
  PRIMARY KEY(id)
);
-- Query OK, 0 rows affected (0.11 sec)

INSERT INTO customers    
  VALUES(1, 'Samsonic', 'Pleasant', 'J'),
  (2, 'Panasung', 'Oaktown', 'J'),
  (3, 'Samony', 'Jackson', 'B'),
  (4, 'Orange', 'Jackson', 'B');
-- Query OK, 4 rows affected (0.06 sec)
-- Records: 4  Duplicates: 0  Warnings: 0

CREATE TABLE orders(
  id INT(5) NOT NULL AUTO_INCREMENT,
  order_date DATE,
  cust_id INT(5) NOT NULL,
  salesperson_id INT(5) NOT NULL,
  amount FLOAT(10, 2),
  PRIMARY KEY(id),
  FOREIGN KEY(cust_id) REFERENCES customers(id),
  FOREIGN KEY(salesperson_id) REFERENCES salespersons(id)
);
-- Query OK, 0 rows affected (0.18 sec)

INSERT INTO orders
  VALUES(1, '2013-01-08', 1, 2, 540),
  (2, '2013-01-13', 1, 5, 1800),
  (3, '2013-01-17', 4, 1, 460),
  (4, '2013-02-02', 3, 2, 2400),
  (5, '2013-02-03', 2, 4, 600),
  (6, '2013-02-03', 2, 4, 720),
  (7, '2013-03-05', 4, 4, 150);
-- Query OK, 7 rows affected (0.06 sec)
-- Records: 7  Duplicates: 0  Warnings: 0

-- a)  The details of all salespeople that have an order with Samsonic.
SELECT s.id, s.name, s.age, s.salary    
  FROM salespersons AS s JOIN customers AS c JOIN orders AS o    
  ON o.cust_id = c.id AND o.salesperson_id = s.id    
  WHERE c.name = "Samsonic";
-- +----+------+------+-----------+
-- | id | name | age  | salary    |
-- +----+------+------+-----------+
-- |  2 | Bob  |   34 |  44000.00 |
-- |  5 | Ken  |   57 | 115000.00 |
-- +----+------+------+-----------+
-- 2 rows in set (0.00 sec)

-- b) The names of salespeople that have 2 or more orders
SELECT name
  FROM salespersons AS s JOIN orders AS o 
  ON o.salesperson_id = s.id
  GROUP BY name
  HAVING count(name) >= 2;
-- +------+
-- | name |
-- +------+
-- | Bob  |
-- | Dan  |
-- +------+
-- 2 rows in set (0.00 sec)

-- c) The names of salespeople that have not got any order for last 15 days, 
--    also show details of their last orders

SELECT s.id, name, o.id AS order_id, o.order_date, o.cust_id, o.amount
  FROM salespersons AS s LEFT JOIN orders AS o
  ON s.id = o.salesperson_id
  GROUP BY name
  HAVING (DATEDIFF(CURDATE(), order_date) > 15) OR order_id IS NULL
  ORDER BY order_date DESC;

-- +----+-------+----------+------------+---------+---------+
-- | id | name  | order_id | order_date | cust_id | amount  |
-- +----+-------+----------+------------+---------+---------+
-- |  4 | Dan   |        5 | 2013-02-03 |       2 |  600.00 |
-- |  1 | Abe   |        3 | 2013-01-17 |       4 |  460.00 |
-- |  5 | Ken   |        2 | 2013-01-13 |       1 | 1800.00 |
-- |  2 | Bob   |        1 | 2013-01-08 |       1 |  540.00 |
-- |  6 | Joe   |     NULL | NULL       |    NULL |    NULL |
-- |  3 | Chris |     NULL | NULL       |    NULL |    NULL |
-- +----+-------+----------+------------+---------+---------+
-- 6 rows in set (0.00 sec)

-- d) Find the names of the salespeople whose order has the maximum amount as of now
--    (Do this without using MAX Or MIN, do this using joins and consider possibility 
--      of more than one person having the highest amount)

SELECT s.id AS salesperson_id, name, SUM(amount) AS total_order_amount
  FROM salespersons AS s JOIN orders AS o
  ON s.id = o.salesperson_id
  GROUP BY name
  HAVING total_order_amount = (
    SELECT SUM(amount) AS total_order_amount
      FROM orders
      GROUP BY salesperson_id
      ORDER BY total_order_amount DESC
      LIMIT 1
);

-- +----------------+------+--------------------+
-- | salesperson_id | name | total_order_amount |
-- +----------------+------+--------------------+
-- |              2 | Bob  |            2940.00 |
-- +----------------+------+--------------------+
-- 1 row in set (0.00 sec)


-- e) Find the industry type all salespeople have got order from in a single column like :
--    Name Indsutries
--    Bob J,B
--    and so on..(with no repetitions like J,J,B in Industries column)

SELECT s.name, GROUP_CONCAT(DISTINCT industry_type) AS Industries
  FROM salespersons AS s JOIN orders AS o JOIN customers AS c
  ON s.id = o.salesperson_id AND o.cust_id = c.id
  GROUP BY s.name;

-- +------+------------+
-- | name | Industries |
-- +------+------------+
-- | Abe  | B          |
-- | Bob  | J,B        |
-- | Dan  | J,B        |
-- | Ken  | J          |
-- +------+------------+
-- 4 rows in set (0.00 sec)


-- f)  In the last query, get the total amount of money they have got orders for

SELECT s.name, GROUP_CONCAT(DISTINCT industry_type) AS Industries, SUM(amount) AS total_amount
  FROM salespersons AS s JOIN orders AS o JOIN customers AS c
  ON s.id = o.salesperson_id AND o.cust_id = c.id
  GROUP BY s.name;

-- +------+------------+--------------+
-- | name | Industries | total_amount |
-- +------+------------+--------------+
-- | Abe  | B          |       460.00 |
-- | Bob  | J,B        |      2940.00 |
-- | Dan  | J,B        |      1470.00 |
-- | Ken  | J          |      1800.00 |
-- +------+------------+--------------+
-- 4 rows in set (0.00 sec)
