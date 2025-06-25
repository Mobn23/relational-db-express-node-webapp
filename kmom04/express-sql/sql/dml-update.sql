--
-- Move the money
--
--UPDATE account
--SET
--    balance = balance + 1.5
--WHERE
--    id = "2222";

--UPDATE account
--SET
--    balance = balance - 1.5
--WHERE
--    id = "1111";

--SELECT * FROM account;

--
-- Move the money, within a transaction
--
START TRANSACTION;

UPDATE account
SET
    balance = balance + 1.5
WHERE
    id = "2222";

UPDATE account
SET
    balance = balance - 1.5
WHERE
    id = "1111";

COMMIT;

SELECT * FROM account;

-- BEGIN TRANSACTION;
-- COMMIT;
-- ROLLBACK;