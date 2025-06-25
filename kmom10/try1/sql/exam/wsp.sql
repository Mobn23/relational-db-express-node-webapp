--
-- This module is for the web-client's requirements (web application).
--

--
-- Select produktkategorier procedure.
--

DROP PROCEDURE IF EXISTS show_content;

DELIMITER $$

CREATE PROCEDURE show_content()
BEGIN
    SHOW TABLES;
    SELECT * FROM product;
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
        p.id,
        p.name AS produkt_namn,
        p.nick,
        SUBSTRING_INDEX(LEFT(p.debate, 20), ' ', 3) AS debate,
        p.year,
        p.developer_id,
        t.name AS type_name,
        t.url AS type_url,
        GROUP_CONCAT(d.developer) AS developer_name,
        p.url AS product_url
    FROM
        product AS p
    LEFT JOIN
        developer AS d ON p.developer_id = d.id
    LEFT JOIN
        product2type AS pt ON p.id = pt.product_id
    LEFT JOIN
        type AS t ON pt.type_id = t.id
    GROUP BY
        p.id;
END $$

DELIMITER ;
