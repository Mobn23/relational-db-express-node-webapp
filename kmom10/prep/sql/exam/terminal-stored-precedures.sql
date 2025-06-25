--
-- Select product categories proc
--

DROP PROCEDURE IF EXISTS show_categories;

DELIMITER $$

CREATE PROCEDURE show_categories()
BEGIN
    SELECT * FROM produktkategorier;
END $$

DELIMITER ;


--
-- Select products proc
--

DROP PROCEDURE IF EXISTS show_products;

DELIMITER $$

CREATE PROCEDURE show_products()
BEGIN
    SELECT
        p.produkt_id,
        p.namn AS produkt_namn,
        p.pris,
        l.antal_produkter,
        k.namn AS kategori_namn
    FROM
        produkter AS p
    LEFT JOIN
        lagerhyllor AS l ON p.produkt_id = l.produkt_id
    LEFT JOIN
        produkt2kategori AS pk ON p.produkt_id = pk.produkt_id
    LEFT JOIN
        produktkategorier AS k ON pk.kategori_id = k.kategori_id;
    
END $$

DELIMITER ;



--
-- Insert product proc
--

DROP PROCEDURE IF EXISTS insert_product;

DELIMITER $$

CREATE PROCEDURE insert_product(
    IN f_id INT,
    IN f_name VARCHAR(20),
    IN f_price INT
)
BEGIN
    INSERT INTO produkter (produkt_id, namn, pris)
    VALUES(f_id, f_name, f_price);
END $$

DELIMITER ;

---
--- Update product
--



-------------------CLI.JS--------------------


--
-- Select logg
--
DROP PROCEDURE IF EXISTS show_log;

DELIMITER $$

CREATE PROCEDURE show_log(IN num INT)
BEGIN
    SELECT * FROM logg
    ORDER BY tidstÃ¤mpel DESC
    LIMIT num;
END $$

DELIMITER ;


--
-- select products
--

DROP PROCEDURE IF EXISTS show_product;

DELIMITER $$

CREATE PROCEDURE show_product()
BEGIN
    SELECT * FROM produkter;
END $$

DELIMITER ;


--
-- select shelf
--

DROP PROCEDURE IF EXISTS show_shelf;

DELIMITER $$

CREATE PROCEDURE show_shelf()
BEGIN
    SELECT hylla FROM lagerhyllor;
END $$

DELIMITER ;

--
-- select inv
--

DROP PROCEDURE IF EXISTS show_inv;

DELIMITER $$

CREATE PROCEDURE show_inv()
BEGIN
    SELECT * FROM lagerhyllor;
END $$

DELIMITER ;

--
-- inv with arg
--

DROP PROCEDURE IF EXISTS show_inv_arg;

DELIMITER $$

CREATE PROCEDURE show_inv_arg(IN arg VARCHAR(20))
BEGIN
    SELECT * FROM lagerhyllor
    WHERE produkt_id = arg OR produkt_namn = arg OR hylla = arg;
END $$

DELIMITER ;


--
-- add antal of a product
--

DROP PROCEDURE IF EXISTS insert_to_inv;

DELIMITER $$
CREATE PROCEDURE  insert_to_inv(IN productid INT, IN shelf VARCHAR(10), IN antal INT)
BEGIN

    UPDATE lagerhyllor
    SET antal_produkter = antal_produkter + antal
    WHERE produkt_id = productid AND hylla = shelf;


    IF ROW_COUNT() = 0 THEN
        INSERT INTO lagerhyllor (produkt_id, hylla, antal_produkter)
        VALUES (productid, shelf, antal);
    END IF;
END $$

DELIMITER ;


--
-- Drop antal of a product
--
DROP PROCEDURE IF EXISTS drop_inv;

DELIMITER $$

CREATE PROCEDURE drop_inv(IN productid INT, IN shelf VARCHAR(10), IN antal INT)
BEGIN
    UPDATE lagerhyllor SET antal_produkter = antal_produkter - antal
    WHERE produkt_id = productid AND hylla = shelf;
END $$

DELIMITER ;
