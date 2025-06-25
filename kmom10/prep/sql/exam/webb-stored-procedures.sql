--
-- This module is for the web-client's requirements (web application).
--

--
-- Select produktkategorier procedure.
--
DROP PROCEDURE IF EXISTS show_categories;

DELIMITER $$

CREATE PROCEDURE show_categories()
BEGIN
    SELECT * FROM produktkategorier;
END $$

DELIMITER ;

--
-- Select produkter procedure.
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
        GROUP_CONCAT(k.namn) AS kategori_namn
    FROM
        produkter AS p
    LEFT JOIN
        lagerhyllor AS l ON p.produkt_id = l.produkt_id
    LEFT JOIN
        produkt2kategori AS pk ON p.produkt_id = pk.produkt_id
    LEFT JOIN
        produktkategorier AS k ON pk.kategori_id = k.kategori_id
    GROUP BY
    p.produkt_id;
END $$

DELIMITER ;

--
-- insert product procedure.
--

DROP PROCEDURE IF EXISTS insert_product;

DELIMITER $$

CREATE PROCEDURE insert_product(
    IN p_id INT,
    IN p_name VARCHAR(20),
    IN p_price INT,
    IN p_description VARCHAR(120)
)
BEGIN
    INSERT INTO produkter (produkt_id, namn, pris, beskrivning)
    VALUES(p_id, p_name, p_price, p_description);
END $$

DELIMITER ;

--
-- Update product procedure.
--

DROP PROCEDURE IF EXISTS update_product;

DELIMITER $$

CREATE PROCEDURE update_product(
    IN p_id INT,
    IN p_name VARCHAR(20),
    IN p_price INT,
    IN p_description VARCHAR(120)
)
BEGIN
    UPDATE produkter
    SET namn = p_name,
        pris = p_price,
        beskrivning = p_description
    WHERE produkt_id = p_id;
END $$

DELIMITER ;


--
-- Get one name.
--
DROP PROCEDURE IF EXISTS get_one;

DELIMITER $$

CREATE PROCEDURE get_one( IN p_name VARCHAR(20) )
BEGIN
    SELECT
        p.produkt_id,
        p.namn,
        p.pris,
        p.beskrivning,
        l.antal_produkter,
        GROUP_CONCAT(k.namn) AS kategori_namn
    FROM produkter AS p
    LEFT JOIN
        lagerhyllor AS l ON p.produkt_id = l.produkt_id
    LEFT JOIN
        produkt2kategori AS pk ON p.produkt_id = pk.produkt_id
    LEFT JOIN
        produktkategorier AS k ON pk.kategori_id = k.kategori_id
    WHERE p.namn = p_name
    GROUP BY
        p.produkt_id;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS delete_product;

DELIMITER $$

CREATE PROCEDURE delete_product( IN p_name VARCHAR(20) )
BEGIN
    DELETE FROM produkter WHERE namn = p_name;
END $$

DELIMITER ;
