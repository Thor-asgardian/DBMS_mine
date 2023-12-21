CREATE TABLE sailor(
sid INT PRIMARY KEY,
sname VARCHAR(20),
rating FLOAT,
age INT
);

CREATE TABLE boat(
bid INT PRIMARY KEY,
bname VARCHAR(20),
color VARCHAR(20)
);

CREATE TABLE rserver(
sid INT,
bid INT,
dojoin DATE
);

INSERT INTO sailor (sid, sname, rating, age) VALUES (201, 'Albert', 7, 30);

INSERT INTO sailor (sid, sname, rating, age) VALUES (202, 'Abrahim', 9, 32);

INSERT INTO sailor (sid, sname, rating, age) VALUES (203, 'bhaskar', 6, 30);

INSERT INTO sailor (sid, sname, rating, age) VALUES (204, 'Newton', 5, 30);

INSERT INTO sailor (sid, sname, rating, age) VALUES (205, 'Einstien', 8, 30);

SELECT * FROM sailor;

INSERT INTO boat (bid, bname, color) VALUES (101, 'boat1', 'Yellow');

INSERT INTO boat (bid, bname, color) VALUES (202, 'boat2', 'Red');

INSERT INTO boat (bid, bname, color) VALUES (203, 'boat3', 'Green');

INSERT INTO boat (bid, bname, color) VALUES (204, 'boat4', 'White');

INSERT INTO boat (bid, bname, color) VALUES (205, 'boat5', 'Orange');

SELECT * FROM boat;

INSERT INTO rserver (sid, bid, dojoin) VALUES (201, 101, '2000-02-10');

INSERT INTO rserver (sid, bid, dojoin) VALUES (202, 102, '2001-07-07');

INSERT INTO rserver (sid, bid, dojoin) VALUES (203, 103, '2003-10-29');

INSERT INTO rserver (sid, bid, dojoin) VALUES (204, 104, '2007-07-07');

INSERT INTO rserver (sid, bid, dojoin) VALUES (205, 105, '2011-07-07');

SELECT * FROM rserver;

SELECT *
FROM sailor
WHERE sname LIKE '%A%';

SELECT s.sname
FROM sailor s
WHERE s.sid IN (SELECT rs.sid FROM rserver rs);

SELECT s.*
FROM sailor s
WHERE EXISTS (SELECT 1 FROM rserver rs WHERE s.sid = rs.sid);

CREATE TRIGGER T1
AFTER INSERT ON sailor
FOR EACH ROW
    INSERT INTO sail (sid, sname, rating, age)
    VALUES (NEW.sid, NEW.sname, DEFAULT, DEFAULT);
