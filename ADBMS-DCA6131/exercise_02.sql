-- create database
create database supplier_management;

-- Supplier (scode: int, sname: string, scity: string, turnover: int)
-- Part (pcode: string, weight: int, color: string, cost: int, sellingprice: int)
-- Supplier_Part (scode: int, pcode: string, qty: int)

-- 1.Create the above tables
CREATE TABLE Supplier (
    scode INT PRIMARY KEY,
    sname VARCHAR(255),
    scity VARCHAR(255),
    turnover INT
);
CREATE TABLE Part (
    pcode VARCHAR(255) PRIMARY KEY,
    weight INT,
    color VARCHAR(255),
    cost INT,
    sellingprice INT
);
CREATE TABLE Supplier_Part (
    scode INT,
    pcode VARCHAR(255),
    qty INT,
    PRIMARY KEY (scode, pcode),
    FOREIGN KEY (scode) REFERENCES Supplier(scode),
    FOREIGN KEY (pcode) REFERENCES Part(pcode)
);

-- 2.Insert at least five suitable tuples for each relation
INSERT INTO Supplier (scode, sname, scity, turnover) VALUES
(1, 'ABC Electronics', 'New York', 100000),
(2, 'XYZ Tech', 'Los Angeles', 150000),
(3, 'Best Components', 'Chicago', 120000),
(4, 'Global Suppliers', 'Houston', 180000),
(5, 'Quality Parts Inc.', 'San Francisco', 90000);

INSERT INTO Part (pcode, weight, color, cost, sellingprice) VALUES
('P001', 50, 'Red', 20, 40),
('P002', 100, 'Blue', 30, 60),
('P003', 75, 'Green', 25, 50),
('P004', 90, 'Black', 35, 70),
('P005', 60, 'White', 15, 30);

INSERT INTO Supplier_Part (scode, pcode, qty) VALUES
(1, 'P001', 100),
(2, 'P002', 200),
(3, 'P003', 150),
(4, 'P004', 120),
(5, 'P005', 90);

-- 3.Get the supplier number and part number in ascending order of supplier number.
SELECT scode, pcode FROM Supplier_Part ORDER BY scode ASC;

-- 4.Get the details of supplier who operate from certain place (say Kolkata) with turnover 50.
SELECT * FROM Supplier WHERE scity = 'Kolkata' AND turnover = 50;

-- 5.Get the total number of supplier.
SELECT COUNT(*) AS total_suppliers FROM Supplier;

-- 6. Get pairs of supplier number such that both operate from the same city.
SELECT s1.scode AS supplier1, s2.scode AS supplier2, s1.scity AS city
FROM Supplier s1
INNER JOIN Supplier s2 ON s1.scity = s2.scity AND s1.scode < s2.scode;

-- 7. Get the part number (code) weighing between 25 and 35.
SELECT pcode
FROM Part
WHERE weight BETWEEN 25 AND 35;

-- 8. Get the supplier number whose turnover is null.
SELECT scode
FROM Supplier
WHERE turnover IS NULL;

-- 9. Get the part number that cost 20, 30 or 40 rupees.
SELECT pcode
FROM Part
WHERE cost IN (20, 30, 40);

-- 10. Get the supplier number of supplier are located in the same city (say Ahmedabad).
SELECT DISTINCT sp1.scode AS supplier1, sp2.scode AS supplier2
FROM Supplier_Part sp1
INNER JOIN Supplier_Part sp2 ON sp1.scode < sp2.scode
INNER JOIN Supplier s1 ON sp1.scode = s1.scode
INNER JOIN Supplier s2 ON sp2.scode = s2.scode
WHERE s1.scity = 'Ahmedabad' AND s2.scity = 'Ahmedabad';

-- 11. Get the part number for part whose cost is less than the current maximum cost.
SELECT pcode
FROM Part
WHERE cost < (SELECT MAX(cost) FROM Part);

-- 12. Get the part number whose cost is greater than the average cost.
SELECT pcode
FROM Part
WHERE cost > (SELECT AVG(cost) FROM Part);

-- 13. For each part supplied get part number and names of all cities supplying the part.
SELECT sp.pcode, s.scity
FROM Supplier_Part sp
JOIN Supplier s ON sp.scode = s.scode
ORDER BY sp.pcode, s.scity;

-- 14. Get the supplier number who supply at least one part supplied by supplier 5.
SELECT DISTINCT sp.scode
FROM Supplier_Part sp
WHERE sp.pcode IN (SELECT pcode FROM Supplier_Part WHERE scode = 5);

-- 15. Get the part number for the part supplied by more than one supplier.
SELECT pcode
FROM Supplier_Part
GROUP BY pcode
HAVING COUNT(DISTINCT scode) > 1;

-- 16. Get the names of suppliers who supply from city where there is at least one more supplier.
SELECT s.sname
FROM Supplier s
WHERE s.scity IN (
    SELECT scity
    FROM Supplier
    GROUP BY scity
    HAVING COUNT(*) > 1
);

-- 17. Get the part number of all the part being supplied with no duplicates.
SELECT DISTINCT pcode
FROM Supplier_Part;


