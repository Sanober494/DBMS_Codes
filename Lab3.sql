use dbmslab;
/* lab 3 practice: */

-- credits to my friend for table creation and values insertion, mad respect for this manual labor :)

create table salesman(salesman_id int primary key,name varchar(25),city varchar(25),commission float);

insert into salesman values(5001,"James Hoog","New York",0.15);
insert into salesman values(5002,"Nail Knite","Paris",0.13);
insert into salesman values(5005,"Pit Alex","London",0.11);
insert into salesman values(5006,"Mc Lyon","Paris",0.14);
insert into salesman values(5003,"Lauson Hen",null,0.12);
insert into salesman values(5007,"Paul Adam","Rome",0.13);

select * from salesman;

create table customer(customer_id int primary key,cust_name varchar(25),city varchar(25),grade int,salesman_id int,foreign key(salesman_id) references salesman(salesman_id));

insert into customer values(3002,"Nick Rimando","New York",100,5001);
insert into customer values(3005,"Graham Zusi","California",200,5002);
insert into customer values(3001,"Brad Guzan","London",null,5005);
insert into customer values(3004,"Fabian Johns","Paris",300,5006);
insert into customer values(3007,"Brad Davis","New York",200,5001);
insert into customer values(3009,"Geoff Camero","Berlin",100,5003);
insert into customer values(3008,"Julian Green","London",300,5002);
insert into customer values(3003,"Jozy Altidor","Moscow",200,5007);

select * from customer;

create table orders(ord_no int primary key,purch_amt float, ord_date date,customer_id int,salesman_id int, foreign key(customer_id) references customer(customer_id),foreign key(salesman_id) references salesman(salesman_id));

insert into orders values(70001,150.5,"2012/10/05",3005,5002);
insert into orders values(70009,270.65,"2012/09/10",3001,5005);
insert into orders values(70002,65.26,"2012/10/05",3002,5001);
insert into orders values(70004,110.5,"2012/08/17",3009,5003);
insert into orders values(70007,948.5,"2012/09/10",3005,5002);
insert into orders values(70005,2400.6,"2012/07/27",3007,5001);
insert into orders values(70008,5760,"2012/09/10",3002,5001);
insert into orders values(70010,1983.43,"2012/10/10",3004,5006);
insert into orders values(70003,2480.4,"2012/10/10",3009,5003);
insert into orders values(70012,250.45,"2012/06/27",3008,5002);
insert into orders values(70011,75.29,"2012/08/17",3003,5007);
insert into orders values(70013,3045.6,"2012/04/25",3002,5001);

select * from orders;

select c.cust_name,  s.name, s.city 
from salesman s, customer c
where s.city=c.city;

select c.cust_name, s.name
from salesman s, customer c
where s.salesman_id=c.salesman_id;

select o.ord_no 
from salesman s, customer c, orders o
where c.city <> s.city 
and o.customer_id=c.customer_id
and o.salesman_id=s.salesman_id;

select o.ord_no, c.cust_name
from orders o, customer c
where o.customer_id=c.customer_id;

select c.cust_name, c.grade
from customer c, salesman s
where c.grade is not null
and s.city is not null 
and c.salesman_id=s.salesman_id;

select c.cust_name, c.city, s.name, s.commission
from customer c, salesman s
where c.salesman_id=s.salesman_id
and s.commission between 0.12 and 0.14;

select o.ord_no, c.cust_name, s.commission, purch_amt*commission as "Earned Commission"
from salesman s, orders o, customer c
where c.grade>=200 
and c.customer_id=o.customer_id
and o.salesman_id=s.salesman_id;

select * from customer 
where grade>100;

select * from customer 
where city='New York'
and grade>100;

select * from customer
where city = 'New York'
or not grade > 100;

select * from customer
where city <> 'New York'
and not grade > 100;

select * from orders o, salesman s 
where o.ord_date <> '2012-09-10'
and s.salesman_id <= 5005
or o.purch_amt >=1000;
