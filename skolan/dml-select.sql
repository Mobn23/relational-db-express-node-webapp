SELECT * FROM larare;

SELECT * FROM larare WHERE avdelning = "DIDD";

SELECT * FROM larare WHERE akronym LIKE "h%";

SELECT * FROM larare WHERE fornamn LIKE "%o%";

SELECT * FROM larare WHERE lon BETWEEN 30000 AND 50000;

SELECT * FROM larare WHERE Kompetens < 7 AND lon > 40000;

SELECT * FROM larare WHERE akronym IN ("sna", "dum", "min");

SELECT * FROM larare WHERE lon > 80000 OR kompetens = 2 AND avdelning = "ADM";

SELECT fornamn,lon FROM larare ORDER BY efternamn DESC;
SELECT fornamn,lon FROM larare ORDER BY efternamn ASC;

SELECT fornamn,lon FROM larare ORDER BY lon ASC;
SELECT fornamn,lon FROM larare ORDER BY lon DESC;

SELECT fornamn,lon FROM larare ORDER BY lon DESC LIMIT 3;

--
-- Change namn of a column
--
SELECT
    fornamn AS 'Lärare',
    lon AS 'Lön'
FROM larare;
