-- MariaDB dump 10.19  Distrib 10.6.16-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: exam
-- ------------------------------------------------------
-- Server version	10.6.16-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `developer`
--

DROP TABLE IF EXISTS `developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `developer` (
  `id` varchar(3) NOT NULL,
  `developer` varchar(50) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `developer`
--

LOCK TABLES `developer` WRITE;
/*!40000 ALTER TABLE `developer` DISABLE KEYS */;
INSERT INTO `developer` VALUES ('AHC','Allen Newell, Herbert A. Simon, and Cliff Shaw','USA\r'),('CMU','Carnegie Mellon University','USA\r'),('OAI','Open AI','USA'),('VUM','Victoria University of Manchester','England\r');
/*!40000 ALTER TABLE `developer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` char(7) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nick` text DEFAULT NULL,
  `debate` text DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL,
  `developer_id` varchar(3) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('DEEPBLU','Deep Blue','Alien opponent','Behind Deep Blue: Building the Computer that Defeated the World Chess Champion','1997','CMU','https://en.wikipedia.org/wiki/Deep_Blue_(chess_computer)','https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Deep_Blue.jpg/220px-Deep_Blue.jpg'),('LOGTHE','Logic Theorist','The first artificial intelligence program','Logic Theorist proved 38 of the first 52 theorems in chapter two of Whitehead and Bertrand Russell\'s Principia Mathematica, and found new and shorter proofs for some of them.','1956','AHC','https://en.wikipedia.org/wiki/Logic_Theorist','https://img.youtube.com/vi/HfPXr90HXSY/0.jpg\r'),('MARK1','Manchester Mark 1','Electronic brain','Can an electronic computer ever be truly creative.','1949','VUM','https://en.wikipedia.org/wiki/Manchester_Mark_1','https://upload.wikimedia.org/wikipedia/en/d/d8/Manchester_Mark2.jpg\r'),('NAVLAB1','Navlab 1','Warp supercomputer','The vehicle suffered from software limitations and was not fully functional until the late 80s, when it achieved its top speed of 20 mph (32 km/h).','1986','CMU','https://en.wikipedia.org/wiki/Navlab','https://www.cs.cmu.edu/afs/cs/project/alv/www/img2/textured_car_after.png\r'),('NAVLAB5','Navlab 5','From Pittsburgh to San Diego','Our current work involves pedestrian detection, surround sensing, and short range sensing for vehicle control.','1995','CMU','https://en.wikipedia.org/wiki/Navlab','https://www.cs.cmu.edu/afs/cs/project/alv/www/img2/detection.png\r');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product2type`
--

DROP TABLE IF EXISTS `product2type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product2type` (
  `product_id` char(7) DEFAULT NULL,
  `type_id` char(3) DEFAULT NULL,
  KEY `product_id` (`product_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `product2type_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `product2type_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product2type`
--

LOCK TABLES `product2type` WRITE;
/*!40000 ALTER TABLE `product2type` DISABLE KEYS */;
INSERT INTO `product2type` VALUES ('MARK1','SPC'),('LOGTHE','AUR'),('NAVLAB1','SAV'),('NAVLAB5','SAV'),('DEEPBLU','CES');
/*!40000 ALTER TABLE `product2type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `id` char(3) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES ('AUR','Automated reasoning','https://en.wikipedia.org/wiki/Automated_reasoning\r'),('CES','Chess-playing expert system','https://en.wikipedia.org/wiki/Expert_system\r'),('GEN','Generative artificial intelligence','https://en.wikipedia.org/wiki/Generative_artificial_intelligence'),('SAV','Autonomous and semi-autonomous vehicle','https://en.wikipedia.org/wiki/Autonomous\r'),('SPC','Stored-program computer','https://en.wikipedia.org/wiki/Stored-program_computer\r');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'exam'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_content` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_content`()
BEGIN
    SHOW TABLES;
    SELECT * FROM product;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_products`()
BEGIN
    SELECT
        p.id,
        p.name AS produkt_namn,
        p.nick,
        LEFT(p.debate, 20),
        p.year,
        p.developer_id,
        t.name AS type_name,
        GROUP_CONCAT(d.developer) AS developer_name
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-21 20:28:40
