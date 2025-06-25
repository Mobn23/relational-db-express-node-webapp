CREATE USER 'dbadm'@'localhost'
IDENTIFIED BY 'P@ssw0rd'
;

GRANT ALL PRIVILEGES
ON *.* TO 'dbadm'@'localhost'
WITH GRANT OPTION
;

FLUSH PRIVILEGES;

-- Logga in i terminalklienten med din nyskapade användare.
mariadb -u maria

SHOW GRANTS;

SHOW GRANTS FOR 'dbadm'@'localhost';

-- DROP USER IF EXISTS 'maria'@'localhost';
-- Vill du växla användare så bör det gå bra så här:
-- mariadb -udbadm
-- mariadb -umaria