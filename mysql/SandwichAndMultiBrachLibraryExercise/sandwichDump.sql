-- MySQL dump 10.13  Distrib 5.5.44, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sandwich
-- ------------------------------------------------------
-- Server version	5.5.44-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `LName` varchar(30) NOT NULL DEFAULT '',
  `Phone` varchar(10) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`LName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES ('Buttery','702 3421','College St'),('Lincoln','6834523','Lincoln Place'),('O\'Neill\'s','674 2134','Pearse St'),('Old Nag','767 8132','Dame St');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sandwiches`
--

DROP TABLE IF EXISTS `sandwiches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sandwiches` (
  `Location` varchar(30) NOT NULL DEFAULT '',
  `Bread` varchar(15) NOT NULL DEFAULT '',
  `Filling` varchar(20) NOT NULL DEFAULT '',
  `Price` float(5,2) DEFAULT NULL,
  PRIMARY KEY (`Location`,`Bread`,`Filling`),
  CONSTRAINT `sandwiches_ibfk_1` FOREIGN KEY (`Location`) REFERENCES `locations` (`LName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sandwiches`
--

LOCK TABLES `sandwiches` WRITE;
/*!40000 ALTER TABLE `sandwiches` DISABLE KEYS */;
INSERT INTO `sandwiches` VALUES ('Buttery','White','Cheese',1.00),('Buttery','White','Ham',1.10),('Lincoln','Rye','Beef',1.35),('Lincoln','Rye','Ham',1.25),('Lincoln','White','Ham',1.30),('O\'Neill\'s','White','Cheese',1.20),('O\'Neill\'s','White','Turkey',1.35),('O\'Neill\'s','Whole','Ham',1.25),('Old Nag','Rye','Beef',1.35),('Old Nag','Rye','Ham',1.40);
/*!40000 ALTER TABLE `sandwiches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tastes`
--

DROP TABLE IF EXISTS `tastes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tastes` (
  `name` varchar(20) NOT NULL DEFAULT '',
  `filling` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`,`filling`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tastes`
--

LOCK TABLES `tastes` WRITE;
/*!40000 ALTER TABLE `tastes` DISABLE KEYS */;
INSERT INTO `tastes` VALUES ('Brown','Beef'),('Brown','Ham'),('Brown','Turkey'),('Green','Beef'),('Green','Cheese'),('Green','Turkey'),('Jones','Cheese');
/*!40000 ALTER TABLE `tastes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-16 11:51:47
