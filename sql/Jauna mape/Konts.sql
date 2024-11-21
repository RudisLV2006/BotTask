create database if not exists newuser;

create user if not exists 'testUser';

GRANT INSERT, SELECT, TRIGGER ON newuser . * TO 'testUser';


CREATE TABLE newuser.persons (
    persons_id INT PRIMARY KEY AUTO_INCREMENT,
    firstname TINYTEXT
);




select user from mysql.user;