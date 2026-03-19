-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: store_management
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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Electronics'),(2,'Office Supplies'),(3,'Accessories'),(4,'Furniture'),(5,'Computer Components');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Liam Andersson','liam.andersson@email.com','0701234567'),(2,'Emma Johansson','emma.johansson@email.com','0709876543'),(3,'Noah Karlsson','noah.karlsson@email.com','0723456789'),(4,'Olivia Nilsson','olivia.nilsson@email.com','0731122334'),(5,'Lucas Eriksson','lucas.eriksson@email.com','0745566778'),(6,'Maja Lindberg','maja.lindberg@email.com','0769988776'),(7,'William Svensson','william.svensson@email.com','0704433221');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (1,1,1,1,1350.00),(2,1,2,2,24.99),(3,2,3,1,79.99),(4,2,6,3,12.99),(5,3,4,1,189.00),(6,3,7,1,29.90),(7,4,8,4,9.50),(8,5,9,1,149.99),(9,5,10,1,89.90),(10,6,11,1,320.00),(11,7,3,1,79.99),(12,8,9,10,149.99),(13,9,14,1,25.00);
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2025-04-10','Completed','Card'),(2,2,'2025-04-11','Completed','Swish'),(3,3,'2025-04-13','Completed','Card'),(4,4,'2025-04-15','Completed','Cash'),(5,5,'2025-04-18','Completed','Card'),(6,6,'2025-04-19','Completed','Card'),(7,7,'2026-03-18','Completed','Swish'),(8,5,'2026-03-18','Completed','Card'),(9,1,'2026-03-19','Completed','Cash');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Laptop Pro 15','ELEC1001',1350.00,11,1,1,1),(2,'Wireless Mouse','ELEC1002',24.99,53,1,5,1),(3,'Mechanical Keyboard','ELEC1003',79.99,38,1,3,1),(4,'Office Chair Ergonomic','FURN2001',189.00,5,4,4,1),(5,'Adjustable Desk Lamp','OFF3001',34.50,18,2,2,1),(6,'USB-C Charging Cable','ACC4001',12.99,92,3,5,1),(7,'Laptop Stand Aluminum','ACC4002',29.90,13,3,5,1),(8,'Notebook Pack A4','OFF3002',9.50,66,2,2,1),(9,'External SSD 1TB','ELEC1004',149.99,11,1,3,1),(10,'Gaming Headset','ELEC1005',89.90,24,1,3,1),(11,'Office Desk Large','FURN2002',320.00,3,4,4,1),(12,'Shelf','SKU5635',275.00,24,3,2,1),(13,'Magnet','SKU8136',45.00,3,5,4,1),(14,'Chips','SKU2872',25.00,23,4,2,1),(15,'Printer','SKU6085',750.00,10,1,5,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocklogs`
--

DROP TABLE IF EXISTS `stocklogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stocklogs` (
  `stock_log_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `change_amount` int DEFAULT NULL,
  `change_reason` varchar(50) DEFAULT NULL,
  `change_date` date DEFAULT NULL,
  PRIMARY KEY (`stock_log_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `stocklogs_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocklogs`
--

LOCK TABLES `stocklogs` WRITE;
/*!40000 ALTER TABLE `stocklogs` DISABLE KEYS */;
INSERT INTO `stocklogs` VALUES (1,1,-1,'Sale','2026-03-18'),(2,2,-2,'Sale','2026-03-18'),(3,3,-1,'Sale','2026-03-18'),(4,6,-3,'Sale','2026-03-18'),(5,4,-1,'Sale','2026-03-18'),(6,7,-1,'Sale','2026-03-18'),(7,8,-4,'Sale','2026-03-18'),(8,9,-1,'Sale','2026-03-18'),(9,10,-1,'Sale','2026-03-18'),(10,11,-1,'Sale','2026-03-18'),(11,1,-1,'Sale','2025-04-10'),(12,2,-2,'Sale','2025-04-10'),(13,3,-1,'Sale','2025-04-11'),(14,6,-3,'Sale','2025-04-11'),(15,4,-1,'Sale','2025-04-13'),(16,7,-1,'Sale','2025-04-13'),(17,8,-4,'Sale','2025-04-15'),(18,9,-1,'Sale','2025-04-18'),(19,10,-1,'Sale','2025-04-18'),(20,11,-1,'Sale','2025-04-19'),(21,3,-1,'Sale','2026-03-18'),(22,9,-10,'Sale','2026-03-18'),(23,14,-1,'Sale','2026-03-19');
/*!40000 ALTER TABLE `stocklogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `contact_info` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Nordic Tech AB','contact@nordictech.com'),(2,'OfficePro Ltd','sales@officepro.com'),(3,'Global Electronics','support@globalelec.com'),(4,'DeskWorld Sweden','info@deskworld.se'),(5,'Accessory Planet','sales@accessoryplanet.com');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-19 13:00:53
