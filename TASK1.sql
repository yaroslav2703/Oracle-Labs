
set SERVEROUTPUT ON;

--Создайте необходимые таблицы для решения задачи и внесите в них минимально необходимый набор данных. 
--Создайте процедуру, которая выводит списки аудиторий в зависимости от параметра: все аудитории или все аудитории определенного типа. Обработайте возможные ошибки.


drop table auditorium_type;
create table AUDITORIUM_TYPE(
AUDITORIUM_TYPE char(20),
AUDITORIUM_TYPENAME varchar2(100) not null,
constraint PK_AUDITORIUM_TYPE primary key(AUDITORIUM_TYPE)
);

drop table AUDITORIUM;
create table AUDITORIUM(
AUDITORIUM char(20) not null,
AUDITORIUM_NAME varchar2(50) not null,
AUDITORIUM_TYPE char(20) not null ,
constraint PK_AUDITORIUM primary key(AUDITORIUM),
constraint FK_AUDITORIUM_TYPE foreign key(AUDITORIUM_TYPE) references AUDITORIUM_TYPE(AUDITORIUM_TYPE)
);

insert into auditorium_type
    values('лк', 'лекционная');
insert into auditorium_type
    values('пз', 'практическая');
insert into auditorium_type
    values('лб', 'лабараторная');
    
insert into auditorium
    values('301-1', '301-1', 'лб');
insert into auditorium
    values('200-3a', '200-3a', 'лк');
insert into auditorium 
    values('210-4', '210-4', 'пз');


DROP PROCEDURE AUDITORIUM_OUT;
CREATE OR REPLACE PROCEDURE AUDITORIUM_OUT(STYPE auditorium_type.auditorium_typename%TYPE DEFAULT 'ALL')
IS
CURSOR CUR_SELECT_ALL_AUDITORIUM IS 
    SELECT AUDITORIUM_NAME, AUDITORIUM_TYPE FROM AUDITORIUM;   
CURSOR CUR_SELECT_AUDITORIUM IS
    SELECT AUDITORIUM_NAME, AUDITORIUM.AUDITORIUM_TYPE FROM AUDITORIUM
    JOIN AUDITORIUM_TYPE ON AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE
    WHERE auditorium_type.auditorium_typename = STYPE;    
A_NAME AUDITORIUM.auditorium_name%TYPE;
A_TYPE AUDITORIUM.auditorium_type%TYPE;
NO_TYPE EXCEPTION;
PRAGMA EXCEPTION_INIT(NO_TYPE, -20110);
BEGIN
IF STYPE = 'ALL' THEN
    OPEN CUR_SELECT_ALL_AUDITORIUM;
    FETCH CUR_SELECT_ALL_AUDITORIUM INTO A_NAME, A_TYPE;  
    while(cur_select_all_auditorium%found)
    loop
     DBMS_OUTPUT.PUT_LINE('Название аудитории: ' || a_name || ' Тип аудитории: ' || a_type);
        FETCH CUR_SELECT_ALL_AUDITORIUM INTO A_NAME, A_TYPE;     
    end loop;
    CLOSE CUR_SELECT_ALL_AUDITORIUM;
  
ELSE
    OPEN CUR_SELECT_AUDITORIUM;
    FETCH CUR_SELECT_AUDITORIUM INTO A_NAME, A_TYPE;  
    IF cur_select_auditorium%NOTFOUND THEN
        RAISE NO_TYPE;
    END IF;       
    while(cur_select_auditorium%found)
    loop
     DBMS_OUTPUT.PUT_LINE('Название аудитории: ' || a_name || ' Тип аудитории: ' || a_type);
        FETCH CUR_SELECT_AUDITORIUM INTO A_NAME, A_TYPE;     
    end loop;
    CLOSE CUR_SELECT_AUDITORIUM;

END IF;
EXCEPTION
    when NO_TYPE
        then dbms_output.put_line(sqlcode || ' аудиторий с таким типо нет');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM );
END AUDITORIUM_OUT;


BEGIN 
    -- AUDITORIUM_OUT();
    -- AUDITORIUM_OUT('лекционная');
    -- AUDITORIUM_OUT('практическая');
    -- AUDITORIUM_OUT('hh');
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM );
END;