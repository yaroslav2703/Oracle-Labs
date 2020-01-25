SELECT NAME, TYPE FROM V$FIXED_TABLE WHERE NAME LIKE 'V$T%';

select FILE#, NAME from v$dbfile;    
select file#, name, status from v$datafile;
select FILE#, NAME, STATUS from v$tempfile;
select group#, member from v$logfile order by group#;
select name from v$controlfile;
select name from v$archived_log;

