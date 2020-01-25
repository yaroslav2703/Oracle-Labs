

--4 —оздайте собственный экземпл€р PDB

--5 ѕолучите список всех существующих PDB в рамках экземпл€ра ORA12W.
select name,open_mode, restricted from v$pdbs;

--6 ѕодключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты
CREATE TABLESPACE TS_PYA_1
DATAFILE 'D:\3  ”–—\Ѕазы данных\Ћабы\лаба4\1\TS_PYA_1.dbf' size 7M
AUTOEXTEND ON NEXT 5M
MAXSIZE 20M
LOGGING
ONLINE;
commit;

drop TABLESPACE TS_PYA_TEMP_11 INCLUDING CONTENTS;
commit;

CREATE TEMPORARY TABLESPACE TS_PYA_TEMP_11
TEMPFILE 'D:\3  ”–—\Ѕазы данных\Ћабы\лаба4\1\TS_PYA_TEMP.dbf' size 5M
AUTOEXTEND ON NEXT 3M
MAXSIZE 30M;
commit;

SELECT * FROM DBA_TABLESPACES ;


create role RLPYA4;
commit;

drop role rlpya4;

select * from dba_users;

GRANT CREATE SESSION,
CREATE TABLE,
CREATE VIEW,
CREATE PROCEDURE TO RLPYA4;

create profile PFPY limit
password_life_time 180; Ч кол-во дней жизни парол€
sessions_per_user 3; Ч кол-во сессий дл€ пользовател€
FAILED_LOGIN_ATTEMPTS 7; Ч кол-во попыток входа
PASSWORD_LOCK_TIME 1; Ч кол-во дней блокировки после ошибки
PASSWORD_Reuse_time 10; Ч через сколько дней можно повторить пароль
password_grace_time default; Ч кол-во дней предупреждени€ о смене парол€
connect_time 180; Ч врем€ соединени€
idle_time 30; Ч простой
commit;

create user U1_PYA_PDB identified by 12345678
default tablespace TS_PYA_1 quota unlimited on TS_PYA_1
profile PFPY
account unlock;
grant RLPYA4 to U1_PYA_PDB;
commit;

select * from dba_users;


--8 — помощью представлений словар€ базы данных определите, все табличные пространства, все файлы (перманентные и временные), все роли (и выданные им привилегии),
--профили безопасности, всех пользователей базы данных XXX_PDB и назначенные им роли

select * from ALL_USERS; Чвсе пользователи
select * from DBA_TABLESPACES; Чвсе таб. простр
select * from DBA_DATA_FILES; Чперман данные
select * from DBA_TEMP_FILES; Чвремен данные
select * from DBA_ROLES; Чроли
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS; Чпривилег
select * from DBA_PROFILES; Чпрофил без.
select * from ALL_USERS; Чвсе пользователи
select * from DBA_TABLESPACES; Чвсе таб. простр

-- 9 ѕодключитесь к CDB-базе данных, создайте общего пользовател€ с именем C##XXX, назначьте ему привилегию, позвол€ющую подключитс€ к базе данных XXX_PDB
create user C##PYA identified by 12345678
account unlock;
grant create session to C##PYA

select * from v$session where USERNAME is not null;

