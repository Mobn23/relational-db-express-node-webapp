--
-- This module copys the laare table to pre_table in order to make changes then compare the data before/after.
--
SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;

--
-- Make copy of table
--
-- DROP TABLE IF EXISTS larare_pre;
CREATE TABLE larare_pre LIKE larare;
INSERT INTO larare_pre SELECT * FROM larare;

-- Check the content of the tables, for sanity checking
SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;
SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare_pre;

-- source dml-update-lonerevision.sql
SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;
-- So overall we created a back up (copy of the table) before applying the modifications (of lön).
SHOW WARNINGS;