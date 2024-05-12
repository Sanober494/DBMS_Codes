use dbmslab;

/* lab 1 practice: */

create table student (
first_name varchar(20) not null,
id char(5) primary key,
last_name varchar(20) unique,
gender char(1) default ('F'),
age int,
check (age>15)
);
create table teacher(
first_name varchar(20) not null,
teach_id char(5) primary key,
gender char(1) default ('F'),
age int,
stu_id char(5),
foreign key (stu_id) references student(id) 
);

alter table student
add house char(5);

select * from student;

show tables;

alter table student
drop column house;

alter table student
modify last_name char(10);

select * from student;
desc student;

truncate table teacher; /* won't show any difference since the table is already empty*/
