CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON librarydb.* TO 'admin_user'@'localhost';

CREATE USER 'librarian_user'@'localhost' IDENTIFIED BY 'librarian_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON librarydb.books TO 'librarian_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON librarydb.loans TO 'librarian_user'@'localhost';

CREATE USER 'member_user'@'localhost' IDENTIFIED BY 'member_password';
GRANT SELECT ON librarydb.members TO 'member_user'@'localhost';
GRANT SELECT ON librarydb.loans TO 'member_user'@'localhost';


SELECT * FROM mysql.general_log;
