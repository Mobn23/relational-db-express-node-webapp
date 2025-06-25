--
-- This is the main ddl module that creates all the database's structure
-- defines and manages the structure of databases and database objects.
--

source create-database.sql;

source ddl-larare.sql

source insert-larare.sql

source ddl-alter.sql

source dml-update.sql

source ddl-copy.sql

source dml-view.sql


-- DROP TABLE IF EXISTS larare;
-- CREATE TABLE larare
-- (
--     akronym CHAR(3),
--     avdelning CHAR(4),
--     fornamn VARCHAR(20),
--     efternamn VARCHAR(20),
--     kon CHAR(1),
--     lon INT,
--     fodd DATE,
--     kompetens INT NOT NULL DEFAULT 1,
--     PRIMARY KEY (akronym)
-- );
-- SHOW WARNINGS;

--
-- Update a column value
--
UPDATE larare
    SET
        lon = 30000
    WHERE
        lon IS NULL
;



-- The sources of the code above.
-- source ddl-larare.sql
-- source dml-update.sql

SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare_pre;

-- Skapa vyn
CREATE OR REPLACE VIEW v_namn_alder
AS
SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare_pre;

-- Använd vyn
SELECT * FROM v_namn_alder;

CREATE OR REPLACE VIEW v_larare
AS
SELECT
    *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare_pre;
SELECT * FROM v_larare;

-- DROP TABLE IF EXISTS kurs;
CREATE TABLE kurs (
  kod char(6) NOT NULL,
  namn varchar(40) DEFAULT NULL,
  poang float DEFAULT NULL,
  niva char(3) DEFAULT NULL,
  PRIMARY KEY (kod)
);

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

--
-- Create table: kurstillfalle
--
-- DROP TABLE IF EXISTS kurstillfalle;
CREATE TABLE kurstillfalle (
  id int(11) NOT NULL AUTO_INCREMENT,
  kurskod char(6) NOT NULL,
  kursansvarig char(3) NOT NULL,
  lasperiod int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY kurskod (kurskod),
  KEY kursansvarig (kursansvarig),
  CONSTRAINT kurstillfalle_ibfk_1 FOREIGN KEY (kurskod) REFERENCES kurs (kod),
  CONSTRAINT kurstillfalle_ibfk_2 FOREIGN KEY (kursansvarig) REFERENCES larare (akronym)
);

-- SHOW CREATE TABLE kurs;
-- SHOW CREATE TABLE kurstillfalle;

CREATE OR REPLACE VIEW v_planering
AS
SELECT
    l.akronym, CONCAT(l.fornamn, ' ', l.efternamn) AS Namn, COUNT(k.kurskod) AS antal_kurstillfallen
FROM
    larare l
INNER JOIN
    kurstillfalle k ON l.akronym = k.kursansvarig
GROUP BY
    l.akronym, Namn
ORDER BY
    antal_kurstillfallen DESC, l.akronym;

SELECT * FROM v_planering;
