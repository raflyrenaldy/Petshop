-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 29, 2018 at 02:43 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amazing`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `kdbarang` (`nomer` INT) RETURNS VARCHAR(8) CHARSET latin1 BEGIN
DECLARE kodebaru CHAR(8);
DECLARE urut INT;
 
SET urut = IF(nomer IS NULL, 1, nomer + 1);
SET kodebaru = CONCAT("BG", LPAD(urut, 6, 0));
 
RETURN kodebaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `kdkeuangan` (`nomer` INT) RETURNS VARCHAR(8) CHARSET latin1 BEGIN
DECLARE kodebaru CHAR(8);
DECLARE urut INT;
 
SET urut = IF(nomer IS NULL, 1, nomer + 1);
SET kodebaru = CONCAT("TS", LPAD(urut, 6, 0));
 
RETURN kodebaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `kdpegawai` (`nomer` INT) RETURNS VARCHAR(8) CHARSET latin1 BEGIN
DECLARE kodebaru CHAR(8);
DECLARE urut INT;
 
SET urut = IF(nomer IS NULL, 1, nomer + 1);
SET kodebaru = CONCAT("PG", LPAD(urut, 6, 0));
 
RETURN kodebaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `kdpembelian` (`nomer` INT) RETURNS VARCHAR(8) CHARSET cp1251 BEGIN
DECLARE kodebaru CHAR(8);
DECLARE urut INT;
 
SET urut = IF(nomer IS NULL, 1, nomer + 1);
SET kodebaru = CONCAT("PB", LPAD(urut, 6, 0));
 
RETURN kodebaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `kdpenjualan` (`nomer` INT) RETURNS VARCHAR(8) CHARSET latin1 BEGIN
DECLARE kodebaru CHAR(8);
DECLARE urut INT;
 
SET urut = IF(nomer IS NULL, 1, nomer + 1);
SET kodebaru = CONCAT("PJ", LPAD(urut, 6, 0));
 
RETURN kodebaru;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `kode_barang` varchar(255) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `jenis` varchar(255) NOT NULL,
  `harga` int(11) NOT NULL,
  `ukuran` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`kode_barang`, `nama_barang`, `jenis`, `harga`, `ukuran`, `stock`) VALUES
('BG000001', '123', 'Item 2', 2312, '250 gr', 53),
('BG000003', 'Siapa', 'Kucing', 222, '31', 668),
('BG000004', '123', 'Kucing', 555, '123', 35),
('BG000005', 'rOLEX', 'Kucing', 2000, '250 gr', 12);

--
-- Triggers `barang`
--
DELIMITER $$
CREATE TRIGGER `kode` BEFORE INSERT ON `barang` FOR EACH ROW BEGIN
DECLARE s VARCHAR(8);
DECLARE i INTEGER;
 
SET i = (SELECT SUBSTRING(kode_barang,3,6) AS Nomer
FROM barang ORDER BY kode_barang DESC LIMIT 1);
 
SET s = (SELECT kdbarang(i));
 
IF(NEW.kode_barang IS NULL OR NEW.kode_barang = '')
 THEN SET NEW.kode_barang =s;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `keuangan`
--

CREATE TABLE `keuangan` (
  `kode_keuangan` varchar(255) NOT NULL,
  `kode_transaksi` varchar(255) NOT NULL,
  `kode_pegawai` varchar(255) NOT NULL,
  `pemasukkan` int(11) NOT NULL,
  `pengeluaran` int(11) NOT NULL,
  `dates` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `keuangan`
--
DELIMITER $$
CREATE TRIGGER `kode2` BEFORE INSERT ON `keuangan` FOR EACH ROW BEGIN
DECLARE s VARCHAR(8);
DECLARE i INTEGER;
 
SET i = (SELECT SUBSTRING(kode_keuangan,3,6) AS Nomer
FROM keuangan ORDER BY kode_keuangan DESC LIMIT 1);
 
SET s = (SELECT kdkeuangan(i));
 
IF(NEW.kode_keuangan IS NULL OR NEW.kode_keuangan = '')
 THEN SET NEW.kode_keuangan =s;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `kode_pegawai` varchar(255) NOT NULL,
  `nama_pegawai` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `jenis_kelamin` varchar(255) NOT NULL,
  `no_hp` varchar(13) NOT NULL,
  `agama` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`kode_pegawai`, `nama_pegawai`, `alamat`, `jenis_kelamin`, `no_hp`, `agama`) VALUES
('PG000001', 'Rafly Renaldy', 'Jln Golf Raya No.6', 'Pria', '089662867871', 'Islam'),
('PG000002', 'Sendy Hendriawan', 'Jln Cikutra No. 204', 'Pria', '0896522153', 'Islam'),
('PG000003', 'rasd', '123123123123', 'Wanita', '213123', 'Islam');

--
-- Triggers `pegawai`
--
DELIMITER $$
CREATE TRIGGER `kode3` BEFORE INSERT ON `pegawai` FOR EACH ROW BEGIN
DECLARE s VARCHAR(8);
DECLARE i INTEGER;
 
SET i = (SELECT SUBSTRING(kode_pegawai,3,6) AS Nomer
FROM pegawai ORDER BY kode_pegawai DESC LIMIT 1);
 
SET s = (SELECT kdpegawai(i));
 
IF(NEW.kode_pegawai IS NULL OR NEW.kode_pegawai = '')
 THEN SET NEW.kode_pegawai =s;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `kode_pembelian` varchar(255) NOT NULL,
  `kode_pegawai` varchar(255) NOT NULL,
  `kode_barang` varchar(255) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `pembelian`
--
DELIMITER $$
CREATE TRIGGER `kode4` BEFORE INSERT ON `pembelian` FOR EACH ROW BEGIN
DECLARE s VARCHAR(8);
DECLARE i INTEGER;
 
SET i = (SELECT SUBSTRING(kode_pembelian,3,6) AS Nomer
FROM pembelian ORDER BY kode_pembelian DESC LIMIT 1);
 
SET s = (SELECT kdpembelian(i));
 
IF(NEW.kode_pembelian IS NULL OR NEW.kode_pembelian = '')
 THEN SET NEW.kode_pembelian =s;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updt` AFTER INSERT ON `pembelian` FOR EACH ROW BEGIN
	UPDATE barang set stock = stock+new.jumlah
    where kode_barang = new.kode_barang;
        INSERT INTO KEUANGAN (kode_transaksi, kode_pegawai, pengeluaran, dates) values (new.kode_pembelian, new.kode_pegawai, new.total, sysdate());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `kode_penjualan` varchar(255) NOT NULL,
  `kode_pegawai` varchar(255) NOT NULL,
  `kode_barang` varchar(255) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `penjualan`
