CREATE DATABASE employeeCommision;
-- Query OK, 1 row affected (0.00 sec)
USE employeeCommision;
-- Database changed
CREATE TABLE departments(
  ID INT(4) NOT NULL,
  name VARCHAR(20) NOT NULL,
  PRIMARY KEY(ID)
  );
-- Query OK, 0 rows affected (0.13 sec)
INSERT INTO departments
  VALUES(1, 'Banking'),
  (2, 'Insurance'),
  (3, 'Services');
-- Query OK, 3 rows affected (0.10 sec)
-- Records: 3  Duplicates: 0  Warnings: 0

CREATE TABLE employees(
  ID INT(4) NOT NULL AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  salary INT(10),
  department_Id INT(4),
  PRIMARY KEY(ID),
  FOREIGN KEY(department_Id) REFERENCES departments(ID)
  );
-- Query OK, 0 rows affected (0.15 sec)

 INSERT INTO employees
  VALUES(1, 'Chris Gayle', 1000000, 1),
  (2, 'Michael Clarke', 800000, 2),
  (3, 'Rahul Dravid', 700000, 1),
  (4, 'Ricky Ponting', 600000, 2),
  (5, 'Albie Morkel', 650000, 2),
  (6, 'Wasim Akram', 750000, 3);
-- Query OK, 6 rows affected (0.11 sec)
-- Records: 6  Duplicates: 0  Warnings: 0

CREATE TABLE commisions(
  ID INT(4) NOT NULL,
  employee_Id INT(4),
  commision_amount INT(8),
  PRIMARY KEY(ID),
  FOREIGN KEY(employee_Id) REFERENCES employees(ID)
  );
-- Query OK, 0 rows affected (0.16 sec)
INSERT INTO commisions
  VALUES(1, 1, 5000),
  (2, 2, 3000),
  (3, 3, 4000),
  (4, 1, 4000),
  (5, 2, 3000),
  (6, 4, 2000),
  (7, 5, 1000),
  (8, 6, 5000)
  (9, 2, 3000);
-- Query OK, 9 rows affected (0.11 sec)
-- Records: 9  Duplicates: 0  Warnings: 0


-- i. Find the employee who gets the highest total commission.
SELECT employees.ID, name, salary, department_Id,SUM(commision_amount) AS total_commision 
  FROM employees JOIN commisions 
  ON employees.ID = commisions.employee_Id 
  GROUP BY employees.ID 
  HAVING total_commision = (SELECT SUM(commision_amount) AS total_commision 
    FROM employees JOIN commisions 
    ON employees.ID = commisions.employee_Id 
    GROUP BY employees.ID 
    ORDER BY total_commision DESC 
    LIMIT 1
    );
-- +----+----------------+---------+---------------+-----------------+
-- | ID | name           | salary  | department_Id | total_commision |
-- +----+----------------+---------+---------------+-----------------+
-- |  1 | Chris Gayle    | 1000000 |             1 |            9000 |
-- |  2 | Michael Clarke |  800000 |             2 |            9000 |
-- +----+----------------+---------+---------------+-----------------+
-- 2 rows in set (0.00 sec)






-- ii. Find employee with 4th Highest salary from employee table.
SELECT * FROM employees
  HAVING salary = (SELECT salary FROM employees
    GROUP BY salary
    ORDER BY salary DESC
    LIMIT 3,1);
-- +----+--------------+--------+---------------+
-- | ID | name         | salary | department_Id |
-- +----+--------------+--------+---------------+
-- |  3 | Rahul Dravid | 700000 |             1 |
-- +----+--------------+--------+---------------+
-- 1 row in set (0.00 sec)



-- iii. Find department that is giving highest commission.
SELECT d.ID, d.name, SUM(commision_amount) AS total_commision
  FROM departments AS d JOIN employees AS e JOIN commisions AS c 
  ON e.ID = c.employee_Id 
  AND d.ID = e.department_Id 
  GROUP BY d.ID 
  ORDER BY total_commision DESC 
  LIMIT 1;
-- +----+---------+-----------------+
-- | ID | name    | total_commision |
-- +----+---------+-----------------+
-- |  1 | Banking |           13000 |
-- +----+---------+-----------------+
-- 1 row in set (0.00 sec)

SELECT d.ID, d.name, SUM(commision_amount) AS total_commision
  FROM departments AS d JOIN employees AS e JOIN commisions AS c
  ON e.ID = c.employee_Id AND d.Id = e.department_Id
  GROUP BY d.Id
  HAVING total_commision = (SELECT SUM(commision_amount) AS total_commision
    FROM employees AS e JOIN commisions AS c
    ON e.ID = c.employee_Id
    GROUP BY e.department_Id
    ORDER BY total_commision DESC
    LIMIT 1);
-- +----+---------+-----------------+
-- | ID | name    | total_commision |
-- +----+---------+-----------------+
-- |  1 | Banking |           13000 |
-- +----+---------+-----------------+
-- 1 row in set (0.01 sec)

-- iv. Find employees getting commission more than 3000

SELECT GROUP_CONCAT(Distinct name) AS employee_names, total_commision
FROM (SELECT e.id, e.name, SUM(c.commision_amount) AS total_commision
      FROM employees e JOIN commisions c 
      ON e.id = c.employee_id
    GROUP BY e.id
    HAVING SUM(c.commision_amount) > 3000) t 
GROUP BY t.total_commision
ORDER BY t.total_commision DESC;
-- +----------------------------+-----------------+
-- | employee_names             | total_commision |
-- +----------------------------+-----------------+
-- | Chris Gayle,Michael Clarke |            9000 |
-- | Wasim Akram                |            5000 |
-- | Rahul Dravid               |            4000 |
-- +----------------------------+-----------------+
-- 3 rows in set (0.01 sec)

