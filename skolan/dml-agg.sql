SELECT MIN(lon) FROM larare;
SELECT MAX(lon) FROM larare;

SELECT
    COUNT(akronym),
    avdelning
FROM
    larare
GROUP BY
    avdelning;

SELECT
    SUM(lon) AS Summanlön,
    avdelning
FROM
    larare
GROUP BY
    avdelning;

SELECT
    ROUND(AVG(lon),2) AS Medlön,
    avdelning
FROM
    larare
GROUP BY
    avdelning;

SELECT
    ROUND(AVG(CASE WHEN kon = 'K' THEN lon END),2) AS Medellön_K,
    ROUND(AVG(CASE WHEN kon = 'M' THEN lon END),2 ) AS Medellön_M
FROM
    larare;

SELECT
    avdelning,
    AVG(kompetens) AS kompetens
FROM
    larare
GROUP BY
    avdelning
ORDER BY
    kompetens DESC
LIMIT 1;

SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS snittlön,
    COUNT(*) AS Antal
FROM
    larare
GROUP BY
    avdelning,
    kompetens
ORDER BY
    avdelning,
    snittlön;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Snittlon > 35000
ORDER BY
    Snittlon DESC
;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(*) AS Antal
FROM
    larare
GROUP BY
    avdelning
HAVING
    COUNT(kompetens) >= 3;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Snittlon > 35000
ORDER BY
    Snittlon DESC
;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
WHERE
    kompetens = 1
GROUP BY
    avdelning
HAVING
    Snittlon < 30000
ORDER BY
    avdelning
;

-- 1
SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlön,
    COUNT(*) AS Antal
FROM
    larare
GROUP BY
    avdelning
ORDER BY
    avdelning,
    Snittlön;

-- 2
SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlön,
    COUNT(*) AS Antal
FROM
    larare
GROUP BY
    avdelning,
    kompetens
ORDER BY
    avdelning,
    kompetens;

-- 3
SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlön,
    COUNT(*) AS Antal
FROM
    larare
GROUP BY
    avdelning,
    kompetens
HAVING
    kompetens <= 3
ORDER BY
    avdelning,
    kompetens;

-- 4
SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlön,
    COUNT(*) AS Antal
FROM
    larare
GROUP BY
    avdelning,
    kompetens
HAVING
    kompetens <= 3
    AND Antal = 1
    AND Snittlön BETWEEN 30000 AND 45000
ORDER BY
    avdelning,
    kompetens;
