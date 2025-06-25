--
-- Delete from database skolan.
--

--
-- Delete rows from table
--
DELETE FROM larare WHERE fornamn = 'Hagrid';
SELECT * FROM larare;
SHOW WARNINGS;

DELETE FROM larare WHERE avdelning = 'DIPT';
SELECT * FROM larare;
SHOW WARNINGS;

DELETE FROM larare WHERE lon IS NOT NULL ORDER BY RAND() LIMIT 2;
SELECT * FROM larare;
SHOW WARNINGS;

DELETE FROM larare LIMIT 2;
SELECT * FROM larare;
SHOW WARNINGS;
