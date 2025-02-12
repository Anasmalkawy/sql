--create database project;


CREATE TABLE book
(
  id INT primary key ,
  Title VARCHAR(100),
  Author VARCHAR(100),
  Genre VARCHAR(100),
  Publication_Year DATE,
  Availability_Status varchar(100),
);

CREATE TABLE member_
(
  id int primary key,
  Name VARCHAR(100),
  Contact_Information VARCHAR(100),
  Membership_Type VARCHAR(100),
  Registration_Date varchar(100),
);

CREATE TABLE member_book
(
  id INT primary key,
  borrowing_data date,
  due_data DATE,
  return_ date,
  member_id INT,
  book_id INT,
  FOREIGN KEY (member_id) REFERENCES member_(id),
  FOREIGN KEY (book_id) REFERENCES book(id)
);
CREATE TABLE Reservations
(
  id INT primary key ,
  Reservation_Date date,
  Status VARCHAR(100),
  member_id INT,
  book_id INT,
  FOREIGN KEY (member_id) REFERENCES member_(id),
  FOREIGN KEY (book_id) REFERENCES book(ID)
);
CREATE TABLE libaray_staff
(
  id INT primary key,
  Name VARCHAR(100),
  Contact_Info VARCHAR(100),
  Assigned_Section VARCHAR(100),
  Employment_Date DATE,
);

CREATE TABLE Categories
(
  id INT primary key,
  Name VARCHAR(100),
  Description VARCHAR(100),
  book_id INT,
  FOREIGN KEY (book_id) REFERENCES book(ID)
);


----------------- insert data ------------
-- Insert data into book table
INSERT INTO book (id, Title, Author, Genre, Publication_Year, Availability_Status) VALUES
(1, 'Database Fundamentals', 'John Smith', 'Education', '2020-05-10', 'Available'),
(2, 'SQL for Beginners', 'Alice Johnson', 'Education', '2019-08-21', 'Borrowed'),
(3, 'C# Programming', 'Robert Brown', 'Programming', '2021-03-15', 'Available'),
(4, 'Web Development Essentials', 'Emily White', 'Technology', '2022-07-09', 'Borrowed'),
(5, 'Data Structures in Python', 'Michael Green', 'Programming', '2023-01-25', 'Available');

-- Insert data into member_ table
INSERT INTO member_ (id, Name, Contact_Information, Membership_Type, Registration_Date) VALUES
(1, 'Ahmed', '1234567890', 'Student', '2025-01-01'),
(2, 'Sara', '2345678901', 'Regular', '2025-02-10'),
(3, 'Ali', '3456789012', 'Premium', '2024-12-15'),
(4, 'Mona', '4567890123', 'Student', '2024-06-20'),
(5, 'Omar', '9876543210', 'Student', '2024-05-06');

-- Insert data into member_book table
INSERT INTO member_book (id, borrowing_data, due_data, return_, member_id, book_id) VALUES
(1, '2024-01-02', '2024-01-10', '2024-01-09', 1, 2),
(2, '2024-02-05', '2024-02-15', NULL, 2, 3),
(3, '2024-03-12', '2024-03-20', '2024-03-25', 3, 3),
(4, '2024-04-15', '2024-04-25', NULL, 4, 4),
(5, '2024-05-10', '2024-05-18', '2024-05-20', 5, 5);

-- Insert data into Reservations table
INSERT INTO Reservations (id, Reservation_Date, Status, member_id, book_id) VALUES
(1, '2024-06-10', 'Pending', 1, 1),
(2, '2024-07-15', 'Approved', 2, 3),
(3, '2024-08-20', 'Rejected', 3, 4),
(4, '2024-09-25', 'Pending', 4, 5),
(5, '2024-10-30', 'Approved', 5, 2);

-- Insert data into libaray_staff table
INSERT INTO libaray_staff (id, Name, Contact_Info, Assigned_Section, Employment_Date) VALUES
(1, 'Librarian 1', '5678901234', 'Fiction', '2020-01-15'),
(2, 'Librarian 2', '6789012345', 'Education', '2019-06-20'),
(3, 'Librarian 3', '7890123456', 'Science', '2021-03-30'),
(4, 'Librarian 4', '8901234567', 'Technology', '2018-11-10'),
(5, 'Librarian 5', '9012345678', 'Programming', '2022-05-05');

-- Insert data into Categories table
INSERT INTO Categories (id, Name, Description, book_id) VALUES
(1, 'Education', 'Books related to educational topics', 1),
(2, 'Programming', 'Books about coding and development', 2),
(3, 'Technology', 'Tech-related books', 3),
(4, 'Science', 'Science books', 4),
(5, 'Data Science', 'Books on data analysis and AI', 5);


------------1---------------


select * from member_ where Registration_Date='2025-01-01';


------------2---------------

select * from book where title='Database Fundamentals';


----------------3----------

alter table member_ add email varchar(100);



-----------------4--------------

insert into member_ values (1,'omar','student','2024-06-05','omarg@gmail.com');

----------5---------------

SELECT DISTINCT member_.*
FROM member_
INNER JOIN Reservations ON member_.id = Reservations.member_id;

------------6------------

select member_.*
from member_
inner join member_book on member_book.id = member_.id
inner join book on book.id = member_book.book_id
where Title = 'SQL for Beginners';

----------------7------------

select member_.* 
from member_ 
inner join member_book on member_book.member_id = member_.id
inner join book on book.id = member_book.book_id
where member_book.return_ IS NOT NULL and book.Title='C# Programming';

--------------8---------------


select member_.* 
from member_ 
inner join member_book on member_.id = member_book.member_id
where member_book.return_>member_book.due_data;


---------------9----------------

select     member_book.book_id , book.Title
FROM book
INNER JOIN member_book 
ON book.id = member_book.book_id
GROUP BY member_book.book_id ,  book.Title
HAVING COUNT  (book.id ) >=3


-----------10--------------



select *
from member_ 
inner join member_book on member_.id=member_book.member_id
where borrowing_data between '2024-01-01' and '2024-01-10';


--------------------11---------------



select count(Availability_Status) as available_book 
from book
where Availability_Status='available'
group by Availability_Status