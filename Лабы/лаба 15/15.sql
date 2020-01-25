SET serveroutput ON;


ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER USER_LABS IDENTIFIED BY password;
GRANT ALL PRIVILEGES TO USER_LABS;

--1.	Создайте таблицу, имеющую несколько атрибутов, один из которых первичный ключ.

DROP TABLE FACULTY2
CREATE TABLE FACULTY2
  (
   FACULTY      VARCHAR2(10)      NOT NULL,
   FACULTY_NAME VARCHAR2(100), 
   CONSTRAINT PK_FACULTY2 PRIMARY KEY(FACULTY) 
  );


--2.	Заполните таблицу строками (10 шт.).


delete FACULTY2;
insert into FACULTY2  (FACULTY,   FACULTY_NAME )
             values  ('ИДиП',   'Издателькое дело и полиграфия');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ХТиТ',   'Химическая технология и техника');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ЛХФ',     'Лесохозяйственный факультет');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ИЭФ',     'Инженерно-экономический факультет');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ТТЛП',    'Технология и техника лесной промышленности');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ТОВ',     'Технология органических веществ');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ФИТ',     'Факультет информационных технолигий');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ФЛИМД',    'Факультет лесной инженерии, материаловедения и дизайна');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ПИМ',    'Факультет принттехнологий и медиакоммуникаций');
insert into FACULTY2   (FACULTY,   FACULTY_NAME )
            values  ('ФЗО',     'Факультет заочного образования');


--3.	Создайте BEFORE – триггер уровня оператора на события INSERT, DELETE и UPDATE. 
--4.	Этот и все последующие триггеры должны выдавать сообщение на серверную консоль (DMS_OUTPUT) со своим собственным именем. 


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



--5.	Создайте BEFORE-триггер уровня строки на события INSERT, DELETE и UPDATE.

--6.	Примените предикаты INSERTING, UPDATING и DELETING.
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


--7.	Разработайте AFTER-триггеры уровня оператора на события INSERT, DELETE и UPDATE.
--8.	Разработайте AFTER-триггеры уровня строки на события INSERT, DELETE и UPDATE.

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



--9.	Создайте таблицу с именем AUDIT. Таблица должна содержать поля: OperationDate, 
--OperationType (операция вставки, обновления и удаления),
--TriggerName(имя триггера),
--Data (строка с значениями полей до и после операции).



CREATE TABLE AUDIT15
(
OperationDate date,
OperationType nvarchar2(50),
TriggerName nvarchar2(100),
Data nvarchar2(200)
);

select * from AUDIT15;

--10.	Измените триггеры таким образом, чтобы они регистрировали все операции с исходной таблицей в таблице AUDIT.

--11.	Выполните операцию, нарушающую целостность таблицы по первичному ключу. Выясните, зарегистрировал ли триггер это событие. Объясните результат.

insert into FACULTY2  (FACULTY,   FACULTY_NAME )
             values  ('ИДиП',   'Издателькое дело и полиграфия');

--?12.	Удалите (drop) исходную таблицу. Объясните результат. Добавьте триггер, запрещающий удаление исходной таблицы.

DROP TABLE FACULTY2;

DROP TRIGGER BEFORE_DROP;
CREATE OR REPLACE TRIGGER BEFORE_DROP
       BEFORE DROP ON SCHEMA
BEGIN
    raise_application_error(-20000, 'Do not drop table .' || ORA_DICT_OBJ_TYPE|| ' ' || ORA_DICT_OBJ_NAME);
END;

--13.	Удалите (drop) таблицу AUDIT. Просмотрите состояние триггеров с помощью SQL-DEVELOPER. Объясните результат. Измените триггеры.

DROP TABLE AUDIT;

--14.	Создайте представление над исходной таблицей. Разработайте INSTEADOF INSERT-триггер. Триггер должен добавлять строку в таблицу.

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

DELETE V_FACULTY2 WHERE FACULTY = 'ИДиП';

insert into V_FACULTY2  (FACULTY,   FACULTY_NAME )
             values  ('ИДиП',   'Издателькое дело и полиграфия');


--15.	Продемонстрируйте, в каком порядке выполняются триггеры.

delete faculty2;
