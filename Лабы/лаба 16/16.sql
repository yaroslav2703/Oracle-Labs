SET serveroutput ON;

create tablespace lab16_1
datafile 'D:\3 КУРС\Базы данных\Лабы\лаба 16\lab16_1.dbf' size 5M
AUTOEXTEND ON NEXT 5M
MAXSIZE UNLIMITED
LOGGING
ONLINE;
commit;

create tablespace lab16_2
datafile 'D:\3 КУРС\Базы данных\Лабы\лаба 16\lab16_2.dbf' size 5M
AUTOEXTEND ON NEXT 5M
MAXSIZE UNLIMITED
LOGGING
ONLINE;
commit;

create tablespace lab16_3
datafile 'D:\3 КУРС\Базы данных\Лабы\лаба 16\lab16_3.dbf' size 5M
AUTOEXTEND ON NEXT 5M
MAXSIZE UNLIMITED
LOGGING
ONLINE;
commit;

drop TABLESPACE lab16_1  INCLUDING CONTENTS;
drop TABLESPACE lab16_2  INCLUDING CONTENTS;
drop TABLESPACE lab16_3  INCLUDING CONTENTS;
commit;

--1.	Создайте таблицу T_RANGE c диапазонным секционированием. Используйте ключ секционирования типа NUMBER. 

 CREATE TABLE T_RANGE
 (ticket_no NUMBER,
sale_year NUMBER NOT NULL,
 sale_month NUMBER NOT NULL,
 sale_day NUMBER NOT NULL)
 PARTITION BY RANGE (sale_year, sale_month, sale_day)
 (
 PARTITION sales_q1 VALUES LESS THAN (2019, 04, 01)
 TABLESPACE lab16_1,
 PARTITION sales_q2 VALUES LESS THAN (2019, 07, 01)
 TABLESPACE lab16_2,
 PARTITION sales_q3 VALUES LESS THAN (2019, 10, 01)
 TABLESPACE lab16_3
);

--2.	Создайте таблицу T_INTERVAL c интервальным секционированием. Используйте ключ секционирования типа DATE.

CREATE TABLE T_INTERVAL
( prod_id NUMBER(6)
, cust_id NUMBER
, time_id DATE
, channel_id CHAR(1)
, promo_id NUMBER(6)
, quantity_sold NUMBER(3)
, amount_sold NUMBER(10,2)
)
PARTITION BY RANGE (time_id)
INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
( PARTITION p0 VALUES LESS THAN (TO_DATE('1-1-2016', 'DD-MM-YYYY')),
PARTITION p1 VALUES LESS THAN (TO_DATE('1-1-2017', 'DD-MM-YYYY')),
PARTITION p2 VALUES LESS THAN (TO_DATE('1-7-2018', 'DD-MM-YYYY')),
PARTITION p3 VALUES LESS THAN (TO_DATE('1-1-2019', 'DD-MM-YYYY')) );

--3.	Создайте таблицу T_HASH c хэш-секционированием. Используйте ключ секционирования типа VARCHAR2.

CREATE TABLE T_HASH
 (
 ticket_no VARCHAR2(100),
 sale_year INT NOT NULL,
 sale_month INT NOT NULL,
 sale_day INT NOT NULL
 )
 PARTITION BY HASH (ticket_no)
PARTITIONS 3
 STORE IN (lab16_1, lab16_2, lab16_3);

--4.	Создайте таблицу T_LIST со списочным секционированием. Используйте ключ секционирования типа CHAR.

CREATE TABLE T_LIST
 (ticket_no NUMBER,
sale_year INT NOT NULL,
 sale_month INT NOT NULL,
sale_day INT NOT NULL,
 destination_city CHAR(3),
 start_city CHAR(3))
PARTITION BY LIST (start_city)
(
PARTITION northeast_sales values ('NYC','BOS','PEN') TABLESPACE lab16_1,
 PARTITION southwest_sales values ('DFW','ORL','HOU') TABLESPACE lab16_2,
PARTITION pacificwest_sales values('SAN','LOS','WAS') TABLESPACE lab16_3
 );

--5.	Введите с помощью операторов INSERT данные в таблицы T_RANGE, T_INTERVAL, T_HASH, T_LIST. Данные должны быть такими, чтобы они разместились по всем секциям. Продемонстрируйте это с помощью SELECT запроса. 

--T_RANGE--------

INSERT INTO T_RANGE
VALUES
(1,2019,05,13);

INSERT INTO T_RANGE
VALUES
(2,2019,08,02);


INSERT INTO T_RANGE
VALUES
(3,2019,01,20);

INSERT INTO T_RANGE
VALUES
(4,2018,10,08);

SELECT * FROM T_RANGE PARTITION(sales_q1);
SELECT * FROM T_RANGE PARTITION(sales_q2);
SELECT * FROM T_RANGE PARTITION(sales_q3);


--T_INTERVAL-----

INSERT INTO T_INTERVAL
VALUES
(1, 2, '02-03-2016', '1',345223, 432, 6543);


INSERT INTO T_INTERVAL
VALUES
(1, 2, '02-03-2017', '1',345223, 432, 6543);


INSERT INTO T_INTERVAL
VALUES
(1, 2, '02-03-2018', '1',345223, 432, 6543);

INSERT INTO T_INTERVAL
VALUES
(1, 2, '02-03-2019', '1',345223, 432, 6543);

