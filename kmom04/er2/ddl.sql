--
-- ERD database ddl module..
--

-- DROP TABLE IF EXISTS kund;
-- DROP TABLE IF EXISTS produkt;
-- DROP TABLE IF EXISTS kategori;
-- DROP TABLE IF EXISTS lager;
-- DROP TABLE IF EXISTS `order`;
-- DROP TABLE IF EXISTS faktura;
-- DROP TABLE IF EXISTS plocklista;
-- DROP TABLE IF EXISTS logg;

CREATE TABLE kund
(
  kund_id INT NOT NULL AUTO_INCREMENT,
  namn CHAR(100) NOT NULL UNIQUE,
  address VARCHAR (255) UNIQUE,

  PRIMARY KEY (kund_id)
);


CREATE TABLE produkt
(
  produkt_id INT NOT NULL AUTO_INCREMENT,
  namn CHAR(100),
  produktkod CHAR(100) UNIQUE,
  beskrivning VARCHAR (255),
  pris INT UNIQUE,

  PRIMARY KEY (produkt_id)
);


CREATE TABLE  kategori
(
  kategori_id INT NOT NULL AUTO_INCREMENT,
  kategori_namn CHAR(100),
  produktkod CHAR(100),

  PRIMARY KEY (kategori_id),
  FOREIGN KEY(produktkod) REFERENCES produkt(produktkod)
);


CREATE TABLE lager 
(
  lager_id INT NOT NULL AUTO_INCREMENT,
  produktkod CHAR(100),
  produktantal INT,
  hylla INT UNIQUE,

  PRIMARY KEY (lager_id),
  FOREIGN KEY(produktkod) REFERENCES produkt(produktkod)
 
);


CREATE TABLE `order`
(
  order_nr INT NOT NULL AUTO_INCREMENT,
  produktkod CHAR(100),
  kund_namn CHAR(100),
  kund_address VARCHAR (255),
  anatalbeställda INT UNIQUE,

  PRIMARY KEY (order_nr),
  FOREIGN KEY(produktkod) REFERENCES produkt(produktkod),
  FOREIGN KEY(kund_namn) REFERENCES kund(namn),
  FOREIGN KEY(kund_address) REFERENCES kund(address)

);

CREATE TABLE plocklista
(
  plocklista_id INT NOT NULL AUTO_INCREMENT,
  produktkod CHAR(100),
  antal_produkt INT,
  order_nr INT,
  hylla INT,

  PRIMARY KEY (plocklista_id),
  FOREIGN KEY(produktkod) REFERENCES produkt(produktkod),
  FOREIGN KEY(hylla) REFERENCES lager(hylla),
  FOREIGN KEY(antal_produkt) REFERENCES `order`(anatalbeställda),
  FOREIGN KEY(order_nr) REFERENCES `order`(order_nr)

);

CREATE TABLE faktura
(
  faktura_nr INT NOT NULL AUTO_INCREMENT,
  order_nr INT,
  datum DATE,
  kund_namn CHAR(100),
  pris INT,
  total_pris INT,

  PRIMARY KEY (faktura_nr),
  FOREIGN KEY(kund_namn) REFERENCES kund(namn),
  FOREIGN KEY(order_nr) REFERENCES `order`(order_nr),
  FOREIGN KEY(pris) REFERENCES produkt(pris)
);

CREATE TABLE logg
(
  Logg_id INT NOT NULL AUTO_INCREMENT,
  faktura_nr INT,
  order_nr INT,
  datum INT,
  händelse VARCHAR (255),

  PRIMARY KEY (logg_id),
  FOREIGN KEY(order_nr) REFERENCES `order`(order_nr),
  FOREIGN KEY(faktura_nr) REFERENCES faktura(faktura_nr)
);