--1.	�������� ������ ������ ������� ���������. 
 SELECT * FROM v$BGPROCESS;

--2.	���������� ������� ��������, ������� �������� � �������� � ��������� ������.
SELECT * FROM v$BGPROCESS WHERE PADDR != HEXTORAW('00');

--3.	����������, ������� ��������� DBWn �������� � ��������� ������.
SELECT COUNT(*) FROM V$PROCESS WHERE PNAME LIKE 'DBWR%';

--4.	�������� �������� ������� ���������� � �����������.
SELECT * FROM V$SESSION WHERE USERNAME IS NOT NULL;

--5.	���������� ������ ���� ����������.
SELECT  SERVER,  USERNAME,  SID,  STATUS FROM V$SESSION WHERE USERNAME IS NOT NULL;

--6.	���������� ������� (����� ����������� ����������).
SELECT * FROM V$SERVICES;

--7.	�������� ��������� ��� ��������� ���������� � �� ��������.
/as sysdba
SHOW PARAMETER DISPATCHER;

--8.	������� � ������ Windows-�������� ������, ����������� ������� LISTENER.
--���	�� ��������	��������	���������	������
--OracleOraDB12Home1TNSListener	4688	OracleOraDB12Home1TNSListener	�����������	

--9.	�������� �������� ������� ���������� � ���������. (dedicated, shared). 
SELECT * FROM V$SESSION WHERE USERNAME IS NOT NULL;

--10.	����������������� � �������� ���������� ����� LISTENER.ORA. 
--D:\app\oracledatabase\product\12.1.0\dbhome_1\NETWORK\ADMIN\

--11.	��������� ������� lsnrctl � �������� �� �������� �������. 
--D:\app\oracledatabase\product\12.1.0\dbhome_1\BIN

--12.	�������� ������ ����� ��������, ������������� ��������� LISTENER. 
-- cmd
-- lsnrctl
-- services
