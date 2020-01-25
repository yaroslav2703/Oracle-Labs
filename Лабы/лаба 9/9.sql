
--2.	Создайте последовательность S1 (SEQUENCE), со следующими характеристиками: начальное значение 1000;
--приращение 10; нет минимального значения; нет максимального значения; не циклическая;
--значения не кэшируются в памяти; хронология значений не гарантируется. 
--Получите несколько значений последовательности. Получите текущее значение последовательности.
create sequence pya_s1
increment by 10 
start with 1000
nomaxvalue
NOMINVALUE
nocycle
nocache
noorder;

select pya_s1.nextval from dual;
select pya_s1.CURRVAL from dual;

drop SEQUENCE pya_s1;

--3.	Создайте последовательность S2 (SEQUENCE), со следующими характеристиками: начальное значение 10; приращение 10; максимальное значение 100; 
create sequence pya_s2
increment by 10 
start with 10
maxvalue 100
nocycle;

drop sequence pya_s2;

--4

select pya_s2.NEXTval from dual;
select pya_s2.currval from dual;


--5
create sequence pya_s3
increment by -10
start with 10
minvalue -100
maxvalue 10
nocycle
order;

select pya_s3.NEXTVAL from dual;
select pya_s3.currval from dual;

drop sequence pya_s3;


--6
create sequence pya_s4
increment by 1
minvalue 10
maxvalue 100
cycle
cache 5
noorder;

select pya_s4.NEXTVAL from dual;
select pya_s4.currval from dual;

drop sequence pya_s4;

--7
select * from dba_users;

select SEQUENCE_NAME,min_value, max_value, increment_by,CYCLE_FLAG,ORDER_FLAG,CACHE_SIZE,LAST_NUMBER 
from DBA_SEQUENCES where SEQUENCE_owner='SYS';

--8
CREATE TABLE T1(N1 number(20), N2 number(20), N3 number(20), N4 number(20));
alter table T1 storage (buffer_pool keep);
 
insert into T1(N1,N2,N3,N4) values (pya_s1.NEXTval,pya_s2.NEXTval,pya_s3.NEXTval,pya_s4.NEXTval);
insert into T1(N1,N2,N3,N4) values (pya_s1.NEXTval,pya_s2.NEXTval,pya_s3.NEXTval,pya_s4.NEXTval);
insert into T1(N1,N2,N3,N4) values (pya_s1.NEXTval,pya_s2.NEXTval,pya_s3.NEXTval,pya_s4.NEXTval);
insert into T1(N1,N2,N3,N4) values (pya_s1.NEXTval,pya_s2.NEXTval,pya_s3.NEXTval,pya_s4.NEXTval);
insert into T1(N1,N2,N3,N4) values (pya_s1.NEXTval,pya_s2.NEXTval,pya_s3.NEXTval,pya_s4.NEXTval);
insert into T1(N1,N2,N3,N4) values (pya_s1.NEXTval,pya_s2.NEXTval,pya_s3.NEXTval,pya_s4.NEXTval);
insert into T1(N1,N2,N3,N4) values (pya_s1.NEXTval,pya_s2.NEXTval,pya_s3.NEXTval,pya_s4.NEXTval);
insert into T1(N1,N2,N3,N4) values (pya_s1.NEXTval,pya_s2.NEXTval,pya_s3.NEXTval,pya_s4.NEXTval);

select * from T1;

drop table T1;


--9
create cluster ABC(X NUMBER(10), V VARCHAR2(12)) HASHKEYS 200;
drop cluster abc INCLUDING TABLES;


--10
create table A(XA number(10), VA varchar2(12),AA char(10)) cluster ABC(xa,va);

--11
create table B(XB number(10), VB varchar2(12),AB char(10)) cluster ABC(xb,vb);

insert into B(xb,vb,ab) values (1,'bb','bbb');

--12
create table C(XC number(10), VC varchar2(12),AC char(10)) cluster ABC(xc,vc);

insert into c(xc,vc,ac) values (1,'cc','ccc');

--13
select cluster_name, owner, tablespace_name, cluster_type, cache from dba_clusters;

SELECT * FROM DICTIONARY;

--14
create synonym syn1 for SYS.C;
select * from syn1;

--15
create public synonym syn2 for SYS.B;
select * from syn2;

--16
create table A2(x int primary key, x_name varchar2(10));
create table B2(xe int, x_namee varchar2(10), constraint fk_x foreign key(xe) REFERENCES A2(x));
insert into A2(x,x_name) values (1,'one');
insert into A2(x,x_name) values (2,'two');
insert into A2(x,x_name) values (3,'three');
INSERT INTO A2(X,X_NAME) VALUES(4, 'four');

insert into B2(xe,x_namee) values (1,'один');
insert into B2(xe,x_namee) values (2,'два');
insert into B2(xe,x_namee) values (3,'три');
INSERT INTO B2(XE,X_NAMEE) VALUES(4, 'четыри');
create view v1 as select A2.X_name,B2.X_NAMEE FROM A2 inner join B2 on A2.x = B2.xe;
select * from v1;
drop view v1


--17
CREATE MATERIALIZED VIEW MAT_EX
BUILD IMMEDIATE
REFRESH COMPLETE NEXT SYSDATE + NUMTODSINTERVAL(2,'MINUTE') AS SELECT A2.X, B2.X_NAMEE FROM A2 inner join B2 on A2.x = B2.xe;

SELECT * FROM MAT_EX