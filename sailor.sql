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

-- Find the colours of boats reserved by Albert

SELECT color FROM boat b
JOIN reserves r ON b.bid=r.bid
WHERE r.sid=(SELECT sid FROM sailor WHERE sname="albert");

-- Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103

SELECT sailor_id
FROM Reserves
WHERE rating >= 8 OR boat_id = 103;

-- Find the names of sailors who have not reserved a boat whose name contains the string “storm”. Order the names in ascending order.

SELECT DISTINCT Sailors.sailor_name
FROM Sailors
WHERE Sailors.sid NOT IN (
    SELECT Reserves.sid
    FROM Reserves
    JOIN Boats ON Reserves.bid = Boats.bid
    WHERE Boats.boat_name LIKE '%storm%'
)
  ORDER BY Sailors.sailor_name ASC;

-- Find the names of sailors who have reserved all boats.

SELECT DISTINCT S.sname
FROM Sailors S
WHERE NOT EXISTS (
    SELECT B.bid
    FROM Boats B
    WHERE NOT EXISTS (
        SELECT R.bid
        FROM Reserves R
        WHERE R.sid = S.sid AND R.bid = B.bid
    )
);

-- Find the name and age of the oldest sailor.

SELECT sname,age FROM sailor 
WHERE age=(SELECT MAX(s.age) FROM sailor s);

-- For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and the average age of such sailors.

SELECT b.bid,AVG(s.age) 
FROM sailor s,boat b,reserves r
WHERE s.age>=40 AND s.sid=r.sid AND r.bid=b.bid
GROUP BY b.bid
HAVING COUNT(DISTINCT(s.sid))>=5;

-- Create a view that shows the names and colours of all the boats that have been reserved by a sailor with a specific rating.    

CREATE VIEW Boat_reservation AS
SELECT bname, color
FROM BOAT b
JOIN RESERVES r ON b.bid = r.bid
JOIN SAILOR s ON s.sid = r.sid
WHERE rating = 8;
SELECT * FROM Boat_reservation;

-- A trigger that prevents boats from being deleted If they have active reservations.

CREATE TRIGGER Prevent_Delete_Boats
BEFORE DELETE ON BOAT
FOR EACH ROW
BEGIN
IF (EXISTS (SELECT * FROM RESERVES WHERE bid = OLD.bid)) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot delete boat with active reservations';
END IF;
END;
