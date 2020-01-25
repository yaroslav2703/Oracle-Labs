select * from dba_tablespaces;

create tablespace ex_pdb_ts1
datafile 'D:\app\oracledatabase\oradata\orcl\EXPDB\ex_pdb_ts1.dbf'
size 10m
AUTOEXTEND ON NEXT 500K MAXSIZE 100M
EXTENT MANAGEMENT LOCAL;

drop tablespace ex_pdb_ts1;

CREATE ROLE EX_ROLE1;