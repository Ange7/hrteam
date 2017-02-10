-- MySQL dump 10.15  Distrib 10.0.28-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: mysql.dev    Database: mysql.dev
-- ------------------------------------------------------
-- Server version	10.0.29-MariaDB-0+deb8u1

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
-- Table structure for table `appel`
--

DROP TABLE IF EXISTS `appel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `compte` int(10) unsigned NOT NULL,
  `facture` int(10) unsigned NOT NULL,
  `abonne` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `dureeRelle` time NOT NULL,
  `dureeFacturee` time NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `recu` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56846 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autre`
--

DROP TABLE IF EXISTS `autre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autre` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `compte` int(10) unsigned NOT NULL,
  `facture` int(10) unsigned NOT NULL,
  `abonne` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `dureeRelle` varchar(100) DEFAULT NULL,
  `dureeFacturee` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `recu` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connexion`
--

DROP TABLE IF EXISTS `connexion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `connexion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `compte` int(10) unsigned NOT NULL,
  `facture` int(10) unsigned NOT NULL,
  `abonne` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `dureeRelle` float NOT NULL,
  `dureeFacturee` float NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `recu` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31490 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `compte` int(10) unsigned NOT NULL,
  `facture` int(10) unsigned NOT NULL,
  `abonne` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `dureeRelle` varchar(100) DEFAULT NULL,
  `dureeFacturee` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `recu` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12348 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-10 17:48:21

