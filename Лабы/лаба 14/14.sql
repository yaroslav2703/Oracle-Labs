GRANT CREATE DATABASE LINK TO USER_LABS

--Чтобы создать dblink типа user1-user2:
CREATE DATABASE LINK anotherdb 
   CONNECT TO USER2
   IDENTIFIED BY PASSWORD
   USING 'INST_B';

SELECT name FROM student@anotherdb;

--Чтобы иметь возможность создать dblink типа global, необходимо выдать привилегии: 
GRANT CREATE PUBLIC DATABASE LINK,
   DROP PUBLIC DATABASE LINK TO USERNAME

--Чтобы создать dblink типа global:
CREATE PUBLIC DATABASE LINK public_anotherdb 
   USING 'INST_B';

--Чтобы обратиться к объектам удаленного сервера, необходимо: 
SELECT name FROM student@ public_anotherdb;

ALTER SESSION CLOSE DATABASE LINK anotherdb;

--Словарь для dblink: 
DBA_DB_LINKS
USER_DB_LINKS
V$DBLINKS



create database link remote_dvcr
CONNECT TO 'login' IDENTIFIED BY 'password'
using'(DESCRIPTION =
(ADDRESS_LIST =
(ADDRESS = (PROTOCOL = TCP)(HOST = 'ipaddress')(PORT = 1521))
)
(CONNECT_DATA =
(SID = 'sid')
)
)'


CREATE DATABASE LINK test_link CONNECT TO sys IDENTIFIED BY '1234' USING 'LECHA';

CREATE PUBLIC DATABASE LINK test_link CONNECT TO sys IDENTIFIED BY 1234 USING '192.168.56.1:1521/ALC_PDB';

--пользователь и пароль естественно от удалённой_базы....

select * from v$version@название_соединения



CREATE TABLE MyTable2
(
id number primary key,
cname nvarchar2(50)
);

DROP TABLE MyTable2;

INSERT into MyTable2 (id, cname) values(1, 'Name 1');
INSERT into MyTable2 (id, cname) values(2, 'Name 2');
INSERT into MyTable2 (id, cname) values(3, 'Name 3');
INSERT into MyTable2 (id, cname) values(4, 'Name 4');














