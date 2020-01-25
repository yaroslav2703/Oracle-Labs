CREATE TABLE AUDITORIUM (
  room INTEGER PRIMARY KEY,
  type VARCHAR2(20),
  count_people INTEGER
);

INSERT INTO AUDITORIUM(room, type, count_people) VALUES(224, '��', 25); 
INSERT INTO AUDITORIUM(room, type, count_people) VALUES(220, '��', 10);
INSERT INTO AUDITORIUM(room, type, count_people) VALUES(310, '��', 20);
INSERT INTO AUDITORIUM(room, type, count_people) VALUES(300, '��', 100);
INSERT INTO AUDITORIUM(room, type, count_people) VALUES(324, '��', 120);
INSERT INTO AUDITORIUM(room, type, count_people) VALUES(120, '��', 9);
COMMIT;

CREATE OR REPLACE PROCEDURE AUDITORIUM_LESS_TEN(auditorium_type VARCHAR2)
      IS
          start_value sys_refcursor;
          end_value sys_refcursor;
      BEGIN
          open start_value for SELECT * FROM AUDITORIUM;          
          DELETE FROM AUDITORIUM WHERE AUDITORIUM.TYPE = auditorium_type AND AUDITORIUM.count_people < 10;
          open end_value for SELECT * FROM AUDITORIUM;
          SYS.DBMS_SQL.RETURN_RESULT (start_value);
          SYS.DBMS_SQL.RETURN_RESULT (end_value);
          COMMIT;
          EXCEPTION
            WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE ('Exeption!');
      END AUDITORIUM_LESS_TEN;
      
EXECUTE AUDITORIUM_LESS_TEN('��');
       