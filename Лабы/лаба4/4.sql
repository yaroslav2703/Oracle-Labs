--1 �������� ������ ���� ������������ PDB(������������ ��) � ������ ���������� ORA12W
select name, open_mode, total_size from v$pdbs;

--2 ��������� ������ � ORA12W, ����������� �������� �������� �����������.
select INSTANCE_NAME from v$instance;

� 3 ��������� ������ � ORA12W, ����������� �������� �������� ������������� ����������� ���� Oracle 12c � �� ������ � ������.
select * from PRODUCT_COMPONENT_VERSION;

--4 �������� ����������� ��������� PDB

--5 �������� ������ ���� ������������ PDB � ������ ���������� ORA12W.
select name,open_mode, restricted from v$pdbs;

--6 ������������ � XXX_PDB c ������� SQL Developer �������� ���������������� �������
CREATE TABLESPACE TS_PYA_1
DATAFILE 'D:\3 ����\���� ������\����\����4\TS_PYA_1.dbf' size 7M
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
password_life_time 180 � ���-�� ���� ����� ������
sessions_per_user 3 � ���-�� ������ ��� ������������
FAILED_LOGIN_ATTEMPTS 7 � ���-�� ������� �����
PASSWORD_LOCK_TIME 1 � ���-�� ���� ���������� ����� ������
PASSWORD_Reuse_time 10 � ����� ������� ���� ����� ��������� ������
password_grace_time default � ���-�� ���� �������������� � ����� ������
connect_time 180 � ����� ����������
idle_time 30; � �������
commit;

create user U1_PYA_PDB identified by 12345678
default tablespace TS_PYA_1 quota unlimited on TS_PYA_1
profile PFPY
account unlock;
grant RLPYA to U1_PYA_PDB;
commit;

--7 ������������ � ������������ U1_XXX_PDB, � ������� SQL Developer, �������� ������� XXX_table, �������� � ��� ������, ��������� SELECT-������ � �������.
create table PYA_t (x number(3), s varchar2(50)) ;
commit;

insert into PYA_t (x, s) values (1, 'first');
insert into PYA_t (x, s) values (2, 'second');
insert into PYA_t (x, s) values (3, 'third');
commit;

select * from PYA_t;


--8 � ������� ������������� ������� ���� ������ ����������, ��� ��������� ������������, ��� ����� (������������ � ���������), ��� ���� (� �������� �� ����������),
�������� ������������, ���� ������������� ���� ������ XXX_PDB � ����������� �� ����

select * from ALL_USERS; ���� ������������
select * from DBA_TABLESPACES; ���� ���. ������
select * from DBA_DATA_FILES; ������� ������
select * from DBA_TEMP_FILES; ������� ������
select * from DBA_ROLES; �����
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS; ���������
select * from DBA_PROFILES; ������� ���.
select * from ALL_USERS; ���� ������������
select * from DBA_TABLESPACES; ���� ���. ������



� 9 ������������ � CDB-���� ������, �������� ������ ������������ � ������ C##XXX, ��������� ��� ����������, ����������� ����������� � ���� ������ XXX_PDB
create user PYA identified by 12345678
account unlock;
grant create session to PYA

select * from v$session where USERNAME is not null;

--10 ������������ � ������������ U1_XXX_PDB �� ������ ����������, � � ������������� C##XXX � C##YYY � ������� (� XXX_PDB-���� ������).
SELECT username
FROM v$session
WHERE username IS NOT NULL

--11-12 ����������������� �������������, ��������������� PDB-���� ������ � ��������� ��������������

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