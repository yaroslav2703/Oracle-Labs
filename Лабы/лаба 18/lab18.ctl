LOAD DATA
INFILE *
append
INTO TABLE loaderinfo7
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(f1 POSITION (1:2) char ,
f2 POSITION (5:13) char "UPPER(:f2)",
f3 POSITION (17:26) char )
BEGINDATA
01,"Sunday   ","09.01.2019"
02,"Monday   ","09.02.2019"
03,"Tuesday  ","09.03.2019"
04,"Wednesday","09.04.2019"
05,"Thursday ","09.05.2019"
06,"Friday   ","09.06.2019"
07,"Saturday ","09.07.2019"
08,"Sunday   ","09.08.2019"
09,"Monday   ","09.09.2019"
10,"Tuesday  ","09.10.2019"
11,"Wednesday","09.11.2019"
12,"Thursday ","09.12.2019"
13,"Friday   ","09.13.2019"
14,"Saturday ","09.14.2019"
15,"Sunday   ","09.15.2019"
16,"Monday   ","09.16.2019"
17,"Tuesday  ","09.17.2019"
18,"Wednesday","09.18.2019"
19,"Thursday ","09.19.2019"
20,"Friday   ","09.20.2019"
