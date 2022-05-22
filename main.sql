create database hospital;

use hospital;

/* 1. Create tables */

/* Create physicians tables */

create table physicians (
phy_id int primary key,
phy_fname varchar(20) NOT NULL, 
phy_lname varchar(20), 
address varchar(20), 
salary double, 
designation varchar(20), 
field_of_spec varchar(20), 
year_of_spec date
);


/* Create nurse tables */

create table nurse (
nurse_id int primary key,
nurse_name varchar(20),
shift int check (shift BETWEEN 1 AND 3));


/* Create ward tables */

create table ward (
ward_no int primary key, 
ward_name varchar(20) not NULL, 
no_of_beds int check(no_of_beds>0) , 
telephone int, 
nurse_id int,
FOREIGN KEY (nurse_id) references nurse(nurse_id));


/*Create patient tables */

create table patient (
pat_no int primary key AUTO_INCREMENT, 
pat_name varchar(10), 
phy_id int, 
ward_no int, 
date_of_admit date,
FOREIGN KEY (phy_id) references physicians(phy_id),
FOREIGN KEY (ward_no) references ward(ward_no)
);

/* 2.Insert values into the tables */

/* Insert values into the physicians tables */

insert into physicians values
(1000,'promod','shankar','addres line',100000.0,"director","ortho",2005-011),
(1001,'vimal','bechan','adress2',10000.0,'staff','eye','2001-02-01'),
(1002,'manshawas','naraiyin','adress3',10000.0,'staff','leg','2005-09-08');

/* Insert values into the nurse tables */

insert into nurse values
(2000,'mary',2),
(2001,'jhon',3),
(2002,'vishnu',1);

/* Insert values into the ward tables */

insert into ward values
(3000,'genaral',55,987654321,2000),
(3001,'isolated',155,987689654,2001),
(3002,'icu',200,987874569,2002);

/* Insert values into the patient tables */

insert into patient(pat_name,phy_id, ward_no, date_of_admit)values
('jhon rambo',1000,3000,'2022-04-30'),
('macclarin',1001,3001,'2022-05-14'),
('nerajan',1002,3002,'2022-01-28');



/* 3.Display the patient number and ward number of all patients.*/

select pat_no,ward_no from patient;


/* 4. Display the name of nurse and the shift he/she is working. */

select nurse_name,shift from nurse;


/* 5. Display the name of patients and their physician only for patients assigned to any ward */

select patient.pat_name,physicians.phy_fname from patient inner join physicians on (patient.phy_id=physicians.phy_id and patient.ward_no is NOT NULL);


/* 6. Display the details of all physicians who earn more than 50,000. */

select * from physicians where salary >50000;


/* 7. Display the unique listing of areas that the physicians are specialized in. */

select distinct(field_of_spec) from physicians;


/* 8. Display the details of patients whose names have letter 'N' in them and are being treated by
physician Pramod. */

select pat_no,pat_name,patient.phy_id,ward_no,date_of_admit from patient inner join physicians on (patient.phy_id=physicians.phy_id and physicians.phy_fname='promod') where pat_name like '%n%';


/* 9. Display the physician's names and their monthly salary. */

select phy_fname,salary from physicians;


/* 10. Display the names of physicians whose first name is made up of 5 letters. */

select phy_fname from physicians where phy_fname like '_____';


/* 11. Display the names of department (field_of_spec) that physicians belong to that do not start with
letter 'P'. */

select field_of_spec from physicians where field_of_spec not like 'p%';


/* 12. Display the name of ward that have more than 22 beds. */

select ward_name from ward where(no_of_beds>22);


/* 13. Display the name of all patients who are admitted, their physician's name and ward name. */

select patient.pat_name,ward.ward_name,physicians.phy_fname from patient inner join ward on ( ward.ward_no=patient.ward_no)inner join physicians on(patient.phy_id=physicians.phy_id);