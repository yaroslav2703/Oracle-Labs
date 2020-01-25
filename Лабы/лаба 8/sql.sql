--1 SQLNET.ORA TNSNAMES.ORA

--D:\app\oracledatabase\product\12.1.0\dbhome_1\NETWORK\ADMIN\

--2 connect sqlplus as SYSTEM, select all parms of instance Oracle.

show parameters;

--3 connect sqlplus as SYSTEM to PDB, get list of tablespaces, list tablespaces
--            files, roles, users

select * from v$pdbs; -- ALC_PDB

--connect sys/1234@//localhost:1521/alc_pdb.belstu.by as sysdba
--select status from v$instance;
--alter database open;


--select * from sys.dba_tablespaces;
  --tablespaces
select tablespace_name, status, contents logging from sys.dba_tablespaces;

  --files
select file_name, tablespace_name, status, maxbytes, user_bytes 
  from dba_data_files
union
select file_name, tablespace_name, status, maxbytes, user_bytes 
  from dba_temp_files;

  --roles
select * from dba_roles;
select * from dba_roles where role like 'C##%';

  --users
--select * from dba_profiles;
--select * from dba_users;
select * from v$services;
--4

--HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE

--5

--Oracle Net Manager
--alc_pdb
-- file tnsnames.ora added data
-- tnsping alc_pdb  ---- in CMD

--6

--connect c##alc/1234@alc_pdb

--7

--select table_name from user_tables; -- task9table1, task9table
--select * from task9table;

--8

--SQLPLUS help timing

-- set timing on
-- select * from task9table;

--9

-- help describe
-- describe task9table;

--10

-- select * from user_segments;
select segment_name, segment_type, owner from dba_segments where owner = 'C##ALC';
--select * from dba_segments;

--11

create view vlab8task11
  as
    select count(segment_name) segment_count,
      count(extents) extent_count,
      count(blocks) block_count,
      sum(bytes) byte_sum
    from dba_segments;
    
select * from vlab8task11;
