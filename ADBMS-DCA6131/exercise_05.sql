-- 1. Create tables with primary keys and foreign keys
CREATE TABLE AUTHOR (
    author_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE PUBLISHER (
    publisher_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE CATEGORY (
    category_id INT PRIMARY KEY,
    description VARCHAR(100)
);

CREATE TABLE CATALOG (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT,
    publisher_id INT,
    category_id INT,
    year INT,
    price INT,
    FOREIGN KEY (author_id) REFERENCES AUTHOR(author_id),
    FOREIGN KEY (publisher_id) REFERENCES PUBLISHER(publisher_id),
    FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id)
);

CREATE TABLE ORDER_DETAILS (
    order_no INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    FOREIGN KEY (book_id) REFERENCES CATALOG(book_id)
);

-- 2. Insert data into tables
INSERT INTO AUTHOR VALUES
(1, 'J.K. Rowling', 'London', 'United Kingdom'),
(2, 'George R.R. Martin', 'Bayonne', 'United States'),
(3, 'Stephen King', 'Portland', 'United States'),
(4, 'Agatha Christie', 'Torquay', 'United Kingdom'),
(5, 'Haruki Murakami', 'Kyoto', 'Japan');

INSERT INTO PUBLISHER VALUES
(1, 'Bloomsbury Publishing', 'London', 'United Kingdom'),
(2, 'Bantam Books', 'New York', 'United States'),
(3, 'Doubleday', 'New York', 'United States'),
(4, 'HarperCollins', 'New York', 'United States'),
(5, 'Shinchosha', 'Tokyo', 'Japan');

INSERT INTO CATEGORY VALUES
(1, 'Fiction'),
(2, 'Mystery'),
(3, 'Thriller'),
(4, 'Fantasy');

INSERT INTO CATALOG VALUES
(1, 'Harry Potter and the Philosopher''s Stone', 1, 1, 1, 1997, 20),
(2, 'A Game of Thrones', 2, 2, 4, 1996, 25),
(3, 'The Shining', 3, 3, 3, 1977, 18),
(4, 'Murder on the Orient Express', 4, 4, 2, 1934, 15),
(5, 'Norwegian Wood', 5, 5, 1, 1987, 22);

INSERT INTO ORDER_DETAILS VALUES
(1, 1, 100),
(2, 2, 150),
(3, 3, 80),
(4, 4, 120),
(5, 5, 90);

-- 3. Retrieve authors with 2 or more books, books with price > average price, and year > 2000
SELECT A.author_id, A.name
FROM AUTHOR A
JOIN CATALOG C ON A.author_id = C.author_id
WHERE C.year > 2000
GROUP BY A.author_id, A.name
HAVING COUNT(*) >= 2 AND AVG(C.price) < (SELECT AVG(price) FROM CATALOG);

-- 4. Find the author with maximum sales
SELECT A.author_id, A.name
FROM AUTHOR A
JOIN CATALOG C ON A.author_id = C.author_id
JOIN ORDER_DETAILS O ON C.book_id = O.book_id
GROUP BY A.author_id, A.name
ORDER BY SUM(O.quantity) DESC
LIMIT 1;

-- 5. Increase price of books from a specific publisher by 10%
UPDATE CATALOG
SET price = price * 1.1
WHERE publisher_id = [specific_publisher_id];

-- 6. Use UNION to combine results from AUTHOR and CATALOG
SELECT author_id, name FROM AUTHOR
UNION
SELECT author_id, title FROM CATALOG;
