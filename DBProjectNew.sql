CREATE DATABASE  IF NOT EXISTS `StoreProject` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `StoreProject`;
-- MariaDB dump 10.19  Distrib 10.9.4-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: StoreProject
-- ------------------------------------------------------
-- Server version	10.9.4-MariaDB

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
-- Table structure for table `Addresses`
--

DROP TABLE IF EXISTS `Addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Addresses` (
  `addressID` int(11) NOT NULL AUTO_INCREMENT,
  `postalCode` varchar(10) NOT NULL,
  `description` varchar(100) NOT NULL,
  `phoneNumber` varchar(12) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `customerID` int(11) NOT NULL,
  PRIMARY KEY (`addressID`),
  KEY `fk_Addresses_Customer1_idx` (`customerID`),
  CONSTRAINT `fk_Addresses_Customer1` FOREIGN KEY (`customerID`) REFERENCES `Customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Addresses`
--

LOCK TABLES `Addresses` WRITE;
/*!40000 ALTER TABLE `Addresses` DISABLE KEYS */;
INSERT INTO `Addresses` VALUES
(1,'1111111111','bullshit','989156646936','Birjand','Iran',1),
(2,'1111111111','bullshit','989156646936','Tehran','Iran',1),
(3,'1111111111','bullshit','989156646936','Birjand','Iran',2),
(4,'1111111111','bullshit','989156646936','Tehran','Iran',3);
/*!40000 ALTER TABLE `Addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bill`
--

DROP TABLE IF EXISTS `Bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bill` (
  `billID` int(11) NOT NULL AUTO_INCREMENT,
  `issueDate` datetime NOT NULL,
  `totalPrice` varchar(45) NOT NULL,
  `orderID` int(11) NOT NULL,
  PRIMARY KEY (`billID`),
  KEY `fk_Bill_Order1_idx` (`orderID`),
  CONSTRAINT `fk_Bill_Order1` FOREIGN KEY (`orderID`) REFERENCES `Order` (`orderID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bill`
--

LOCK TABLES `Bill` WRITE;
/*!40000 ALTER TABLE `Bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `Bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Branch`
--

DROP TABLE IF EXISTS `Branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Branch` (
  `branchID` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `phoneNumber` varchar(12) NOT NULL,
  `faxNumber` varchar(12) NOT NULL,
  `address` varchar(100) NOT NULL,
  `postalCode` varchar(10) NOT NULL,
  `managerID` int(11) NOT NULL,
  PRIMARY KEY (`branchID`),
  KEY `fk_Branch_Staff1_idx` (`managerID`),
  CONSTRAINT `fk_Branch_Staff1` FOREIGN KEY (`managerID`) REFERENCES `Staff` (`staffID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Branch`
--

LOCK TABLES `Branch` WRITE;
/*!40000 ALTER TABLE `Branch` DISABLE KEYS */;
/*!40000 ALTER TABLE `Branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comments`
--

DROP TABLE IF EXISTS `Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comments` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  `text` varchar(500) DEFAULT NULL,
  `itemID` int(11) NOT NULL,
  `customerID` int(11) NOT NULL,
  `score` int(11) DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `fk_Comments_Item1_idx` (`itemID`),
  KEY `fk_Comments_Customer1_idx` (`customerID`),
  CONSTRAINT `fk_Comments_Customer1` FOREIGN KEY (`customerID`) REFERENCES `Customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_Item1` FOREIGN KEY (`itemID`) REFERENCES `Item` (`itemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comments`
--

LOCK TABLES `Comments` WRITE;
/*!40000 ALTER TABLE `Comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `customerID` int(11) NOT NULL AUTO_INCREMENT,
  `fName` varchar(45) NOT NULL,
  `lName` varchar(45) NOT NULL,
  `phoneNumber` varchar(12) NOT NULL,
  `birthDate` date DEFAULT NULL,
  `ssn` varchar(10) DEFAULT NULL,
  `userName` varchar(45) NOT NULL,
  `password` varchar(256) NOT NULL,
  `email` varchar(45) NOT NULL,
  `gender` int(1) DEFAULT NULL,
  `score` int(11) NOT NULL,
  `referenceID` int(11) DEFAULT NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE KEY `userName` (`userName`),
  KEY `fk_Customer_Customer1_idx` (`referenceID`),
  CONSTRAINT `fk_Customer_Customer1` FOREIGN KEY (`referenceID`) REFERENCES `Customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES
(1,'Ehsan','Ghorbani','09156646936','2002-02-22','0926252134','ehsangh190','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','eghorbani@gmail.com',1,0,NULL),
(2,'Tina','tavakoli','09156646936','2002-02-22','0926251462','ttavakoli','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','example@site.com',0,0,NULL),
(3,'Kiana','Kermani','0915001377','2002-04-16','0926252143','kkermani','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','kianakermani1381@gmail.com',0,0,NULL),
(4,'Ali','Hamidzadeh','09152273816','2002-05-15','0926251885','ahamidzadeh','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','ahamidzadeh93@gmail.com',1,0,NULL);
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Item` (
  `itemID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `currentPrice` bigint(7) NOT NULL,
  `category` varchar(45) NOT NULL,
  `score` int(11) NOT NULL,
  `color` varchar(45) DEFAULT NULL,
  `offer` int(3) DEFAULT NULL,
  `weight` bigint(7) NOT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
INSERT INTO `Item` VALUES
(1,'Bag',500,'School',0,'purple',30,3),
(2,'Laptop',500000,'Electronics',0,'gray',15,5),
(3,'Headphone',6000,'Electronics',0,'Pink',NULL,1),
(4,'shoe',400,'Wearing',0,'yellow',70,0),
(5,'shoe',400,'Wearing',0,'yellow',70,0);
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notifications`
--

DROP TABLE IF EXISTS `Notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notifications` (
  `notifID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `text` varchar(500) NOT NULL,
  `date` datetime NOT NULL,
  `for` varchar(45) NOT NULL,
  `customerID` int(11) NOT NULL,
  `staffID` int(11) NOT NULL,
  PRIMARY KEY (`notifID`),
  KEY `fk_Notifications_Customer1_idx` (`customerID`),
  KEY `fk_Notifications_Staff1_idx` (`staffID`),
  CONSTRAINT `fk_Notifications_Customer1` FOREIGN KEY (`customerID`) REFERENCES `Customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Notifications_Staff1` FOREIGN KEY (`staffID`) REFERENCES `Staff` (`staffID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notifications`
--

LOCK TABLES `Notifications` WRITE;
/*!40000 ALTER TABLE `Notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Offers`
--

DROP TABLE IF EXISTS `Offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Offers` (
  `offerID` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `value` int(3) NOT NULL,
  `expiresAt` datetime NOT NULL,
  `startedAt` datetime NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Offers`
--

LOCK TABLES `Offers` WRITE;
/*!40000 ALTER TABLE `Offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Offers_has_Item`
--

DROP TABLE IF EXISTS `Offers_has_Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Offers_has_Item` (
  `Offers_offerID` int(11) NOT NULL,
  `Item_itemID` int(11) NOT NULL,
  PRIMARY KEY (`Offers_offerID`,`Item_itemID`),
  KEY `fk_Offers_has_Item_Item1_idx` (`Item_itemID`),
  KEY `fk_Offers_has_Item_Offers1_idx` (`Offers_offerID`),
  CONSTRAINT `fk_Offers_has_Item_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `Item` (`itemID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Offers_has_Item_Offers1` FOREIGN KEY (`Offers_offerID`) REFERENCES `Offers` (`offerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Offers_has_Item`
--

LOCK TABLES `Offers_has_Item` WRITE;
/*!40000 ALTER TABLE `Offers_has_Item` DISABLE KEYS */;
/*!40000 ALTER TABLE `Offers_has_Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Order` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `totalPrice` bigint(20) NOT NULL,
  `orderDate` datetime DEFAULT NULL,
  `offer` bigint(7) DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  `offerID` int(11) DEFAULT NULL,
  `addressID` int(11) NOT NULL,
  `customerID` int(11) NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `fk_Order_Offers1_idx` (`offerID`),
  KEY `fk_Order_Addresses1_idx` (`addressID`),
  KEY `fk_Order_Customer1_idx` (`customerID`),
  CONSTRAINT `fk_Order_Addresses1` FOREIGN KEY (`addressID`) REFERENCES `Addresses` (`addressID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Customer1` FOREIGN KEY (`customerID`) REFERENCES `Customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Offers1` FOREIGN KEY (`offerID`) REFERENCES `Offers` (`offerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_has_Item`
--

DROP TABLE IF EXISTS `Order_has_Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Order_has_Item` (
  `Order_orderID` int(11) NOT NULL,
  `Item_itemID` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Order_orderID`,`Item_itemID`),
  KEY `fk_Order_has_Item_Item1_idx` (`Item_itemID`),
  KEY `fk_Order_has_Item_Order1_idx` (`Order_orderID`),
  CONSTRAINT `fk_Order_has_Item_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `Item` (`itemID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_Item_Order1` FOREIGN KEY (`Order_orderID`) REFERENCES `Order` (`orderID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_has_Item`
--

LOCK TABLES `Order_has_Item` WRITE;
/*!40000 ALTER TABLE `Order_has_Item` DISABLE KEYS */;
/*!40000 ALTER TABLE `Order_has_Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PriceHistory`
--

DROP TABLE IF EXISTS `PriceHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PriceHistory` (
  `date` datetime NOT NULL,
  `price` bigint(7) NOT NULL,
  `Item_itemID` int(11) NOT NULL,
  PRIMARY KEY (`date`,`Item_itemID`),
  KEY `fk_PriceHistory_Item1_idx` (`Item_itemID`),
  CONSTRAINT `fk_PriceHistory_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `Item` (`itemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PriceHistory`
--

LOCK TABLES `PriceHistory` WRITE;
/*!40000 ALTER TABLE `PriceHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `PriceHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Staff` (
  `staffID` int(11) NOT NULL AUTO_INCREMENT,
  `fName` varchar(45) NOT NULL,
  `lName` varchar(45) NOT NULL,
  `salary` bigint(7) NOT NULL,
  `role` varchar(45) NOT NULL,
  `ssn` varchar(10) NOT NULL,
  `startDate` datetime NOT NULL,
  `phoneNumber` varchar(12) NOT NULL,
  `gender` int(1) DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `insuranceCode` varchar(45) NOT NULL,
  `postalCode` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `userName` varchar(45) NOT NULL,
  `password` varchar(256) NOT NULL,
  `birthDate` date DEFAULT NULL,
  `bankAccountCode` varchar(24) NOT NULL,
  `managerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`staffID`),
  UNIQUE KEY `userName` (`userName`),
  KEY `fk_Staff_Staff1_idx` (`managerID`),
  CONSTRAINT `fk_Staff_Staff1` FOREIGN KEY (`managerID`) REFERENCES `Staff` (`staffID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES
(1,'Sina','Golmakani',25000000,'Boss','0926252184','2019-05-14 09:00:00','989152246517',1,'IRAN-Tehran-Sajad 5-NO.22','562','5126487523','sgolmakani@gmail.com','sgolmakani','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','1850-02-20','080180000001254896251342',NULL),
(2,'Elham','Gholami',5000000,'Manager','0926252183','2022-11-05 11:00:00','989387921536',1,'IRAN-Shiraz-Emamat 28-NO.5','784','9716478523','egholami80@gmail.com','egholami','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','1995-08-01','098780000001254796242342',1),
(3,'Fateneh','tataba',2000000,'DBadminn','9262070400','1990-04-26 09:22:00','989396330',0,'Iran , Mashad , piroozi BLv , piroozi 21','987654321','123456','fatemeh28389@gmail.com','fatmeheh ','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','1990-03-02','546789',1),
(4,'hamid','kermami',5000000,'scrum master','051258','2020-04-26 10:22:00','972852',1,'Iran , Mashad , piroozi BLv , hashemie 50','94567841','9854785','kermaniha@gmail.com','hamid52 ','3bcf860d93e657407b8ec1dbfbfa59220ed16a4ecdf4682fa52310971fde5cf7','1985-03-02','546789',2);
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supplier`
--

DROP TABLE IF EXISTS `Supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Supplier` (
  `supplierID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `phoneNumber` varchar(12) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `postalCode` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`supplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplier`
--

LOCK TABLES `Supplier` WRITE;
/*!40000 ALTER TABLE `Supplier` DISABLE KEYS */;
INSERT INTO `Supplier` VALUES
(1,'LionComputer','989150000000',0,'Mashad,Janbaz Street','1234567891','info@lioncomputer.com'),
(2,'MashhadKala','989151111111',0,'Mashad,Khayam Street','2345678901','info@mashhadKala.com'),
(3,'TehranShop','989152222222',0,'Tehran,Enghelab Street','3456789012','info@tehranshop.com'),
(4,'EsfehanShop','989153333333',0,'Esfehan,Modarres Street','4567890123','info@esfehanshop.com'),
(5,'ShirazStore','989155555555',0,'Shiraz,Moaalem Stree','5678901234','info@sstore.com');
/*!40000 ALTER TABLE `Supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supplier_Sends_to_Warehouse`
--

DROP TABLE IF EXISTS `Supplier_Sends_to_Warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Supplier_Sends_to_Warehouse` (
  `Supplier_supplierID` int(11) NOT NULL,
  `Warehouse_warehouseID` int(11) NOT NULL,
  PRIMARY KEY (`Supplier_supplierID`,`Warehouse_warehouseID`),
  KEY `fk_Supplier_has_Warehouse_Warehouse1_idx` (`Warehouse_warehouseID`),
  KEY `fk_Supplier_has_Warehouse_Supplier1_idx` (`Supplier_supplierID`),
  CONSTRAINT `fk_Supplier_has_Warehouse_Supplier1` FOREIGN KEY (`Supplier_supplierID`) REFERENCES `Supplier` (`supplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supplier_has_Warehouse_Warehouse1` FOREIGN KEY (`Warehouse_warehouseID`) REFERENCES `Warehouse` (`warehouseID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplier_Sends_to_Warehouse`
--

LOCK TABLES `Supplier_Sends_to_Warehouse` WRITE;
/*!40000 ALTER TABLE `Supplier_Sends_to_Warehouse` DISABLE KEYS */;
/*!40000 ALTER TABLE `Supplier_Sends_to_Warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supplier_supplies_Item`
--

DROP TABLE IF EXISTS `Supplier_supplies_Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Supplier_supplies_Item` (
  `Item_itemID` int(11) NOT NULL,
  `Supplier_supplierID` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `amount` bigint(7) NOT NULL,
  PRIMARY KEY (`Item_itemID`,`Supplier_supplierID`),
  KEY `fk_Item_has_Supplier_Supplier1_idx` (`Supplier_supplierID`),
  KEY `fk_Item_has_Supplier_Item1_idx` (`Item_itemID`),
  CONSTRAINT `fk_Item_has_Supplier_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `Item` (`itemID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Supplier_Supplier1` FOREIGN KEY (`Supplier_supplierID`) REFERENCES `Supplier` (`supplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplier_supplies_Item`
--

LOCK TABLES `Supplier_supplies_Item` WRITE;
/*!40000 ALTER TABLE `Supplier_supplies_Item` DISABLE KEYS */;
/*!40000 ALTER TABLE `Supplier_supplies_Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vehicle`
--

DROP TABLE IF EXISTS `Vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vehicle` (
  `vehicleID` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(45) NOT NULL,
  `value` bigint(10) NOT NULL,
  `driverID` int(11) NOT NULL,
  `usedFor` varchar(45) NOT NULL,
  PRIMARY KEY (`vehicleID`),
  KEY `fk_Vehicle_Staff1_idx` (`driverID`),
  CONSTRAINT `fk_Vehicle_Staff1` FOREIGN KEY (`driverID`) REFERENCES `Staff` (`staffID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vehicle`
--

LOCK TABLES `Vehicle` WRITE;
/*!40000 ALTER TABLE `Vehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `Vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Warehouse`
--

DROP TABLE IF EXISTS `Warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Warehouse` (
  `warehouseID` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `postalCode` varchar(10) NOT NULL,
  `phoneNumber` varchar(12) NOT NULL,
  PRIMARY KEY (`warehouseID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Warehouse`
--

LOCK TABLES `Warehouse` WRITE;
/*!40000 ALTER TABLE `Warehouse` DISABLE KEYS */;
INSERT INTO `Warehouse` VALUES
(1,'mashhad','iran','hashemieh 67','3458888889','989053213280'),
(2,'tehran','iran','zaferanieh','1234567789','989053213270'),
(3,'shiraz','iran','hashemieh 67','1357909743','989053213260');
/*!40000 ALTER TABLE `Warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Warehouse_has_Item`
--

DROP TABLE IF EXISTS `Warehouse_has_Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Warehouse_has_Item` (
  `warehouseID` int(11) NOT NULL,
  `itemID` int(11) NOT NULL,
  `availableNum` int(11) NOT NULL,
  `Supplier_supplierID` int(11) NOT NULL,
  PRIMARY KEY (`warehouseID`,`itemID`,`Supplier_supplierID`),
  KEY `fk_Warehouse_has_Item_Item1_idx` (`itemID`),
  KEY `fk_Warehouse_has_Item_Warehouse1_idx` (`warehouseID`),
  KEY `fk_Warehouse_has_Item_Supplier1_idx` (`Supplier_supplierID`),
  CONSTRAINT `fk_Warehouse_has_Item_Item1` FOREIGN KEY (`itemID`) REFERENCES `Item` (`itemID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Warehouse_has_Item_Supplier1` FOREIGN KEY (`Supplier_supplierID`) REFERENCES `Supplier` (`supplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Warehouse_has_Item_Warehouse1` FOREIGN KEY (`warehouseID`) REFERENCES `Warehouse` (`warehouseID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Warehouse_has_Item`
--

LOCK TABLES `Warehouse_has_Item` WRITE;
/*!40000 ALTER TABLE `Warehouse_has_Item` DISABLE KEYS */;
/*!40000 ALTER TABLE `Warehouse_has_Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_is_favorite_of_customer`
--

DROP TABLE IF EXISTS `item_is_favorite_of_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_is_favorite_of_customer` (
  `Item_itemID` int(11) NOT NULL,
  `Customer_customerID` int(11) NOT NULL,
  `category` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Item_itemID`,`Customer_customerID`),
  KEY `fk_Item_has_Customer_Customer1_idx` (`Customer_customerID`),
  KEY `fk_Item_has_Customer_Item1_idx` (`Item_itemID`),
  CONSTRAINT `fk_Item_has_Customer_Customer1` FOREIGN KEY (`Customer_customerID`) REFERENCES `Customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Customer_Item1` FOREIGN KEY (`Item_itemID`) REFERENCES `Item` (`itemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_is_favorite_of_customer`
--

LOCK TABLES `item_is_favorite_of_customer` WRITE;
/*!40000 ALTER TABLE `item_is_favorite_of_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_is_favorite_of_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `token` varchar(256) NOT NULL,
  `userID` int(11) NOT NULL,
  `isStaff` int(1) NOT NULL,
  PRIMARY KEY (`token`,`userID`),
  UNIQUE KEY `token_UNIQUE` (`token`),
  KEY `fk_login_Staff1_idx` (`userID`),
  CONSTRAINT `fk_login_Staff1` FOREIGN KEY (`userID`) REFERENCES `Staff` (`staffID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-01 18:12:27
