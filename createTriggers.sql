DELIMITER //;
CREATE TRIGGER CHECK_EMPLOYEE 
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN 
	IF CHAR_LENGTH(NEW.USERNAME) < 6
	THEN SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Username must be at least 6 characters';
	END IF;
	
	IF CHAR_LENGTH(NEW.PASSWORD) < 8
	THEN SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Password must be at least 8 characters';
	END IF;
	
	IF CHAR_LENGTH(NEW.FIRSTNAME) < 1
	THEN SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'First name cannot be empty';
	END IF;
	
	IF CHAR_LENGTH(NEW.LASTNAME) < 1
	THEN SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Last name cannot be empty';
	END IF;
END; 

/

DELIMITER //;
CREATE TRIGGER CHECK_CUSTOMER 
BEFORE INSERT ON CUSTOMER
FOR EACH ROW
BEGIN 
	IF CHAR_LENGTH(NEW.USERNAME) < 6
	THEN SIGNAL SQLSTATE '10001' SET MESSAGE_TEXT = 'Username must be at least 6 characters';
	END IF;
	
	IF CHAR_LENGTH(NEW.PASSWORD) < 8
	THEN SIGNAL SQLSTATE '10001' SET MESSAGE_TEXT = 'Password must be at least 8 characters';
	END IF;
	
	IF CHAR_LENGTH(NEW.FIRSTNAME) < 1
	THEN SIGNAL SQLSTATE '10001' SET MESSAGE_TEXT = 'First name cannot be empty';
	END IF;
	
	IF CHAR_LENGTH(NEW.LASTNAME) < 1
	THEN SIGNAL SQLSTATE '10001' SET MESSAGE_TEXT = 'Last name cannot be empty';
	END IF;
END; 

/

DELIMITER //;
create trigger calc_days_insert
before insert on reservation
for each row
begin
	if (datediff(day, new.startDate, new.endDate) > 60)
	then signal sqlstate'10002' set message_text = 'Reservation cannot be greater than 60 days';	
    else
	set new.numOfDays = datediff(day, new.startDate, new.endDate);
    end if;
end;

/

DELIMITER //;
create trigger calc_days_update
before update on reservation
for each row
begin
	if (datediff(day, new.startDate, new.endDate) > 60)
	then signal sqlstate'10002' set message_text = 'Reservation cannot be greater than 60 days';	
    else
	set new.numOfDays = datediff(d, new.startDate, new.endDate);
    end if;
end;