--
-- This module is for the web-client's requirements (web application).
-- To run the local environment navigate to then run node index.js.

--
-- Select produktkategorier procedure.
--
-- DROP PROCEDURE IF EXISTS show_categories;

DELIMITER $$

CREATE PROCEDURE show_categories_web_sp()
BEGIN
    SELECT * FROM produktkategorier;
END $$

DELIMITER ;
SHOW WARNINGS;
--
-- Select produkter procedure.
--
-- DROP PROCEDURE IF EXISTS show_products;

DELIMITER $$

CREATE PROCEDURE show_products_web_sp()
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
SHOW WARNINGS;
--
-- insert product procedure.
--

-- DROP PROCEDURE IF EXISTS insert_product;

DELIMITER $$

CREATE PROCEDURE insert_product_web_sp(
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
SHOW WARNINGS;
--
-- Update product procedure.
--

-- DROP PROCEDURE IF EXISTS update_product;

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
SHOW WARNINGS;

--
-- Get one name.
--
-- DROP PROCEDURE IF EXISTS get_one;

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
SHOW WARNINGS;
-- DROP PROCEDURE IF EXISTS delete_product;

DELIMITER $$

CREATE PROCEDURE delete_product( IN p_name VARCHAR(20) )
BEGIN
    DELETE FROM produkter WHERE namn = p_name;
END $$

DELIMITER ;
SHOW WARNINGS;
--
-- Select customers procedure.
--
-- DROP PROCEDURE IF EXISTS show_customers;

DELIMITER $$

CREATE PROCEDURE show_customers()
BEGIN
    SELECT
        kund_id,
        namn,
        adress,
        telephone
    FROM
        kunder;
END $$

DELIMITER ;
SHOW WARNINGS;

--
-- decrese products ordered quantity from hyllor procedure.
--
DELIMITER $$

CREATE PROCEDURE decreaseProductQuantity(
    IN p_product_id INT,
    IN p_quantity_ordered INT
)
BEGIN
    UPDATE lagerhyllor
    SET antal_produkter = antal_produkter - p_quantity_ordered
    WHERE produkt_id = p_product_id;
END $$

DELIMITER ;
SHOW WARNINGS;

--
-- insert order procedure.
--

-- DROP PROCEDURE IF EXISTS insert_order;

DELIMITER $$

CREATE PROCEDURE insert_order(
    IN p_id INT,
    IN p_productId INT,
    IN p_productQuantity INT,
    IN p_kund_namn VARCHAR(20)
)
BEGIN
    INSERT INTO orders (kund_id, produkt_id, antal_produkter, kund_namn)
    VALUES(p_id, p_productId, p_productQuantity, p_kund_namn);

    CALL decreaseProductQuantity(p_productId, p_productQuantity);
END $$

DELIMITER ;
SHOW WARNINGS;
DELIMITER $$

CREATE PROCEDURE show_products_modify_order_status()
BEGIN
    SELECT
        p.produkt_id,
        p.namn AS produkt_namn,
        p.pris,
        l.antal_produkter,
        GROUP_CONCAT(k.namn) AS kategori_namn,
        order_status(o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at) AS order_status
    FROM
        produkter AS p
    LEFT JOIN
        lagerhyllor AS l ON p.produkt_id = l.produkt_id
    LEFT JOIN
        produkt2kategori AS pk ON p.produkt_id = pk.produkt_id
    LEFT JOIN
        produktkategorier AS k ON pk.kategori_id = k.kategori_id
    LEFT JOIN
        orders AS o ON p.produkt_id = o.produkt_id
    GROUP BY
        p.produkt_id;
END $$

DELIMITER ;
SHOW WARNINGS;

--
--  show_orders procedure.
--
-- DROP PROCEDURE IF EXISTS show_orders;

DELIMITER $$

CREATE PROCEDURE show_orders()
BEGIN
    SELECT
        o.order_id AS order_id,
        o.kund_id AS costumer_id,
        o.kund_namn AS costumer_name,
        po.antal_produkter AS quantity,
        DATE_FORMAT(o.created_at, '%Y-%m-%d %H:%i:%s') AS creation_date,
        order_status(o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at) AS order_status,
        p.namn AS product_name,
        p.pris AS product_price
    FROM
        orders AS o
    LEFT JOIN
        produkter2orders AS po ON o.order_id = po.order_id
    LEFT JOIN
        produkter AS p ON po.produkt_id = p.produkt_id;
END $$

DELIMITER ;
SHOW WARNINGS;

DELIMITER $$

CREATE PROCEDURE update_order_status_to_ordered(
    IN p_order_id INT
)
BEGIN
    UPDATE orders
    SET ordered_at = CURRENT_TIMESTAMP 
    WHERE order_id = p_order_id 
    AND order_status(created_at, updated_at, deleted_at, ordered_at, shipped_at) = 'Skapad';
END $$

DELIMITER ;
SHOW WARNINGS;

DELIMITER $$

CREATE PROCEDURE manage_order(
    IN p_costumer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_costumer_name VARCHAR(255)
)
BEGIN
    DECLARE order_id_var INT;

    SELECT
        order_id INTO order_id_var
    FROM orders o
    WHERE kund_id = p_costumer_id
    AND order_status(o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at) = 'Skapad'
    LIMIT 1;

    IF order_id_var IS NULL THEN
        INSERT INTO orders (kund_id, kund_namn, produkt_id, antal_produkter)
        VALUES (p_costumer_id, p_costumer_name, p_product_id, p_quantity);
        SET order_id_var = LAST_INSERT_ID();
    END IF;

    IF EXISTS (SELECT 1 FROM produkter2orders WHERE order_id = order_id_var AND produkt_id = p_product_id) THEN
        UPDATE produkter2orders
        SET antal_produkter = antal_produkter + p_quantity
        WHERE order_id = order_id_var AND produkt_id = p_product_id;
    ELSE
        INSERT INTO produkter2orders (order_id, produkt_id, antal_produkter)
        VALUES (order_id_var, p_product_id, p_quantity);
    END IF;

    CALL decreaseProductQuantity(p_product_id, p_quantity);
END $$

DELIMITER ;
SHOW WARNINGS;











DELIMITER $$

CREATE PROCEDURE show_orders_web()
BEGIN
    SELECT
        o.order_id AS order_id,
        o.kund_id AS costumer_id,
        o.kund_namn AS costumer_name,
        COUNT(po.produkt_id) AS total_items,
        DATE_FORMAT(o.created_at, '%Y-%m-%d %H:%i:%s') AS creation_date,
        order_status(o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at) AS order_status,
        GROUP_CONCAT(p.namn ORDER BY p.namn) AS product_names,
        SUM(p.pris * po.antal_produkter) AS total_price
    FROM
        orders AS o
    LEFT JOIN
        produkter2orders AS po ON o.order_id = po.order_id
    LEFT JOIN
        produkter AS p ON po.produkt_id = p.produkt_id
    GROUP BY
        o.order_id, o.kund_id, o.kund_namn, o.created_at;
END $$

DELIMITER ;
SHOW WARNINGS;


-- DELIMITER $$

-- CREATE PROCEDURE show_order_web_by_arg(
--     IN p_order_id INT
-- )
-- BEGIN
--     SELECT
--         o.order_id AS order_id,
--         o.kund_id AS customer_id,
--         o.kund_namn AS customer_name,
--         DATE_FORMAT(o.created_at, '%Y-%m-%d %H:%i:%s') AS creation_date,
--         order_status(o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at) AS order_status
--     FROM
--         orders AS o
--     LEFT JOIN
--         produkter2orders AS po ON o.order_id = po.order_id
--     LEFT JOIN
--         produkter AS p ON po.produkt_id = p.produkt_id
--     WHERE
--         (
--             o.order_id = p_order_id
--         )
--     GROUP BY
--         o.order_id, o.kund_id, o.kund_namn, o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at;
-- END $$

-- DELIMITER ;
-- SHOW WARNINGS;


DELIMITER $$

CREATE PROCEDURE show_order_web_by_arg(
    IN p_order_id INT
)
BEGIN
    SELECT
        o.order_id AS order_id,
        o.kund_id AS costumer_id,
        o.kund_namn AS costumer_name,
        po.antal_produkter AS quantity,
        DATE_FORMAT(o.created_at, '%Y-%m-%d %H:%i:%s') AS creation_date,
        order_status(o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at) AS order_status,
        p.namn AS product_name,
        p.pris AS product_price
    FROM
        orders AS o
    LEFT JOIN
        produkter2orders AS po ON o.order_id = po.order_id
    LEFT JOIN
        produkter AS p ON po.produkt_id = p.produkt_id
    WHERE
        o.order_id = p_order_id;
END $$

DELIMITER ;
SHOW WARNINGS;
