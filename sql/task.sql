use mydb;
drop table if exists mydb.phoneNumbers;
drop table if exists mydb.status_lookup;
drop table if exists mydb.address;
drop table if exists mydb.persons;

CREATE TABLE mydb.persons (
	PersonID int auto_increment primary key,
	FirstName tinytext,
	LastName tinytext,
    DateOfBirth date,
    Email varchar(30)
);

DELIMITER //

CREATE TRIGGER check_dateofbirth_before_insert
BEFORE INSERT ON mydb.persons
FOR EACH ROW
BEGIN
    IF NEW.DateOfBirth > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'DateOfBirth cannot be a future date.';
    END IF;
END; //

DELIMITER ;


CREATE TABLE mydb.status_lookup (
    status VARCHAR(20) PRIMARY KEY
);

INSERT INTO mydb.status_lookup (status) VALUES ('Home'), ('Work'), ('Mobile');

CREATE TABLE mydb.address (
	AddressID int auto_increment primary key,#
    PersonID int,
	StreetAddress tinytext,
	City varchar(50),
    State varchar(20),
    foreign key (PersonID) references mydb.persons(PersonID) on delete cascade
);

CREATE TABLE mydb.phoneNumbers (
	PhoneID int auto_increment primary key,
    PersonID int,
	PhoneNumber tinytext,
	PhoneType varchar(15) not null,
    foreign key (PersonID) references mydb.persons(PersonID) on delete cascade,
    foreign key (PhoneType) references mydb.status_lookup(status) on delete cascade
);

INSERT INTO mydb.persons (FirstName, LastName, DateOfBirth, Email)
VALUES 
    ('John', 'Doe', '1985-06-15', 'johndoe@example.com'),
    ('Jane', 'Smith', '1990-03-22', 'janesmith@example.com'),
    ('Emily', 'Jones', '1978-11-08', 'emilyjones@example.com'),
    ('Michael', 'Brown', '1982-01-30', 'michaelbrown@example.com'),
    ('Sarah', 'Davis', '1995-07-19', 'sarahdavis@example.com');




INSERT INTO mydb.address (PersonID, StreetAddress, City, State)
VALUES 
    (1, '123 Maple St', 'Springfield', 'IL'),
    (2, '456 Elm St', 'Greenville', 'NY'),
    (3, '789 Oak St', 'Shelbyville', 'TX'),
    (4, '101 Pine St', 'Centerville', 'CA'),
    (5, '202 Birch St', 'Lakewood', 'FL');



INSERT INTO mydb.phoneNumbers (PersonID, PhoneNumber, PhoneType)
VALUES 
    (1, '555-1234', 'Home'),
    (1, '555-5678', 'Mobile'),
    (2, '555-2345', 'Work'),
    (3, '555-3456', 'Mobile'),
    (4, '555-4567', 'Home'),
    (5, '555-5678', 'Work');

select * from mydb.persons;

select p.FirstName, p.LastName, a.City, a.City, a.State, pn.PhoneNumber, pn.PhoneType from mydb.persons p 
inner join mydb.address a on (a.PersonID=p.PersonID)
inner join mydb.phoneNumbers pn on (pn.PersonID=p.PersonID);
