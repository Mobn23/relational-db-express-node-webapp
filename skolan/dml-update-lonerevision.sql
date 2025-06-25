-- Reset the Database


SELECT
    SUM(lon) AS Lönesumma,
    SUM(kompetens) AS Kompetens
FROM larare
;

SELECT
    *
FROM larare
;
SELECT
    SUM(lon) AS Lönesumma,
    ROUND(SUM(lon) * 0.064, 0) AS Lonepott
FROM larare
;

UPDATE larare
SET kompetens = 7, lon = 85000
WHERE akronym = "dum";

SELECT akronym, fornamn, kompetens, lon
FROM larare
WHERE akronym = 'dum';

UPDATE larare
SET lon = lon + 4000
WHERE akronym = 'min';

SELECT akronym, fornamn, kompetens, lon
FROM larare
WHERE akronym = "min";

UPDATE larare
SET kompetens = 3, lon = lon + 2000
WHERE akronym = "fil";

SELECT fornamn, akronym, kompetens, lon
FROM larare
WHERE akronym ="fil";

UPDATE larare
SET lon = lon - 3000
WHERE akronym IN ("gyl", "ala");

SELECT fornamn, akronym, kompetens, lon
FROM larare
WHERE akronym IN ("gyl", "ala");

UPDATE larare
SET lon = lon + (lon * 0.02)
WHERE avdelning = "DIDD";

SELECT fornamn, akronym, avdelning, lon
FROM larare
WHERE avdelning = "DIDD";

UPDATE larare
SET lon = lon + (lon * 0.03)
WHERE kon = "K" AND lon < 40000;

SELECT fornamn, akronym, kon, lon
FROM larare
WHERE lon < 40000 AND kon = "K";

UPDATE larare
SET lon = lon + 5000, kompetens = kompetens + 1
WHERE akronym IN ("sna", "min", "hag");

SELECT lon, akronym, kompetens
FROM larare
WHERE akronym IN ("sna", "min", "hag");

UPDATE larare
SET lon = lon + (lon * 0.022)
WHERE akronym NOT IN ("dum", "sna", "min", "hag");

SELECT lon, akronym
FROM larare
WHERE akronym NOT IN ("dum", "sna", "min", "hag");

SELECT akronym, avdelning, fornamn, kon, lon, kompetens
FROM larare
ORDER BY lon DESC
;

SELECT
    *
FROM larare
;
SHOW FULL TABLES;

source dml-join.sql