SET serveroutput ON;



--1. Добавьте в таблицу TEACHERS два столбца BIRTHDAY и SALARY,
--заполните их значениями.
ALTER TABLE TEACHER
ADD( 
 BIRTHDAY DATE NULL,
 SALARY DECIMAL(10,2) NULL
);


declare
cursor cur_teacher is select TEACHER,BIRTHDAY, SALARY, PULPIT FROM TEACHER for update;
i int ;
teach teacher.teacher%type;
birth teacher.birthday%type;
sal teacher.salary%type;
pul teacher.pulpit%type;
begin
i:=0;
 open cur_teacher;
 fetch cur_teacher into teach, birth, sal, pul;
 while(cur_teacher%found)
loop
i:=i+1;
update TEACHER
set birthday=to_date('20.09.1990'),
    salary=200.50+10*i
WHERE current of cur_teacher;

update TEACHER
set birthday=to_date('12.02.1983')
WHERE pul='ИСиТ';

 fetch cur_teacher into teach, birth, sal, pul;

end loop;
close cur_teacher;
commit;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;

SELECT * FROM TEACHER;


--2. Получите список преподавателей в виде Фамилия И.О.

SELECT SUBSTR(T,0,instr(T,' ')),
    substr(T, instr(T,' ')+ 1, 1),
    substr(T, instr(T,' ',instr(T,' ')+1)+1, 1)
  FROM (SELECT TEACHER_NAME AS T FROM TEACHER);


--3. Получите список преподавателей, родившихся в понедельник.
SELECT * FROM TEACHER WHERE TO_CHAR((BIRTHDAY), 'DAY')= 'MONDAY';
select TO_CHAR((BIRTHDAY), 'DAY') from teacher;

--4. Создайте представление, в котором поместите список преподавателей,
--которые родились в следующем месяце.
CREATE VIEW Teacher12 AS
SELECT * FROM TEACHER
WHERE TO_CHAR((BIRTHDAY), 'MM')=( TO_CHAR((sysdate),'MM')-'3');

SELECT * FROM Teacher12;
DROP VIEW Teacher12;


--5. Создайте представление, в котором поместите количество преподавателей, 
--которые родились в каждом месяце.
CREATE VIEW NumberTeachMonths AS
SELECT to_char(TBIRTHDAY, 'Month') as MONTH , count(Teacher) as COUNT
 FROM (select trunc(BIRTHDAY, 'MM') as TBIRTHDAY, TEACHER.TEACHER FROM TEACHER)   
 GROUP BY TBIRTHDAY
 ORDER BY TBIRTHDAY;
 

SELECT * FROM NumberTeachMonths;
DROP VIEW NumberTeachMonths;

--6. Создать курсор и вывести список преподавателей,
--у которых в следующем году юбилей.
declare  
    CURSOR c_teacher_bd IS
   ( SELECT TEACHER_NAME, BIRTHDAY 
    FROM TEACHER
    WHERE mod((to_char(sysdate,'yyyy') - to_char(BIRTHDAY, 'yyyy')+1), 10)=0);
    tname TEACHER.TEACHER_NAME%type; 
    bd TEACHER.BIRTHDAY%type; 
  begin
      open c_teacher_bd;
      FETCH c_teacher_bd into tname, bd;
       dbms_output.put_line(tname||' '||bd);

      WHILE(c_teacher_bd%found)
        loop
          fetch c_teacher_bd into tname, bd;
          dbms_output.put_line(tname||' '||bd);
        end loop;
        
      close c_teacher_bd;
      exception
  when others
  then dbms_output.put_line(sqlerrm);
end;
  


--7. Создать курсор и вывести среднюю заработную плату по кафедрам с 
--округлением вниз до целых,
--вывести средние итоговые значения для каждого 
--факультета и для всех факультетов в целом.

--среднее по кафедрам
DECLARE
CURSOR AvgSalary IS  
SELECT floor(AVG(TEACHER.SALARY)), TEACHER.PULPIT
    FROM TEACHER
    GROUP BY TEACHER.PULPIT;
    sal teacher.salary%type;
    pul teacher.pulpit%type;
BEGIN 
    open AvgSalary;
    fetch AvgSalary into sal, pul;
   dbms_output.put_line(sal || ' ' || pul);
    while(AvgSalary%found)
    loop
     fetch AvgSalary into sal, pul;
    DBMS_OUTPUT.PUT_LINE(sal || ' ' || pul);
   
    end loop;
    close AvgSalary;
    commit;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;


--среднее по факультетам
DECLARE
CURSOR AvgSalaryF IS  
SELECT round(AVG(TEACHER.SALARY), 1), pulpit.faculty
    FROM TEACHER
    JOIN PULPIT ON PULPIT.PULPIT = TEACHER.PULPIT
    GROUP BY pulpit.faculty;
    sal teacher.salary%type;
    facul pulpit.faculty%type;
BEGIN 
    open AvgSalaryF;
    fetch AvgSalaryF into sal, facul;
   dbms_output.put_line(sal || ' ' || facul);
    while(AvgSalaryF%found)
    loop
     fetch AvgSalaryF into sal, facul;
    DBMS_OUTPUT.PUT_LINE(sal || ' ' || facul);
   
    end loop;
    close AvgSalaryF;
    commit;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;

--среднее по университету
SELECT round(AVG(SALARY),1) FROM TEACHER;


--8. Создайте собственный тип PL/SQL-записи (record) 
--и продемонстрируйте работу с ним. Продемонстрируйте работу с
--вложенными записями. Продемонстрируйте и объясните операцию присвоения.   
DECLARE
  TYPE PERSON IS RECORD
    (
      PULP teacher.pulpit%type,
      NAME teacher.teacher_name%type
    );
  rec2 PERSON;
BEGIN
  SELECT  PULPIT, TEACHER_NAME INTO rec2
  FROM TEACHER
  WHERE TEACHER='СМЛВ';
  DBMS_OUTPUT.PUT_LINE(rec2.PULP||' '||rec2.NAME);
END;
