CREATE TABLE Teacher (
  id INTEGER GENERATED AS IDENTITY,
  name VARCHAR2(50),
  department VARCHAR2(20)
);

select * from TEACHER;

INSERT INTO Teacher(name, department) VALUES('test', 'test');
INSERT INTO Teacher(name, department) VALUES('test2', 'test');
INSERT INTO Teacher(name, department) VALUES('test3', 'test1');
INSERT INTO Teacher(name, department) VALUES('test4', 'test2');
INSERT INTO Teacher(name, department) VALUES('test5', 'test2');
INSERT INTO Teacher(name, department) VALUES('test6', 'test2');
COMMIT;

CREATE OR REPLACE FUNCTION count_teacher(dep VARCHAR2) 
  RETURN INTEGER
  IS
    res INTEGER;
    BEGIN
      SELECT count(id) Into res FROM Teacher where Teacher.department = dep;
      return(res);
    END count_teacher;
    
select count_teacher('test') as "Count" from dual;
select count_teacher('test1') as "Count" from dual;
select count_teacher('test2') as "Count" from dual;
select count_teacher('test3') as "Count" from dual;
      