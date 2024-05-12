use dbmslab;
/* lab 8 practice: */

-- before update trigger

CREATE TABLE customer1 (
   acc_no INTEGER PRIMARY KEY,
   cust_name VARCHAR(20),
   avail_balance DECIMAL
);

CREATE TABLE mini_statement (
   acc_no INTEGER,
   avail_balance DECIMAL,
   FOREIGN KEY(acc_no) REFERENCES customer1(acc_no) ON DELETE CASCADE
);

INSERT INTO customer1 VALUES (1000, 'Fanny', 7000);
INSERT INTO customer1 VALUES (1001, 'Peter', 12000);

delimiter //
create trigger update_cus
before update on customer1
for each row
begin
insert into mini_statement values (old.acc_no,old.avail_balance);
end; //
delimiter ; 

UPDATE customer1 SET avail_balance = avail_balance + 3000 WHERE acc_no = 1001;
UPDATE customer1 SET avail_balance = avail_balance + 3000 WHERE acc_no = 1000;

select * from mini_statement;

-- after update trigger

CREATE TABLE customer2 (
   acc_no INTEGER PRIMARY KEY,
   cust_name VARCHAR(20),
   avail_balance DECIMAL
);

CREATE TABLE micro_statement (
   acc_no INTEGER,
   avail_balance DECIMAL,
   FOREIGN KEY(acc_no) REFERENCES customer2(acc_no) ON DELETE CASCADE
);

INSERT INTO customer2 VALUES (1002, 'Janitor', 4500);

delimiter //
create trigger update_after
after update on customer2
for each row
begin
insert into micro_statement VALUES(NEW.acc_no, NEW.avail_balance);
END; //
DELIMITER ;

UPDATE customer2 SET avail_balance = avail_balance + 1500 WHERE acc_no = 1002;

select * from micro_statement;

-- before insert trigger

CREATE TABLE contacts1 (
   contact_id INT(11) NOT NULL AUTO_INCREMENT,
   last_name VARCHAR(30) NOT NULL,
   first_name VARCHAR(25),
   birthday DATE,
   created_date DATE,
   created_by VARCHAR(30),
   CONSTRAINT contacts1_pk PRIMARY KEY (contact_id)
);

DELIMITER //
CREATE TRIGGER contacts1_before_insert
BEFORE INSERT ON contacts1
FOR EACH ROW
BEGIN
   DECLARE vUser VARCHAR(50);
   
   -- Find username of person performing INSERT into table
   SELECT USER() INTO vUser;
   
   -- Update created_date field to current system date
   SET NEW.created_date = SYSDATE();
   
   -- Update created_by field to the username of the person performing the INSERT
   SET NEW.created_by = vUser;
END; //
DELIMITER ;

INSERT INTO contacts1 (last_name, first_name, birthday) 
VALUES ('Newton', 'Enigma', STR_TO_DATE('19-08-1999', '%d-%m-%Y'));

select * from contacts1;

-- after insert trigger

CREATE TABLE contacts2 (
   contact_id INT(11) NOT NULL AUTO_INCREMENT,
   last_name VARCHAR(30) NOT NULL,
   first_name VARCHAR(25),
   birthday DATE,
   CONSTRAINT contacts2_pk PRIMARY KEY (contact_id)
);

CREATE TABLE contacts2_audit (
   contact_id INTEGER,
   created_date DATE,
   created_by VARCHAR(30)
);

DELIMITER //
CREATE TRIGGER contacts2_after_insert
AFTER INSERT ON contacts2
FOR EACH ROW
BEGIN
   DECLARE vUser VARCHAR(50);

   -- Find username of person performing the INSERT into table
   SELECT USER() INTO vUser;

   -- Insert record into audit table
   INSERT INTO contacts2_audit
   (contact_id,
    created_date,
    created_by)
   VALUES
   (NEW.contact_id,
    SYSDATE(),
    vUser);
END; //
DELIMITER ;

INSERT INTO contacts2 (last_name, first_name, birthday) 
VALUES ('Kumar', 'Rupesh', STR_TO_DATE('20-06-1999', '%d-%m-%Y'));

select* from contacts2_audit;

-- before delete trigger

CREATE TABLE contacts3 (
   contact_id INT(11) NOT NULL AUTO_INCREMENT,
   last_name VARCHAR(30) NOT NULL,
   first_name VARCHAR(25),
   birthday DATE,
   created_date DATE,
   created_by VARCHAR(30),
   CONSTRAINT contacts3_pk PRIMARY KEY (contact_id)
);
CREATE TABLE contacts3_audit (
   contact_id INTEGER,
   deleted_date DATE,
   deleted_by VARCHAR(20)
);

DELIMITER //
CREATE TRIGGER contacts3_before_delete
BEFORE DELETE ON contacts3
FOR EACH ROW
BEGIN
   DECLARE vUser VARCHAR(50);
   
   -- Find username of person performing the DELETE from table
   SELECT USER() INTO vUser;
   
   -- Insert record into audit table
   INSERT INTO contacts3_audit
   (contact_id,
    deleted_date,
    deleted_by)
   VALUES
   (OLD.contact_id,
    SYSDATE(),
    vUser);
END; //
DELIMITER ;

INSERT INTO contacts3 (last_name, first_name, birthday, created_date, created_by)
VALUES ('Bond', 'Ruskin', STR_TO_DATE('19-08-1995', '%d-%m-%Y'), STR_TO_DATE('27-04-2018', '%d-%m-%Y'), 'xyz');

DELETE FROM contacts3 WHERE last_name = 'Bond';

select *from contacts3_audit;

-- after delete trigger

CREATE TABLE contacts4 (
   contact_id INT(11) NOT NULL AUTO_INCREMENT,
   last_name VARCHAR(30) NOT NULL,
   first_name VARCHAR(25),
   birthday DATE,
   created_date DATE,
   created_by VARCHAR(30),
   CONSTRAINT contacts4_pk PRIMARY KEY (contact_id)
);

CREATE TABLE contacts4_audit (
   contact_id INTEGER,
   deleted_date DATE,
   deleted_by VARCHAR(20)
);

DELIMITER //
CREATE TRIGGER contacts4_after_delete
AFTER DELETE ON contacts4
FOR EACH ROW
BEGIN
   DECLARE vUser VARCHAR(50);
   
   -- Find username of person performing the DELETE from table
   SELECT USER() INTO vUser;
   
   -- Insert record into audit table
   INSERT INTO contacts4_audit
   (contact_id,
    deleted_date,
    deleted_by)
   VALUES
   (OLD.contact_id,
    SYSDATE(),
    vUser);
END; //
DELIMITER ;

INSERT INTO contacts4 (last_name, first_name, birthday, created_date, created_by)
VALUES ('Newton', 'Isaac', STR_TO_DATE('19-08-1985', '%d-%m-%Y'), STR_TO_DATE('23-07-2018', '%d-%m-%Y'), 'xyz');

DELETE FROM contacts4 WHERE first_name = 'Isaac';

select *from contacts4_audit;
