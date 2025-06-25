--
-- A crossjoin
--
-- SELECT * FROM kurs, kurstillfalle;

--
-- Join using WHERE, use alias AS to shorten the statement
--
SELECT *
FROM kurs AS k, kurstillfalle AS kt
WHERE k.kod = kt.kurskod;

--
-- Join using JOIN..ON
-- As same as the above one but this more accurate.
--SELECT *
--FROM kurs AS k
--    JOIN kurstillfalle AS kt
--        ON k.kod = kt.kurskod;

--
-- Join three tables
--
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;

SELECT
    l.akronym,
    CONCAT(l.fornamn, ' ', l.efternamn) AS namn,
    COUNT(k.id) AS antal_kurstillfallen
FROM
    larare l
INNER JOIN
    kurstillfalle k ON l.akronym = k.kursansvarig
GROUP BY
    l.akronym, namn
ORDER BY
    antal_kurstillfallen DESC, l.akronym;

SELECT akronym,fornamn, efternamn , fodd, TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare_pre
ORDER BY alder DESC
LIMIT 3;

SELECT DISTINCT
    CONCAT(k.namn, ' ', '(' ,k.kod, ')') AS Kursnamn,
    CONCAT(l.fornamn, ' ', l.efternamn, ' (', l.akronym, ')') AS Larare,
    TIMESTAMPDIFF(YEAR, l.fodd, CURDATE()) AS Alder
FROM
    kurstillfalle kt
JOIN
    kurs k ON kt.kurskod = k.kod
JOIN
    larare l ON kt.kursansvarig = l.akronym
WHERE
    TIMESTAMPDIFF(YEAR, l.fodd, CURDATE()) IS NOT NULL
ORDER BY
    Alder DESC, Kursnamn LIMIT 6;
