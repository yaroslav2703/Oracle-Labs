
--1 �������� ������ ���� ������������ PDB(������������ ��) � ������ ���������� ORA12W
select name,open_mode, total_size from v$pdbs;

select * from dba_users;

--2 ��������� ������ � ORA12W, ����������� �������� �������� �����������.
select INSTANCE_NAME from v$instance;
-- 3 ��������� ������ � ORA12W, ����������� �������� �������� ������������� ����������� ���� Oracle 12c � �� ������ � ������.
select * from PRODUCT_COMPONENT_VERSION;

select con_id, name
  from v$pdbs;