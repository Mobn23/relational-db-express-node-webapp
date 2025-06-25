SELECT
    CONCAT(fornamn, efternamn)
    AS avdelning
FROM
    larare;

SELECT
    CONCAT(LOWER(fornamn), ' ' ,LOWER(efternamn), ' ', avdelning)
    AS avdelning
FROM
    larare
LIMIT 3;

SELECT CURDATE() AS Dagens_datum;

SELECT
    fornamn,
    fodd,
    CURDATE() AS dagens_datum,
    CURTIME() AS nuvarande_tid
FROM
    larare;

SELECT
    fornamn,
    fodd,
    YEAR(CURDATE()) - YEAR(fodd) AS alder
FROM
    larare
ORDER BY
    alder DESC;

SELECT
    fornamn,
    fodd,
    MONTHNAME(fodd) AS 'Månad'
FROM larare
WHERE MONTH(fodd) = 5;

SELECT *
FROM larare
WHERE YEAR(fodd) BETWEEN 1940 AND 1949;
