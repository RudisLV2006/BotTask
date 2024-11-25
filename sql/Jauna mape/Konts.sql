create database if not exists LibraryDB;

create user if not exists 'testUser';

GRANT INSERT, SELECT, TRIGGER,create, references, alter, delete ON librarydb . * TO 'testUser';

revoke all privileges on mydb . * from 'testUser';

CREATE TABLE newuser.persons (
    persons_id INT PRIMARY KEY AUTO_INCREMENT,
    firstname TINYTEXT
);




select user from mysql.user;