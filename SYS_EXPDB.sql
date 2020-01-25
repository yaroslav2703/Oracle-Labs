
grant create TABLESPACE to EXPDBADMIN;
COMMIT;

grant drop TABLESPACE to expdbadmin;
commit;

revoke drop TABLESPACE from expdbadmin;
commit;

select * from sys.dba_tablespaces;

select * from dba_data_files;

grant create role to EXPDBADMIN;

CREATE PROFILE EXPROFILE1 LIMIT
PASSWORD_LIFE_TIME 180;

SELECT * FROM DBA_PROFILES WHERE profile = 'EXPROFILE1';

DROP PROFILE EXPROFILE1 CASCADE;

CREATE USER EXUSER1 IDENTIFIED BY 1234567890
DEFAULT TABLESPACE ex_pdb_ts1 QUOTA UNLIMITED ON ex_pdb_ts1 
PROFILE EXPROFILE1
ACCOUNT UNLOCK
PASSWORD EXPIRE;

grant ex_role1 to exuser1;

SELECT * FROM dba_users;

alter profile exprofile1 limit password_life_time unlimited;


