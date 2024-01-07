CREATE DATABASE orderprocess;
USE orderprocess;

CREATE TABLE cust(
Custno INT PRIMARY KEY, 
cname VARCHAR(50), 
city VARCHAR(70)
);

CREATE TABLE orderplace(
orderno INT PRIMARY KEY,
odate DATE,
custno INT,
order_amt INT,
FOREIGN KEY (custno) REFERENCES cust (custno)
);

CREATE TABLE order_item(
Itemno INT PRIMARY KEY,
orderno INT,
qty INT,
FOREIGN KEY (orderno) REFERENCES orderplace (orderno)
);

CREATE TABLE Warehouse (
warehouseno VARCHAR(5) PRIMARY KEY,
city VARCHAR(40)
);

CREATE TABLE Shipment (
orderno INT,
warehouseno INT,
shipdate DATE,
FOREIGN KEY (warehouseno) REFERENCES Warehouse (warehouseno),
FOREIGN KEY (orderno) REFERENCES orderplace (orderno)
);

CREATE TABLE item (
itemno INT, 
unitprice INT,
FOREIGN KEY (itemno) REFERENCES order_item (itemno)
);

INSERT INTO cust(Custno, cname, city) VALUES (1001, 'Bhangaarwaala', 'city1');
INSERT INTO cust(Custno, cname, city) VALUES (1002, 'kumar', 'city2');
INSERT INTO cust(Custno, cname, city) VALUES (1003, 'madan', 'city3');
INSERT INTO cust(Custno, cname, city) VALUES (1004, 'ravindra', 'city4');
INSERT INTO cust(Custno, cname, city) VALUES (1005, 'tony', 'city5');

INSERT INTO orderplace(orderno, odate, custno, order_amt) VALUES (101, '2023-12-12', 1001, 1000);
INSERT INTO orderplace(orderno, odate, custno, order_amt) VALUES (102, '2023-12-12', 1002, 2000);
INSERT INTO orderplace(orderno, odate, custno, order_amt) VALUES (103, '2023-12-13', 1003, 3000);
INSERT INTO orderplace(orderno, odate, custno, order_amt) VALUES (104, '2023-12-14', 1004, 4000);
INSERT INTO orderplace(orderno, odate, custno, order_amt) VALUES (105, '2023-12-15', 1005, 5000);

INSERT INTO order_item(Itemno, orderno, qty) VALUES (1, 101, 100);
INSERT INTO order_item(Itemno, orderno, qty) VALUES (2, 102, 200);
INSERT INTO order_item(Itemno, orderno, qty) VALUES (3, 103, 300);
INSERT INTO order_item(Itemno, orderno, qty) VALUES (4, 104, 400);
INSERT INTO order_item(Itemno, orderno, qty) VALUES (5, 105, 100);

INSERT INTO Warehouse(warehouseno, city) VALUES ('W1', 'city1');
INSERT INTO Warehouse(warehouseno, city) VALUES ('W2', 'city2');
INSERT INTO Warehouse(warehouseno, city) VALUES ('W3', 'city3');
INSERT INTO Warehouse(warehouseno, city) VALUES ('W4', 'city4');
INSERT INTO Warehouse(warehouseno, city) VALUES ('W5', 'city5');

INSERT INTO Shipment(orderno, warehouseno, shipdate) VALUES (101, 'W1', '2024-01-01');
INSERT INTO Shipment(orderno, warehouseno, shipdate) VALUES (102, 'W2', '2024-01-02');
INSERT INTO Shipment(orderno, warehouseno, shipdate) VALUES (103, 'W3', '2024-01-03');
INSERT INTO Shipment(orderno, warehouseno, shipdate) VALUES (104, 'W4', '2024-01-04');
INSERT INTO Shipment(orderno, warehouseno, shipdate) VALUES (105, 'W5', '2024-01-05');

INSERT INTO item(itemno, unitprice) VALUES (1, 500);
INSERT INTO item(itemno, unitprice) VALUES (2, 1000);
INSERT INTO item(itemno, unitprice) VALUES (3, 1500);
INSERT INTO item(itemno, unitprice) VALUES (4, 2000);
INSERT INTO item(itemno, unitprice) VALUES (5, 2500);

SELECT orderno, shipdate
FROM shipment
WHERE Warehouseno = 'W2';

SELECT w.warehouseno, w.city
FROM Warehouse w
INNER JOIN Shipment s ON w.warehouseno = s.warehouseno
INNER JOIN orderplace o ON s.orderno = o.orderno
INNER JOIN cust c ON o.custno = c.custno
WHERE c.cname = 'kumar';

SELECT cname, COUNT(DISTINCT orderno)
AS orderno, AVG(order_amt)
AS avg_order_amt FROM
cust c
JOIN orderplace o ON
c.Custno = o.custno
GROUP BY c.cname;

DELETE FROM orderplace
WHERE orderno IN (
    SELECT o.orderno
    FROM orderplace o
    JOIN cust c ON o.custno = c.Custno
    WHERE c.cname = 'kumar'
);

SELECT MAX(DISTINCT unitprice)
FROM item;

CREATE TRIGGER t1
AFTER UPDATE 
ON order_item
FOR EACH ROW
BEGIN
    SET NEW.orderamt = NEW.qty * NEW.unitprice;
END;

CREATE VIEW v1 AS
SELECT orderno, shipdate
FROM shipment;

SELECT * FROM v1;
