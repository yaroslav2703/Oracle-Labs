--7 ������������ � ������������ U1_XXX_PDB, � ������� SQL Developer, �������� ������� XXX_table, �������� � ��� ������, ��������� SELECT-������ � �������.
create table PYA_t (x number(3), s varchar2(50)) ;
commit;

insert into PYA_t (x, s) values (1, 'first');
insert into PYA_t (x, s) values (2, 'second');
insert into PYA_t (x, s) values (3, 'third');
commit;

select * from PYA_t;