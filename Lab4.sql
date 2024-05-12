use dbmslab;
/* lab 4 practice: */

-- question 1
-- the tables remain the same as the one used in the previous lab exp.

select * from salesman;

select c.cust_name, s.name
from customer c, salesman s
where s.salesman_id= c.salesman_id;

select c.cust_name
from customer c, salesman s
where s.salesman_id= c.salesman_id
and s.commission> 0.12;

select c.cust_name
from customer c, salesman s
where s.salesman_id= c.salesman_id
and s.commission> 0.12
and c.city <> s.city;

select * from orders
natural join customer
natural join salesman;

select c.cust_name 
from customer c left join salesman s
on c.salesman_id=s.salesman_id
order by c.cust_name asc;

select * from salesman s cross join customer c;

-- question 2

create table course(
course_id varchar(15),
title varchar(15),
dept_name varchar(15),
credits int
);

create table prereq(
course_id varchar(15),
prereq_id varchar(15)
);

insert into course
values ('BIO-301', 'GENETICS', 'BIOLOGY',4),
('CS-190','GAME DESIGN', 'COMP SCI.',4),
('CS-315','ROBOTICS','COMP SCI.',3);

insert into prereq
values ('BIO-301','BIO-101'),
('CS-190','CS-101'),
('CS-347','CS-101');

select c.course_id, c.title, c.dept_name, c.credits, p.prereq_id
from course c left join prereq p on c.course_id=p.course_id;

select c.course_id, c.title, c.dept_name, c.credits, p.prereq_id
from course c right join prereq p on c.course_id=p.course_id;

select c.course_id, c.title, c.dept_name, c.credits, p.prereq_id
from course c left join prereq p on c.course_id=p.course_id
union
select c.course_id, c.title, c.dept_name, c.credits, p.prereq_id
from course c right join prereq p on c.course_id=p.course_id;
