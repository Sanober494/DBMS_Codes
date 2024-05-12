use dbmslab;
/* lab 6 practice: */

-- the tables remain the same as the one used in the previous lab exp.

create view v1 as 
select *
from salesman;
select salesman_id, name, city from v1;

create view v2 as 
select * 
from salesman
where city='New York';
select salesman_id, name, city, commission from v2;

create view v3 as
select grade, count(grade)
from customer
group by grade;
select * from v3; 

create view v4 as
select ord_date, count(distinct customer_id) as count, avg(purch_amt) as average, sum(purch_amt) as sum
from orders
group by ord_date;
select * from v4;

