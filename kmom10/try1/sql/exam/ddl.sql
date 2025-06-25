--
-- Exam database ddl module..
--
-- DROP TABLE IF EXISTS product2type;
-- DROP TABLE IF EXISTS product;
-- DROP TABLE IF EXISTS `type`;
-- DROP TABLE IF EXISTS developer;

CREATE TABLE product (
    id CHAR(7) PRIMARY KEY,
    `name` VARCHAR(50),
    nick TEXT,
    debate TEXT,
    `year` VARCHAR(4),
    developer_id VARCHAR(3),
    `url` VARCHAR(255),
    `image` VARCHAR(255)
);

SHOW WARNINGS;

CREATE TABLE `type` (
    id CHAR(3) PRIMARY KEY,
    `name` VARCHAR(50),
    `url` VARCHAR(255)
);

CREATE TABLE product2type (
    product_id CHAR(7),
    type_id CHAR(3),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (type_id) REFERENCES `type`(id)
);

CREATE TABLE developer (
    id VARCHAR(3) PRIMARY KEY,
    developer VARCHAR(50),
    country VARCHAR(20)
);
