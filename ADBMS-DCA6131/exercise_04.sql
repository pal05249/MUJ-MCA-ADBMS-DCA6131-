-- 1. Create tables with primary keys and foreign keys

CREATE TABLE STUDENT (
    regno VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    major VARCHAR(50),
    bdate DATE
);

CREATE TABLE COURSE (
    course# INT PRIMARY KEY,
    cname VARCHAR(100),
    dept VARCHAR(50)
);

CREATE TABLE ENROLL (
    regno VARCHAR(10),
    course# INT,
    sem INT,
    marks INT,
    PRIMARY KEY (regno, course#),
    FOREIGN KEY (regno) REFERENCES STUDENT(regno),
    FOREIGN KEY (course#) REFERENCES COURSE(course#)
);

CREATE TABLE BOOK_ADOPTION (
    course# INT,
    sem INT,
    book_ISBN INT,
    PRIMARY KEY (course#, sem, book_ISBN),
    FOREIGN KEY (course#, sem) REFERENCES ENROLL(course#, sem),
    FOREIGN KEY (book_ISBN) REFERENCES TEXT(book_ISBN)
);

CREATE TABLE TEXT (
    book_ISBN INT PRIMARY KEY,
    book_title VARCHAR(200),
    publisher VARCHAR(100),
    author VARCHAR(100)
);

-- 2. Insert data into tables

-- Inserting into STUDENT
INSERT INTO STUDENT (regno, name, major, bdate) VALUES 
('S001', 'John Doe', 'Computer Science', '2000-01-01'),
('S002', 'Jane Smith', 'Electrical Engineering', '2000-02-02'),
('S003', 'Alice Johnson', 'Physics', '1999-03-03'),
('S004', 'Bob Brown', 'Mathematics', '2001-04-04'),
('S005', 'Emma White', 'Chemistry', '2002-05-05');

-- Inserting into COURSE
INSERT INTO COURSE (course#, cname, dept) VALUES 
(101, 'Introduction to Programming', 'Computer Science'),
(102, 'Circuit Analysis', 'Electrical Engineering'),
(103, 'Classical Mechanics', 'Physics'),
(104, 'Calculus', 'Mathematics'),
(105, 'Organic Chemistry', 'Chemistry');

-- Inserting into ENROLL
INSERT INTO ENROLL (regno, course#, sem, marks) VALUES 
('S001', 101, 1, 85),
('S002', 102, 1, 78),
('S003', 103, 1, 90),
('S004', 104, 1, 82),
('S005', 105, 1, 88);

-- Inserting into TEXT
INSERT INTO TEXT (book_ISBN, book_title, publisher, author) VALUES 
(1001, 'Programming Fundamentals', 'Pearson', 'Alice Johnson'),
(1002, 'Electric Circuits', 'Wiley', 'Bob Brown'),
(1003, 'Classical Mechanics', 'Oxford University Press', 'Charles Smith'),
(1004, 'Calculus: Early Transcendentals', 'McGraw-Hill', 'David Johnson'),
(1005, 'Organic Chemistry', 'Pearson', 'Emma White');

-- Inserting into BOOK_ADOPTION
INSERT INTO BOOK_ADOPTION (course#, sem, book_ISBN) VALUES 
(101, 1, 1001),
(102, 1, 1002),
(103, 1, 1003),
(104, 1, 1004),
(105, 1, 1005);

-- 3. Add a new textbook and adoption
INSERT INTO TEXT (book_ISBN, book_title, publisher, author) VALUES 
(1006, 'Introduction to Algorithms', 'MIT Press', 'Thomas Cormen');

INSERT INTO BOOK_ADOPTION (course#, sem, book_ISBN) VALUES 
(101, 2, 1006);

-- 4. List enrolled students
SELECT * FROM STUDENT WHERE regno IN (SELECT DISTINCT regno FROM ENROLL);

-- 5. List registered but not enrolled students
SELECT * FROM STUDENT WHERE regno NOT IN (SELECT DISTINCT regno FROM ENROLL);

-- 6. List adopted books
SELECT * FROM TEXT WHERE book_ISBN IN (SELECT DISTINCT book_ISBN FROM BOOK_ADOPTION);

-- 7. List departments with all books from a specific publisher
SELECT dept
FROM COURSE
GROUP BY dept
HAVING COUNT(*) = (SELECT COUNT(*)
                   FROM BOOK_ADOPTION BA
                   JOIN TEXT T ON BA.book_ISBN = T.book_ISBN
                   WHERE T.publisher = 'Pearson');

-- 8. Join operations
-- Inner Join
SELECT *
FROM STUDENT INNER JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

-- Left Join
SELECT *
FROM STUDENT LEFT JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

-- Right Join
SELECT *
FROM STUDENT RIGHT JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

-- Full Join (Assuming MySQL)
SELECT *
FROM STUDENT FULL JOIN ENROLL ON STUDENT.regno = ENROLL.regno;
