create table Table_1(x number(3), s varchar2(50));

create view First_View as select * from Table_1 Where x=2;

create table Table_2(x int) tablespace KYA_QDATA;

insert into Table_2(x) values (5);
insert into Table_2(x) values (7);
insert into Table_2(x) values (8);

select * from Table_2;