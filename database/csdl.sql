DROP DATABASE IF EXISTS `sem4`;

CREATE DATABASE `sem4` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

use sem4;

CREATE TABLE IF NOT EXISTS `account` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE,
  `password` VARCHAR(100) NOT NULL,
  `role` VARCHAR(100) DEFAULT 'customer',
  `status` VARCHAR(100) DEFAULT 'Hoạt động',
  `created_at` date DEFAULT CURRENT_TIMESTAMP(),
  `last_login` date DEFAULT CURRENT_TIMESTAMP()
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `product` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `image` VARCHAR(100) NULL,
  `price` float NOT NULL,
  `sale_price` float DEFAULT '1',
  `status` VARCHAR(100) DEFAULT 'Còn hàng',
  `description` text NULL,
  `created_at` date DEFAULT current_timestamp(),
  `category_id` int NOT NULL,
  FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `orders` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `account_id` INT NOT NULL, 
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(100) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `note` text NULL,
  `status` VARCHAR(100) DEFAULT 'Chờ xác nhận',
  `total_price` DECIMAL(10, 2) NOT NULL,
  `created_at` date DEFAULT CURRENT_TIMESTAMP(),
  FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `order_details` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  FOREIGN KEY (`product_id`) REFERENCES `product`(`id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`)
);

CREATE TABLE IF NOT EXISTS `favorite` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `created_at` date DEFAULT current_timestamp(),
  FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE = InnoDB;