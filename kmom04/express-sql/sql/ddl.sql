--
-- Create Database.
--
DROP DATABASE IF EXISTS bank;
CREATE DATABASE bank;
USE bank;

--
-- Example transactions
--
DROP TABLE IF EXISTS account;
CREATE TABLE account
(
    `id` CHAR(4) PRIMARY KEY,
    `name` VARCHAR(8),
    `balance` DECIMAL(6, 2)
);

-- DELETE FROM account;
INSERT INTO account
VALUES
    ("1111", "Adam", 10.0),
    ("2222", "Eva", 7.0)
;

SELECT * FROM account;
