-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 05, 2024 at 10:15 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sem4`
--
DROP DATABASE IF EXISTS `sem4`;

CREATE DATABASE `sem4` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

use sem4;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(100) DEFAULT 'customer',
  `status` varchar(100) DEFAULT 'Hoạt động',
  `created_at` date DEFAULT current_timestamp(),
  `last_login` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id`, `name`, `phone`, `address`, `email`, `password`, `role`, `status`, `created_at`, `last_login`) VALUES
(1, 'Huynh Thành Thái', '0989112113', 'Hà nội', 'admin@gmail.com', '123456', 'admin', 'Hoạt động', '2024-09-05', '2024-09-05');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(4, 'Bàn phím'),
(3, 'Chuột'),
(2, 'Điện thoại'),
(1, 'Loa'),
(5, 'Tai nghe');

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`id`, `account_id`, `product_id`, `created_at`) VALUES
(1, 1, 18, '2024-09-05'),
(2, 1, 9, '2024-09-05'),
(3, 1, 5, '2024-09-05'),
(4, 1, 15, '2024-09-05'),
(5, 1, 13, '2024-09-05'),
(6, 1, 2, '2024-09-05');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `note` text DEFAULT NULL,
  `status` varchar(100) DEFAULT 'Chờ xác nhận',
  `total_price` decimal(10,2) NOT NULL,
  `created_at` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `account_id`, `name`, `phone`, `address`, `note`, `status`, `total_price`, `created_at`) VALUES
