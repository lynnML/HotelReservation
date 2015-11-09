DROP DATABASE IF EXISTS hoteldb;
CREATE DATABASE hoteldb;
USE hoteldb;

DROP TABLE IF EXISTS user;
CREATE TABLE user (
	userId INT(10) AUTO_INCREMENT NOT NULL,
	username VARCHAR(20) NOT NULL, 
	password VARCHAR(20) NOT NULL, 
	firstName VARCHAR(20) NOT NULL, 
	lastName VARCHAR(20) NOT NULL,
	age INT NOT NULL,
	gender ENUM ('M', 'F', 'D'),
	phoneNumber VARCHAR(15) NOT NULL,
	address VARCHAR(100) NOT NULL,
    userRole ENUM ('customer', 'manager', 'receptionist', 'room service'),
    employeeCode INT(10),
	question VARCHAR(50) NOT NULL,
	answer VARCHAR(30) NOT NULL,
	PRIMARY KEY (userId),
	UNIQUE KEY (username)
);

DROP TABLE IF EXISTS room;
CREATE TABLE room (
	roomId INT(10) NOT NULL AUTO_INCREMENT,
	costPerNight DOUBLE(10,2) NOT NULL,
	roomType ENUM('Luxury', 'Normal') NOT NULL,
	PRIMARY KEY (roomId)
);

DROP TABLE IF EXISTS reservation;
CREATE TABLE reservation (
	reservationId INT(10) NOT NULL AUTO_INCREMENT,
	roomId INT(10) NOT NULL,
	userId INT(10) NOT NULL,
	startDate DATETIME NOT NULL,
	endDate DATETIME NOT NULL,
	numOfDays INT(10) NOT NULL,
	totalCost DOUBLE(10,2) NOT NULL,
	keyReturned BOOLEAN NOT NULL DEFAULT FALSE,
	paid BOOLEAN NOT NULL DEFAULT FALSE,
	canceled BOOLEAN NOT NULL DEFAULT FALSE,
    updatedOn TIMESTAMP NOT NULL ON UPDATE current_timestamp,
	PRIMARY KEY (reservationId),
	FOREIGN KEY (roomId) references room (roomId) ON DELETE CASCADE,
	FOREIGN KEY (userId) references user (userId) ON DELETE CASCADE
);

DROP TABLE IF EXISTS roomservice;
CREATE TABLE roomservice (
	taskId INT(10) NOT NULL AUTO_INCREMENT,
	task VARCHAR(250) NOT NULL,
	userId INT(10) NOT NULL,
	roomId INT(10) NOT NULL,
	reservationId INT(10) NOT NULL,
	time DATE NOT NULL,
	cost DOUBLE(10,2) NOT NULL,
    updatedOn TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (taskId),
	FOREIGN KEY (userId) references user (userId) ON DELETE CASCADE,
	FOREIGN KEY (roomId) references room (roomId) ON DELETE CASCADE,
	FOREIGN KEY (reservationId) references reservation (reservationId) ON DELETE CASCADE
);

DROP TABLE IF EXISTS login;
CREATE TABLE login (
	username VARCHAR(20) NOT NULL,
	password VARCHAR(20) NOT NULL,
	successful BOOLEAN NOT NULL,
	numOfConsecTries INT(10) NOT NULL,
    updatedOn TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (username)
);

DROP TABLE IF EXISTS complaint;
CREATE TABLE complaint (
	complaintId INT(10) NOT NULL AUTO_INCREMENT,
	userId INT(10) NOT NULL,
	complaint VARCHAR(100) NOT NULL,
	time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	resolvedBy INT(10) NOT NULL DEFAULT 0,
	solution VARCHAR(100) NOT NULL DEFAULT '',
    updatedOn TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (complaintId),
	FOREIGN KEY (userId) references user (userId) ON DELETE CASCADE,
	FOREIGN KEY (resolvedBy) references user (userId) ON DELETE CASCADE
);