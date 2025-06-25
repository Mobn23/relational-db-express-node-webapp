--
-- Update a column value
--
UPDATE larare
    SET
        lon = 30000
    WHERE
        lon IS NULL
;

SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;

SELECT akronym, avdelning, fornamn, kon, lon, kompetens
FROM larare
ORDER BY lon DESC;