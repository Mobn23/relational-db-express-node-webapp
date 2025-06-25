--
-- ERD database ddl module..
--

CREATE TABLE kunder (
    kund_id INT PRIMARY KEY,
    namn VARCHAR(25),
    adress VARCHAR(25),
    telephone VARCHAR(15)
);

SHOW WARNINGS;

CREATE TABLE produktkategorier (
    kategori_id CHAR(2) PRIMARY KEY,
    namn VARCHAR(25)
);

CREATE TABLE produkter (
    produkt_id INT PRIMARY KEY,
    namn VARCHAR(20),
    pris INT,
    beskrivning VARCHAR(120),
    kategori_id CHAR(1),
    FOREIGN KEY (kategori_id) REFERENCES produktkategorier(kategori_id)
);

CREATE TABLE lagerhyllor (
    hylla_id INT AUTO_INCREMENT PRIMARY KEY,
    produkt_id INT,
    antal_produkter INT,
    produkt_namn VARCHAR(50),
    hylla VARCHAR(50),
    FOREIGN KEY (produkt_id) REFERENCES produkter(produkt_id),
    UNIQUE (produkt_id, hylla)
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

-- tips from coatchen
-- DROP TABLE IF EXISTS user;
-- CREATE TABLE user (
--     `acronym` CHAR(5) PRIMARY KEY,
--     `name` VARCHAR(20),
--     `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     `updated` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
--     `activated` TIMESTAMP NULL,
--     `deleted` TIMESTAMP NULL
-- );

-- Orders Table Example
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    kund_id INT,
    kund_namn VARCHAR(20),
    produkt_id INT,
    antal_produkter INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    ordered_at TIMESTAMP NULL,
    shipped_at TIMESTAMP NULL,
    FOREIGN KEY (kund_id) REFERENCES kunder(kund_id),
    FOREIGN KEY (produkt_id) REFERENCES produkter(produkt_id)
);

CREATE TABLE produkter2orders (
    produkt_id INT,
    order_id INT,
    antal_produkter INT,
    FOREIGN KEY (produkt_id) REFERENCES produkter(produkt_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- updated_at:
-- we likely chose to index updated_at because it's a common practice to track the most recent changes in a system. Queries based on this column can benefit significantly from indexing, especially in systems where tracking and auditing changes are important.
-- kund_id:
-- Indexing kund_id is crucial because it's a foreign key that links the orders table to the kunder (customers) table. In a typical e-commerce or order management system, it's very common to query orders by customer. This index ensures that those queries are as efficient as possible.
-- the unique key is as same as primary key but we doit maniually not inheritially.
-- Indexes

-- One-to-Many: Place foreign key in "many" table. Example: storage_boxes table includes a foreign key referencing users.
-- Many-to-Many: Use a junction table with foreign keys from both tables. Example: student_courses table includes foreign keys referencing students and courses.
-- One-to-One: Add foreign key in one table with a unique constraint. Example: user_profile table has a foreign key referencing user, with a unique constraint.

CREATE INDEX idx_orders_updated_at ON orders(updated_at);
CREATE INDEX idx_orders_kund_id ON orders(kund_id);
