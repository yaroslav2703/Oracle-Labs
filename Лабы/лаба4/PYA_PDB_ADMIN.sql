

--4 �������� ����������� ��������� PDB

--5 �������� ������ ���� ������������ PDB � ������ ���������� ORA12W.
select name,open_mode, restricted from v$pdbs;

--6 ������������ � XXX_PDB c ������� SQL Developer �������� ���������������� �������
CREATE TABLESPACE TS_PYA_1
DATAFILE 'D:\3 ����\���� ������\����\����4\1\TS_PYA_1.dbf' size 7M
AUTOEXTEND ON NEXT 5M
MAXSIZE 20M
LOGGING
ONLINE;
commit;

drop TABLESPACE TS_PYA_TEMP_11 INCLUDING CONTENTS;
commit;

CREATE TEMPORARY TABLESPACE TS_PYA_TEMP_11
TEMPFILE 'D:\3 ����\���� ������\����\����4\1\TS_PYA_TEMP.dbf' size 5M
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
password_life_time 180; � ���-�� ���� ����� ������
sessions_per_user 3; � ���-�� ������ ��� ������������
FAILED_LOGIN_ATTEMPTS 7; � ���-�� ������� �����
PASSWORD_LOCK_TIME 1; � ���-�� ���� ���������� ����� ������
PASSWORD_Reuse_time 10; � ����� ������� ���� ����� ��������� ������
password_grace_time default; � ���-�� ���� �������������� � ����� ������
connect_time 180; � ����� ����������
idle_time 30; � �������
commit;

create user U1_PYA_PDB identified by 12345678
default tablespace TS_PYA_1 quota unlimited on TS_PYA_1
profile PFPY
account unlock;
grant RLPYA4 to U1_PYA_PDB;
commit;

select * from dba_users;


--8 � ������� ������������� ������� ���� ������ ����������, ��� ��������� ������������, ��� ����� (������������ � ���������), ��� ���� (� �������� �� ����������),
--������� ������������, ���� ������������� ���� ������ XXX_PDB � ����������� �� ����

select * from ALL_USERS; ���� ������������
select * from DBA_TABLESPACES; ���� ���. ������
select * from DBA_DATA_FILES; ������� ������
select * from DBA_TEMP_FILES; ������� ������
select * from DBA_ROLES; �����
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS; ���������
select * from DBA_PROFILES; ������� ���.
select * from ALL_USERS; ���� ������������
select * from DBA_TABLESPACES; ���� ���. ������

-- 9 ������������ � CDB-���� ������, �������� ������ ������������ � ������ C##XXX, ��������� ��� ����������, ����������� ����������� � ���� ������ XXX_PDB
create user C##PYA identified by 12345678
account unlock;
grant create session to C##PYA

select * from v$session where USERNAME is not null;

