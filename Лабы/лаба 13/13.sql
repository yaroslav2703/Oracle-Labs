SET serveroutput ON;

--1. ������������ ��������� ��������� 
--GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE) 
--��������� ������ �������� ������ �������������� �� ������� TEACHER (� ����������� ��������� �����),
--���������� �� ������� �������� ����� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.

declare
procedure GET_TEACHERS (PCODE TEACHER.PULPIT%type)
is
CURSOR CUR_SELECT_TEACHERS IS 
select TEACHER.TEACHER_NAME from TEACHER
where TEACHER.PULPIT = PCODE;

NAME TEACHER.TEACHER_NAME%TYPE;
begin

OPEN CUR_SELECT_TEACHERS;
FETCH CUR_SELECT_TEACHERS INTO NAME;
DBMS_OUTPUT.PUT_LINE(NAME);
WHILE(CUR_SELECT_TEACHERS%FOUND)
LOOP

FETCH CUR_SELECT_TEACHERS INTO NAME;
DBMS_OUTPUT.PUT_LINE(NAME);

END LOOP;

CLOSE CUR_SELECT_TEACHERS;
end GET_TEACHERS;
begin


GET_TEACHERS('����');
end;



--2. ������������ ��������� ������� 
--3. GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE) 
--RETURN NUMBER
--������� ������ �������� ���������� �������������� �� ������� TEACHER, 
--���������� �� ������� �������� ����� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.

declare
function GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%type)
return number
is
AVAIL number;
begin

select count(TEACHER.TEACHER_NAME) into AVAIL
from TEACHER 
where TEACHER.PULPIT = PCODE;

return AVAIL;
end GET_NUM_TEACHERS;
begin

DBMS_OUTPUT.PUT_LINE(GET_NUM_TEACHERS('����'));

end;


--4. ������������ ���������:
--GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
--��������� ������ �������� ������ �������������� �� ������� TEACHER (� ����������� ��������� �����),
--���������� �� ����������, �������� ����� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.
--GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
--��������� ������ �������� ������ ��������� �� ������� SUBJECT,
--������������ �� ��������, �������� ����� ������� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.

--1
DROP PROCEDURE GET_TEACHERS;
CREATE PROCEDURE GET_TEACHERS( FCODE faculty.faculty%TYPE)
IS
CURSOR CUR_GET_TEACHERS IS  
SELECT teacher.teacher_name
    FROM TEACHER
    JOIN PULPIT ON PULPIT.PULPIT = TEACHER.PULPIT
    JOIN FACULTY ON faculty.faculty = pulpit.faculty
WHERE FACULTY.FACULTY = FCODE;
    
TEACH teacher.TEACHER_NAME%type;
   
BEGIN

 open CUR_GET_TEACHERS ;
    fetch CUR_GET_TEACHERS  into TEACH;
 
    while(CUR_GET_TEACHERS%found)
    loop
      DBMS_OUTPUT.PUT_LINE(TEACH);
     fetch CUR_GET_TEACHERS  into TEACH;
  
   
    end loop;
    close CUR_GET_TEACHERS ;

END GET_TEACHERS;

--2
DROP PROCEDURE GET_SUBJECTS;
CREATE PROCEDURE GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
IS
CURSOR CUR_GET_SUBJECTS IS  
SELECT SUBJECT.SUBJECT
    FROM SUBJECT
WHERE SUBJECT.PULPIT = PCODE;
    
SUBJ SUBJECT.SUBJECT%type;
   
BEGIN

 open CUR_GET_SUBJECTS;
    fetch CUR_GET_SUBJECTS into SUBJ;
 
    while(CUR_GET_SUBJECTS%found)
    loop
      DBMS_OUTPUT.PUT_LINE(SUBJ);
     fetch CUR_GET_SUBJECTS  into SUBJ;
  
   
    end loop;
    close CUR_GET_SUBJECTS ;

END GET_SUBJECTS;




DECLARE

BEGIN 
    GET_TEACHERS('����');
    GET_SUBJECTS('����');
    commit;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;


--5. ������������ ��������� ������� 
--GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
--RETURN NUMBER
--������� ������ �������� ���������� �������������� �� ������� TEACHER,
--���������� �� ����������, �������� ����� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.
--GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER ������� ������ �������� ���������� ��������� �� ������� SUBJECT,
--������������ �� ��������, �������� ����� ������� ���������. ������������ ��������� ���� � ����������������� ���������� ���������. 


--1
DECLARE
 FUNCTION GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
 RETURN NUMBER
 IS 