SELECT * FROM T_INTERVAL PARTITION(p0);
SELECT * FROM T_INTERVAL PARTITION(p1);
SELECT * FROM T_INTERVAL PARTITION(p2);
SELECT * FROM T_INTERVAL PARTITION(p3);

select * from user_tab_partitions where table_name = 'T_INTERVAL';

--T_HASH---------

INSERT INTO T_HASH
VALUES
(1,2019,05,13);

INSERT INTO T_HASH
VALUES
(2,2019,08,02);


INSERT INTO T_HASH
VALUES
(3,2019,01,20);

INSERT INTO T_HASH
VALUES
(4,2018,10,08);

delete t_hash;

select * from user_tab_partitions where table_name = 'T_HASH';

--T_LIST---------

INSERT INTO T_LIST
VALUES
(1,2018,02,13,'SAN','BOS');

INSERT INTO T_LIST
VALUES
(2,2019,12,02,'NYC','HOU');


INSERT INTO T_LIST
VALUES
(3,2019,05,20,'SAN','WAS');

INSERT INTO T_LIST
VALUES
(4,2019,10,08,'PEN','DFW');



SELECT * FROM T_LIST PARTITION(northeast_sales);
SELECT * FROM T_LIST PARTITION(southwest_sales);
SELECT * FROM T_LIST PARTITION(pacificwest_sales);


--6.	Продемонстрируйте для всех таблиц процесс перемещения строк между секциями, при изменении (оператор UPDATE) ключа секционирования.


--range
SELECT * FROM T_RANGE PARTITION(sales_q1);
SELECT * FROM T_RANGE PARTITION(sales_q2);
SELECT * FROM T_RANGE PARTITION(sales_q3);



ALTER TABLE T_RANGE ENABLE ROW MOVEMENT;
UPDATE T_RANGE PARTITION(sales_q1)
set sale_month = 06;

SELECT * FROM T_RANGE PARTITION(sales_q1);
SELECT * FROM T_RANGE PARTITION(sales_q2);
SELECT * FROM T_RANGE PARTITION(sales_q3);
rollback;

--interval

SELECT * FROM T_INTERVAL PARTITION(p0);
SELECT * FROM T_INTERVAL PARTITION(p1);
SELECT * FROM T_INTERVAL PARTITION(p2);
SELECT * FROM T_INTERVAL PARTITION(p3);

select * from user_tab_partitions where table_name = 'T_INTERVAL';



ALTER TABLE T_INTERVAL ENABLE ROW MOVEMENT;
UPDATE T_INTERVAL PARTITION(p1)
set time_id = '02-03-2020';

SELECT * FROM T_INTERVAL PARTITION(p0);
SELECT * FROM T_INTERVAL PARTITION(p1);
SELECT * FROM T_INTERVAL PARTITION(p2);
SELECT * FROM T_INTERVAL PARTITION(p3);

select * from user_tab_partitions where table_name = 'T_INTERVAL';
rollback;

--hash

select * from user_tab_partitions where table_name = 'T_HASH';



ALTER TABLE T_HASH ENABLE ROW MOVEMENT;
UPDATE T_HASH PARTITION for(4)
set ticket_no= 2;

select * from user_tab_partitions where table_name = 'T_HASH';
rollback;

--list

SELECT * FROM T_LIST PARTITION(northeast_sales);
SELECT * FROM T_LIST PARTITION(southwest_sales);
SELECT * FROM T_LIST PARTITION(pacificwest_sales);

ALTER TABLE T_LIST ENABLE ROW MOVEMENT;
UPDATE T_LIST PARTITION(southwest_sales)
set  start_city = 'BOS';

SELECT * FROM T_LIST PARTITION(northeast_sales);
SELECT * FROM T_LIST PARTITION(southwest_sales);
SELECT * FROM T_LIST PARTITION(pacificwest_sales);
rollback;

--7.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE MERGE.
--8.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE SPLIT.

SELECT * FROM T_LIST PARTITION(northeast_sales);
SELECT * FROM T_LIST PARTITION(southwest_sales);
SELECT * FROM T_LIST PARTITION(pacificwest_sales);



ALTER TABLE T_LIST
MERGE PARTITIONS northeast_sales, southwest_sales INTO PARTITION
ticket_sales;

SELECT * FROM T_LIST PARTITION(ticket_sales);
SELECT * FROM T_LIST PARTITION(pacificwest_sales);
ROLLBACK;


ALTER TABLE T_LIST
SPLIT PARTITION ticket_sales values('NYC','BOS','PEN') INTO
(PARTITION northeast_sales TABLESPACE lab16_1,
PARTITION southwest_sales TABLESPACE lab16_2);


SELECT * FROM T_LIST PARTITION(northeast_sales);
SELECT * FROM T_LIST PARTITION(southwest_sales);
SELECT * FROM T_LIST PARTITION(pacificwest_sales);
rollback;

--9.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE EXCHANGE.

CREATE TABLE T_LIST1
 (ticket_no NUMBER,
sale_year INT NOT NULL,
 sale_month INT NOT NULL,
sale_day INT NOT NULL,
 destination_city CHAR(3),
 start_city CHAR(3))

DELETE T_LIST1;
INSERT INTO T_LIST1
VALUES
(4,2019,10,02,'NYC','LOS');

ALTER TABLE T_LIST
EXCHANGE PARTITION pacificwest_sales WITH TABLE T_LIST1;

SELECT * FROM T_LIST PARTITION(northeast_sales);
SELECT * FROM T_LIST PARTITION(southwest_sales);
SELECT * FROM T_LIST PARTITION(pacificwest_sales);
rollback;