--
-- SQL query in another Sql query (Subquery)
--

SELECT
    akronym
FROM larare
WHERE
    avdelning = 'DIDD'
;

SELECT
    *
FROM kurstillfalle
;

SELECT
    *
FROM kurstillfalle
WHERE
    kursansvarig IN (
        SELECT
            akronym
        FROM larare
        WHERE
            avdelning = 'DIDD'
    )
;

--
-- Subqueries med UNION
--

(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIDD'
)
UNION
(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIPT'
)
;

SELECT
    akronym,
    fornamn,
    efternamn,
    alder
FROM
    v_larare
WHERE

    alder = (SELECT MAX(alder) FROM v_larare)
;
