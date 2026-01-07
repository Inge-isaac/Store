-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.41 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para tienda
CREATE DATABASE IF NOT EXISTS `tienda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tienda`;

-- Volcando estructura para tabla tienda.fabricante
CREATE TABLE IF NOT EXISTS `fabricante` (
  `codigo` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tienda.fabricante: ~9 rows (aproximadamente)
INSERT INTO `fabricante` (`codigo`, `nombre`) VALUES
	(1, 'Asus'),
	(2, 'Lenovo'),
	(3, 'Hewlett-Packard'),
	(4, 'Samsung'),
	(5, 'Seagate'),
	(6, 'Crucial'),
	(7, 'Gigabyte'),
	(8, 'Huawei'),
	(9, 'Xiaomi');

-- Volcando estructura para tabla tienda.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `codigo` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` float NOT NULL,
  `codigo_fabricante` int NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fabr_prod_FK` (`codigo_fabricante`),
  CONSTRAINT `fabr_prod_FK` FOREIGN KEY (`codigo_fabricante`) REFERENCES `fabricante` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tienda.producto: ~11 rows (aproximadamente)
INSERT INTO `producto` (`codigo`, `nombre`, `precio`, `codigo_fabricante`) VALUES
	(1, 'Disco duro SATA3 1TB', 86.99, 5),
	(2, 'Memoria RAM DDR4 8GB', 120, 6),
	(3, 'Disco SSD 1 TB', 150.99, 4),
	(4, 'GeForce GTX 1050Ti', 185, 7),
	(5, 'GeForce GTX 1080 Xtreme', 755, 6),
	(6, 'Monitor 24 LED Full HD', 202, 1),
	(7, 'Monitor 27 LED Full HD', 245.99, 1),
	(8, 'Portátil Yoga 520', 559, 2),
	(9, 'Portátil Ideapd 320', 444, 2),
	(10, 'Impresora HP Deskjet 3720', 59.99, 3),
	(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
