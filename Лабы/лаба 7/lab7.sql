--1.	Получите полный список фоновых процессов. 
 SELECT * FROM v$BGPROCESS;

--2.	Определите фоновые процессы, которые запущены и работают в настоящий момент.
SELECT * FROM v$BGPROCESS WHERE PADDR != HEXTORAW('00');

--3.	Определите, сколько процессов DBWn работает в настоящий момент.
SELECT COUNT(*) FROM V$PROCESS WHERE PNAME LIKE 'DBWR%';

--4.	Получите перечень текущих соединений с экземпляром.
SELECT * FROM V$SESSION WHERE USERNAME IS NOT NULL;

--5.	Определите режимы этих соединений.
SELECT  SERVER,  USERNAME,  SID,  STATUS FROM V$SESSION WHERE USERNAME IS NOT NULL;

--6.	Определите сервисы (точки подключения экземпляра).
SELECT * FROM V$SERVICES;

--7.	Получите известные вам параметры диспетчера и их значений.
/as sysdba
SHOW PARAMETER DISPATCHER;

--8.	Укажите в списке Windows-сервисов сервис, реализующий процесс LISTENER.
--Имя	ИД процесса	Описание	Состояние	Группа
--OracleOraDB12Home1TNSListener	4688	OracleOraDB12Home1TNSListener	Выполняется	

--9.	Получите перечень текущих соединений с инстансом. (dedicated, shared). 
SELECT * FROM V$SESSION WHERE USERNAME IS NOT NULL;

--10.	Продемонстрируйте и поясните содержимое файла LISTENER.ORA. 
--D:\app\oracledatabase\product\12.1.0\dbhome_1\NETWORK\ADMIN\

--11.	Запустите утилиту lsnrctl и поясните ее основные команды. 
--D:\app\oracledatabase\product\12.1.0\dbhome_1\BIN

--12.	Получите список служб инстанса, обслуживаемых процессом LISTENER. 
-- cmd
-- lsnrctl
-- services