N number;  
BEGIN

SELECT count(teacher.teacher_name)INTO N
    FROM TEACHER
    JOIN PULPIT ON PULPIT.PULPIT = TEACHER.PULPIT
    JOIN FACULTY ON faculty.faculty = pulpit.faculty
WHERE FACULTY.FACULTY = FCODE;

RETURN N;
 END GET_NUM_TEACHERS;
BEGIN
DBMS_OUTPUT.PUT_LINE(GET_NUM_TEACHERS ('���'));

END;

--2

DROP FUNCTION GET_NUM_SUBJECTS;
CREATE FUNCTION GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
RETURN NUMBER
IS  
SUBJ NUMBER;
   
BEGIN

SELECT COUNT(SUBJECT.SUBJECT) INTO SUBJ
    FROM SUBJECT
WHERE SUBJECT.PULPIT = PCODE;

RETURN SUBJ;
END GET_NUM_SUBJECTS;




DECLARE

BEGIN  
  DBMS_OUTPUT.PUT_LINE(  GET_NUM_SUBJECTS('����'));
    commit;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;



--6. ������������ ����� TEACHERS, ���������� ��������� � �������:
--GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
--GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
--GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER 

drop package  main_pac;
CREATE PACKAGE main_pac
as

 PROCEDURE GET_TEACHERS( FCODE faculty.faculty%TYPE);
 PROCEDURE GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE);
 function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER;
 function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER;

end main_pac;


drop package body main_pac;
CREATE PACKAGE body main_pac
as


PROCEDURE GET_TEACHERS( FCODE faculty.faculty%TYPE)
IS
CURSOR CUR_GET_TEACHERS IS  
SELECT teacher.teacher_name
    FROM TEACHER
    JOIN PULPIT ON PULPIT.PULPIT = TEACHER.PULPIT
    JOIN FACULTY ON faculty.faculty = pulpit.faculty
WHERE FACULTY.FACULTY = FCODE;
    
TEACH teacher.TEACHER_NAME%type;
   
BEGIN

 open CUR_GET_TEACHERS ;
    fetch CUR_GET_TEACHERS  into TEACH;
 
    while(CUR_GET_TEACHERS%found)
    loop
      DBMS_OUTPUT.PUT_LINE(TEACH);
     fetch CUR_GET_TEACHERS  into TEACH;
  
   
    end loop;
    close CUR_GET_TEACHERS ;

END GET_TEACHERS;


PROCEDURE GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
IS
CURSOR CUR_GET_SUBJECTS IS  
SELECT SUBJECT.SUBJECT
    FROM SUBJECT
WHERE SUBJECT.PULPIT = PCODE;
    
SUBJ SUBJECT.SUBJECT%type;
   
BEGIN

 open CUR_GET_SUBJECTS;
    fetch CUR_GET_SUBJECTS into SUBJ;
 
    while(CUR_GET_SUBJECTS%found)
    loop
      DBMS_OUTPUT.PUT_LINE(SUBJ);
     fetch CUR_GET_SUBJECTS  into SUBJ;
  
   
    end loop;
    close CUR_GET_SUBJECTS ;

END GET_SUBJECTS;


FUNCTION GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
 RETURN NUMBER
 IS 
N number;  
BEGIN

SELECT count(teacher.teacher_name)INTO N
    FROM TEACHER
    JOIN PULPIT ON PULPIT.PULPIT = TEACHER.PULPIT
    JOIN FACULTY ON faculty.faculty = pulpit.faculty
WHERE FACULTY.FACULTY = FCODE;

RETURN N;
 END GET_NUM_TEACHERS;


  FUNCTION GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
RETURN NUMBER
IS  
SUBJ NUMBER;
   
BEGIN

SELECT COUNT(SUBJECT.SUBJECT) INTO SUBJ
    FROM SUBJECT
WHERE SUBJECT.PULPIT = PCODE;

RETURN SUBJ;
END GET_NUM_SUBJECTS;

end main_pac;



--7. ������������ ��������� ���� � ����������������� ���������� �������� � ������� ������ TEACHERS.

DECLARE

BEGIN  
    main_pac.GET_TEACHERS('����');
    main_pac.GET_SUBJECTS('����');
    DBMS_OUTPUT.PUT_LINE(main_pac.GET_NUM_TEACHERS ('���'));
    DBMS_OUTPUT.PUT_LINE(  main_pac.GET_NUM_SUBJECTS('����'));
    commit;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;



