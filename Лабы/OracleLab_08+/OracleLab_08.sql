-- if error when connect to pdb
-- alter pluggable database all open;

--create user C##MES_PDB identified by Qwerty123;

-- Task 1. set rule to user (from system console)
GRANT CREATE SESSION,
      CREATE SEQUENCE,
      CREATE TABLE,
      CREATE CLUSTER,
      CREATE SYNONYM,
      CREATE PUBLIC SYNONYM,
      CREATE VIEW,
      CREATE MATERIALIZED VIEW TO C##Slava_PDB;

-- Task 2. Create sequence
CREATE SEQUENCE S1
      START WITH 1000
      INCREMENT BY 10
      NOMINVALUE NOMAXVALUE NOCYCLE NOCACHE NOORDER;

SELECT S1.nextval FROM dual;

SELECT S1.currval FROM dual;

DROP SEQUENCE S4;

-- Task 3.
CREATE SEQUENCE S2 START WITH 10 INCREMENT BY 10 MAXVALUE 100 NOCYCLE;

SELECT S2.nextval FROM dual;

DROP SEQUENCE S2;

-- Task 4.
CREATE SEQUENCE S3 START WITH 10 INCREMENT BY -10 MAXVALUE 100 MINVALUE -100 NOCYCLE ORDER;

SELECT S3.nextval FROM dual;

DROP SEQUENCE S3;

-- Task 5.
CREATE SEQUENCE S4 START WITH 1 INCREMENT BY 1 MINVALUE 0 MAXVALUE 20 CYCLE CACHE 5 NOORDER;

SELECT S4.nextval FROM dual;

DROP SEQUENCE S4;

-- Task 6. get all sequences (from system console)
SELECT *
FROM DBA_SEQUENCES
WHERE SEQUENCE_OWNER = 'SYSTEM';

-- Task 7. create table and insert date from seq
CREATE TABLE T1 (
  N1 NUMBER(20),
  N2 NUMBER(20),
  N3 NUMBER(20),
  N4 NUMBER(20),
  N5 NUMBER(20),
  N6 NUMBER(20),
  N7 NUMBER(20)
) STORAGE (BUFFER_POOL KEEP
);

/*INSERT INTO T1 SELECT
                 S1.nextval,
                 S2.nextval,
                 S3.nextval,
                 S4.nextval
               FROM dual;*/
INSERT INTO T1(N1) values (S1.nextval
INSERT INTO T1(N2) values (S2.nextval);
INSERT INTO T1(N3) values (S3.nextval);
INSERT INTO T1(N2) values (S2.nextval);
INSERT INTO T1(N3) values (S3.nextval);
INSERT INTO T1(N4) values (S4.nextval);
INSERT INTO T1(N5) values (S1.nextval);
INSERT INTO T1(N6) values (S2.nextval);
INSERT INTO T1(N7) values (S3.nextval);

SELECT *
FROM T1;

DROP TABLE T1;

-- Task 8. create cluster table
CREATE CLUSTER ABC (X NUMBER(10), VA NVARCHAR2(12))
  HASHKEYS 200;

DROP CLUSTER ABC;

-- Task 9. create table for cluster
CREATE TABLE A (
  XA NUMBER(10),
  VA NVARCHAR2(12),
  AA INT
) CLUSTER ABC(XA, VA);

DROP TABLE A;

-- Task 10. create table for cluster
CREATE TABLE B (
  XB NUMBER(10),
  VB NVARCHAR2(12),
  BB INT
) CLUSTER ABC(XB, VB);

DROP TABLE B;

-- Task 11. create table for cluster
CREATE TABLE C (
  XC NUMBER(10),
  VC NVARCHAR2(12),
  CC INT
) CLUSTER ABC(XC, VC);

DROP TABLE C;

-- Task 12. get all created tables and clusters
SELECT *
FROM ALL_TABLES
WHERE TABLE_NAME = 'A';
-- from system console
SELECT *
FROM DBA_CLUSTERS;

-- Task 13. Create synonym for table
CREATE SYNONYM SYN1 FOR C;

SELECT *
FROM SYN1;

-- Task 14. create public synonym for table
CREATE PUBLIC SYNONYM SYN2 FOR B;

SELECT *
FROM SYN2;

-- Task 15. create two table with fk, and create view for it
CREATE TABLE AA (
  id    NUMBER PRIMARY KEY,
  login NVARCHAR2(20)
);

CREATE TABLE BB (
  entryDate DATE,
  userId    NUMBER,
  CONSTRAINT userID_id_fk FOREIGN KEY (userId) REFERENCES AA (id)
);

INSERT INTO AA (id, login) VALUES (1, 'first');
INSERT INTO AA (id, login) VALUES (2, 'second');
INSERT INTO BB (entryDate, userId) VALUES (CURRENT_DATE, 1);
INSERT INTO BB (entryDate, userId) VALUES (CURRENT_DATE, 1);
INSERT INTO BB (entryDate, userId) VALUES (CURRENT_DATE, 2);
COMMIT;

SELECT *
FROM AA
  INNER JOIN BB ON AA.id = BB.userId;

CREATE VIEW VIEW1 AS
  SELECT *
  FROM AA
    INNER JOIN BB ON AA.id = BB.userId;

SELECT *
FROM VIEW1;

DROP VIEW VIEW1;
ALTER TABLE BB
  DROP CONSTRAINT userID_id_fk;
DROP TABLE BB;
DROP TABLE AA;

-- Task 16. Create materialize view
CREATE MATERIALIZED VIEW VIEW2 BUILD IMMEDIATE REFRESH COMPLETE ON DEMAND NEXT SYSDATE + NUMTODSINTERVAL(2, 'MINUTE') AS
  SELECT *
  FROM AA
    INNER JOIN BB ON AA.id = BB.userId;

SELECT *
FROM VIEW2;

DROP MATERIALIZED VIEW VIEW2;