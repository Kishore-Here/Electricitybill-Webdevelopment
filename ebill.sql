-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2020 at 04:58 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ebill`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `unitstoamount` (IN `units` INT(14), OUT `result` INT(14))  BEGIN
   
    DECLARE a INT(14) DEFAULT 0;
    DECLARE b INT(14) DEFAULT 0;
    DECLARE c INT(14) DEFAULT 0;

    SELECT twohundred FROM unitsRate INTO a ;
    SELECT fivehundred FROM unitsRate INTO b ;
    SELECT thousand FROM unitsRate INTO c  ;

    IF units<200
    then
        SELECT a*units INTO result;
    
    ELSEIF units<500
    then
        SELECT (a*200)+(b*(units-200)) INTO result;
    ELSEIF units > 500
    then
        SELECT (a*200)+(b*(300))+(c*(units-500)) INTO result;
    END IF;

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `curdate1` () RETURNS INT(11) BEGIN
    DECLARE x INT;
    SET x = DAYOFMONTH(CURDATE());
    IF (x=1)
    THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(14) NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `pass` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `pass`) VALUES
(1, 'amrutha', 'amrutha@gmail.com', 'amrutha123'),
(2, 'keerthana', 'keerthana@gmail.com', 'keerthana');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `id` int(14) NOT NULL,
  `aid` int(14) NOT NULL,
  `uid` int(14) NOT NULL,
  `units` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(10) NOT NULL,
  `bdate` date NOT NULL,
  `ddate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`id`, `aid`, `uid`, `units`, `amount`, `status`, `bdate`, `ddate`) VALUES
(1, 1, 2, 12, '24.00', 'PROCESSED', '2014-12-01', '2014-12-31'),
(2, 1, 1, 200, '400.00', 'PROCESSED', '2014-09-01', '2014-10-01'),
(3, 1, 2, 103, '206.00', 'PROCESSED', '2014-09-01', '2014-10-01'),
(4, 1, 3, 453, '1665.00', 'PROCESSED', '2014-09-01', '2014-10-01'),
(5, 1, 4, 654, '3440.00', 'PROCESSED', '2014-09-01', '2014-10-01'),
(6, 1, 5, 609, '2990.00', 'PROCESSED', '2014-09-01', '2014-10-01'),
(7, 1, 1, 435, '1575.00', 'PROCESSED', '2014-10-01', '2014-10-31'),
(8, 1, 3, 986, '6760.00', 'PROCESSED', '2014-10-01', '2014-10-31'),
(9, 1, 4, 657, '3470.00', 'PROCESSED', '2014-10-01', '2014-10-31'),
(10, 1, 2, 546, '2360.00', 'PROCESSED', '2014-10-01', '2014-10-31'),
(11, 1, 5, 699, '3890.00', 'PROCESSED', '2014-10-01', '2014-10-31'),
(12, 1, 1, 643, '3330.00', 'PROCESSED', '2014-11-01', '2014-12-01'),
(13, 1, 2, 781, '4710.00', 'PROCESSED', '2014-11-01', '2014-12-01'),
(14, 1, 3, 434, '1570.00', 'PROCESSED', '2014-11-01', '2014-12-01'),
(15, 1, 5, 235, '575.00', 'PROCESSED', '2014-11-01', '2014-12-01'),
(16, 1, 4, 435, '1575.00', 'PROCESSED', '2014-11-01', '2014-12-01');

-- --------------------------------------------------------

--
-- Table structure for table `complaint`
--

