CREATE DATABASE blog2;
-- Query OK, 1 row affected (0.00 sec)

USE blog2;
-- Database changed
CREATE TABLE users(
  Id INT(5) NOT NULL AUTO_INCREMENT,
  name VARCHAR(30),
  type ENUM('admin', 'normal'),
  PRIMARY KEY(Id)
);
-- Query OK, 0 rows affected (0.15 sec)

CREATE TABLE categories(
  Id INT(5) NOT NULL,
  name VARCHAR(10),
  PRIMARY KEY(Id)
);
-- Query OK, 0 rows affected (0.15 sec)

CREATE TABLE articles(
  Id INT(5) NOT NULL AUTO_INCREMENT,
  user_Id INT(5),
  title VARCHAR(30) NOT NULL,
  category_Id INT(5),
  PRIMARY KEY(Id),
  FOREIGN KEY(user_Id) REFERENCES users(Id),
  FOREIGN KEY(category_Id) REFERENCES categories(Id)
);
-- Query OK, 0 rows affected (0.20 sec)
CREATE TABLE comments(
  Id INT(5) NOT NULL AUTO_INCREMENT,
  article_Id INT(5),
  user_id INT(5),
  PRIMARY KEY(Id),
  FOREIGN KEY(article_Id) REFERENCES articles(Id),
  FOREIGN KEY(user_Id) REFERENCES users(Id)
);
-- Query OK, 0 rows affected (0.20 sec)
INSERT INTO users
  VALUES(1, 'Praveen', 'normal'),
  (2, 'Ram', 'normal'),
  (3, 'Shyam', 'normal'),
  (4, 'root', 'admin'),
  (5, 'Ghanshyam', 'normal');
-- Query OK, 5 rows affected (0.10 sec)
-- Records: 5  Duplicates: 0  Warnings: 0
INSERT INTO categories
  VALUES(1, 'Research'),
  (2, 'Explanation'),
  (3, 'Gyming'),
  (4, 'Sports'),
  (5, 'Current Affairs'),
  (6, 'Economics');
-- Query OK, 6 rows affected, 2 warnings (0.11 sec)
-- Records: 6  Duplicates: 0  Warnings: 2
INSERT INTO articles
  VALUES(1, 1, 'Cryptography Techniques', 1),
  (2, 3, 'How Computers Work', 2),
  (3, 2, 'Keep Yourself Fit', 3),
  (4, 5, 'Todays Latest News', 5),
  (5, 5, 'Indian Economy', 6);
-- Query OK, 5 rows affected (0.11 sec)
-- Records: 5  Duplicates: 0  Warnings: 0
 INSERT INTO comments
VALUES(1, 2, 1),
(2, 2, 2),
(3, 1, 3),
(4, 3, 5),
(5, 4, 1);
-- Query OK, 5 rows affected (0.04 sec)
-- Records: 5  Duplicates: 0  Warnings: 0


-- (i) select all articles whose author's name is Praveen 
--     (Do this exercise using variable also).
SELECT articles.Id AS article_Id, title
  FROM articles JOIN users
  ON articles.user_ID = users.ID AND users.name = 'Praveen';
-- +------------+-------------------------+
-- | article_Id | title                   |
-- +------------+-------------------------+
-- |          1 | Cryptography Techniques |
-- +------------+-------------------------+
-- 1 row in set (0.00 sec)

SET @name = 'Praveen';
-- Query OK, 0 rows affected (0.00 sec)
SELECT articles.Id AS article_Id, title
  FROM articles JOIN users
  ON articles.user_ID = users.ID AND users.name = @name;
-- +------------+-------------------------+
-- | article_Id | title                   |
-- +------------+-------------------------+
-- |          1 | Cryptography Techniques |
-- +------------+-------------------------+
-- 1 row in set (0.02 sec)


 
-- (ii)For all the articles being selected above, select all the articles and 
--       also the comments associated with those articles in a single query 
--       (Do this using subquery also)
SELECT articles.Id, title, category_Id, comments.Id AS comment_Id 
  FROM articles JOIN users JOIN comments 
  ON articles.user_Id = users.Id 
    AND users.name = 'Praveen' 
    AND comments.article_Id = articles.Id;
-- +----+-------------------------+-------------+------------+
-- | Id | title                   | category_Id | comment_Id |
-- +----+-------------------------+-------------+------------+
-- |  1 | Cryptography Techniques |           1 |          3 |
-- +----+-------------------------+-------------+------------+
-- 1 row in set (0.00 sec)

