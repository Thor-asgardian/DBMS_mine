CREATE DATABASE insurance;
USE insurance;

CREATE TABLE person (
driverid VARCHAR(50) PRIMARY KEY, 
drivernm VARCHAR(30), 
address VARCHAR(100)
);

CREATE TABLE car (
regno VARCHAR(50) PRIMARY KEY, 
model VARCHAR(30), 
year_of_manufacture INT
);

CREATE TABLE accident (
report_number INT, 
acc_date DATE, 
location VARCHAR(50)
); 

CREATE TABLE owns (
driverid VARCHAR(50) PRIMARY KEY, 
regno VARCHAR(50),
FOREIGN KEY (driverid) REFERENCES person (driverid),
FOREIGN KEY (regno) REFERENCES car (regno)
); 

CREATE TABLE participated (
driverid VARCHAR(50),
regno VARCHAR(50),
report_number INT,
damage_amount DECIMAL(10, 2),
FOREIGN KEY (driverid) REFERENCES person(driverid) ON DELETE CASCADE,
FOREIGN KEY (regno) REFERENCES car(regno) ON DELETE CASCADE,
FOREIGN KEY (reportnumber) REFERENCES accident(reportnumber)
);
