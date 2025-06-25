--
-- Select product categories proc
--

-- DROP PROCEDURE IF EXISTS show_categories;

-- DELIMITER $$

-- CREATE PROCEDURE show_categories()
-- BEGIN
--     SELECT * FROM produktkategorier;
-- END $$

-- DELIMITER ;


--
-- Select products proc
--

-- DROP PROCEDURE IF EXISTS show_products;

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

-- DROP PROCEDURE IF EXISTS insert_product;

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
-- DROP PROCEDURE IF EXISTS show_log;

DELIMITER $$

CREATE PROCEDURE show_log(IN num INT)
BEGIN
    SELECT * FROM logg
    ORDER BY tidstämpel DESC
    LIMIT num;
END $$

DELIMITER ;


--
-- select products
--

-- DROP PROCEDURE IF EXISTS show_product;

DELIMITER $$

CREATE PROCEDURE show_product()
BEGIN
    SELECT * FROM produkter;
END $$

DELIMITER ;


--
-- select shelf
--

-- DROP PROCEDURE IF EXISTS show_shelf;

DELIMITER $$

CREATE PROCEDURE show_shelf()
BEGIN
    SELECT hylla FROM lagerhyllor;
END $$

DELIMITER ;

--
-- select inv
--

-- DROP PROCEDURE IF EXISTS show_inv;

DELIMITER $$

CREATE PROCEDURE show_inv()
BEGIN
    SELECT * FROM lagerhyllor;
END $$

DELIMITER ;

--
-- inv with arg
--

-- DROP PROCEDURE IF EXISTS show_inv_arg;

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

-- DROP PROCEDURE IF EXISTS insert_to_inv;

DELIMITER $$
CREATE PROCEDURE insert_to_inv(
    IN productid INT,
    IN shelf VARCHAR(10),
    IN antal INT
)
BEGIN
    INSERT INTO lagerhyllor (produkt_id, hylla, antal_produkter)
    VALUES (productid, shelf, antal)
    ON DUPLICATE KEY UPDATE
        antal_produkter = antal_produkter + antal;
END $$

DELIMITER ;

--
-- Drop antal of a product
--
-- DROP PROCEDURE IF EXISTS drop_inv;

DELIMITER $$

CREATE PROCEDURE drop_inv(IN productid INT, IN shelf VARCHAR(10), IN antal INT)
BEGIN
    UPDATE lagerhyllor SET antal_produkter = antal_produkter - antal
    WHERE produkt_id = productid AND hylla = shelf;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE show_orders_cli()
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
        o.order_id, o.kund_id, o.kund_namn, o.created_at; --Group By: When we use GROUP BY order.id, we're grouping everything around the order. So, we treat each order as a single group, and within that group, we gather all the related product details. So that means for 1 order many products.
END $$

DELIMITER ;
SHOW WARNINGS;


DELIMITER $$

CREATE PROCEDURE show_orders_cli_by_arg(
    IN p_order_id_or_customer_id INT
)
BEGIN
    SELECT
        o.order_id AS order_id,
        o.kund_id AS customer_id,
        o.kund_namn AS customer_name,
        DATE_FORMAT(o.created_at, '%Y-%m-%d %H:%i:%s') AS creation_date,
        order_status(o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at) AS order_status
    FROM
        orders AS o
    LEFT JOIN
        produkter2orders AS po ON o.order_id = po.order_id
    LEFT JOIN
        produkter AS p ON po.produkt_id = p.produkt_id
    WHERE
        (
            o.order_id = p_order_id_or_customer_id OR
            o.kund_id = p_order_id_or_customer_id
        )
    GROUP BY
        o.order_id, o.kund_id, o.kund_namn, o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at;
END $$

DELIMITER ;
SHOW WARNINGS;

DELIMITER $$

CREATE PROCEDURE generate_picklist(
    IN p_order_id INT
)
BEGIN
    SELECT
        o.order_id AS order_id,
        o.kund_id AS customer_id,
        o.kund_namn AS customer_name,
        po.antal_produkter AS quantity,
        p.namn AS product_name,
        lh.hylla AS warehouse_location,
        CASE 
            WHEN lh.antal_produkter = 0 THEN 'Not Available'
            ELSE lh.antal_produkter
        END AS available_stock
    FROM
        orders AS o
    JOIN
        produkter2orders AS po ON o.order_id = po.order_id
    JOIN
        produkter AS p ON po.produkt_id = p.produkt_id
    JOIN
        lagerhyllor AS lh ON p.produkt_id = lh.produkt_id
    WHERE
        o.order_id = p_order_id
    ORDER BY
        p.namn;
END $$

DELIMITER ;
SHOW WARNINGS;

DELIMITER $$

CREATE PROCEDURE change_status_to_shiped(
    IN p_order_id INT
)
BEGIN
    UPDATE orders
    SET shipped_at = NOW()
    WHERE order_id = p_order_id;
END $$

DELIMITER ;
SHOW WARNINGS;