--
DELIMITER $$
CREATE TRIGGER `kode5` BEFORE INSERT ON `penjualan` FOR EACH ROW BEGIN
DECLARE s VARCHAR(8);
DECLARE i INTEGER;
 
SET i = (SELECT SUBSTRING(kode_penjualan,3,6) AS Nomer
FROM penjualan ORDER BY kode_penjualan DESC LIMIT 1);
 
SET s = (SELECT kdpenjualan(i));
 
IF(NEW.kode_penjualan IS NULL OR NEW.kode_penjualan = '')
 THEN SET NEW.kode_penjualan =s;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pengurangan` AFTER INSERT ON `penjualan` FOR EACH ROW BEGIN
	UPDATE BARANG SET STOCK = STOCK - NEW.JUMLAH
    WHERE KODE_BARANG = NEW.KODE_BARANG;
    INSERT INTO KEUANGAN (kode_transaksi, kode_pegawai, pemasukkan, dates) values (new.kode_penjualan, new.kode_pegawai, new.total, sysdate());
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'beng', 'ibeng@gmail.com', '$2y$10$8E12wp4CCCqpBlLRW0SGruCJm1V1JAnQjDSmPFHQiFfgB7pwkpggG', 'DUb6yBJEP8WKAIuNTnhm3eRtPnhoiX1tSGdGowqjSXjZ3lDWXp8PcGWcTqEQ', '2018-02-12 21:57:50', '2018-02-12 21:57:50'),
(2, 'zzz', 'admin@admin.com', '$2y$10$dGNIr3elId2YwGQMWsHn6.NHf5RuF0mi5ZtXZyboYKuSlutNKbwiq', 'zofkXdSr9hraesGldZbscWbWZNNRW8i3HLsIWtp9DokLpYMPjkkcoYJaB4Wm', '2018-02-13 05:33:29', '2018-02-13 05:33:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kode_barang`);

--
-- Indexes for table `keuangan`
--
ALTER TABLE `keuangan`
  ADD PRIMARY KEY (`kode_keuangan`),
  ADD KEY `kode_pegawai` (`kode_pegawai`),
  ADD KEY `pegawai` (`kode_pegawai`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`kode_pegawai`);

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`kode_pembelian`),
  ADD KEY `kode_barang` (`kode_barang`),
  ADD KEY `kode_pegawai` (`kode_pegawai`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`kode_penjualan`),
  ADD KEY `kode_pegawai` (`kode_pegawai`),
  ADD KEY `kode_barang` (`kode_barang`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `pembelian_ibfk_1` FOREIGN KEY (`kode_pegawai`) REFERENCES `pegawai` (`kode_pegawai`),
  ADD CONSTRAINT `pembelian_ibfk_2` FOREIGN KEY (`kode_barang`) REFERENCES `barang` (`kode_barang`);

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`kode_barang`) REFERENCES `barang` (`kode_barang`),
  ADD CONSTRAINT `penjualan_ibfk_2` FOREIGN KEY (`kode_pegawai`) REFERENCES `pegawai` (`kode_pegawai`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
