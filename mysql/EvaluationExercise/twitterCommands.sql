-- 1. FInd all users with all their followings.

SELECT u1.name, u2.name AS followings
FROM users AS u1 JOIN relationships JOIN users AS u2
ON u1.Id = relationships.user_id
WHERE u2.Id = relationships.following_id;

-- +-------+------------+
-- | name  | followings |
-- +-------+------------+
-- | Akhil | Manik      |
-- | Akhil | Amit       |
-- | Akhil | Kapil      |
-- | Akhil | Ankur      |
-- | Akhil | Suman      |
-- | John  | Ryan       |
-- | Ryan  | John       |
-- | Kapil | Akhil      |
-- | Kapil | Manik      |
-- | Kapil | Suman      |
-- | Ankur | Akhil      |
-- | Ankur | Manik      |
-- | Ankur | Amit       |
-- | Ankur | Rahul      |
-- | Ankur | Kapil      |
-- | Ankur | John       |
-- | Ankur | Ryan       |
-- | Ankur | Sunil      |
-- | Ankur | Suman      |
-- +-------+------------+
-- 19 rows in set (0.01 sec)


-- 2. Find all users with all their followings(comma Separated). Users having 
--    maximum followings should be on the top and min at the bottom.

-- previous query
-- SELECT temp.name, temp.followings
-- FROM (
--   SELECT u1.name, GROUP_CONCAT(u2.name) AS followings, COUNT(*) AS count
--   FROM users AS u1 JOIN relationships JOIN users AS u2
--   ON u1.Id = relationships.user_id
--   WHERE u2.Id = relationships.following_id
--   GROUP BY u1.name
--   ORDER BY count DESC
-- ) temp;

-- new query
SELECT u1.name, GROUP_CONCAT(u2.name) AS followings
FROM users AS u1 JOIN relationships JOIN users AS u2
ON u1.Id = relationships.user_id
WHERE u2.Id = relationships.following_id
GROUP BY u1.name
ORDER BY COUNT(*) DESC

-- +-------+----------------------------------------------------+
-- | name  | followings                                         |
-- +-------+----------------------------------------------------+
-- | Ankur | Akhil,Manik,Amit,Rahul,Kapil,John,Ryan,Sunil,Suman |
-- | Akhil | Kapil,Ankur,Suman,Manik,Amit                       |
-- | Kapil | Akhil,Manik,Suman                                  |
-- | John  | Ryan                                               |
-- | Ryan  | John                                               |
-- +-------+----------------------------------------------------+
-- 5 rows in set (0.01 sec)


-- 3. Display my timeline (users.Id = 1). Timeline is tweets by me and by my followings 
--    in reverse chrono. order.
-- initial query using subquery
SELECT users.name, content, created_at
FROM users JOIN tweets
ON users.Id = tweets.user_id
WHERE users.Id = 1
OR users.Id IN(
  SELECT u2.Id
  FROM users AS u1 JOIN relationships AS r JOIN users as u2
  ON u1.Id = r.user_id
  WHERE u2.Id = r.following_id AND u1.Id = 1
)
ORDER BY created_at DESC;


SELECT IF(r.user_id = t.user_id, u2.name, u1.name) AS name, content, created_at
FROM users AS u1 JOIN tweets AS t JOIN users AS u2 JOIN relationships AS r
ON u2.Id = r.user_id
AND u1.Id = r.following_id
AND (r.user_id = t.user_id OR r.following_id = t.user_id)
WHERE u2.Id = 1
GROUP BY content
ORDER BY created_at DESC;

-- better solution
select distinct u.name, t.content, t.created_at from users u, tweets t, relationships r 
where t.user_id = u.id and (u.id = 1) and  r.user_id = 1;
-- +-------+-------------------------------------------------+---------------------+
-- | name  | content                                         | created_at          |
-- +-------+-------------------------------------------------+---------------------+
-- | Akhil | Its raining                                     | 2012-08-07 12:57:43 |
-- | Manik | Stop playing twitter twitter, focus on your job | 2012-08-07 12:55:46 |
-- | Ankur | Thanks for letting me know                      | 2012-08-07 12:54:51 |
-- | Ankur | Nokis is a nice mobile company                  | 2012-08-07 12:54:20 |
-- | Kapil | I am at vinsol                                  | 2012-08-07 12:53:59 |
-- | Suman | Lets test this...                               | 2012-08-07 12:53:18 |
-- | Akhil | lorem ipsum                                     | 2012-08-07 12:53:01 |
-- | Manik | Hello there                                     | 2012-08-07 12:52:46 |
-- | Manik | Test tweet.                                     | 2012-08-07 12:52:38 |
-- | Akhil | My first ever tweet.                            | 2012-08-07 12:52:11 |
-- +-------+-------------------------------------------------+---------------------+
-- 10 rows in set (0.00 sec)


-- 4. Find out how many tweets each user has done.
SELECT users.name, COUNT(*) AS totat_tweets
FROM users JOIN tweets
ON users.Id = tweets.user_id
GROUP BY users.name;

-- +-------+--------------+
-- | name  | totat_tweets |
-- +-------+--------------+
-- | Akhil |            3 |
-- | Ankur |            2 |
-- | John  |            1 |
-- | Kapil |            1 |
-- | Manik |            3 |
-- | Rahul |            1 |
-- | Ryan  |            2 |
-- | Suman |            1 |
-- | Sunil |            1 |
-- +-------+--------------+
-- 9 rows in set (0.00 sec)

-- 5. Find out all users who haven't tweeted ever.
SELECT name
FROM users LEFT JOIN tweets
ON users.Id = tweets.user_id
WHERE tweets.user_id IS NULL;
-- +------+
-- | name |
-- +------+
-- | Amit |
-- +------+
-- 1 row in set (0.00 sec)

-- 6. Find out all users with their tweets who has tweeted in last 1 hour.
INSERT INTO users
    -> VALUES(11, 'Praveen');
-- Query OK, 1 row affected (0.00 sec)
INSERT INTO tweets
    -> VALUES(16, 11, 'tweet to check last query', NULL, NOW());
-- Query OK, 1 row affected (0.00 sec)

SELECT name, content, created_at
FROM users JOIN tweets
ON users.Id = tweets.user_id
HAVING (TIMEDIFF(CURTIME(), DATE_FORMAT(created_at,'%H:%i:%s')) < '01:00:00') = 1;

-- +---------+---------------------------+---------------------+
-- | name    | content                   | created_at          |
-- +---------+---------------------------+---------------------+
-- | Praveen | tweet to check last query | 2015-09-18 13:50:47 |
-- +---------+---------------------------+---------------------+
-- 1 row in set (0.00 sec)