SELECT articles.Id, title, category_Id, comments.Id AS comment_Id
  FROM comments, articles 
  WHERE comments.article_Id = articles.Id AND comments.article_Id 
  IN (SELECT Id FROM articles 
    WHERE user_Id IN(SELECT Id 
      FROM users 
      WHERE name = 'Praveen'
      )
    );
-- +----+-------------------------+-------------+------------+
-- | Id | title                   | category_Id | comment_Id |
-- +----+-------------------------+-------------+------------+
-- |  1 | Cryptography Techniques |           1 |          3 |
-- +----+-------------------------+-------------+------------+
-- 1 row in set (0.00 sec)


-- (iii) Write a query to select all articles which do not have any comments 
--       (Do using subquery also)
SELECT articles.Id, title, category_Id 
  FROM articles LEFT JOIN comments 
  ON articles.Id = comments.article_Id 
  WHERE comments.Id IS NULL;
-- +----+----------------+-------------+
-- | Id | title          | category_Id |
-- +----+----------------+-------------+
-- |  5 | Indian Economy |           6 |
-- +----+----------------+-------------+
-- 1 row in set (0.00 sec)


-- (iv) Write a query to select article which has maximum comments
        -- (Do this using subquery also)
SELECT articles.Id, title, category_Id, COUNT(*) AS comment_count
  FROM articles LEFT JOIN comments
  ON articles.Id = comments.article_Id
  GROUP BY articles.Id
  HAVING MAX(comment_count)
  LIMIT 1;
-- +----+--------------------+-------------+---------------+
-- | Id | title              | category_Id | comment_count |
-- +----+--------------------+-------------+---------------+
-- |  2 | How Computers Work |           2 |             2 |
-- +----+--------------------+-------------+---------------+
-- 1 row in set (0.01 sec)

SELECT articles.Id, title, category_Id, COUNT(*) AS comment_count
  FROM articles LEFT JOIN comments
  ON articles.Id = comments.article_Id
  GROUP BY articles.Id
  HAVING comment_count = (SELECT COUNT(*) AS comment_count
    FROM comments
    GROUP BY comments.article_Id
    ORDER BY comment_count DESC
    LIMIT 1);
-- +----+--------------------+-------------+---------------+
-- | Id | title              | category_Id | comment_count |
-- +----+--------------------+-------------+---------------+
-- |  2 | How Computers Work |           2 |             2 |
-- +----+--------------------+-------------+---------------+
-- 1 row in set (0.00 sec)


-- (v) Write a query to select article which does not have more than one comment 
--     by the same user ( do this using left join and group by )
      -- (Do this using subquery also)
SELECT articles.Id, title, category_Id, articles.user_Id, COUNT(*) AS comment_count 
  FROM articles LEFT JOIN comments 
  ON articles.Id = comments.article_Id 
  GROUP BY articles.Id 
  HAVING comment_count <= 1;
-- +----+-------------------------+-------------+---------+---------------+
-- | Id | title                   | category_Id | user_Id | comment_count |
-- +----+-------------------------+-------------+---------+---------------+
-- |  1 | Cryptography Techniques |           1 |       1 |             1 |
-- |  3 | Keep Yourself Fit       |           3 |       2 |             1 |
-- |  4 | Todays Latest News      |           5 |       5 |             1 |
-- |  5 | Indian Economy          |           6 |       5 |             1 |
-- +----+-------------------------+-------------+---------+---------------+
-- 4 rows in set (0.00 sec)

SELECT *
FROM articles LEFT JOIN (SELECT article_Id AS Id, COUNT(*) AS comment_count
  FROM comments
  GROUP BY comments.article_Id
  ) temp
USING(Id)
HAVING comment_count <= 1 OR comment_count IS NULL;
-- +----+---------+-------------------------+-------------+---------------+
-- | Id | user_Id | title                   | category_Id | comment_count |
-- +----+---------+-------------------------+-------------+---------------+
-- |  1 |       1 | Cryptography Techniques |           1 |             1 |
-- |  3 |       2 | Keep Yourself Fit       |           3 |             1 |
-- |  4 |       5 | Todays Latest News      |           5 |             1 |
-- |  5 |       5 | Indian Economy          |           6 |          NULL |
-- +----+---------+-------------------------+-------------+---------------+
-- 4 rows in set (0.00 sec)