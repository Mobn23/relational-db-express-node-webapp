SELECT DISTINCT
    akronym AS akronym,
    Namn
FROM v_planering
ORDER BY
    akronym
;

--
-- Outer join (LEFT OUTER JOIN), inkludera lärare utan undervisning
--
SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ", l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS Kurskod
FROM larare AS l
    LEFT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

--
-- Outer join (RIGHT OUTER JOIN), inkludera lärare utan undervisning
--
SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ", l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS Kurskod
FROM larare AS l
    RIGHT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

--
-- Gör på egen hand som i föregående exempel och visa enbart de kurser som inte har kurstillfällen.
--
SELECT DISTINCT
    kt.kurskod AS Kurskod,
    k.namn AS Kursnamn,
    kt.lasperiod
FROM larare AS l
    RIGHT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

--
-- Gör på egen hand som i föregående exempel och visa enbart de kurser som inte har kurstillfällen.
-- Left OUTER JOIN = Left JOIN
SELECT DISTINCT
    k.kod AS Kurskod,
    k.namn AS Kursnamn,
    kt.lasperiod AS Läsperiod
FROM kurs AS k
    LEFT OUTER JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
WHERE kt.lasperiod IS NULL;
