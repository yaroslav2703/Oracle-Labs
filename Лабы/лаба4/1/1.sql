
--1 Получите список всех существующих PDB(подключаемые БД) в рамках экземпляра ORA12W
select name,open_mode, total_size from v$pdbs;

select * from dba_users;

--2 Выполните запрос к ORA12W, позволяющий получить перечень экземпляров.
select INSTANCE_NAME from v$instance;
-- 3 Выполните запрос к ORA12W, позволяющий получить перечень установленных компонентов СУБД Oracle 12c и их версии и статус.
select * from PRODUCT_COMPONENT_VERSION;

select con_id, name
  from v$pdbs;