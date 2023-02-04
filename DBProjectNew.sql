CREATE DATABASE  IF NOT EXISTS `storeproject` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `storeproject`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: storeproject
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `addressID` int NOT NULL AUTO_INCREMENT,
  `postalCode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNumber` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customerID` int NOT NULL,
  PRIMARY KEY (`addressID`),
  KEY `fk_Addresses_Customer1_idx` (`customerID`),
  CONSTRAINT `fk_Addresses_Customer1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'1111111111','bullshit','989156646936','Birjand','Iran',1),(2,'1111111111','bullshit','989156646936','Tehran','Iran',1),(3,'1111111111','bullshit','989156646936','Birjand','Iran',2),(4,'1111111111','bullshit','989156646936','Tehran','Iran',3);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `billID` int NOT NULL AUTO_INCREMENT,
  `issueDate` datetime NOT NULL,
  `totalPrice` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orderID` int NOT NULL,
  PRIMARY KEY (`billID`),
  KEY `fk_Bill_Order1_idx` (`orderID`),
  CONSTRAINT `fk_Bill_Order1` FOREIGN KEY (`orderID`) REFERENCES `order` (`orderID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (5,'2021-02-09 00:00:00','1000000',1),(7,'2021-02-09 00:00:00','1000000',1),(8,'2021-03-12 00:00:00','500000',2),(9,'2021-03-22 00:00:00','18000',3);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branchID` int NOT NULL AUTO_INCREMENT,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNumber` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `faxNumber` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postalCode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `managerID` int NOT NULL,
  PRIMARY KEY (`branchID`),
  KEY `fk_Branch_Staff1_idx` (`managerID`),
  CONSTRAINT `fk_Branch_Staff1` FOREIGN KEY (`managerID`) REFERENCES `staff` (`staffID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1,'mashhad','iran','38840918','9178176337','hashemieh20','9178178778',3),(2,'tehran','iran','78900345','986543212','zaferanieh','123456789',1),(3,'shiraz','iran','91567887','234987765','emamat','123123897',2);
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `commentID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `text` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `itemID` int NOT NULL,
  `customerID` int NOT NULL,
  `score` int DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `fk_Comments_Item1_idx` (`itemID`),
  KEY `fk_Comments_Customer1_idx` (`customerID`),
  CONSTRAINT `fk_Comments_Customer1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`),
  CONSTRAINT `fk_Comments_Item1` FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'comment about item','2002-02-02 00:00:00','good',1,1,3),(2,'comment about item','2002-02-10 00:00:00','not bad',2,2,1),(3,'comment about item','2002-02-10 00:00:00','ok',3,3,2),(4,'comment about item','2002-02-20 00:00:00','awful',4,4,0),(5,'comment about item','2002-02-12 00:00:00','good',5,1,3);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerID` int NOT NULL AUTO_INCREMENT,
  `fName` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lName` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNumber` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthDate` date DEFAULT NULL,
  `ssn` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userName` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` int DEFAULT NULL,
  `score` int NOT NULL,
  `referenceID` int DEFAULT NULL,
  PRIMARY KEY (`customerID`),
  KEY `fk_Customer_Customer1_idx` (`referenceID`),
  CONSTRAINT `fk_Customer_Customer1` FOREIGN KEY (`referenceID`) REFERENCES `customer` (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Ehsan','Ghorbani','09156646936','2002-02-22','0926252134','ehsangh190','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','eghorbani@gmail.com',1,0,NULL),(2,'Tina','tavakoli','09156646936','2002-02-22','0926251462','ttavakoli','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','example@site.com',0,0,NULL),(3,'Kiana','Kermani','0915001377','2002-04-16','0926252143','kkermani','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','kianakermani1381@gmail.com',0,0,NULL),(4,'Ali','Hamidzadeh','09152273816','2002-05-15','0926251885','ahamidzadeh','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','ahamidzadeh93@gmail.com',1,0,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `itemID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currentPrice` bigint NOT NULL,
  `category` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int NOT NULL,
  `color` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `offer` int DEFAULT NULL,
  `weight` bigint NOT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Bag',500,'School',0,'purple',30,3),(2,'Laptop',500000,'Electronics',0,'gray',15,5),(3,'Headphone',6000,'Electronics',0,'Pink',NULL,1),(4,'shoe',400,'Wearing',0,'yellow',70,0),(5,'shoe',400,'Wearing',0,'yellow',70,0);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_is_favorite_of_customer`
--

DROP TABLE IF EXISTS `item_is_favorite_of_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_is_favorite_of_customer` (
  `Item_itemID` int NOT NULL,
  `Customer_customerID` int NOT NULL,
  `category` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Item_itemID`,`Customer_customerID`),
  KEY `fk_Item_has_Customer_Customer1_idx` (`Customer_customerID`),
  KEY `fk_Item_has_Customer_Item1_idx` (`Item_itemID`),
  CONSTRAINT `fk_Item_has_Customer_Customer1` FOREIGN KEY (`Customer_customerID`) REFERENCES `customer` (`customerID`),
  CONSTRAINT `fk_Item_has_Customer_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_is_favorite_of_customer`
--

LOCK TABLES `item_is_favorite_of_customer` WRITE;
/*!40000 ALTER TABLE `item_is_favorite_of_customer` DISABLE KEYS */;
INSERT INTO `item_is_favorite_of_customer` VALUES (1,1,'school'),(2,2,'electronics'),(4,3,'wearing');
/*!40000 ALTER TABLE `item_is_favorite_of_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `token` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`token`,`userID`),
  UNIQUE KEY `token_UNIQUE` (`token`),
  KEY `fk_login_Staff1_idx` (`userID`),
  CONSTRAINT `fk_login_Staff1` FOREIGN KEY (`userID`) REFERENCES `staff` (`staffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES ('************************',1),('0d7a122d153d990ecf252053e398e6bba8162a5e342d765f376ef50fe4443794',1),('1c68c766681fb47b629ff8c6347adeaedb3fd503b77c9aa1a7360a67c6f80d1f',2);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notifID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `for` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customerID` int NOT NULL,
  `staffID` int NOT NULL,
  PRIMARY KEY (`notifID`),
  KEY `fk_Notifications_Customer1_idx` (`customerID`),
  KEY `fk_Notifications_Staff1_idx` (`staffID`),
  CONSTRAINT `fk_Notifications_Customer1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`),
  CONSTRAINT `fk_Notifications_Staff1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`staffID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'notification about item','*****','2009-09-09 00:00:00','staff',1,1),(2,'notification about various item','*****','2009-09-15 00:00:00','staff',3,4),(3,'notification about dept','*****','2009-12-09 00:00:00','custemor',4,2);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `offerID` int NOT NULL AUTO_INCREMENT,
  `code` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` int NOT NULL,
  `expiresAt` datetime NOT NULL,
  `startedAt` datetime NOT NULL,
  `type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`offerID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (1,'start',10,'2022-04-06 00:00:00','2022-04-06 00:00:00','caps'),(2,'site',12,'2022-06-12 00:00:00','2022-06-18 00:00:00','aaaa'),(3,'CODE',8,'2022-08-08 00:00:00','2022-08-18 00:00:00','wwwww');
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers_has_item`
--

