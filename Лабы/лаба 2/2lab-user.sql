--1
create tablespace TS_PYA datafile 'D:\3 КУРС\Базы данных\Лабы\лаба 2\TS_PYA.dbf'
size 7m autoextend on next 5m maxsize 20m extent management local;

--2
create temporary tablespace TS_TEMP_PYA tempfile 'D:\3 КУРС\Базы данных\Лабы\лаба 2\TS_TEMP_PYA.dbf'
size 5m AUTOEXTEND on next 3m maxsize 30m extent management local;


DROP TABLESPACE TS_TEMP_PYA;
--3
select * from DICTIONARY;

select file_name, tablespace_name, status, maxbytes, user_bytes  from dba_data_files 
union 
select file_name, tablespace_name, status, maxbytes, user_bytes from dba_temp_files;

ALTER SESSION SET "_ORACLE_SCRIPT"=true;

--4
CREATE ROLE RL_PYACORE;

grant create session, 
      create table,
      create view,
      create procedure to RL_PYACORE;

--5
select * from dba_roles where role like 'RL%';      
select * from DBA_SYS_PRIVS where grantee='RL_PYACORE';  

--6
create profile PF_PYACORE LIMIT
  PASSWORD_LIFE_TIME 180
  SESSIONS_PER_USER 3
  FAILED_LOGIN_ATTEMPTS 7
  PASSWORD_LOCK_TIME 1
  PASSWORD_REUSE_TIME 10
  PASSWORD_GRACE_TIME DEFAULT
  CONNECT_TIME 180
  IDLE_TIME 30

--7
select * from dba_profiles

select * from dba_profiles where profile='PF_PYACORE';

select * from dba_profiles where profile='DEFAULT';

--8
create user PYACORE IDENTIFIED BY 123
DEFAULT TABLESPACE TS_PYA QUOTA UNLIMITED ON TS_PYA
TEMPORARY TABLESPACE TS_TEMP_PYA
PROFILE PF_PYACORE
ACCOUNT UNLOCK
PASSWORD EXPIRE


GRANT RL_PYACORE TO PYACORE;

ALTER USER PYACORE UNLOCK;
--9
alter user PYACORE identified by 1234


grant create table to PYACORE

grant create session to PYACORE

grant create view to PYACORE



--11
create tablespace PYA_QDATA datafile 'D:\3 КУРС\Базы данных\Лабы\лаба 2\PYA_QDATA.dbf'
size 10m autoextend on next 5m maxsize 20m extent management local offline;

alter tablespace PYA_QDATA online;

alter user PYACORE quota 2m on PYA_QDATA

grant insert on Table_2 to PYACORE