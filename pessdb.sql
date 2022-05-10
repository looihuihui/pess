-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 10, 2022 at 02:42 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pessdb`
--
CREATE DATABASE IF NOT EXISTS `pessdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pessdb`;

-- --------------------------------------------------------

--
-- Table structure for table `dispatch`
--

CREATE TABLE `dispatch` (
  `incident_id` int(11) NOT NULL,
  `patrolcar_id` varchar(10) NOT NULL,
  `time_dispatched` datetime NOT NULL,
  `time_arrived` datetime DEFAULT NULL,
  `time_completed` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `dispatch`
--

INSERT INTO `dispatch` (`incident_id`, `patrolcar_id`, `time_dispatched`, `time_arrived`, `time_completed`) VALUES
(12, 'QX2222G', '2014-05-29 10:51:15', NULL, '2014-05-29 10:53:43'),
(13, 'QX2222G', '2014-05-29 10:59:42', NULL, NULL),
(14, 'QX4444P', '2014-05-29 11:10:57', NULL, '2022-05-10 20:34:40'),
(20, 'QX1234', '2022-05-05 13:25:01', NULL, '2022-05-06 10:38:16'),
(21, 'QX4321R', '2022-05-05 13:27:20', NULL, '2022-05-10 20:34:27'),
(22, 'QX1234', '2022-05-05 13:54:32', NULL, '2022-05-06 10:38:16'),
(23, 'QX4321R', '2022-05-05 13:54:40', NULL, '2022-05-10 20:34:27'),
(27, 'QX1234', '2022-05-08 13:33:58', NULL, '2022-05-08 13:35:07'),
(28, 'QX1234', '2022-05-08 14:30:24', NULL, '2022-05-08 21:58:12'),
(30, 'QX1234', '2022-05-08 22:17:30', NULL, '2022-05-08 22:17:35'),
(32, 'QX1234', '2022-05-10 20:27:18', NULL, '2022-05-10 20:33:35'),
(33, 'QX1234', '2022-05-10 20:36:34', NULL, '2022-05-10 20:37:16');

-- --------------------------------------------------------

--
-- Table structure for table `incident`
--

CREATE TABLE `incident` (
  `incident_id` int(11) NOT NULL,
  `caller_name` varchar(30) NOT NULL,
  `phone_number` varchar(10) NOT NULL,
  `incident_type_id` varchar(3) NOT NULL,
  `incident_location` varchar(50) NOT NULL,
  `incident_desc` varchar(100) NOT NULL,
  `incident_status_id` varchar(1) NOT NULL,
  `time_called` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `incident`
--

INSERT INTO `incident` (`incident_id`, `caller_name`, `phone_number`, `incident_type_id`, `incident_location`, `incident_desc`, `incident_status_id`, `time_called`) VALUES
(6, 'PETER LEOW', '81234567', '010', 'Junction of North Bridge Rd and Middle Rd', 'A bus collided with a Taxi. 2 injuries', '1', '2022-04-21 05:58:48'),
(8, 'qwerty', '12345678', '030', 'cck', 'qwerty', '3', '2022-04-21 05:58:48'),
(22, 'Hayley', '81234567', '010', 'cck', 'swdSXZ', '2', '2022-05-05 05:54:32'),
(23, 'dsa', '12345678', '010', 'SAC', 'CASCSA', '3', '2022-05-05 05:54:40'),
(24, 'Hayley', '81234567', '010', 'dsa', 'czx', '1', '2022-05-05 06:17:18'),
(25, 'Hayley', '81234567', '010', 'dsa', 'dsv', '1', '2022-05-05 11:16:30'),
(26, 'Hayley', '81234567', '010', 'cck', '', '1', '2022-05-05 11:21:18'),
(27, 'hui', '81234567', '010', 'cckvefsdv', 'bn', '2', '2022-05-08 05:33:58'),
(28, 'Hayley', '81234567', '010', 'dvsc', 'vdcx', '2', '2022-05-08 06:30:24'),
(29, 'Hayley', '81234567', '010', 'cck', 'sca', '1', '2022-05-08 14:03:03'),
(30, 'Hayley', '81234567', '010', 'cck', 'vsd', '2', '2022-05-08 14:17:30'),
(31, 'Hayley', '81234567', '010', 'cckedew', 'fwed', '1', '2022-05-09 04:47:14'),
(32, 'Hayley', '12345678', '010', 'vfd', 'vfd', '3', '2022-05-10 12:27:18'),
(33, 'Hui Hui', '90001234', '050', 'Jurong', 'Tree drop on car.', '3', '2022-05-10 12:36:34');

-- --------------------------------------------------------

--
-- Table structure for table `incident_status`
--

CREATE TABLE `incident_status` (
  `incident_status_id` varchar(1) NOT NULL,
  `incident_status_desc` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `incident_status`
--

INSERT INTO `incident_status` (`incident_status_id`, `incident_status_desc`) VALUES
('1', 'Pending'),
('2', 'Dispatched'),
('3', 'Completed'),
('4', 'Duplicate');

-- --------------------------------------------------------

--
-- Table structure for table `incident_type`
--

CREATE TABLE `incident_type` (
  `incident_type_id` varchar(3) NOT NULL,
  `incident_type_desc` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `incident_type`
--

INSERT INTO `incident_type` (`incident_type_id`, `incident_type_desc`) VALUES
('010', 'Fire'),
('020', 'Riot'),
('030', 'Burglary'),
('040', 'Domestic Violent'),
('050', 'Fallen Tree'),
('060', 'Traffic Acciident'),
('070', 'Loan Shark'),
('999', 'Others');

-- --------------------------------------------------------

--
-- Table structure for table `patrolcar`
--

CREATE TABLE `patrolcar` (
  `patrolcar_id` varchar(10) NOT NULL,
  `patrolcar_status_id` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patrolcar`
--

INSERT INTO `patrolcar` (`patrolcar_id`, `patrolcar_status_id`) VALUES
('QX1234', '3'),
('QX4321R', '3'),
('QX4444P', '3'),
('QX45545', '1'),
('QX9999H', '1');

-- --------------------------------------------------------

--
-- Table structure for table `patrolcar_status`
--

CREATE TABLE `patrolcar_status` (
  `patrolcar_status_id` varchar(1) NOT NULL,
  `patrolcar_status_desc` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patrolcar_status`
--

INSERT INTO `patrolcar_status` (`patrolcar_status_id`, `patrolcar_status_desc`) VALUES
('1', 'Dispatched'),
('2', 'Patrol'),
('3', 'Free'),
('4', 'On-site'),
('5', 'NA');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dispatch`
--
ALTER TABLE `dispatch`
  ADD PRIMARY KEY (`incident_id`,`patrolcar_id`);

--
-- Indexes for table `incident`
--
ALTER TABLE `incident`
  ADD PRIMARY KEY (`incident_id`);

--
-- Indexes for table `incident_status`
--
ALTER TABLE `incident_status`
  ADD PRIMARY KEY (`incident_status_id`);

--
-- Indexes for table `incident_type`
--
ALTER TABLE `incident_type`
  ADD PRIMARY KEY (`incident_type_id`);

--
-- Indexes for table `patrolcar`
--
ALTER TABLE `patrolcar`
  ADD PRIMARY KEY (`patrolcar_id`);

--
-- Indexes for table `patrolcar_status`
--
ALTER TABLE `patrolcar_status`
  ADD PRIMARY KEY (`patrolcar_status_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `incident`
--
ALTER TABLE `incident`
  MODIFY `incident_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
