SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare;

-- Skapa vyn
CREATE OR REPLACE VIEW v_namn_alder
AS
SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare;

-- Använd vyn
SELECT * FROM v_namn_alder;

-- 1
CREATE OR REPLACE VIEW v_larare
AS
SELECT
    *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare;
SELECT * FROM v_larare;

-- 2
SELECT
    avdelning,
    ROUND(AVG(alder)) AS Snittalder
FROM
    v_larare
GROUP BY
    avdelning
ORDER BY
    Snittalder;
