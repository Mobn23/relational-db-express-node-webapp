--
-- Exam database insert module..
--
LOAD DATA LOCAL INFILE 'product.csv'
INTO TABLE product
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id,`name`,nick,debate,`year`,developer_id,`url`,`image`);

SHOW WARNINGS;

LOAD DATA LOCAL INFILE 'type.csv'
INTO TABLE type
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id,`name`,`url`);

SHOW WARNINGS;
LOAD DATA LOCAL INFILE 'product2type.csv'
INTO TABLE product2type
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(product_id,type_id);

SHOW WARNINGS;

LOAD DATA LOCAL INFILE 'developer.csv'
INTO TABLE developer
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id,developer,country);

SHOW WARNINGS;
