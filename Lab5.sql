use dbmslab;
/* lab 5 practice: */

-- the tables remain the same as the one used in the previous lab exp for question 1.

select * from salesman 
where city= any (select city from customer);

select * from orders 
where purch_amt > any (select purch_amt from orders
where ord_date='2012-09-10');

select * from orders 
where purch_amt < 
(select max(o.purch_amt) 
from customer c, orders o
where c.city='London' and 
o.customer_id=c.customer_id);

select * from customer 
where grade > all (select grade from customer
where city='New York');

select * from customer 
where grade <> any (select grade from customer
where city = 'London');

select * from orders 
where salesman_id = (select salesman_id from salesman
where name='Paul Adam');

select * from orders 
where salesman_id = (select salesman_id from salesman
where city='London');

select * from orders 
where purch_amt> (select avg(purch_amt) from orders
where ord_date='10-10-2012');

SELECT commission
FROM salesman
WHERE salesman_id =
    (SELECT salesman_id 
     FROM customer
     WHERE city = 'Paris');
     
select o.*, c.cust_name
from customer c, orders o
where c.customer_id=o.customer_id and
o.ord_date='2012-08-17';
