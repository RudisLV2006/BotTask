use librarydb;



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