use librarydb;
Load data INFILE '/BotTask/sql/dsddaasd.csv'
INTO TABLE testtable 
Fields TERMINATED BY ','
ENCLOSED BY '"'
IGNore 1 ROWS
(AuthorID, Name, Birthdate);