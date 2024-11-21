use newuser;


insert into persons (firstname) values ('Kristaps'),('Mihails');

select column_name from information_schema.columns where table_schema = 'newuser';