
set SERVEROUTPUT ON;

create SEQUENCE first_seq
START with 1000
INCREMENT by 10
noMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE
NOORDER;

select first_seq.nextval from dual;
SELECT first_seq.currval from dual;

drop SEQUENCE first_seq;

select * from user_sequences;

create table t (
f number(4,0),
s number(4,0),
t number(4,0)
)
drop table t;

insert into t(f,s,t)
VALUES(
 first_seq.nextval, first_seq.nextval,first_seq.nextval 
)

create synonym sf for t;
drop SYNONYM sf;

select * from sf;

declare
per1 number(4):=0;
begin
select f into per1 from t; 
dbms_output.put_line('per1= ' || per1);
per1 := per1/0;
exception
when others
then 
dbms_output.put_line('sqlcode=' || sqlcode || ', sqlerrm=' || sqlerrm);
end;


DECLARE
    credit_limit_exceed EXCEPTION;
    PRAGMA exception_init(credit_limit_exceed, -20111);   
BEGIN
    -- get customer credit limit
    
    
    -- raise an exception if the credit limit is exceeded
      dbms_output.put_line('Credit Limit is checked and passed');
        raise_application_error(-20111,'Credit Limit Exceeded');
 
    
    dbms_output.put_line('Credit Limit is checked and passed');
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Customer with id does not exist.');
END;










declare 
    my_exception exception;
    pragma exception_init(my_exception, -20100);
begin
    raise_application_error(-20100,' моя ошибка');
end;    




declare 
    mexc exception;
    pragma exception_init(mexc, -20101);
begin  
    raise mexc;
exception
    when mexc
        then dbms_output.put_line(sqlcode || ' моя ошибка');
    when others
        then dbms_output.put_line(sqlcode || sqlerrm);
end;











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





create table faculty(
faculty char(20),
faculty_name varchar2(200) not null,
constraint pk_faculty primary key(faculty)
);

create table pulpit(
pulpit char(20),
pulpit_name varchar2(200) not null,
faculty char(20),
constraint pk_pulpit primary key(pulpit),
constraint fk_faculty_pulpit foreign key(faculty) references faculty(faculty)
);


create table teacher(
teacher char(20),
teacher_name varchar2(100) not null,
pulpit char(20),
constraint pk_teacher primary key(teacher),
constraint fk_pulpit_teacher foreign key(pulpit) references pulpit(pulpit)
);


INSERT INTO FACULTY
VALUES('ФИТ', 'Факультет информационнох технологий');
INSERT INTO FACULTY
VALUES('ИЭФ', 'Инженерно-жкономический факультет');
INSERT INTO FACULTY
VALUES('ХФ', 'Химический факультет');

insert into pulpit
values('ПИ', 'Программной инженирии','ФИТ');

insert into pulpit
values('М', 'Маркетинга','ИЭФ');

insert into pulpit
values('ХО', 'Химической обработки','ХФ');


insert into teacher
values('ПЛГ', 'Прокопчик Леодин Георгиевич', 'ПИ');
insert into teacher
values('МВР', 'Миронов Виталий Ростиславович', 'М');
insert into teacher
values('СОЛ', 'Сойкель Ольга Леонидовна', 'ХО');
insert into teacher
values('УГВ', 'Угляница Галина Владимировна', 'ХО');

create or replace function teacher_count(Sfaculty faculty.faculty%type default null)
return number
is
teacher_count_faculty number:=0;
no_param exception;
pragma exception_init(no_param, -20112);
begin
IF Sfaculty is null 
then raise no_param;
return 0;
end if;
select count(teacher) into teacher_count_faculty from teacher
join pulpit on pulpit.pulpit = teacher.pulpit
join faculty on faculty.faculty = pulpit.faculty
where faculty.faculty = Sfaculty;
return teacher_count_faculty;
exception
when no_param
then dbms_output.put_line(sqlcode || ' не указан параметр');
when others
then dbms_output.put_line(sqlcode || ' ' || sqlerrm);
end;


begin
DBMS_OUTPUT.PUT_LINE(teacher_count('ФИТ'));
exception
when others
then dbms_output.put_line(sqlcode || ' ' || sqlerrm);
end;







