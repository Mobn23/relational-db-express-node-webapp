--
-- JOIN
--

-- source dml-update.sql
-- source ddl-copy.sql
-- source dml-update-lonerevision.sql
-- source dml-view.sql
-- source dml-join.sql
SELECT
    l.akronym,
    l.lon,
    l.kompetens,
    p.lon AS "pre-lon",
    p.kompetens AS "pre-kompetens"
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY akronym
;

CREATE OR REPLACE VIEW v_lonerevision AS
SELECT
    l.akronym,
    l.fornamn,
    l.efternamn,
    p.lon AS pre,
    l.lon AS nu,
    l.lon - p.lon AS diff,
    p.kompetens AS prekomp,
    l.kompetens AS nukomp,
    l.kompetens - p.kompetens AS diffkomp,
    ROUND(((l.lon - p.lon) / p.lon) * 100,2) AS proc,
    CASE WHEN ((l.lon - p.lon) / p.lon) * 100 >= 3 THEN 'ok' ELSE 'nok' END AS mini
FROM
    larare AS l
JOIN
    larare_pre AS p ON l.akronym = p.akronym
ORDER BY
    proc DESC;

SELECT
    akronym, fornamn, efternamn, pre, nu, diff, proc, mini
FROM v_lonerevision
ORDER BY proc DESC
;

SELECT
    akronym, fornamn, efternamn, prekomp, nukomp, diffkomp
FROM v_lonerevision
ORDER BY nukomp DESC, diffkomp DESC
;