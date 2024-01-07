CREATE DATABASE insurance;
USE insurance;

CREATE TABLE person (
driver_id VARCHAR(50) PRIMARY KEY,
driver_name VARCHAR(50),
address VARCHAR(150)
);

CREATE TABLE car (
reg_no VARCHAR(50) PRIMARY KEY,
model VARCHAR(50),
c_year INT
);

CREATE TABLE accident (
report_no INT PRIMARY KEY,
accident_date DATE,
location VARCHAR(150)
);

CREATE TABLE owns (
driver_id VARCHAR(50),
reg_no VARCHAR(50),
FOREIGN KEY (driver_id) REFERENCES person(driver_id),
FOREIGN KEY (reg_no) REFERENCES car(reg_no)
);

CREATE TABLE participated (
driver_id VARCHAR(50),
reg_no VARCHAR(50),
report_no INT,
damage_amount FLOAT,
FOREIGN KEY (driver_id) REFERENCES person(driver_id) ON DELETE CASCADE,
FOREIGN KEY (reg_no) REFERENCES car(reg_no) ON DELETE CASCADE,
FOREIGN KEY (report_no) REFERENCES accident(report_no)
);

SELECT COUNT(DISTINCT p.driver_id)
FROM accident a
JOIN participated pa ON a.report_no = pa.report_no
JOIN person p ON pa.driver_id = p.driver_id
WHERE p.driver_name = 'smith';


SELECT COUNT(DISTINCT pe.driver_name)
FROM person pe
JOIN participated pa ON pe.driver_id = pa.driver_id
JOIN car c ON pa.reg_no = c.reg_no;
