CREATE SEQUENCE Test_SEQUENCE
  INCREMENT BY 2
  START WITH 500
  NOMINVALUE --MINVALUE 500  
  NOMAXVALUE --MAXVALUE 5000
  --CACHE 20
  --ORDER/NOORDER
  NOCYCLE; --CYCLE
  
  --drop SEQUENCE Test_SEQUENCE;
  
CREATE TABLE test_table 
(
  a INTEGER,
  b INTEGER,
  c INTEGER
);

--drop table test_table;
 

DECLARE
    a INTEGER;
    b INTEGER;
    c INTEGER;
  BEGIN
    FOR j IN 1..10 LOOP
      select Test_SEQUENCE.nextVal into a from dual;
      select Test_SEQUENCE.nextVal into b from dual;
      select Test_SEQUENCE.nextVal into c from dual;    
  
      INSERT INTO test_table(a, b, c) VALUES(a, b, c);
      COMMIT;
    END LOOP; 
  END; 
  
  select a, b, c from TEST_TABLE; 