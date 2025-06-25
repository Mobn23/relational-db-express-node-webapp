LOAD DATA LOCAL INFILE 'kunder.csv'
INTO TABLE kunder
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(kund_id,namn,adress,telephone);

SHOW WARNINGS;

LOAD DATA LOCAL INFILE 'produktkategorier.csv'
INTO TABLE produktkategorier
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(kategori_id,namn);

SHOW WARNINGS;
LOAD DATA LOCAL INFILE 'produkter.csv'
INTO TABLE produkter
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(produkt_id,namn,pris,beskrivning);

SHOW WARNINGS;

LOAD DATA LOCAL INFILE 'lagerhyllor.csv'
INTO TABLE lagerhyllor
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(hylla_id,produkt_id,antal_produkter,produkt_namn,hylla);

SHOW WARNINGS;

LOAD DATA LOCAL INFILE 'produkt2kategori.csv'
INTO TABLE produkt2kategori
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(produkt_id, kategori_id);
SHOW WARNINGS;

SELECT produkt_id, antal_produkter FROM lagerhyllor;
SHOW WARNINGS;

--  to remove \r if happend.
UPDATE lagerhyllor
SET hylla = REPLACE(hylla, CHAR(13), '');


-- tips from coatchen
-- INSERT INTO user
--     (`acronym`, `name`)
-- VALUES
--     ('doe', 'John/Jane Doe'),
--     ('mos', 'MegaMos'),
--     ('mum', 'Mumintrollet')
-- ;

-- INSERT INTO orders
