DROP TABLE loaderinfo;
create table loaderinfo
(
f1 int primary key,
f2 varchar2(100),
f3 date
);

select * from loaderinfo;

create table loaderinfo2
(
f1 int primary key
);

select * from loaderinfo7;

create table loaderinfo7
(
f1 varchar2(100) primary key,
f2 varchar2(100),
f3 varchar2(100)
);

SPOOL  d:\sel.txt OUT
select * from loaderinfo7;
SPOOL off