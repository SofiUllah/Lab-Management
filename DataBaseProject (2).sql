-- --------------------------PROJECT ABOUT              LAB ENTRY DATABASE              SYSTEM-----------------------------------

--drop tables if they exists in the database

drop table lab;
drop table teacher;
drop table assistant;
drop table student;
drop table instrument;


--table creation 
create table instrument(
iid number(10) not null,
quantity number(10)
--primary key(iid)
);
alter table instrument add constraint i primary key(iid);

create table student(
sid number(10) not null,
name varchar(10),
age number(10),
dept varchar(10)
--primary key(sid)
);

alter table student add constraint s primary key(sid);
--creating an extra column into student table

alter table student  add gender varchar(10);
--modify 
	
ALTER TABLE student rename column gender to sex;
	



create table assistant(
aid number(10) not null,
name varchar(10),
sex varchar(10),
dept varchar(10)
--primary key(aid)
);

alter table assistant add constraint a primary key(aid);

create table teacher(
 tid number(10) not null,
 name varchar(20),
 mail varchar(20),
 designation varchar(10),
 sex varchar(10),
 phone number(15),
 dept varchar(10)
 --primary key (tid)
);

alter table teacher add constraint t primary key(tid);

create table lab(
lab_no number(10) not null,
Aid number(10),
Tid number(10),
Sid number(10),
Iid number(10),
Total number(10)
);

--adding constraint into table lab
alter table lab add constraint ii foreign key(Iid) references instrument(iid) on delete cascade;
alter table lab add constraint ss foreign key(Sid) references student(sid) on delete cascade;
alter table lab add constraint aa foreign key(Aid) references assistant(aid) on delete cascade;
alter table lab add constraint tt foreign key(Tid ) references teacher(tid) on delete cascade;

--show all tables
describe teacher;
describe student;
describe assistant;
describe instrument;
describe lab;

--creating trigger for value insertion
CREATE OR REPLACE TRIGGER bi_instrument

BEFORE INSERT ON instrument
FOR EACH ROW

DECLARE
v_user VARCHAR (10);
BEGIN
SELECT user INTO v_user FROM dual;
DBMS_OUTPUT.PUT_LINE('You are going to be inserted  a Row Mr. '|| v_user);
END;
/



--insertion using PL/sql
SET SERVEROUTPUT ON
BEGIN

insert into instrument(iid,quantity) values(101,30);
insert into instrument(iid,quantity) values(102,30);
insert into instrument(iid,quantity) values(103,40);
insert into instrument(iid,quantity) values(104,50);


insert into teacher(tid,name,mail,designation,sex,phone,dept) values(0001,'kamall','jahid@gmail.com','lecturer','mail',01764004720,'cse');
insert into teacher(tid,name,mail,designation,sex,phone,dept) values(0002,'jahid','jahirul@gmail.com','AP','femail',01664004720,'IP');
insert into teacher(tid,name,mail,designation,sex,phone,dept) values(0003,'kamall','jahid@gmail.com','lecturer','mail',01764004721,'EEE');
insert into teacher(tid,name,mail,designation,sex,phone,dept) values(0004,'jahid','jahirul@gmail.com','AP','femail',01664004723,'ME');



insert into student(sid,name,age,sex,dept) values(1307039,'sofi',22,'mail','cse');
insert into student(sid,name,age,sex,dept) values(1307052,'rohit',22,'femail','EEE');
insert into student(sid,name,age,sex,dept) values(1307023,'sofi',23,'mail','cse');
insert into student(sid,name,age,sex,dept) values(1307051,'mehadi',25,'male','cse');




insert into assistant(aid,name,sex,dept) values(99900,'kamal','mail','cse');
insert into assistant(aid,name,sex,dept) values(99901,'Jamal','mail','cse');
insert into assistant(aid,name,sex,dept) values(99902,'kamall','mail','EE');
insert into assistant(aid,name,sex,dept) values(99903,'Jamall','mail','EE');



insert into lab(lab_no,Aid,Tid,Sid,Iid,Total) values(01,99900,0001,1307039,101,10);
insert into lab(lab_no,Aid,Tid,Sid,Iid,Total) values(02,99901,0002,1307052,102,10);
insert into lab(lab_no,Aid,Tid,Sid,Iid,Total) values(01,99902,0003,1307023,103,10);
insert into lab(lab_no,Aid,Tid,Sid,Iid,Total) values(02,99903,0004,1307051,104,10);
commit;

DBMS_OUTPUT.PUT_LINE('Data Inserted in each table');

END;
/
 
--select operation
select * from instrument;
select * from teacher;
select * from student;
select * from assistant;
select * from lab;



------------------------------------Aggregiate functions and Some different operations-----------------------------------------------

--Range search of student to see who are available in list
 SELECT *  FROM student  WHERE sid BETWEEN 1307030 AND 1307060;
 
--searching students name containing letter o in his name  to know about students infromation on o
--patteren matching 
 SELECT * FROM student   WHERE name LIKE ‘%o%’;
--seaching student according to roll number in ascending order who took instrument from lab
select * from student order by sid;

-----------------------select total students ,thier average age 
select count(*),sum(age),avg(age) from student;
select distinct(sid) from student group by sid having sid>=1307039;
--temporarily give student id a new name u for showing students table data
select name,sid AS u from student;


---------------------------------Set Operation and subquery-------------------------------------------------


