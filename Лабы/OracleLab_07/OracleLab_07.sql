-- Task 1.Получите полный список фоновых процессов
SELECT *
FROM V$BGPROCESS;

-- Task 2. Определите фоновые процессы, которые запущены и работают в настоящий момент.
SELECT *
FROM V$BGPROCESS
WHERE PADDR != HEXTORAW('00');

-- Task 3.Определите, сколько процессов DBWn работает в настоящий момент.
SELECT COUNT(*)
FROM V$PROCESS
WHERE PNAME LIKE 'DBWR%';

-- Task 4.	Получите перечень текущих соединений с экземпляром.
SELECT *
FROM V$SESSION
WHERE USERNAME IS NOT NULL;

-- Task 5.Определите режимы этих соединений.
SELECT
  SERVER,
  USERNAME,
  SID,
  STATUS
FROM V$SESSION
WHERE USERNAME IS NOT NULL;

-- Task 6.Определите сервисы (точки подключения экземпляра).
SELECT *
FROM V$SERVICES;

-- Task 7. Get dispatcher parameter
-- /as sysdba
-- SHOW PARAMETER DISPATCHER;

-- Task 8. Show tns listener
-- in services

-- Task 9. Get all connection with instance
SELECT *
FROM V$SESSION
WHERE USERNAME IS NOT NULL;

-- Task 10. Show listener ora
-- d:\app\taller\virtual\product\12.2.0\dbhome_2\network\admin\

-- Task 11. exc lsnrctl
-- d:\app\taller\virtual\product\12.2.0\dbhome_2\bin\

-- Task 12. get all services with instance
-- cmd
-- lsnrctl
-- services