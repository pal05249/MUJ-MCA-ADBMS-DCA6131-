-- 1. Create tables with primary keys and foreign keys

CREATE TABLE PERSON (
    driver_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE CAR (
    regno VARCHAR(20) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);

CREATE TABLE ACCIDENT (
    report_number INT PRIMARY KEY,
    accd_date DATE,
    location VARCHAR(100)
);

CREATE TABLE OWNS (
    driver_id VARCHAR(20),
    regno VARCHAR(20),
    PRIMARY KEY (driver_id, regno),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (regno) REFERENCES CAR(regno)
);

CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(20),
    regno VARCHAR(20),
    report_number INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, regno, report_number),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (regno) REFERENCES CAR(regno),
    FOREIGN KEY (report_number) REFERENCES ACCIDENT(report_number)
);

-- 2. Insert tuples

INSERT INTO PERSON VALUES ('D001', 'John Doe', '123 Main St');
INSERT INTO PERSON VALUES ('D002', 'Jane Smith', '456 Elm St');
INSERT INTO PERSON VALUES ('D003', 'Michael Johnson', '789 Oak St');
INSERT INTO PERSON VALUES ('D004', 'Emily Brown', '101 Pine St');
INSERT INTO PERSON VALUES ('D005', 'David Wilson', '202 Maple St');

INSERT INTO CAR VALUES ('ABC123', 'Toyota Camry', 2010);
INSERT INTO CAR VALUES ('DEF456', 'Honda Civic', 2008);
INSERT INTO CAR VALUES ('GHI789', 'Ford Focus', 2015);
INSERT INTO CAR VALUES ('JKL012', 'Chevrolet Malibu', 2012);
INSERT INTO CAR VALUES ('MNO345', 'Nissan Altima', 2009);

INSERT INTO ACCIDENT VALUES (1, '2024-03-15', 'Intersection of 1st St and Main St');
INSERT INTO ACCIDENT VALUES (2, '2024-03-16', 'Highway 101');
INSERT INTO ACCIDENT VALUES (3, '2024-03-17', 'Parking lot near Oak St');
INSERT INTO ACCIDENT VALUES (4, '2024-03-18', 'Residential area on Pine St');
INSERT INTO ACCIDENT VALUES (5, '2024-03-19', 'Downtown near Maple St');

INSERT INTO OWNS VALUES ('D001', 'ABC123');
INSERT INTO OWNS VALUES ('D002', 'DEF456');
INSERT INTO OWNS VALUES ('D003', 'GHI789');
INSERT INTO OWNS VALUES ('D004', 'JKL012');
INSERT INTO OWNS VALUES ('D005', 'MNO345');

INSERT INTO PARTICIPATED VALUES ('D001', 'ABC123', 1, 1500);
INSERT INTO PARTICIPATED VALUES ('D002', 'DEF456', 2, 2000);
INSERT INTO PARTICIPATED VALUES ('D003', 'GHI789', 3, 2500);
INSERT INTO PARTICIPATED VALUES ('D004', 'JKL012', 4, 3000);
INSERT INTO PARTICIPATED VALUES ('D005', 'MNO345', 5, 3500);

-- 3. Update damage amount

UPDATE PARTICIPATED
SET damage_amount = 25000
WHERE regno = 'ABC123' AND report_number = 1;

-- 4. Add a new accident

INSERT INTO ACCIDENT VALUES (6, '2024-03-20', 'Freeway exit ramp');

-- 5. Find total number of people involved in accidents in certain years

SELECT COUNT(DISTINCT driver_id)
FROM OWNS
JOIN PARTICIPATED ON OWNS.regno = PARTICIPATED.regno
JOIN ACCIDENT ON PARTICIPATED.report_number = ACCIDENT.report_number
WHERE YEAR(accd_date) = 2008;

-- 6. Find number of accidents involving cars of specific model

SELECT COUNT(*)
FROM CAR
JOIN PARTICIPATED ON CAR.regno = PARTICIPATED.regno
WHERE model = 'Honda Civic';

-- 7. Display owners and their car details

SELECT p.name, p.address, c.regno, c.model, c.year
FROM PERSON p
JOIN OWNS o ON p.driver_id = o.driver_id
JOIN CAR c ON o.regno = c.regno;
