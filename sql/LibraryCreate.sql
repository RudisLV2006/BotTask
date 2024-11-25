use librarydb;

INSERT INTO Books (Title, PublicationYear, ISBN, Genre)
VALUES 
('The Great Gatsby', 1925, '9780743273565', 'Fiction'),
('To Kill a Mockingbird', 1960, '9780060935467', 'Fiction'),
('1984', 1949, '9780451524935', 'Dystopian');

ALTER TABLE Books 
MODIFY COLUMN PublicationYear Year;  -- Iespēja pievienot, izmainīt eksistējosša tabulā galvenes un datu veidus 


INSERT INTO Books (Title, PublicationYear, ISBN, Genre)
VALUES 
('Pride and Prejudice', 1813, '9780141199078', 'Romance');

delete from books where bookid = 4;



INSERT INTO Authors (Name, Birthdate)
VALUES 
('F. Scott Fitzgerald', '1896-09-24'),
('Harper Lee', '1926-04-28'),
('George Orwell', '1903-06-25');

INSERT INTO Authors (Name, Birthdate)
VALUES 
('Jane Austen', '1775-12-16');


INSERT INTO BookAuthors (BookID, AuthorID)
VALUES 
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Members (Name, MembershipDate, Email)
VALUES 
('Alice Johnson', '2024-01-15', 'alice@example.com'),
('Bob Smith', '2023-06-10', 'bob.smith@example.com'),
('Carol Martinez', '2024-03-22', 'carol@example.com');

INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate)
VALUES 
(1, 1, '2024-11-01', '2024-11-15'),
(2, 2, '2024-11-10', '2024-11-20'),
(3, 3, '2024-11-12', NULL);

INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate)
VALUES
-- Loan with return
(1, 2, '2024-10-15', '2024-10-25'), -- Bob borrowed "The Great Gatsby" and returned it
(3, 1, '2024-10-20', '2024-10-30'), -- Alice borrowed "1984" and returned it

-- Loan still active (ReturnDate = NULL)
(2, 3, '2024-11-05', NULL), -- Carol borrowed "To Kill a Mockingbird" and hasn’t returned it yet

-- Older loans
(1, 3, '2024-09-10', '2024-09-20'), -- Carol borrowed "The Great Gatsby" and returned it
(3, 2, '2024-08-15', '2024-08-25'), -- Bob borrowed "1984" and returned it
(2, 1, '2024-07-05', '2024-07-15'); -- Alice borrowed "To Kill a Mockingbird" and returned it




-- View Books
SELECT * FROM Books;

-- View Authors
SELECT * FROM Authors;

-- View BookAuthors (Relationship Table)
SELECT * FROM BookAuthors;

-- View Members
SELECT * FROM Members;

-- View Loans
SELECT * FROM Loans;


SELECT 
    Books.BookID,
    Books.Title,
    Books.PublicationYear,
    Books.Genre,
    Authors.Name AS AuthorName
FROM 
    Books
JOIN 
    BookAuthors ON Books.BookID = BookAuthors.BookID
JOIN 
    Authors ON BookAuthors.AuthorID = Authors.AuthorID;



SELECT 
    Members.MemberID,
    Members.Name AS MemberName,
    Members.Email,
    Loans.BookID,
    Books.Title AS BorrowedBook,
    Loans.LoanDate
FROM 
    Members
JOIN 
    Loans ON Members.MemberID = Loans.MemberID
JOIN 
    Books ON Loans.BookID = Books.BookID
WHERE 
    Loans.LoanDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

select AVG(BookCount) as AverageBookBorrowed
from(
	SELECT 
    b.title, COUNT(b.BookID) AS BookCount
FROM
    loans l
        LEFT JOIN
    books b ON (l.BookID = b.BookID)
GROUP BY b.title
) as MemberLoanCounts;


SELECT 
    b.title, COUNT(b.BookID) AS BookCount
FROM
    loans l
        LEFT JOIN
    books b ON (l.BookID = b.BookID)
GROUP BY b.title
limit 5;








-- Create view MemberLoanCounts as 
-- SELECT 
--     b.title, COUNT(b.BookID) AS BookCount
-- FROM
--     loans l
--         LEFT JOIN
--     books b ON (l.BookID = b.BookID)
-- GROUP BY b.title;