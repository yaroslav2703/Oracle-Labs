SET serveroutput ON;


ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER USER_LABS IDENTIFIED BY password;
GRANT ALL PRIVILEGES TO USER_LABS;

--1.	�������� �������, ������� ��������� ���������, ���� �� ������� ��������� ����.

DROP TABLE FACULTY2
CREATE TABLE FACULTY2
  (
   FACULTY      VARCHAR2(10)      NOT NULL,
   FACULTY_NAME VARCHAR2(100), 
   CONSTRAINT PK_FACULTY2 PRIMARY KEY(FACULTY) 
  );


--2.	��������� ������� �������� (10 ��.).


delete FACULTY2;
insert into FACULTY2  (FACULTY,   FACULTY_NAME )
             values  ('����',   '����������� ���� � ����������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('����',   '���������� ���������� � �������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('���',     '����������������� ���������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������-������������� ���������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('����',    '���������� � ������� ������ ��������������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������� ������������ �������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('���',     '��������� �������������� ����������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('�����',    '��������� ������ ���������, ���������������� � �������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('���',    '��������� ��������������� � �����������������');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('���',     '��������� �������� �����������');


--3.	�������� BEFORE � ������� ������ ��������� �� ������� INSERT, DELETE � UPDATE. 
--4.	���� � ��� ����������� �������� ������ �������� ��������� �� ��������� ������� (DMS_OUTPUT) �� ����� ����������� ������. 


CREATE OR REPLACE TRIGGER FACULTY2_BEFORE
BEFORE INSERT OR UPDATE OR DELETE ON FACULTY2
BEGIN

IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('INSERT COMLITED IN FACULTY2_BEFORE');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (to_char(CURRENT_DATE), 'INSERT', 'FACULTY2_BEFORE',null);
ELSIF UPDATING  THEN 
DBMS_OUTPUT.PUT_LINE('UPDATE COMLITED IN FACULTY2_BEFORE');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (to_char(CURRENT_DATE), 'UPDATE', 'FACULTY2_BEFORE',null);
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('DELETE COMPLITED IN FACULTY2_BEFORE');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (to_char(CURRENT_DATE), 'DELETE', 'FACULTY2_BEFORE',null);
END IF;
END;



--5.	�������� BEFORE-������� ������ ������ �� ������� INSERT, DELETE � UPDATE.

--6.	��������� ��������� INSERTING, UPDATING � DELETING.
drop trigger FACULTY2_BEFORE_ROW;
CREATE OR REPLACE TRIGGER FACULTY2_BEFORE_ROW
BEFORE INSERT OR UPDATE OR DELETE ON FACULTY2
FOR EACH ROW
BEGIN

IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('INSERT COMLITED IN FACULTY2_BEFORE_ROW');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (TO_CHAR(CURRENT_DATE), 'INSERT', 'FACULTY2_BEFORE_ROW',to_char(:old.FACULTY_NAME || ' ' || :new.FACULTY_NAME));
ELSIF UPDATING  THEN 
DBMS_OUTPUT.PUT_LINE('UPDATE COMLITED IN FACULTY2_BEFORE_ROW');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (TO_CHAR(CURRENT_DATE), 'UPDATE', 'FACULTY2_BEFORE_ROW',to_char(:old.FACULTY_NAME || ' ' || :new.FACULTY_NAME));
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('DELETE COMPLITED IN FACULTY2_BEFORE_ROW');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (TO_CHAR(CURRENT_DATE), 'DELETE', 'FACULTY2_BEFORE_ROW',to_char(:old.FACULTY_NAME || ' ' || :new.FACULTY_NAME));
END IF;
END;


--7.	������������ AFTER-�������� ������ ��������� �� ������� INSERT, DELETE � UPDATE.
--8.	������������ AFTER-�������� ������ ������ �� ������� INSERT, DELETE � UPDATE.

CREATE OR REPLACE TRIGGER FACULTY2_AFTER
AFTER INSERT OR UPDATE OR DELETE ON FACULTY2
BEGIN

IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('INSERT COMLITED IN FACULTY2_AFTER');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (TO_CHAR(CURRENT_DATE), 'INSERT', 'FACULTY2_AFTER',NULL);
ELSIF UPDATING  THEN 
DBMS_OUTPUT.PUT_LINE('UPDATE COMLITED IN FACULTY2_AFTER');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (TO_CHAR(CURRENT_DATE), 'UPDATE', 'FACULTY2_AFTER',NULL);
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('DELETE COMPLITED IN FACULTY2_AFTER');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (to_char(CURRENT_DATE), 'DELETE', 'FACULTY2_AFTER',NULL);
END IF;
END;


CREATE OR REPLACE TRIGGER FACULTY2_AFTER_ROW
AFTER INSERT OR UPDATE OR DELETE ON FACULTY2
FOR EACH ROW
BEGIN

IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('INSERT COMLITED IN FACULTY2_AFTER_ROW');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (to_char(CURRENT_DATE), 'INSERT', 'FACULTY2_AFTER_ROW',to_char(:old.FACULTY_NAME || ' ' || :new.FACULTY_NAME));
ELSIF UPDATING  THEN 
DBMS_OUTPUT.PUT_LINE('UPDATE COMLITED IN FACULTY2_AFTER_ROW');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (to_char(CURRENT_DATE), 'UPDATE', 'FACULTY2_AFTER_ROW',to_char(:old.FACULTY_NAME || ' ' || :new.FACULTY_NAME));
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('DELETE COMPLITED IN FACULTY2_AFTER_ROW');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (to_char(CURRENT_DATE), 'DELETE', 'FACULTY2_AFTER_ROW',to_char(:old.FACULTY_NAME || ' ' || :new.FACULTY_NAME));
END IF;
END;



--9.	�������� ������� � ������ AUDIT. ������� ������ ��������� ����: OperationDate, 
--OperationType (�������� �������, ���������� � ��������),
--TriggerName(��� ��������),
--Data (������ � ���������� ����� �� � ����� ��������).



CREATE TABLE AUDIT15
(
OperationDate date,
OperationType nvarchar2(50),
TriggerName nvarchar2(100),
Data nvarchar2(200)
);

select * from AUDIT15;

--10.	�������� �������� ����� �������, ����� ��� �������������� ��� �������� � �������� �������� � ������� AUDIT.

--11.	��������� ��������, ���������� ����������� ������� �� ���������� �����. ��������, ��������������� �� ������� ��� �������. ��������� ���������.

insert into FACULTY2  (FACULTY,   FACULTY_NAME )
             values  ('����',   '����������� ���� � ����������');

--?12.	������� (drop) �������� �������. ��������� ���������. �������� �������, ����������� �������� �������� �������.

DROP TABLE FACULTY2;

DROP TRIGGER BEFORE_DROP;
CREATE OR REPLACE TRIGGER BEFORE_DROP
       BEFORE DROP ON SCHEMA
BEGIN
    raise_application_error(-20000, 'Do not drop table .' || ORA_DICT_OBJ_TYPE|| ' ' || ORA_DICT_OBJ_NAME);
END;

--13.	������� (drop) ������� AUDIT. ����������� ��������� ��������� � ������� SQL-DEVELOPER. ��������� ���������. �������� ��������.

DROP TABLE AUDIT;

--14.	�������� ������������� ��� �������� ��������. ������������ INSTEADOF INSERT-�������. ������� ������ ��������� ������ � �������.

CREATE VIEW V_FACULTY2
AS SELECT  FACULTY, FACULTY_NAME FROM FACULTY2
  
  CREATE OR REPLACE TRIGGER V_FACULTY2_ROW
INSTEAD OF INSERT ON V_FACULTY2
FOR EACH ROW
BEGIN

DBMS_OUTPUT.PUT_LINE('INSERT COMLITED IN V_FACULTY2_ROW');
insert into AUDIT15  (OperationDate, OperationType, TriggerName, Data )
             values  (to_char(CURRENT_DATE), 'INSERT', 'FACULTY2_BEFORE_ROW',to_char(:old.FACULTY_NAME || ' ' || :new.FACULTY_NAME));

END;

DELETE V_FACULTY2 WHERE FACULTY = '����';

insert into V_FACULTY2  (FACULTY,   FACULTY_NAME )
             values  ('����',   '����������� ���� � ����������');


--15.	�����������������, � ����� ������� ����������� ��������.

delete faculty2;
