--
-- ERD database ddl module..
--

CREATE TABLE kunder (
    kund_id INT PRIMARY KEY,
    namn VARCHAR(25),
    adress VARCHAR(25)
);

SHOW WARNINGS;

CREATE TABLE produktkategorier (
    kategori_id CHAR(1) PRIMARY KEY,
    namn VARCHAR(25)
);

CREATE TABLE produkter (
    produkt_id INT PRIMARY KEY,
    namn VARCHAR(20),
    pris INT,
    beskrivning VARCHAR(120)
);

CREATE TABLE lagerhyllor (
    hylla_id INT PRIMARY KEY,
    produkt_id INT,
    antal_produkter INT,
    hylla VARCHAR(10),

    FOREIGN KEY (produkt_id) REFERENCES produkter(produkt_id)
);

CREATE TABLE produkt2kategori (
    produkt_id INT,
    kategori_id CHAR(1),
    FOREIGN KEY (produkt_id) REFERENCES produkter(produkt_id),
    FOREIGN KEY (kategori_id) REFERENCES produktkategorier(kategori_id)
);

SHOW WARNINGS;

CREATE TABLE logg (
    tidstämpel TIMESTAMP,
    händelse TEXT
);

DELIMITER $$
CREATE TRIGGER log_insert_produkter
AFTER INSERT ON produkter
FOR EACH ROW
BEGIN
INSERT INTO logg (tidstämpel, händelse)
VALUES (NOW(),CONCAT('Ny produkt lades till med produktid ', NEW.produkt_id, '.'));
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER log_update_produkter
AFTER UPDATE ON produkter
FOR EACH ROW
BEGIN
DECLARE log_text TEXT;
SET log_text = CONCAT('Detaljer om produkt med ID ', OLD.produkt_id, ' uppdaterades.');
INSERT INTO logg (tidstämpel, händelse)
VALUES (NOW(), log_text);
END $$
DELIMITER ;
