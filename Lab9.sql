use dbmslab;
/* lab 8 practice: */

CREATE TABLE contacts1 (
   contact_id INT(11) NOT NULL AUTO_INCREMENT,
   last_name VARCHAR(30) NOT NULL,
   first_name VARCHAR(25),
   birthday DATE,
   created_date DATE,
   created_by VARCHAR(30),
   CONSTRAINT contacts1_pk PRIMARY KEY (contact_id)
);

CREATE TABLE customer4 (
   acc_no INTEGER PRIMARY KEY,
   cust_name VARCHAR(20),
   avail_balance DECIMAL
);

CREATE TABLE contacts2 (
   contact_id INT(11) NOT NULL AUTO_INCREMENT,
   last_name VARCHAR(30) NOT NULL,
   first_name VARCHAR(25),
   birthday DATE,
   CONSTRAINT contacts2_pk PRIMARY KEY (contact_id)
);

CREATE TABLE contacts3 (
   contact_id INT(11) NOT NULL AUTO_INCREMENT,
   last_name VARCHAR(30) NOT NULL,
   first_name VARCHAR(25),
   birthday DATE,
   created_date DATE,
   created_by VARCHAR(30),
   CONSTRAINT contacts3_pk PRIMARY KEY (contact_id)
);

CREATE TABLE products (
   product_id INT(11) NOT NULL AUTO_INCREMENT,
   product_name VARCHAR(50) NOT NULL,
   price DECIMAL(10, 2),
   CONSTRAINT products_pk PRIMARY KEY (product_id)
);

INSERT INTO products (product_name, price) VALUES ('Product 1', 10.99);
SELECT * FROM products;

CREATE TABLE employees (
   employee_id INT(11) NOT NULL AUTO_INCREMENT,
   first_name VARCHAR(30) NOT NULL,
   last_name VARCHAR(30) NOT NULL,
   email VARCHAR(50),
   hire_date DATE,
   CONSTRAINT employees_pk PRIMARY KEY (employee_id)
);

INSERT INTO employees (first_name, last_name, email, hire_date)
VALUES ('John', 'Doe', 'john.doe@example.com', CURDATE());

SELECT * FROM employees;
 
DELIMITER //

-- Procedure to insert a new contact into the contacts1 table
CREATE PROCEDURE insert_contact1(
    IN p_last_name VARCHAR(30),
    IN p_first_name VARCHAR(25),
    IN p_birthday DATE
)
BEGIN
    INSERT INTO contacts1 (last_name, first_name, birthday)
    VALUES (p_last_name, p_first_name, p_birthday);
END //


-- Procedure to update a customer's balance in the customer table
CREATE PROCEDURE update_customer_balance(
    IN p_acc_no INTEGER,
    IN p_amount DECIMAL
)
BEGIN
    UPDATE customer
    SET avail_balance = avail_balance + p_amount
    WHERE acc_no = p_acc_no;
END //

-- Function to get the total number of contacts in the contacts2 table
CREATE FUNCTION get_total_contacts2()
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_contacts INT;
    SELECT COUNT(*) INTO total_contacts FROM contacts2;
    RETURN total_contacts;
END //

-- Procedure to delete a contact from the contacts3 table
CREATE PROCEDURE delete_contact3(
    IN p_contact_id INT
)
BEGIN
    DELETE FROM contacts3 WHERE contact_id = p_contact_id;
END //

-- Function to get the average price of products in the products table
CREATE FUNCTION get_average_price()
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE avg_price DECIMAL(10, 2);
    SELECT AVG(price) INTO avg_price FROM products;
    RETURN avg_price;
END //

-- Procedure to insert a new employee into the employees table
CREATE PROCEDURE insert_employee(
    IN p_first_name VARCHAR(30),
    IN p_last_name VARCHAR(30),
    IN p_email VARCHAR(50),
    IN p_hire_date DATE
)
BEGIN
    INSERT INTO employees (first_name, last_name, email, hire_date)
    VALUES (p_first_name, p_last_name, p_email, p_hire_date);
END //

DELIMITER ;

call insert_employee('san','rose','sanrose@gmail.com','2022-12-12');

select* from employees;
