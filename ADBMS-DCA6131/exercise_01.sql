create database manipal_institute;

CREATE TABLE students_department_mechanical (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(100),
    student_name VARCHAR(100),
    sex CHAR(1),
    phone_number INTEGER,
    date_of_birth DATE,
    dept VARCHAR(100),
    address VARCHAR(100)
);

CREATE TABLE students_department_computer (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(100),
    student_name VARCHAR(100),
    sex CHAR(1),
    phone_number INTEGER,
    date_of_birth DATE,
    dept VARCHAR(100),
    address VARCHAR(100)
);

CREATE TABLE students_department_electronics (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(100),
    student_name VARCHAR(100),
    sex CHAR(1),
    phone_number INTEGER,
    date_of_birth DATE,
    dept VARCHAR(100),
    address VARCHAR(100)
);
--1
SELECT DATABASE();
-- 1.Get information about your Database and tables
SHOW TABLES;

-- 2.Add two new column in each table as Roll_number and Marks (in percentage or CGPA)
-- For the students_department_mechanical table
ALTER TABLE students_department_mechanical
ADD COLUMN Roll_number VARCHAR(20),
ADD COLUMN Marks DECIMAL(5, 2); -- Assuming Marks will be stored as a decimal value, adjust the precision and scale accordingly

-- For the students_department_electronics table
ALTER TABLE students_department_electronics
ADD COLUMN Roll_number VARCHAR(20),
ADD COLUMN Marks DECIMAL(5, 2);

-- For the students_department_computer table
ALTER TABLE students_department_computer
ADD COLUMN Roll_number VARCHAR(20),
ADD COLUMN Marks DECIMAL(5, 2);

-- 3. Enter at least five tuples for each relation in each table.
-- Inserting tuples into the students_department_mechanical table
INSERT INTO students_department_mechanical (student_id, student_name, sex, phone_number, date_of_birth, dept, address, Roll_number, Marks)
VALUES
('M001', 'John Doe', 'M', '1234567890', '2000-05-15', 'Mechanical Engineering', '123 Main St, City', 'M001', 85.5),
('M002', 'Jane Smith', 'F', '9876543210', '2001-02-20', 'Mechanical Engineering', '456 Elm St, Town', 'M002', 78.2),
('M003', 'Alice Johnson', 'F', '5551234567', '1999-11-10', 'Mechanical Engineering', '789 Oak St, Village', 'M003', 90.0),
('M004', 'Bob Brown', 'M', '7778889999', '2002-07-25', 'Mechanical Engineering', '101 Pine St, County', 'M004', 82.3),
('M005', 'Michael Lee', 'M', '3332221111', '2000-12-30', 'Mechanical Engineering', '202 Maple St, Suburb', 'M005', 88.7);

-- Inserting tuples into the students_department_electronics table
INSERT INTO students_department_electronics (student_id, student_name, sex, phone_number, date_of_birth, dept, address, Roll_number, Marks)
VALUES
('E001', 'Emily White', 'F', '1234567890', '2000-05-15', 'Electronics Engineering', '123 Main St, City', 'E001', 85.5),
('E002', 'David Johnson', 'M', '9876543210', '2001-02-20', 'Electronics Engineering', '456 Elm St, Town', 'E002', 78.2),
('E003', 'Sophia Miller', 'F', '5551234567', '1999-11-10', 'Electronics Engineering', '789 Oak St, Village', 'E003', 90.0),
('E004', 'Daniel Wilson', 'M', '7778889999', '2002-07-25', 'Electronics Engineering', '101 Pine St, County', 'E004', 82.3),
('E005', 'Olivia Brown', 'F', '3332221111', '2000-12-30', 'Electronics Engineering', '202 Maple St, Suburb', 'E005', 88.7);

-- Inserting tuples into the students_department_computer table
INSERT INTO students_department_computer (student_id, student_name, sex, phone_number, date_of_birth, dept, address, Roll_number, Marks)
VALUES
('C001', 'Michael Scott', 'M', '1234567890', '2000-05-15', 'Computer Science', '123 Main St, City', 'C001', 85.5),
('C002', 'Pam Beesly', 'F', '9876543210', '2001-02-20', 'Computer Science', '456 Elm St, Town', 'C002', 78.2),
('C003', 'Jim Halpert', 'M', '5551234567', '1999-11-10', 'Computer Science', '789 Oak St, Village', 'C003', 90.0),
('C004', 'Dwight Schrute', 'M', '7778889999', '2002-07-25', 'Computer Science', '101 Pine St, County', 'C004', 82.3),
('C005', 'Angela Martin', 'F', '3332221111', '2000-12-30', 'Computer Science', '202 Maple St, Suburb', 'C005', 88.7);

--4.Delete the column Phone_no. in any one table.
ALTER TABLE students_department_electronics
DROP COLUMN phone_number;

-- 5.Update any one table for column with certain roll number and address.
UPDATE students_department_computer
SET address = 'New Address'
WHERE Roll_number = 'C003';

-- 6.Modify existing column with new data type.
ALTER TABLE students_department_computer
MODIFY COLUMN Marks FLOAT(5, 2); -- Change data type to FLOAT with precision of 5 digits and 2 decimal places

-- 7.Delete any one tuples from any two tables with Marks less than certain value (say 85%)
-- Deleting tuples from students_department_computer table
DELETE FROM students_department_computer
WHERE Marks < 85.0;

-- Deleting tuples from students_department_electronics table
DELETE FROM students_department_electronics
WHERE Marks < 85.0;

-- 8.Drop any one table (say student table of Mechanical Dept.)
DROP TABLE students_department_mechanical;

-- 9.Get the table with only two columns: name and Age (of STUDENT).
SELECT student_name AS name, TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS Age
FROM students_department_computer;


