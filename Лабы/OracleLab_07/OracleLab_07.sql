-- Task 1.�������� ������ ������ ������� ���������
SELECT *
FROM V$BGPROCESS;

-- Task 2. ���������� ������� ��������, ������� �������� � �������� � ��������� ������.
SELECT *
FROM V$BGPROCESS
WHERE PADDR != HEXTORAW('00');

-- Task 3.����������, ������� ��������� DBWn �������� � ��������� ������.
SELECT COUNT(*)
FROM V$PROCESS
WHERE PNAME LIKE 'DBWR%';

-- Task 4.	�������� �������� ������� ���������� � �����������.
SELECT *
FROM V$SESSION
WHERE USERNAME IS NOT NULL;

-- Task 5.���������� ������ ���� ����������.
SELECT
  SERVER,
  USERNAME,
  SID,
  STATUS
FROM V$SESSION
WHERE USERNAME IS NOT NULL;

-- Task 6.���������� ������� (����� ����������� ����������).
SELECT *
FROM V$SERVICES;

-- Task 7. Get dispatcher parameter
-- /as sysdba
-- SHOW PARAMETER DISPATCHER;

-- Task 8. Show tns listener
-- in services

-- Task 9. Get all connection with instance
SELECT *
FROM V$SESSION
WHERE USERNAME IS NOT NULL;

-- Task 10. Show listener ora
-- d:\app\taller\virtual\product\12.2.0\dbhome_2\network\admin\

-- Task 11. exc lsnrctl
-- d:\app\taller\virtual\product\12.2.0\dbhome_2\bin\

-- Task 12. get all services with instance
-- cmd
-- lsnrctl
-- services