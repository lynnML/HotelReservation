-- DROP DATABASE IF EXISTS HOTELMGR;
-- CREATE DATABASE HOTELMGR;

DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
	customerId INT(10) AUTO_INCREMENT NOT NULL,
	userName VARCHAR(20) NOT NULL, 
	password VARCHAR(20) NOT NULL, 
	firstName VARCHAR(20) NOT NULL, 
	lastName VARCHAR(20) NOT NULL,
	birthDate DATE NOT NULL,
	gender ENUM ('M', 'F', 'D'),
	phoneNumber VARCHAR(15) NOT NULL,
	address VARCHAR(100) NOT NULL,
	PRIMARY KEY (customerId),
	UNIQUE KEY (userName)
);

DELIMITER $$
CREATE TRIGGER CHECK_CUSTOMER 
BEFORE INSERT ON CUSTOMER
FOR EACH ROW
BEGIN 
	IF CHAR_LENGTH(NEW.USERNAME) < 6
	THEN SIGNAL SQLSTATE '10001' SET MESSAGE_TEXT := 'Username must be at least 6 characters';
	END IF;
	
	IF CHAR_LENGTH(NEW.PASSWORD) < 8
	THEN SIGNAL SQLSTATE '10001' SET MESSAGE_TEXT := 'Password must be at least 8 characters';
	END IF;
	
	IF CHAR_LENGTH(NEW.FIRSTNAME) < 1
	THEN SIGNAL SQLSTATE '10001' SET MESSAGE_TEXT := 'First name cannot be empty';
	END IF;
	
	IF CHAR_LENGTH(NEW.LASTNAME) < 1
	THEN SIGNAL SQLSTATE '10001' SET MESSAGE_TEXT := 'Last name cannot be empty';
	END IF;
END
$$ DELIMITER;

DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE (
	customerId INT(10) AUTO_INCREMENT NOT NULL,
	userName VARCHAR(20) NOT NULL, 
	password VARCHAR(20) NOT NULL, 
	firstName VARCHAR(20) NOT NULL, 
	lastName VARCHAR(20) NOT NULL,
	birthDate DATE NOT NULL,
	gender ENUM ('M', 'F', 'D'),
	phoneNumber VARCHAR(15) NOT NULL,
	address VARCHAR(100) NOT NULL,
	PRIMARY KEY (customerId),
	UNIQUE KEY (userName)
	employeeRole ENUM ('Manager', 'Receptionist', 'Room Service'),
	PRIMARY KEY (customerId),
	UNIQUE KEY (userName)
);

-- DELIMITER $$
-- CREATE TRIGGER CHECK_EMPLOYEE 
-- BEFORE INSERT ON EMPLOYEE
-- FOR EACH ROW
-- BEGIN 
--	IF CHAR_LENGTH(NEW.USERNAME) < 6
--	THEN SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT := 'Username must be at least 6 characters';
--	END IF;
	
--	IF CHAR_LENGTH(NEW.PASSWORD) < 8
--	THEN SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT := 'Password must be at least 8 characters';
--	END IF;
	
--	IF CHAR_LENGTH(NEW.FIRSTNAME) < 1
--	THEN SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT := 'First name cannot be empty';
--	END IF;
	
--	IF CHAR_LENGTH(NEW.LASTNAME) < 1
--	THEN SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT := 'Last name cannot be empty';
--	END IF;
-- END
-- $$ DELIMITER;

DROP TABLE IF EXISTS ROOM;
CREATE TABLE ROOM (
	roomId INT AUTO_INCREMENT NOT NULL,
	costPerNight DOUBLE(10) NOT NULL,
	maxOccupancy INT(10) NOT NULL,
	beds INT(10) NOT NULL,
	PRIMARY KEY (roomId)
);

DROP TABLE IF EXISTS RESERVATION;
CREATE TABLE RESERVATION (
	reservationId INT(10) AUTO_INCREMENT NOT NULL,
	roomId INT(10) NOT NULL,
	customerId INT(10) NOT NULL,
	from DATE NOT NULL,
	to DATE NOT NULL,
	numOfDays INT(10) NOT NULL,
	totalCost DOUBLE(10) NOT NULL,
	keyReturned BOOLEAN NOT NULL,
	paid BOOLEAN NOT NULL,
	canceled BOOLEAN NOT NULL,
	PRIMARY KEY (reservationId, roomId, from, to),
	FOREIGN KEY (roomId) references Room (roomId),
	FOREIGN KEY (customerId) references Book (customerId)
);

DROP TABLE IF EXISTS ROOMSERVICE;
CREATE TABLE ROOMSERVICE (
	taskId INT(10) AUTO_INCREMENT NOT NULL,
	task VARCHAR(100) NOT NULL,
	employeeId INT(10) NOT NULL,
	roomId INT(10) NOT NULL,
	reservationId INT(10) NOT NULL,
	time DATE NOT NULL,
	cost DOUBLE(10) NOT NULL,
	PRIMARY KEY (taskId),
	FOREIGN KEY (employeeId) references Employee (employeeId),
	FOREIGN KEY (roomId) references Room (roomId),
	FOREIGN KEY (reservationId) references Reservation (reservationId)
);

DROP TABLE IF EXISTS LOGIN;
CREATE TABLE LOGIN (
	username VARCHAR(20) NOT NULL,
	password VARCHAR(20) NOT NULL,
	successful BOOLEAN NOT NULL,
	time DATE NOT NULL,
	numOfConsecTries INT(10) NOT NULL,
	PRIMARY KEY (username)
);

DROP TABLE IF EXISTS QUESTION;
CREATE TABLE QUESTION (
	customerId INT(10) NOT NULL,
	question VARCHAR(50) NOT NULL,
	answer VARCHAR(30) NOT NULL,
	PRIMARY KEY (customerId)
);

DROP TABLE IF EXISTS COMPLAINT;
CREATE TABLE COMPLAINT (
	complaintId INT(10) NOT NULL,
	customerId INT(10) NOT NULL,
	complaint VARCHAR(100) NOT NULL,
	time DATE NOT NULL,
	resolvedBy INT(10) NOT NULL,
	solution VARCHAR(100) NOT NULL,
	PRIMARY KEY (complaintId),
	FOREIGN KEY (customerId) references Customer (customerId),
	FOREIGN KEY (resolvedBy) references Employee (employeeId)
);

