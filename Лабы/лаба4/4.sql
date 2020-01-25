--1 ѕолучите список всех существующих PDB(подключаемые Ѕƒ) в рамках экземпл€ра ORA12W
select name, open_mode, total_size from v$pdbs;

--2 ¬ыполните запрос к ORA12W, позвол€ющий получить перечень экземпл€ров.
select INSTANCE_NAME from v$instance;

Ч 3 ¬ыполните запрос к ORA12W, позвол€ющий получить перечень установленных компонентов —”Ѕƒ Oracle 12c и их версии и статус.
select * from PRODUCT_COMPONENT_VERSION;

--4 —оздайте собственный экземпл€р PDB

--5 ѕолучите список всех существующих PDB в рамках экземпл€ра ORA12W.
select name,open_mode, restricted from v$pdbs;

--6 ѕодключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты
CREATE TABLESPACE TS_PYA_1
DATAFILE 'D:\3  ”–—\Ѕазы данных\Ћабы\лаба4\TS_PYA_1.dbf' size 7M
AUTOEXTEND ON NEXT 5M
MAXSIZE 20M
LOGGING
ONLINE;
commit;

CREATE TABLESPACE TS_PYA_1 DATAFILE 'TS_PYA_1'
SIZE 7M REUSE AUTOEXTEND ON NEXT 5M MAXSIZE 20M;

drop TABLESPACE TS_PYA_1 INCLUDING CONTENTS;
commit;


SELECT * FROM DBA_TABLESPACES ;
--select TABLESPACE_NAME, BLOCK_SIZE, MAX_SIZE from sys.dba_tablespaces order by tablespace_name;

CREATE TEMPORARY TABLESPACE TS_PYA_TEMP_11
TEMPFILE 'D:\TS_PYA_TEMP.dbf' size 5M
AUTOEXTEND ON NEXT 3M
MAXSIZE 30M;
commit;


select file_name, tablespace_name, status , maxbytes, user_bytes from dba_data_files where file_name = 'D:\TS_PYA_TEMP.dbf';

alter session set "_ORACLE_SCRIPT"=true;

create role RLPYA;
commit;

select * from dba_users;

GRANT CREATE SESSION,
CREATE TABLE,
CREATE VIEW,
CREATE PROCEDURE TO RLPYA;

create profile PFPY limit
password_life_time 180 Ч кол-во дней жизни парол€
sessions_per_user 3 Ч кол-во сессий дл€ пользовател€
FAILED_LOGIN_ATTEMPTS 7 Ч кол-во попыток входа
PASSWORD_LOCK_TIME 1 Ч кол-во дней блокировки после ошибки
PASSWORD_Reuse_time 10 Ч через сколько дней можно повторить пароль
password_grace_time default Ч кол-во дней предупреждени€ о смене парол€
connect_time 180 Ч врем€ соединени€
idle_time 30; Ч простой
commit;

create user U1_PYA_PDB identified by 12345678
default tablespace TS_PYA_1 quota unlimited on TS_PYA_1
profile PFPY
account unlock;
grant RLPYA to U1_PYA_PDB;
commit;

--7 ѕодключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer, создайте таблицу XXX_table, добавьте в нее строки, выполните SELECT-запрос к таблице.
create table PYA_t (x number(3), s varchar2(50)) ;
commit;

insert into PYA_t (x, s) values (1, 'first');
insert into PYA_t (x, s) values (2, 'second');
insert into PYA_t (x, s) values (3, 'third');
commit;

select * from PYA_t;


--8 — помощью представлений словар€ базы данных определите, все табличные пространства, все файлы (перманентные и временные), все роли (и выданные им привилегии),
Чпрофили безопасности, всех пользователей базы данных XXX_PDB и назначенные им роли

select * from ALL_USERS; Чвсе пользователи
select * from DBA_TABLESPACES; Чвсе таб. простр
select * from DBA_DATA_FILES; Чперман данные
select * from DBA_TEMP_FILES; Чвремен данные
select * from DBA_ROLES; Чроли
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS; Чпривилег
select * from DBA_PROFILES; Чпрофил без.
select * from ALL_USERS; Чвсе пользователи
select * from DBA_TABLESPACES; Чвсе таб. простр



Ч 9 ѕодключитесь к CDB-базе данных, создайте общего пользовател€ с именем C##XXX, назначьте ему привилегию, позвол€ющую подключитс€ к базе данных XXX_PDB
create user PYA identified by 12345678
account unlock;
grant create session to PYA

select * from v$session where USERNAME is not null;

--10 ѕодключитесь к пользователю U1_XXX_PDB со своего компьютера, а к пользовател€м C##XXX и C##YYY с другого (к XXX_PDB-базе данных).
SELECT username
FROM v$session
WHERE username IS NOT NULL

--11-12 ѕродемонстрируйте преподавателю, работоспособную PDB-базу данных и созданную инфраструктуру

CREATE role PYA_1;
GRANT CREATE TABLE,
CREATE VIEW,
CREATE PROCEDURE,
CREATE SESSION TO PYA_1;

CREATE USER qwe IDENTIFIED BY 12345678
PROFILE DEFAULT
ACCOUNT UNLOCK;

GRANT PYA_1 TO EPYA;

grant create session to EPYA;