(1, 1, 'Huynh Thành Thái', '0989112113', 'Hà nội', '', 'Đã hủy', 29490000.00, '2024-09-05'),
(2, 1, 'Huynh Thành Thái', '0989112113', 'Hà nội', '', 'Chờ xác nhận', 79000.00, '2024-09-05'),
(3, 1, 'Huynh Thành Thái', '0989112113', 'Hà nội', '', 'Chờ lấy hàng', 129000.00, '2024-09-05'),
(4, 1, 'Huynh Thành Thái', '0989112113', 'Hà nội', '', 'Chờ giao hàng', 139000.00, '2024-09-05'),
(5, 1, 'Huynh Thành Thái', '0989112113', 'Hà nội', '', 'Đã giao', 469000.00, '2024-09-05'),
(6, 1, 'Huynh Thành Thái', '0989112113', 'Hà nội', 'Giao cham khong tra tien, bom hang', 'Chờ xác nhận', 30306000.00, '2024-09-05'),
(7, 1, 'Huynh Thành Thái', '0989112113', 'Hà nội', 'Giao nhanh', 'Chờ xác nhận', 42779000.00, '2024-09-05');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `quantity`) VALUES
(1, 1, 18, 1),
(2, 2, 9, 1),
(3, 3, 5, 1),
(4, 4, 15, 1),
(5, 5, 13, 1),
(6, 6, 18, 1),
(7, 6, 9, 1),
(8, 6, 5, 1),
(9, 6, 15, 1),
(10, 6, 13, 1),
(11, 7, 13, 1),
(12, 7, 5, 1),
(13, 7, 15, 1),
(14, 7, 9, 1),
(15, 7, 18, 1),
(16, 7, 10, 1),
(17, 7, 23, 1),
(18, 7, 11, 1),
(19, 7, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `price` float NOT NULL,
  `sale_price` float DEFAULT 1,
  `status` varchar(100) DEFAULT 'Còn hàng',
  `description` text DEFAULT NULL,
  `created_at` date DEFAULT current_timestamp(),
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `image`, `price`, `sale_price`, `status`, `description`, `created_at`, `category_id`) VALUES
(1, 'Bàn phím cơ 124 phím keycaps', 'image-1724659615202.jpg', 301000, 165000, 'Còn hàng', 'Kho:     4041\r\nThương hiệu:     XiaoZhubangchu\r\nGửi từ:     Nước ngoài', '2024-08-26', 4),
(2, 'Bàn Phím Máy Tính Gaming RGB SIDOTECH LDK V4 Pro', 'image-1724659621298.jpg', 199000, 118000, 'Còn hàng', 'Số lượng hàng khuyến mãi:     296\r\nSố sản phẩm còn lại:     4882\r\nThương hiệu:     sido tech\r\nBộ sản phẩm:      Không\r\nHạn bảo hành:     12 tháng\r\nLoại bảo hành:     Bảo hành nhà sản xuất\r\nGame chuyên dụng:     Có\r\nModel bàn phím & chuột:     Full size\r\nBàn phím tương thích:      Window\r\nLoại bàn phím:     Bàn phím LED RGB\r\nKích thước (dài x rộng x cao):     44 x 17 x 2', '2024-08-26', 4),
(3, 'Bàn phím máy tính giá rẻ SIDOTECH KM10', 'image-1724659767758.jpg', 119000, 86000, 'Còn hàng', 'Số lượng hàng khuyến mãi:     53\r\nSố sản phẩm còn lại:     1228\r\nThương hiệu:     sido tech\r\nBộ sản phẩm:     Không\r\nHạn bảo hành:     12 tháng\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nGame chuyên dụng:     Không\r\nModel bàn phím & chuột:     LDK1\r\nLoại bàn phím:     Bàn phím thường\r\nKích thước (dài x rộng x cao):     440*130*20 mm', '2024-08-26', 4),
(4, 'Bàn Phím CƠ ZIYOU K3 Luxury Cao Cấp', 'image-1724659908998.jpg', 1100000, 559000, 'Còn hàng', 'Số lượng hàng khuyến mãi:     148\r\nSố sản phẩm còn lại:     3698\r\nThương hiệu:     Ziyou\r\nBộ sản phẩm:     Có\r\nLoại bàn phím:     Bàn phím cơ\r\nHạn bảo hành:     12 tháng\r\nLoại bảo hành:     Bảo hành nhà sản xuất\r\nGame chuyên dụng:     Có\r\nTên tổ chức chịu trách nhiệm sản xuất:     Đang cập nhật\r\nĐịa chỉ tổ chức chịu trách nhiệm sản xuất:     Đang cập nhật\r\nModel bàn phím & chuột:     2023\r\nBàn phím tương thích;     máy tính, laptop, pc\r\nGửi từ:     Hà Nội', '2024-08-26', 4),
(5, 'Bàn phím chính hãng Glowy T-WOLF', 'image-1724660071734.jpg', 155000, 129000, 'Còn hàng', 'Kho:     2\r\nThương hiệu:     Glowy\r\nBộ sản phẩm:     Không\r\nHạn bảo hành:     12 tháng\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nGame chuyên dụng:     Có\r\nModel bàn phím & chuột:     GLOWAY T20\r\nBàn phím tương thích:     USB 3.0\r\nLoại bàn phím:     Bàn phím giả cơ\r\nGửi từ:     Hà Nội', '2024-08-26', 4),
(6, 'Chuột ko dây Bluetooth tự sạc pin SIDOTECH M1P', 'image-1724661299365.jpg', 150000, 0, 'Còn hàng', 'Số lượng hàng khuyến mãi:     418\r\nSố sản phẩm còn lại:    7708\r\nThương hiệu:     sido tech\r\nKiểu kết nối:     Không dây\r\nGame chuyên dụng:     Không\r\nBộ sản phẩm:     Không\r\nHạn bảo hành:     3 tháng\r\nLoại bảo hành:     Bảo hành nhà sản xuất\r\nModel bàn phím & chuột:     Chuột không dây M1P\r\nChuột tương thích:     Mọi hệ điều hành', '2024-08-26', 3),
(7, 'Chuột máy tính có dây văn phòng SIDOTECH P20', 'image-1724660726021.jpg', 109000, 64000, 'Còn hàng', 'Số lượng hàng khuyến mãi:     68\r\nSố sản phẩm còn lại:     1017\r\nThương hiệu:     sido tech\r\nKiểu kết nối:     Không dây\r\nGame chuyên dụng:     Có\r\nBộ sản phẩm:     Không\r\nHạn bảo hành:     3 tháng\r\nLoại bảo hành:    Bảo hành nhà sản xuất\r\nModel bàn phím & chuột:    P20 G2\r\nChuột tương thích:    Window\r\nKích thước (dài x rộng x cao):     20 x 10 x 5', '2024-08-26', 3),
(8, 'Chuột không dây Logitech B170', 'image-1724660953007.jpg', 249000, 185000, 'Còn hàng', 'Kho:     2367\r\nThương hiệu:     Logitech\r\nKiểu kết nối:     Không dây\r\nGame chuyên dụng:     Không\r\nBộ sản phẩm:     Có\r\nHạn bảo hành:     12 tháng\r\nLoại bảo hành:     Bảo hành nhà sản xuất\r\nModel bàn phím & chuột:     B170\r\nChuột tương thích:     UBS\r\nGửi từ:     TP. Hồ Chí Minh', '2024-08-26', 3),
(9, 'Chuột gaming có dây SIDOTECH YINDIAO G5 3200DPI', 'image-1724661594872.jpg', 139000, 79000, 'Còn hàng', 'Kho:     343\r\nThương hiệu:     sido tech\r\nKiểu kết nối:     Không dây\r\nGame chuyên dụng:     Có\r\nBộ sản phẩm:     Không\r\nHạn bảo hành:     3 tháng\r\nLoại bảo hành:     Bảo hành nhà sản xuất\r\nModel bàn phím & chuột:     G5\r\nChuột tương thích:     Window\r\nKích thước (dài x rộng x cao):     20 x 10 x 5', '2024-08-26', 3),
(10, 'Bàn phím Logitech K120', 'image-1724831309897.jpg', 165000, 0, 'Còn hàng', 'Kho:    61\r\nThương hiệu:     Logitech\r\nGame chuyên dụng:     Không', '2024-08-28', 4),
(11, 'Tai nghe có dây trong tai Baseus Encok CZ20 / HZ20', 'image-1725519418754.jpg', 200000, 0, 'Còn hàng', 'Kho:     507\r\nThương hiệu:     Baseus\r\nKiểu kết nối:     Có dây\r\nCác loại tai nghe:     Nhét tai\r\nGame chuyên dụng:     Không\r\nThiết bị âm thanh tương thích:     điện thoại di động, PC & Laptop\r\nGửi từ :     TP. Hồ Chí Minh', '2024-09-05', 5),
(12, 'Lenovo ERAZER XF22 Tai nghe không dây', 'image-1725519556654.jpg', 400000, 239000, 'Còn hàng', 'Kho:     19975\r\nThương hiệu:     Lenovo\r\nKiểu kết nối:     Không dây\r\nCác loại tai nghe:     Tai nghe dẫn xương\r\nGame chuyên dụng:     Không\r\nThiết bị âm thanh tương thích:  máy quay/chụp ảnh, điện thoại di động, xe máy, khác, PC & Laptop\r\nHạn bảo hành:     12 tháng\r\nGửi từ:     Nước ngoài', '2024-09-05', 5),
(13, 'Tai Nghe Gaming Có Dây Onikuma K9', 'image-1725519724692.jpg', 700000, 469000, 'Còn hàng', 'Kho:     900\r\nThương hiệu:     ONIKUMA\r\nKiểu kết nối:     Có dây\r\nCác loại tai nghe:     Chụp tai\r\nGame chuyên dụng:     Có\r\nThiết bị âm thanh tương thích:     điện thoại di động, PC & Laptop\r\nTính năng các loại tai nghe: Tích hợp micro, Cản tiếng ồn, Chống ồn, Chống mồ hôi, Điều chỉnh âm lượng\r\nTrở kháng:     32Ohms\r\nGửi từ:     Hà Nội', '2024-09-05', 5),
(14, 'Loa kéo HOZING 8002', 'image-1725519898152.jpg', 2550000, 1250000, 'Còn hàng', 'Số lượng hàng khuyến mãi:     10\r\nSố sản phẩm còn lại:     2986\r\nThương hiệu:     hozing\r\nThiết bị âm thanh tương thích:     điện thoại di động, khác, PC & Laptop\r\nTần số tối đa:     50000Hz\r\nTần số tối thiểu:     90Hz\r\nHạn bảo hành:     12 tháng\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nKết nối đầu vào:     Cổng kết nối phụ, Cáp quang, USB, VGA\r\nKiểu kết nối:     Không dây\r\nKích thước (dài x rộng x cao):     27*32*51\r\nGửi từ:     Hải Dương', '2024-09-05', 1),
(15, 'Loa bluetooth K12 Không Dây mini', 'image-1725519997597.jpg', 250000, 139000, 'Còn hàng', 'Số lượng hàng khuyến mãi:     84\r\nSố sản phẩm còn lại:     899330\r\nThương hiệu:     2Good\r\nHạn bảo hành:     6 tháng\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nChức năng bluetooth:     Có\r\nKiểu kết nối:     Không dây\r\nGửi từ:     Hà Nội', '2024-09-05', 1),
(16, 'Bộ Loa Máy Tính KAW/SADA D202', 'image-1725520132223.jpg', 440000, 223000, 'Còn hàng', 'Số lượng hàng khuyến mãi:     10\r\nSố sản phẩm còn lại:     132\r\nThương hiệu:     KAW\r\nThiết bị âm thanh tương thích:     PC & Laptop\r\nTần số tối đa:     20000Hz\r\nTần số tối thiểu:     45Hz\r\nHạn bảo hành:     2 tháng\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nKết nối đầu vào:     USB\r\nKiểu kết nối:     Có dây', '2024-09-05', 1),
(17, 'Loa Bluetooth Karaoke SK2036 HTH TECHNOLOGICAL', 'image-1725520274858.jpg', 1200000, 805000, 'Còn hàng', 'Số lượng hàng khuyến mãi:     120\r\nSố sản phẩm còn lại:     3555225\r\nThương hiệu:     HTH TECHNOLOGICAL\r\nHạn bảo hành:     6 tháng\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nChức năng bluetooth:     Có\r\nKiểu kết nối:     Không dây\r\nCông suất:     40\r\nKích thước (dài x rộng x cao):     323x196x299\r\nTên tổ chức chịu trách nhiệm sản xuất:     dg.luxury\r\nĐịa chỉ tổ chức chịu trách nhiệm sản xuất:     Hà Nội\r\nGửi từ:     Hà Nội', '2024-09-05', 1),
(18, 'Điện thoại Samsung Galaxy S24 Ultra', 'image-1725520463267.jpg', 33990000, 29490000, 'Còn hàng', 'Kho:     170\r\nBộ nhớ:     256GB\r\nRam:     12GB\r\nThương hiệu:     SAMSUNG\r\nGửi từ:     Bắc Ninh', '2024-09-05', 2),
(19, 'Điện thoại Apple iPhone 15 Pro', 'image-1725520564085.jpg', 28999000, 26090000, 'Còn hàng', 'Kho:     298\r\nBộ nhớ:     128GB\r\nThương hiệu:     Apple\r\nGửi từ:     TP. Hồ Chí Minh', '2024-09-05', 2),
(20, 'Điện thoại OPPO A58', 'image-1725520693747.jpg', 5490000, 5440000, 'Còn hàng', 'Kho:     87\r\nThương hiệu:     OPPO\r\nDung lượng lưu trữ:     128GB\r\nRam:     8GB\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nHạn bảo hành:     12 tháng\r\nDung lượng pin:     5000.0mAh\r\nBộ xử lý:     Helio G85\r\nĐộ phân giải camera chính:     50.0MP\r\nKích thước màn hình:     6.72inches\r\nGửi từ:     TP. Hồ Chí Minh', '2024-09-05', 2),
(21, 'Điện thoại vivo Y17s', 'image-1725520821779.jpg', 3990000, 3790000, 'Còn hàng', 'Kho:     20\r\nThương hiệu:     Vivo\r\nDung lượng lưu trữ:     128GB\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nHạn bảo hành:     12 tháng\r\nRAM:     4GB\r\nSố khe cắm sim:     2\r\nSố camera chính:     2\r\nTính năng điện thoại:     Màn hình cảm ứng, chống nước, Wifi\r\nLoại điện thoại:     Điện thoại thông minh\r\nHỗ trợ hệ điều hành:     Android\r\nLoại cáp điện thoại:     Type C\r\nBộ xử lý:     Media Tek Helio G85\r\nĐộ phân giải camera chính:     50MP\r\nTình trạng:     Mới\r\nDung lượng pin:     5000mAh\r\nKích thước màn hình:     6.51inches\r\nGửi từ:     TP. Hồ Chí Minh', '2024-09-05', 2),
(22, 'Điện Thoại Xiaomi Redmi Note 13 Pro', 'image-1725520936404.jpg', 6990000, 5759000, 'Còn hàng', 'Kho:     81\r\nThương hiệu:     Xiaomi\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nBộ nhớ:     256GB\r\nRAM:     8GB\r\nDung lượng pin:     5100mAh\r\nBộ xử lý:     Snapdragon 7s Gen 2\r\nKích thước màn hình:     6.67inches\r\nGửi từ:     Nghệ An', '2024-09-05', 2),
(23, 'Điện Thoại Sony Xperia 10 V', 'image-1725521101614.jpg', 11990000, 0, 'Còn hàng', 'Kho:     8\r\nThương hiệu:     sony\r\nLoại bảo hành:     Bảo hành nhà cung cấp\r\nHạn bảo hành:     12 tháng', '2024-09-05', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