--To know about girls who took instrument from lab						
						
SELECT sex,name,dept,sid
FROM student
WHERE sex IN (  SELECT sex 
FROM student
WHERE  sex='male');


--To know about both boys and girls who took instrument from laboratory taken permission of lab assistant 
SELECT j.sid,j.name,j.sex,j.dept
FROM student j
WHERE sid>=1307000
UNION ALL
SELECT c.aid,c.name,c.sex,c.dept
FROM assistant c
WHERE c.aid IN 	(SELECT j.sid
	                     	FROM student j, assistant c
	                  	WHERE j.sid > c.aid);
						
						
						
						
--Information of students who took instrument and teacher associated with lab						
SELECT j.sid,j.name,j.sex,j.dept
FROM student j
WHERE sid>=1307000
UNION
SELECT c.tid,c.name,c.sex,c.dept
FROM teacher c
WHERE c.tid IN 	(SELECT c.tid from teacher where tid>=0000);


--------------------------------------join operation------------------------------------------------
--CROSS JOIN PRODUCT between teacher and assistant table for combination of them who are conduct the lab
select teacher.tid,assistant.aid from teacher CROSS JOIN assistant;
--Natural Join 
--Learn the same department's students and teacher 
select t.tid,t.name,l.name from teacher t JOIN student l on t.dept=l.dept;


--------------------------------PL/SQL OPERATION CONDITIONAL OPERATIION to know about the instrument-------------------------------------------- 
SET SERVEROUTPUT ON;
DECLARE 
ins_id NUMBER := &instrument_id_to_know_about_it;
BEGIN
  IF ins_id > 100 AND ins_id<103 THEN
  DBMS_OUTPUT.PUT_LINE('------It is very expensive instrument------');
  ELSIF ins_id>=103 AND ins_id<105 THEN
  DBMS_OUTPUT.PUT_LINE('---This is valuable and rare instrument-----');
  ELSE 
   DBMS_OUTPUT.PUT_LINE('----Instruments are cheap--- ');
 END IF;
 DBMS_OUTPUT.PUT_LINE(' ------------------ Dept of CSE,KUET----------------------');
 END;
/

										 
------------PL/sql LOOP instruction										 
--Seaching students  information who take instrument USING  loop instruction  in pl/sql					 
										 
  BEGIN
   FOR studentinfro IN (
        SELECT *
          FROM student
         WHERE sid>= 1307000)
		
   LOOP
      DBMS_OUTPUT.put_line(' ........'||  studentinfro.name||'    '||studentinfro.sid||'    '||studentinfro.sex||'-----------');
   END LOOP;
END;						 
/	


--Insertion into student table using PROCEDURE

CREATE OR REPLACE PROCEDURE InsertIntostudent(stid student.sid%type,st student.name%type,kal student.age%type ,
 gender student.sex%type,d student.dept%type
) IS
BEGIN
	INSERT INTO student VALUES(stid,st,kal,gender,d);
	commit;
END InsertIntostudent;
/


--Calling the PROCEDURE for Inserting into student

SET SERVEROUTPUT ON
BEGIN
	InsertIntostudent(1307015,'saklain',24,'male','eee');
END;
/
SELECT * FROM student;

--Update into assistant table using PROCEDURE

CREATE OR REPLACE PROCEDURE UpdateIntoassistant(Aid assistant.aid%type,newname assistant.name%type,
 gender assistant.sex%type,depart assistant.dept%type) IS
BEGIN
	UPDATE assistant SET dept=depart,name=newname,sex=gender WHERE aid=Aid;
	commit;
END UpdateIntoassistant;
/


--Calling the PROCEDURE for Updating into assistant

SET SERVEROUTPUT ON
BEGIN
	UpdateIntoassistant(99900,'EEE','jahir','mail');
END;
/

--------------------Functions---------------------------------------------------------------------------

--Calculating average age of student

CREATE OR REPLACE FUNCTION avg_age RETURN NUMBER IS
   avg_age student.age%type;
BEGIN
  SELECT AVG(age) INTO avg_age
  FROM student where sid>=1307040;
   RETURN avg_age;
END;
/
SET SERVEROUTPUT ON
BEGIN
dbms_output.put_line('Average age: ' || avg_age);
END;
/




--If any information is deleted or lost or crashed then way to undoes or back it

--TRANSACTION MANAGEMENT 
select * from lab;
delete lab ;
rollback;
select * from lab;
insert into lab values(3,99900,4,1307051,102,10);
SAVEPOINT insert1;
insert into lab values(4,99901,3,1307015,101,10);
SAVEPOINT INSERT2;
ROLLBACK TO INSERT1;
SELECT * FROM LAB;



--to know current date of the day 
select sysdate from dual;


--------------------------------------------------Cursor-----------------------------------

-----------showing students information associated with lab 
DECLARE
   a student.sid%type;
   b student.age%type;
   e student.name%type;
   
      CURSOR recordd is
      SELECT sid,age,name FROM student;
BEGIN
   OPEN recordd;
   LOOP
      FETCH recordd into a,b,e;
      EXIT WHEN recordd%notfound;
	  dbms_output.put_line(a||'   '||b||'  '||e);
	   a:=a-floor(a);
            b:=b-floor(b);
	  	  
   END LOOP;
   CLOSE recordd;
END;
/





																 
	





