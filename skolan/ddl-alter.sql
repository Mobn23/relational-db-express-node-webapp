-- Add column to table
ALTER TABLE larare ADD COLUMN IF NOT EXISTS kompetens INT;
SELECT * FROM larare;

-- Drop column from table
ALTER TABLE larare DROP COLUMN IF EXISTS kompetens;
SELECT * FROM larare;

-- Add column with default value 1 and NOT NULL constraint
ALTER TABLE larare ADD COLUMN kompetens INT DEFAULT 1 NOT NULL;
SELECT * FROM larare;

SELECT akronym, fornamn, kompetens FROM larare;
SHOW COLUMNS FROM larare;

SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;