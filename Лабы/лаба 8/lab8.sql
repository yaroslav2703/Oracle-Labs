--1.	Найдите на компьютере конфигурационные файлы SQLNET.ORA и TNSNAMES.ORA и ознакомьтесь с их содержимым.
--D:\app\oracledatabase\product\12.1.0\dbhome_1\NETWORK\ADMIN\

--2.	Соединитесь при помощи sqlplus с Oracle как пользователь SYSTEM, получите перечень параметров экземпляра Oracle.
  show parameters;

--3.	Соединитесь при помощи sqlplus с подключаемой базой данных как пользователь SYSTEM, получите список табличных пространств, файлов табличных пространств, ролей и пользователей.
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
  

--4.	Ознакомьтесь с параметрами в HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE на вашем компьютере.
--5.	Запустите утилиту Oracle Net Manager и подготовьте строку подключения с именем имя_вашего_пользователя_SID, где SID – идентификатор подключаемой базы данных. 
--pya_pdb

--6.	Подключитесь с помощью sqlplus под собственным пользователем и с применением подготовленной строки подключения. 
--connect system/200003vk4PYA2@pya_pdb

--7.	Выполните select к любой таблице, которой владеет ваш пользователь. 
  select * from yar;

--8.	Ознакомьтесь с командой HELP.Получите справку по команде TIMING. Подсчитайте, сколько времени длится select к любой таблице.
help timing
set timing on;
select * from yar;

--9.	Ознакомьтесь с командой DESCRIBE.Получите описание столбцов любой таблицы.
 help describe
 describe yar;

--10.	Получите перечень всех сегментов, владельцем которых является ваш пользователь.
select * from user_segments;
select segment_name, segment_type, owner from dba_segments where owner = 'system';
--select * from dba_segments;

--11.	Создайте представление, в котором получите количество всех сегментов, количество экстентов, блоков памяти и размер в килобайтах, которые они занимают.
create view vyar
  as
    select count(segment_name) segment_count,
      count(extents) extent_count,
      count(blocks) block_count,
      sum(bytes) byte_sum
    from dba_segments;
    
select * from vyar;
