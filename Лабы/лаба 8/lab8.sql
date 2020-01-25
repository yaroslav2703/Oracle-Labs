--1.	������� �� ���������� ���������������� ����� SQLNET.ORA � TNSNAMES.ORA � ������������ � �� ����������.
--D:\app\oracledatabase\product\12.1.0\dbhome_1\NETWORK\ADMIN\

--2.	����������� ��� ������ sqlplus � Oracle ��� ������������ SYSTEM, �������� �������� ���������� ���������� Oracle.
  show parameters;

--3.	����������� ��� ������ sqlplus � ������������ ����� ������ ��� ������������ SYSTEM, �������� ������ ��������� �����������, ������ ��������� �����������, ����� � �������������.
select * from v$pdbs; --PYA_PDB
 --connect system/200003vk4PYA2@//localhost:1521/pya_pdb.be.by
 select status from v$instance;


select tablespace_name, status, contents logging from sys.dba_tablespaces;

select file_name, tablespace_name, status, maxbytes, user_bytes 
  from dba_data_files
union
select file_name, tablespace_name, status, maxbytes, user_bytes 
  from dba_temp_files;
  
  select * from dba_roles;
select * from dba_roles where role like 'C##%';

select * from dba_users;
  

--4.	������������ � ����������� � HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE �� ����� ����������.
--5.	��������� ������� Oracle Net Manager � ����������� ������ ����������� � ������ ���_������_������������_SID, ��� SID � ������������� ������������ ���� ������. 
--pya_pdb

--6.	������������ � ������� sqlplus ��� ����������� ������������� � � ����������� �������������� ������ �����������. 
--connect system/200003vk4PYA2@pya_pdb

--7.	��������� select � ����� �������, ������� ������� ��� ������������. 
  select * from yar;

--8.	������������ � �������� HELP.�������� ������� �� ������� TIMING. �����������, ������� ������� ������ select � ����� �������.
help timing
set timing on;
select * from yar;

--9.	������������ � �������� DESCRIBE.�������� �������� �������� ����� �������.
 help describe
 describe yar;

--10.	�������� �������� ���� ���������, ���������� ������� �������� ��� ������������.
select * from user_segments;
select segment_name, segment_type, owner from dba_segments where owner = 'system';
--select * from dba_segments;

--11.	�������� �������������, � ������� �������� ���������� ���� ���������, ���������� ���������, ������ ������ � ������ � ����������, ������� ��� ��������.
create view vyar
  as
    select count(segment_name) segment_count,
      count(extents) extent_count,
      count(blocks) block_count,
      sum(bytes) byte_sum
    from dba_segments;
    
select * from vyar;