DROP TABLE IF EXISTS `offers_has_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers_has_item` (
  `Offers_offerID` int NOT NULL,
  `Item_itemID` int NOT NULL,
  PRIMARY KEY (`Offers_offerID`,`Item_itemID`),
  KEY `fk_Offers_has_Item_Item1_idx` (`Item_itemID`),
  KEY `fk_Offers_has_Item_Offers1_idx` (`Offers_offerID`),
  CONSTRAINT `fk_Offers_has_Item_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `item` (`itemID`),
  CONSTRAINT `fk_Offers_has_Item_Offers1` FOREIGN KEY (`Offers_offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers_has_item`
--

LOCK TABLES `offers_has_item` WRITE;
/*!40000 ALTER TABLE `offers_has_item` DISABLE KEYS */;
INSERT INTO `offers_has_item` VALUES (2,2);
/*!40000 ALTER TABLE `offers_has_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `totalPrice` bigint NOT NULL,
  `orderDate` datetime DEFAULT NULL,
  `offer` bigint DEFAULT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `offerID` int DEFAULT NULL,
  `addressID` int NOT NULL,
  `customerID` int NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `fk_Order_Offers1_idx` (`offerID`),
  KEY `fk_Order_Addresses1_idx` (`addressID`),
  KEY `fk_Order_Customer1_idx` (`customerID`),
  CONSTRAINT `fk_Order_Addresses1` FOREIGN KEY (`addressID`) REFERENCES `addresses` (`addressID`),
  CONSTRAINT `fk_Order_Customer1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`),
  CONSTRAINT `fk_Order_Offers1` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1000000,'2021-02-09 00:00:00',222222,'Submitted',1,1,1),(2,500000,'2021-03-12 00:00:00',2300,'Done',2,2,2),(3,18000,'2021-03-22 00:00:00',11000,'In progress',3,3,3);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_has_item`
--

DROP TABLE IF EXISTS `order_has_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_has_item` (
  `Order_orderID` int NOT NULL,
  `Item_itemID` int NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`Order_orderID`,`Item_itemID`),
  KEY `fk_Order_has_Item_Item1_idx` (`Item_itemID`),
  KEY `fk_Order_has_Item_Order1_idx` (`Order_orderID`),
  CONSTRAINT `fk_Order_has_Item_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `item` (`itemID`),
  CONSTRAINT `fk_Order_has_Item_Order1` FOREIGN KEY (`Order_orderID`) REFERENCES `order` (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_has_item`
--

LOCK TABLES `order_has_item` WRITE;
/*!40000 ALTER TABLE `order_has_item` DISABLE KEYS */;
INSERT INTO `order_has_item` VALUES (1,1,2),(2,2,1),(3,3,3);
/*!40000 ALTER TABLE `order_has_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricehistory`
--

DROP TABLE IF EXISTS `pricehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricehistory` (
  `date` datetime NOT NULL,
  `price` bigint NOT NULL,
  `Item_itemID` int NOT NULL,
  PRIMARY KEY (`date`,`Item_itemID`),
  KEY `fk_PriceHistory_Item1_idx` (`Item_itemID`),
  CONSTRAINT `fk_PriceHistory_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricehistory`
--

LOCK TABLES `pricehistory` WRITE;
/*!40000 ALTER TABLE `pricehistory` DISABLE KEYS */;
INSERT INTO `pricehistory` VALUES ('2021-02-09 00:00:00',600,1),('2021-02-11 00:00:00',220000,2),('2021-02-12 00:00:00',500,1),('2021-02-16 00:00:00',500000,2),('2021-03-19 00:00:00',12200,3),('2021-03-21 00:00:00',400,4),('2021-03-27 00:00:00',6000,3);
/*!40000 ALTER TABLE `pricehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staffID` int NOT NULL AUTO_INCREMENT,
  `fName` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lName` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary` bigint NOT NULL,
  `role` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ssn` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `startDate` datetime NOT NULL,
  `phoneNumber` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` int DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `insuranceCode` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postalCode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userName` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthDate` date DEFAULT NULL,
  `bankAccountCode` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `managerID` int DEFAULT NULL,
  PRIMARY KEY (`staffID`),
  KEY `fk_Staff_Staff1_idx` (`managerID`),
  CONSTRAINT `fk_Staff_Staff1` FOREIGN KEY (`managerID`) REFERENCES `staff` (`staffID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Sina','Golmakani',25000000,'Boss','0926252184','2019-05-14 09:00:00','989152246517',1,'IRAN-Tehran-Sajad 5-NO.22','562','5126487523','sgolmakani@gmail.com','sgolmakani','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','1850-02-20','080180000001254896251342',NULL),(2,'Elham','Gholami',5000000,'Manager','0926252183','2022-11-05 11:00:00','989387921536',1,'IRAN-Shiraz-Emamat 28-NO.5','784','9716478523','egholami80@gmail.com','egholami','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','1995-08-01','098780000001254796242342',1),(3,'Fateneh','tataba',2000000,'DBadminn','9262070400','1990-04-26 09:22:00','989396330',0,'Iran , Mashad , piroozi BLv , piroozi 21','987654321','123456','fatemeh28389@gmail.com','fatmeheh ','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','1990-03-02','546789',1),(4,'hamid','kermami',5000000,'scrum master','051258','2020-04-26 10:22:00','972852',1,'Iran , Mashad , piroozi BLv , hashemie 50','94567841','9854785','kermaniha@gmail.com','hamid52 ','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','1985-03-02','546789',2);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplierID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNumber` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postalCode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`supplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'LionComputer','989150000000',0,'Mashad,Janbaz Street','1234567891','info@lioncomputer.com'),(2,'MashhadKala','989151111111',0,'Mashad,Khayam Street','2345678901','info@mashhadKala.com'),(3,'TehranShop','989152222222',0,'Tehran,Enghelab Street','3456789012','info@tehranshop.com'),(4,'EsfehanShop','989153333333',0,'Esfehan,Modarres Street','4567890123','info@esfehanshop.com'),(5,'ShirazStore','989155555555',0,'Shiraz,Moaalem Stree','5678901234','info@sstore.com');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_sends_to_warehouse`
--

DROP TABLE IF EXISTS `supplier_sends_to_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_sends_to_warehouse` (
  `Supplier_supplierID` int NOT NULL,
  `Warehouse_warehouseID` int NOT NULL,
  PRIMARY KEY (`Supplier_supplierID`,`Warehouse_warehouseID`),
  KEY `fk_Supplier_has_Warehouse_Warehouse1_idx` (`Warehouse_warehouseID`),
  KEY `fk_Supplier_has_Warehouse_Supplier1_idx` (`Supplier_supplierID`),
  CONSTRAINT `fk_Supplier_has_Warehouse_Supplier1` FOREIGN KEY (`Supplier_supplierID`) REFERENCES `supplier` (`supplierID`),
  CONSTRAINT `fk_Supplier_has_Warehouse_Warehouse1` FOREIGN KEY (`Warehouse_warehouseID`) REFERENCES `warehouse` (`warehouseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_sends_to_warehouse`
--

LOCK TABLES `supplier_sends_to_warehouse` WRITE;
/*!40000 ALTER TABLE `supplier_sends_to_warehouse` DISABLE KEYS */;
INSERT INTO `supplier_sends_to_warehouse` VALUES (1,1),(3,2),(5,3);
/*!40000 ALTER TABLE `supplier_sends_to_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_supplies_item`
--

DROP TABLE IF EXISTS `supplier_supplies_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_supplies_item` (
  `Item_itemID` int NOT NULL,
  `Supplier_supplierID` int NOT NULL,
  `date` datetime NOT NULL,
  `amount` bigint NOT NULL,
  PRIMARY KEY (`Item_itemID`,`Supplier_supplierID`),
  KEY `fk_Item_has_Supplier_Supplier1_idx` (`Supplier_supplierID`),
  KEY `fk_Item_has_Supplier_Item1_idx` (`Item_itemID`),
  CONSTRAINT `fk_Item_has_Supplier_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `item` (`itemID`),
  CONSTRAINT `fk_Item_has_Supplier_Supplier1` FOREIGN KEY (`Supplier_supplierID`) REFERENCES `supplier` (`supplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_supplies_item`
--

LOCK TABLES `supplier_supplies_item` WRITE;
/*!40000 ALTER TABLE `supplier_supplies_item` DISABLE KEYS */;
INSERT INTO `supplier_supplies_item` VALUES (1,1,'2022-02-09 00:00:00',1200000),(2,2,'2022-04-19 00:00:00',20000000),(3,3,'2022-10-22 00:00:00',990000),(4,4,'2022-12-06 00:00:00',6000000);
/*!40000 ALTER TABLE `supplier_supplies_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `vehicleID` int NOT NULL AUTO_INCREMENT,
  `model` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` bigint NOT NULL,
  `driverID` int NOT NULL,
  `usedFor` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`vehicleID`),
  KEY `fk_Vehicle_Staff1_idx` (`driverID`),
  CONSTRAINT `fk_Vehicle_Staff1` FOREIGN KEY (`driverID`) REFERENCES `staff` (`staffID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,'pickup',4000000000,1,'electronic device'),(2,'tractor',500000000,2,'food stuffs'),(3,'truck',2000000000,4,'dress');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `warehouseID` int NOT NULL AUTO_INCREMENT,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postalCode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNumber` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`warehouseID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'mashhad','iran','hashemieh 67','3458888889','989053213280'),(2,'tehran','iran','zaferanieh','1234567789','989053213270'),(3,'shiraz','iran','hashemieh 67','1357909743','989053213260');
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse_has_item`
--

DROP TABLE IF EXISTS `warehouse_has_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_has_item` (
  `warehouseID` int NOT NULL,
  `itemID` int NOT NULL,
  `availableNum` int NOT NULL,
  `Supplier_supplierID` int NOT NULL,
  PRIMARY KEY (`warehouseID`,`itemID`,`Supplier_supplierID`),
  KEY `fk_Warehouse_has_Item_Item1_idx` (`itemID`),
  KEY `fk_Warehouse_has_Item_Warehouse1_idx` (`warehouseID`),
  KEY `fk_Warehouse_has_Item_Supplier1_idx` (`Supplier_supplierID`),
  CONSTRAINT `fk_Warehouse_has_Item_Item1` FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`),
  CONSTRAINT `fk_Warehouse_has_Item_Supplier1` FOREIGN KEY (`Supplier_supplierID`) REFERENCES `supplier` (`supplierID`),
  CONSTRAINT `fk_Warehouse_has_Item_Warehouse1` FOREIGN KEY (`warehouseID`) REFERENCES `warehouse` (`warehouseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse_has_item`
--

LOCK TABLES `warehouse_has_item` WRITE;
/*!40000 ALTER TABLE `warehouse_has_item` DISABLE KEYS */;
INSERT INTO `warehouse_has_item` VALUES (1,1,9,1),(1,4,4,2),(2,2,11,3),(3,3,7,5);
/*!40000 ALTER TABLE `warehouse_has_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-04 22:53:18
