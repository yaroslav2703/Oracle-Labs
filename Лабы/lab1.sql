
create table PYA_t( x int not null,
s varchar2(50),
CONSTRAINT id PRIMARY KEY(x)  
);
insert into PYA_T (x,s) VALUES (8,'red');
insert into PYA_T(x,s) values (7,'white');
insert into pya_t(x,s) values (54,'black');
COMMIT;
update pya_t set x=6 ,s= 'GREEN' WHERE x=7;
update pya_t set s= 'blue' WHERE x=54;
COMMIT;

SELECT x,s from pya_t where s='red';
select avg(x) from pya_t;
delete from pya_t where s='blue';
commit;

create table pya(
v varchar(30) not null,
z int not null,
 CONSTRAINT fk_second
 FOREIGN key (z)
 REFERENCES PYA_t(x)
);

insert into pya(v,z) VALUES ('black',8);


SELECT pya.*, 
       pya_t.s
  FROM pya
 INNER JOIN pya_t
    ON pya.z = pya_t.x
 ORDER BY pya_t.s;

SELECT pya.v, 
       pya_t.s
  FROM pya
 LEFT JOIN pya_t
    ON pya.z = pya_t.x
 ORDER BY pya_t.s;
 
 SELECT pya.*, 
       pya_t.s
  FROM pya
 right JOIN pya_t
    ON pya.z = pya_t.x
 ORDER BY pya_t.s;
 
DROP TABLE PYA;
DROP TABLE PYA_T;




