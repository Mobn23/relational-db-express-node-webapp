--
-- Insert values into table larare.
--
DELETE FROM larare;
SELECT * FROM larare;

--
-- Add teacher staff (rows)
--
INSERT INTO larare VALUES ('sna', 'DIPT', 'Severus', 'Snape', 'M', 40000, '1951-05-01');
INSERT INTO larare VALUES ('dum', 'ADM', 'Albus', 'Dumbledore', 'M', 80000, '1941-04-01');
INSERT INTO larare VALUES ('min', 'DIDD', 'Minerva', 'McGonagall', 'K', 40000, '1955-05-05');

INSERT INTO larare VALUES
    ('hag', 'ADM', 'Hagrid', 'Rubeus', 'M', 25000, '1956-05-06'),
    ('fil', 'ADM', 'Argus', 'Filch', 'M', 25000, '1946-04-06'),
    ('hoc', 'DIDD', 'Madam', 'Hooch', 'K', 35000, '1948-04-08')
;

INSERT INTO larare
    (akronym, avdelning, fornamn, efternamn, kon, lon, fodd)
VALUES
    ('gyl', 'DIPT', 'Gyllenroy', 'Lockman', 'M', NULL, '1952-05-02'),
    ('ala', 'DIPT', 'Alastor', 'Moody', 'M', NULL, '1943-04-03')
;

SELECT akronym, avdelning, fornamn, efternamn, kon, lon, fodd FROM larare;

-- insert the same content of larare into larare_pre.
-- INSERT INTO larare_pre SELECT * FROM larare;