CREATE TABLE `complaint` (
  `id` int(14) NOT NULL,
  `uid` int(14) NOT NULL,
  `aid` int(14) NOT NULL,
  `complaint` varchar(140) NOT NULL,
  `status` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `complaint`
--

INSERT INTO `complaint` (`id`, `uid`, `aid`, `complaint`, `status`) VALUES
(1, 1, 1, 'Transaction Not Processed', 'PROCESSED'),
(2, 1, 1, 'Transaction Not Processed', 'PROCESSED'),
(3, 2, 1, 'Previous Complaint Not Processed', 'PROCESSED'),
(4, 2, 1, 'Transaction Not Processed', 'PROCESSED'),
(5, 2, 2, 'Transaction Not Processed', 'PROCESSED'),
(6, 1, 1, 'Bill Not Correct', 'PROCESSED'),
(7, 3, 1, 'Bill Not Correct', 'PROCESSED'),
(8, 3, 2, 'Transaction Not Processed', 'PROCESSED'),
(9, 4, 2, 'Transaction Not Processed', 'PROCESSED'),
(10, 4, 1, 'Bill Not Correct', 'PROCESSED'),
(11, 5, 2, 'Bill Generated Late', 'PROCESSED'),
(12, 1, 1, 'Bill Not Correct', 'PROCESSED');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(14) NOT NULL,
  `bid` int(14) NOT NULL,
  `payable` decimal(10,2) NOT NULL,
  `pdate` date DEFAULT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `bid`, `payable`, `pdate`, `status`) VALUES
(1, 1, '1024.00', '2015-01-06', 'PROCESSED'),
(2, 2, '1400.00', '2014-10-10', 'PROCESSED'),
(3, 3, '1206.00', '2014-10-10', 'PROCESSED'),
(4, 4, '2665.00', '2014-10-10', 'PROCESSED'),
(5, 5, '4440.00', '2014-10-10', 'PROCESSED'),
(6, 6, '3990.00', '2014-10-10', 'PROCESSED'),
(7, 7, '1575.00', '2014-09-26', 'PROCESSED'),
(8, 8, '6760.00', '2014-10-10', 'PROCESSED'),
(9, 9, '3470.00', '2014-10-10', 'PROCESSED'),
(10, 10, '2360.00', '2014-10-10', 'PROCESSED'),
(11, 11, '3890.00', '2014-10-10', 'PROCESSED'),
(12, 12, '3330.00', '2014-09-18', 'PROCESSED'),
(13, 13, '4710.00', '2014-09-18', 'PROCESSED'),
(14, 14, '1570.00', '2014-09-26', 'PROCESSED'),
(15, 15, '575.00', '2014-09-18', 'PROCESSED'),
(16, 16, '1575.00', '2014-09-26', 'PROCESSED');

-- --------------------------------------------------------

--
-- Table structure for table `unitsrate`
--

CREATE TABLE `unitsrate` (
  `sno` int(1) DEFAULT NULL,
  `twohundred` int(14) NOT NULL,
  `fivehundred` int(14) NOT NULL,
  `thousand` int(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unitsrate`
--

INSERT INTO `unitsrate` (`sno`, `twohundred`, `fivehundred`, `thousand`) VALUES
(1, 2, 5, 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(14) NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` int(14) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `phone`, `pass`, `address`) VALUES
(1, 'Sangeetha', 'sangeetha@gmail.com', 894321367, 'sangeetha', 'kengeri'),
(2, 'Abhishek ', 'abhishek@gmail.com', 89930333, 'abhishek', 'malleshwaram'),
(3, 'Sunena', 'sunena@gmail.com', 807271713, 'sunena', 'kengeri'),
(4, 'Bhumika', 'bhumika@gmail.com', 902133849, 'bhumika', 'jaynagar'),
(5, 'Sharath', 'Sharath@gmail.com', 987644859, 'Sharath', 'jp nagar'),
(6, 'Prema', 'prema@gmail.com', 898333032, 'prema', 'yeshwanthpur'),
(7, 'Sanjana', 'sanjana@gmail.com', 944437321, 'sanjana', 'rajaji nagar');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aid` (`aid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `complaint`
--
ALTER TABLE `complaint`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aid` (`aid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `complaint`
--
ALTER TABLE `complaint`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `complaint`
--
ALTER TABLE `complaint`
  ADD CONSTRAINT `complaint_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `complaint_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `bill` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
