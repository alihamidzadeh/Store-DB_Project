-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema StoreProject
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `StoreProject` ;

-- -----------------------------------------------------
-- Schema StoreProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `StoreProject` ;
USE `StoreProject` ;

-- -----------------------------------------------------
-- Table `StoreProject`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Supplier` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Supplier` (
  `supplierID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phoneNumber` VARCHAR(12) NOT NULL,
  `score` INT NULL,
  `address` VARCHAR(100) NOT NULL,
  `postalCode` VARCHAR(10) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`supplierID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Item` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Item` (
  `itemID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `currentPrice` BIGINT(7) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `score` INT NOT NULL,
  `color` VARCHAR(45) NULL,
  `offer` INT(3) NULL,
  `weight` BIGINT(7) NOT NULL,
  PRIMARY KEY (`itemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`PriceHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`PriceHistory` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`PriceHistory` (
  `date` DATETIME NOT NULL,
  `price` BIGINT(7) NOT NULL,
  `Item_itemID` INT NOT NULL,
  PRIMARY KEY (`date`, `Item_itemID`),
  INDEX `fk_PriceHistory_Item1_idx` (`Item_itemID` ASC) VISIBLE,
  CONSTRAINT `fk_PriceHistory_Item1`
    FOREIGN KEY (`Item_itemID`)
    REFERENCES `StoreProject`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Offers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Offers` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Offers` (
  `offerID` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `value` INT(3) NOT NULL,
  `expiresAt` DATETIME NOT NULL,
  `startedAt` DATETIME NOT NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`offerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Customer` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Customer` (
  `customerID` INT NOT NULL AUTO_INCREMENT,
  `fName` VARCHAR(45) NOT NULL,
  `lName` VARCHAR(45) NOT NULL,
  `phoneNumber` VARCHAR(12) NOT NULL,
  `birthDate` DATE NULL,
  `ssn` VARCHAR(10) NULL,
  `userName` VARCHAR(45) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `gender` INT(1) NULL,
  `score` INT NOT NULL,
  `referenceID` INT NULL,
  PRIMARY KEY (`customerID`),
  INDEX `fk_Customer_Customer1_idx` (`referenceID` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Customer1`
    FOREIGN KEY (`referenceID`)
    REFERENCES `StoreProject`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Addresses` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Addresses` (
  `addressID` INT NOT NULL AUTO_INCREMENT,
  `postalCode` VARCHAR(10) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `phoneNumber` VARCHAR(12) NULL,
  `city` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `customerID` INT NOT NULL,
  PRIMARY KEY (`addressID`),
  INDEX `fk_Addresses_Customer1_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `fk_Addresses_Customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `StoreProject`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Order` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Order` (
  `orderID` INT NOT NULL AUTO_INCREMENT,
  `totalPrice` BIGINT NOT NULL,
  `orderDate` DATETIME NULL,
  `offer` BIGINT(7) NULL,
  `status` VARCHAR(45) NOT NULL,
  `offerID` INT NULL,
  `addressID` INT NOT NULL,
  `customerID` INT NOT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `fk_Order_Offers1_idx` (`offerID` ASC) VISIBLE,
  INDEX `fk_Order_Addresses1_idx` (`addressID` ASC) VISIBLE,
  INDEX `fk_Order_Customer1_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Offers1`
    FOREIGN KEY (`offerID`)
    REFERENCES `StoreProject`.`Offers` (`offerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Addresses1`
    FOREIGN KEY (`addressID`)
    REFERENCES `StoreProject`.`Addresses` (`addressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `StoreProject`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Bill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Bill` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Bill` (
  `billID` INT NOT NULL AUTO_INCREMENT,
  `issueDate` DATETIME NOT NULL,
  `totalPrice` VARCHAR(45) NOT NULL,
  `orderID` INT NOT NULL,
  PRIMARY KEY (`billID`),
  INDEX `fk_Bill_Order1_idx` (`orderID` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Order1`
    FOREIGN KEY (`orderID`)
    REFERENCES `StoreProject`.`Order` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Staff` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Staff` (
  `staffID` INT NOT NULL AUTO_INCREMENT,
  `fName` VARCHAR(45) NOT NULL,
  `lName` VARCHAR(45) NOT NULL,
  `salary` BIGINT(7) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `ssn` VARCHAR(10) NOT NULL,
  `startDate` DATETIME NOT NULL,
  `phoneNumber` VARCHAR(12) NOT NULL,
  `gender` INT(1) NULL,
  `address` VARCHAR(100) NOT NULL,
  `insuranceCode` VARCHAR(45) NOT NULL,
  `postalCode` VARCHAR(10) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `userName` VARCHAR(50) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `birthDate` DATE NULL,
  `bankAccountCode` VARCHAR(24) NOT NULL,
  `managerID` INT NULL,
  PRIMARY KEY (`staffID`),
  INDEX `fk_Staff_Staff1_idx` (`managerID` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_Staff1`
    FOREIGN KEY (`managerID`)
    REFERENCES `StoreProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Branch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Branch` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Branch` (
  `branchID` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `phoneNumber` VARCHAR(12) NOT NULL,
  `faxNumber` VARCHAR(12) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `postalCode` VARCHAR(10) NOT NULL,
  `managerID` INT NOT NULL,
  PRIMARY KEY (`branchID`),
  INDEX `fk_Branch_Staff1_idx` (`managerID` ASC) VISIBLE,
  CONSTRAINT `fk_Branch_Staff1`
    FOREIGN KEY (`managerID`)
    REFERENCES `StoreProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Warehouse` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Warehouse` (
  `warehouseID` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `postalCode` VARCHAR(10) NOT NULL,
  `phoneNumber` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`warehouseID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Vehicle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Vehicle` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Vehicle` (
  `vehicleID` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NOT NULL,
  `value` BIGINT(10) NOT NULL,
  `driverID` INT NOT NULL,
  `usedFor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vehicleID`),
  INDEX `fk_Vehicle_Staff1_idx` (`driverID` ASC) VISIBLE,
  CONSTRAINT `fk_Vehicle_Staff1`
    FOREIGN KEY (`driverID`)
    REFERENCES `StoreProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Comments` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Comments` (
  `commentID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `date` DATETIME NOT NULL,
  `text` VARCHAR(500) NULL,
  `itemID` INT NOT NULL,
  `customerID` INT NOT NULL,
  PRIMARY KEY (`commentID`),
  INDEX `fk_Comments_Item1_idx` (`itemID` ASC) VISIBLE,
  INDEX `fk_Comments_Customer1_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `fk_Comments_Item1`
    FOREIGN KEY (`itemID`)
    REFERENCES `StoreProject`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_Customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `StoreProject`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Notifications` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Notifications` (
  `notifID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `text` VARCHAR(500) NOT NULL,
  `date` DATETIME NOT NULL,
  `for` VARCHAR(45) NOT NULL,
  `customerID` INT NOT NULL,
  `staffID` INT NOT NULL,
  PRIMARY KEY (`notifID`),
  INDEX `fk_Notifications_Customer1_idx` (`customerID` ASC) VISIBLE,
  INDEX `fk_Notifications_Staff1_idx` (`staffID` ASC) VISIBLE,
  CONSTRAINT `fk_Notifications_Customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `StoreProject`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Notifications_Staff1`
    FOREIGN KEY (`staffID`)
    REFERENCES `StoreProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Order_has_Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Order_has_Item` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Order_has_Item` (
  `Order_orderID` INT NOT NULL,
  `Item_itemID` INT NOT NULL,
  PRIMARY KEY (`Order_orderID`, `Item_itemID`),
  INDEX `fk_Order_has_Item_Item1_idx` (`Item_itemID` ASC) VISIBLE,
  INDEX `fk_Order_has_Item_Order1_idx` (`Order_orderID` ASC) VISIBLE,
  CONSTRAINT `fk_Order_has_Item_Order1`
    FOREIGN KEY (`Order_orderID`)
    REFERENCES `StoreProject`.`Order` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_Item_Item1`
    FOREIGN KEY (`Item_itemID`)
    REFERENCES `StoreProject`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Offers_has_Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Offers_has_Item` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Offers_has_Item` (
  `Offers_offerID` INT NOT NULL,
  `Item_itemID` INT NOT NULL,
  PRIMARY KEY (`Offers_offerID`, `Item_itemID`),
  INDEX `fk_Offers_has_Item_Item1_idx` (`Item_itemID` ASC) VISIBLE,
  INDEX `fk_Offers_has_Item_Offers1_idx` (`Offers_offerID` ASC) VISIBLE,
  CONSTRAINT `fk_Offers_has_Item_Offers1`
    FOREIGN KEY (`Offers_offerID`)
    REFERENCES `StoreProject`.`Offers` (`offerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Offers_has_Item_Item1`
    FOREIGN KEY (`Item_itemID`)
    REFERENCES `StoreProject`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`item_is_favorite_of_customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`item_is_favorite_of_customer` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`item_is_favorite_of_customer` (
  `Item_itemID` INT NOT NULL,
  `Customer_customerID` INT NOT NULL,
  `category` VARCHAR(45) NULL,
  PRIMARY KEY (`Item_itemID`, `Customer_customerID`),
  INDEX `fk_Item_has_Customer_Customer1_idx` (`Customer_customerID` ASC) VISIBLE,
  INDEX `fk_Item_has_Customer_Item1_idx` (`Item_itemID` ASC) VISIBLE,
  CONSTRAINT `fk_Item_has_Customer_Item1`
    FOREIGN KEY (`Item_itemID`)
    REFERENCES `StoreProject`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Customer_Customer1`
    FOREIGN KEY (`Customer_customerID`)
    REFERENCES `StoreProject`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Warehouse_has_Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Warehouse_has_Item` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Warehouse_has_Item` (
  `warehouseID` INT NOT NULL,
  `itemID` INT NOT NULL,
  `availableNum` INT NOT NULL,
  `Supplier_supplierID` INT NOT NULL,
  PRIMARY KEY (`warehouseID`, `itemID`, `Supplier_supplierID`),
  INDEX `fk_Warehouse_has_Item_Item1_idx` (`itemID` ASC) VISIBLE,
  INDEX `fk_Warehouse_has_Item_Warehouse1_idx` (`warehouseID` ASC) VISIBLE,
  INDEX `fk_Warehouse_has_Item_Supplier1_idx` (`Supplier_supplierID` ASC) VISIBLE,
  CONSTRAINT `fk_Warehouse_has_Item_Warehouse1`
    FOREIGN KEY (`warehouseID`)
    REFERENCES `StoreProject`.`Warehouse` (`warehouseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Warehouse_has_Item_Item1`
    FOREIGN KEY (`itemID`)
    REFERENCES `StoreProject`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Warehouse_has_Item_Supplier1`
    FOREIGN KEY (`Supplier_supplierID`)
    REFERENCES `StoreProject`.`Supplier` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Supplier_Sends_to_Warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Supplier_Sends_to_Warehouse` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Supplier_Sends_to_Warehouse` (
  `Supplier_supplierID` INT NOT NULL,
  `Warehouse_warehouseID` INT NOT NULL,
  PRIMARY KEY (`Supplier_supplierID`, `Warehouse_warehouseID`),
  INDEX `fk_Supplier_has_Warehouse_Warehouse1_idx` (`Warehouse_warehouseID` ASC) VISIBLE,
  INDEX `fk_Supplier_has_Warehouse_Supplier1_idx` (`Supplier_supplierID` ASC) VISIBLE,
  CONSTRAINT `fk_Supplier_has_Warehouse_Supplier1`
    FOREIGN KEY (`Supplier_supplierID`)
    REFERENCES `StoreProject`.`Supplier` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supplier_has_Warehouse_Warehouse1`
    FOREIGN KEY (`Warehouse_warehouseID`)
    REFERENCES `StoreProject`.`Warehouse` (`warehouseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`Supplier_supplies_Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`Supplier_supplies_Item` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`Supplier_supplies_Item` (
  `Item_itemID` INT NOT NULL,
  `Supplier_supplierID` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `amount` BIGINT(7) NOT NULL,
  PRIMARY KEY (`Item_itemID`, `Supplier_supplierID`),
  INDEX `fk_Item_has_Supplier_Supplier1_idx` (`Supplier_supplierID` ASC) VISIBLE,
  INDEX `fk_Item_has_Supplier_Item1_idx` (`Item_itemID` ASC) VISIBLE,
  CONSTRAINT `fk_Item_has_Supplier_Item1`
    FOREIGN KEY (`Item_itemID`)
    REFERENCES `StoreProject`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Supplier_Supplier1`
    FOREIGN KEY (`Supplier_supplierID`)
    REFERENCES `StoreProject`.`Supplier` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StoreProject`.`login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StoreProject`.`login` ;

CREATE TABLE IF NOT EXISTS `StoreProject`.`login` (
  `token` VARCHAR(256) NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`token`, `userID`),
  UNIQUE INDEX `token_UNIQUE` (`token` ASC) VISIBLE,
  INDEX `fk_login_Staff1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_login_Staff1`
    FOREIGN KEY (`userID`)
    REFERENCES `StoreProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
