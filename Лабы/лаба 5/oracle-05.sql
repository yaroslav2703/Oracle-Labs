-- 1
SELECT FILE_NAME, TABLESPACE_NAME, STATUS, MAXBYTES, USER_BYTES FROM DBA_DATA_FILES
UNION
SELECT FILE_NAME, TABLESPACE_NAME, STATUS, MAXBYTES, USER_BYTES FROM DBA_TEMP_FILES;
 
-- 2
CREATE TABLESPACE PYA_QDATA5
  DATAFILE 'D:\3 КУРС\Базы данных\Лабы\лаба 5\PYA_QDATA5.dbf'
  SIZE 10M
  AUTOEXTEND ON NEXT 1M
  MAXSIZE 20M
  EXTENT MANAGEMENT LOCAL
  OFFLINE;

--DROP TABLESPACE PYA_QDATA5 INCLUDING CONTENTS;
ALTER TABLESPACE PYA_QDATA5 ONLINE;
ALTER USER PYA QUOTA 2M ON PYA_QDATA5;
ALTER USER PYA DEFAULT TABLESPACE PYA_QDATA5;
GRANT CREATE TABLE TO PYA;
GRANT SELECT ANY DICTIONARY TO PYA;

select default_tablespace, temporary_tablespace from dba_users where username='PYA';

CREATE TABLE PYA_T1
(
    id int,
    s varchar2(50),
    CONSTRAINT PYA_table_pk PRIMARY KEY (id)
);

-- DROP TABLE PYA_T1;

INSERT INTO PYA_T1 values (1, 'X');
INSERT INTO PYA_T1 values (2, 'C');
INSERT INTO PYA_T1 values (3, 'V');

SELECT * FROM PYA_T1;

-- 3
SELECT * FROM dba_segments where tablespace_name='PYA_QDATA5';

-- 4
DROP TABLE PYA_T1;
SELECT * FROM dba_segments where tablespace_name='GON_QDATA5';
SELECT * FROM user_recyclebin;

-- 5
FLASHBACK TABLE PYA_T1 TO BEFORE DROP;

-- 6
BEGIN
  DELETE PYA_T1;
  FOR i IN 1..10000
  LOOP
    INSERT INTO PYA_T1(id, s) VALUES(i, 'STRING');
  END LOOP;
  COMMIT;
END;
 
-- 7
-- количество экстентов в сегменте таблицы 
SELECT segment_name, segment_type, tablespace_name, bytes, blocks, extents, buffer_pool
FROM user_segments
WHERE tablespace_name='PYA_QDATA5' and segment_name='PYA_T1';

SELECT * FROM user_extents WHERE tablespace_name='PYA_QDATA5';

-- 8
DROP TABLESPACE PYA_QDATA5 INCLUDING CONTENTS;

-- 9
SELECT GROUP#, STATUS, MEMBERS FROM V$LOG;

-- 10
SELECT * FROM V$LOGFILE;

-- 11
ALTER SYSTEM SWITCH LOGFILE; --10:23

-- 12
ALTER DATABASE ADD LOGFILE GROUP 4 '\REDO04.LOG'
SIZE 50m BLOCKSIZE 512;

ALTER DATABASE ADD LOGFILE MEMBER 'D:\3 КУРС\Базы данных\Лабы\лаба 5\tablespace\REDO041.LOG' TO GROUP 4;
ALTER DATABASE ADD LOGFILE MEMBER 'D:\3 КУРС\Базы данных\Лабы\лаба 5\tablespace\REDO042.LOG' TO GROUP 4;
ALTER DATABASE ADD LOGFILE MEMBER 'D:\3 КУРС\Базы данных\Лабы\лаба 5\tablespace\REDO043.LOG' TO GROUP 4;

SELECT * FROM V$LOG;

-- 13
ALTER DATABASE DROP LOGFILE MEMBER 'D:\3 КУРС\Базы данных\Лабы\лаба 5\tablespace\REDO041.LOG';
ALTER DATABASE DROP LOGFILE MEMBER 'D:\3 КУРС\Базы данных\Лабы\лаба 5\tablespace\REDO042.LOG';
ALTER DATABASE DROP LOGFILE MEMBER 'D:\3 КУРС\Базы данных\Лабы\лаба 5\tablespace\REDO043.LOG';

ALTER DATABASE DROP LOGFILE GROUP 4;

-- 14
SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;

-- 15
SELECT * FROM V$ARCHIVED_LOG;

-- 16
-- sql plus
-- connect / as sysdba
-- shutdown immediate;
-- startup mount;
-- alter database archivelog;
-- alter database open;

-- 17
ALTER SYSTEM SWITCH LOGFILE;
SELECT * FROM V$ARCHIVED_LOG;
SELECT * FROM V$LOG;

-- 18
-- sql plus
-- connect / as sysdba
-- shutdown immediate;
-- startup mount;
-- alter database noarchivelog;
-- alter database open;

-- 19
SHOW PARAMETER CONTROL;
SELECT NAME FROM V$CONTROLFILE;

-- 20
SELECT * FROM V$CONTROLFILE_RECORD_SECTION;
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;

-- 21
 SHOW PARAMETER PFILE;

-- 22
CREATE PFILE = 'PYA_PFILE.ORA' FROM SPFILE;
SELECT *FROM V$SPPARAMETER;

-- 23
-- D:\app\oracledatabase\product\12.1.0\dbhome_1\database\PWDorcl.ora
SELECT * FROM V$PWFILE_USERS;

-- 24
SELECT * FROM V$DIAG_INFO;

-- 25
-- C:\University\3 курс\5 сем\БД\oracl\gonch\diag\rdbms\orcl\orcl\alert















-- Блок — наименьшая единица управления пространством в базе данных. 
-- Control files – файлы, содержащие имена (местоположение) основных 
-- физических файлов базы данных и некоторых параметров