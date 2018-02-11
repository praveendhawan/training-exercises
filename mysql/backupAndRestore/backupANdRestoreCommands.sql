-- Create BackUp of blog database
> mysqldump -u root -p blog > backUpBlog.sql
  Enter password: 

-- Create a new Database named restored;
CREATE DATABASE restored;

-- Restore the database from backup file 
> mysql -u root -p restored < backUpBlog.sql
Enter password: 
