--
-- eshop Database functions module..
--

DELIMITER ;;

CREATE FUNCTION order_status(
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    ordered_at TIMESTAMP,
    shipped_at TIMESTAMP
)
RETURNS VARCHAR(50)

DETERMINISTIC

BEGIN

    DECLARE status VARCHAR(50);

    IF deleted_at IS NOT NULL THEN
        SET status = 'Raderad';
    ELSEIF shipped_at IS NOT NULL THEN
        SET status = 'Skickad';
    ELSEIF ordered_at IS NOT NULL THEN
        SET status = 'Beställd';
    ELSEIF updated_at > created_at THEN
        SET status = 'Uppdaterad';
    ELSE
        SET status = 'Skapad';
    END IF;
    RETURN status;

END ;;

DELIMITER ;
