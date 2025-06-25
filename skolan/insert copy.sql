--
-- Insert values into table larare.
--
-- source insert-larare.sql

--
-- Update a column value
--
UPDATE larare_pre
    SET
        lon = 30000
    WHERE
        lon IS NULL
;

SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare_pre;
SELECT * FROM larare_pre;
