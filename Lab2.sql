use dbmslab;
/* lab 2 practice: */

-- question 1: 

create table admission (
num int,
name_person char(20),
age int,
department char(15),
dateofadm char(10),
fee int,
sex char(1)
);

insert into admission (num,name_person,age,department,dateofadm,fee,sex)
values (1,'Pankaj',24,'Computer','2002-10-12',120,'M'),
(2,'Shalini',21,'History','2012-02-25',200,'F'),
(3,'Sudha',25,'History','2015-05-30',400,'F');
/*didn't add more values because I'm lazy to type it all lol*/

update admission 
set age=27
where name_person='Pankaj';

update admission set fee=425 where name_person='Sudha';

alter table admission
add column city varchar(30);

desc admission;

alter table admission
drop column city;

desc admission;

-- question 2:

create table pet(
name_pet varchar(15),
owner_pet varchar(15),
species varchar(15),
sex char(1),
birth varchar(12),
death varchar(12) default NULL
);

desc pet;

alter table pet
modify birth varchar(13) default null;

insert into pet
values('Buffy','Harold','dog','F','1989-05-13',NULL),
('Bowser','Diane','dog','M','1979-08-31','1995-07-29'),
('Claws','Gwen','cat','M','1994-03-17',null),
('Puffball','Diane','hamster','F','1999-03-30',null);
-- again, got lazy, so didn't type in all the values 

insert into pet
values ('Chirpy','Gwen','bird','F',NULL,'1997-12-09');

select * from pet;

select * from pet where name_pet='Fang';

select * from pet where owner_pet='Gwen';

select owner_pet from pet where species='dog';

select * from pet where sex='F';

select birth from pet where species='hamster';
