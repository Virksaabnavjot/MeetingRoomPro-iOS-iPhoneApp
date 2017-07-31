-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 31, 2017 at 12:13 AM
-- Server version: 10.1.20-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id2294984_navsingh_mrpro`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `roomID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `startDate` int(11) NOT NULL,
  `endDate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `title`, `roomID`, `userID`, `startDate`, `endDate`) VALUES
(1, 'title', 14, 4, 1501383300, 1501394100),
(2, 'book 2', 14, 4, 1501603930, 1501607530),
(3, 'book 2', 14, 4, 1501603930, 1501607530),
(4, 'book 2', 14, 4, 1501603930, 1501607530),
(5, 'book 2', 14, 4, 1501603930, 1501607530),
(6, 'book 2', 14, 4, 1501607590, 1501607830),
(7, 'My meeting 1', 6, 5, 1501605487, 1501605607);

-- --------------------------------------------------------

--
-- Table structure for table `booking_invitations`
--

CREATE TABLE `booking_invitations` (
  `id` int(11) NOT NULL,
  `bookingID` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `booking_invitations`
--

INSERT INTO `booking_invitations` (`id`, `bookingID`, `userID`) VALUES
(0, 1, 1),
(0, 2, 1),
(0, 2, 2),
(0, 2, 3),
(0, 3, 1),
(0, 3, 2),
(0, 3, 3),
(0, 4, 1),
(0, 4, 2),
(0, 4, 3),
(0, 5, 1),
(0, 5, 2),
(0, 5, 3),
(0, 6, 1),
(0, 6, 2),
(0, 6, 3),
(0, 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `buildings`
--

CREATE TABLE `buildings` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `city` text NOT NULL,
  `country` text NOT NULL,
  `floors` varchar(10) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(40) NOT NULL,
  `email` varchar(30) NOT NULL,
  `coordinates` polygon NOT NULL,
  `location` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `buildings`
--

INSERT INTO `buildings` (`id`, `name`, `city`, `country`, `floors`, `address`, `phone`, `email`, `coordinates`, `location`) VALUES
(2, 'National College of Ireland', 'Dublin', 'Ireland', '4', 'Mayor Street, IFSC, Dublin 1, D01 Y300', '+353892110549', 'virksaabnavjot@gmail.com', '\0\0\0\0\0\0\0\0\0\0\r\0\0\0LS8��J@1�䠴��]���J@�C����ht��J@�JZ�\r��N��1��J@X��\Z���{eު�J@�����1�����J@y<-?p��������J@øDk����m���J@h˹W��Z�����J@F#�W<��@ٔ+��J@�O����t��z��J@�~�~���������J@���ڴ�LS8��J@1�䠴�', '53.34888 -6.2435, 53.34875 -6.24351, 53.34853 -6.24352, 53.34853 -6.2435, 53.34851 -6.2435, 53.3485 -6.24327, 53.34854 -6.24326, 53.34853 -6.24312, 53.34847 -6.24312, 53.34844 -6.24266, 53.34843 -6.24243, 53.34844 -6.24243, 53.34843 -6.24231, 53.34844 -6.24231, 53.34843 -6.24221, 53.34848 -6.2422, 53.34847 -6.24216, 53.34896 -6.24208, 53.34897 -6.24216, 53.34899 -6.24217, 53.34898 -6.24204, 53.34906 -6.24202, 53.34906 -6.24204, 53.34909 -6.24203, 53.34912 -6.24243, 53.34916 -6.24304, 53.34889 -6.2431, 53.34891 -6.24336, 53.34889 -6.24337, 53.3489 -6.24346, 53.34888 -6.24346, 53.34888 -6.2435'),
(3, 'NCI', 'Dublin', 'Ireland', '3', 'Mayor Street, IFSC, Dublin 1, D01 Y300', '+353892110549', 'virksaabnavjot@gmail.com', '\0\0\0\0\0\0\0\0\0\0\r\0\0\0LS8��J@1�䠴��]���J@�C����ht��J@�JZ�\r��N��1��J@X��\Z���{eު�J@�����1�����J@y<-?p��������J@øDk����m���J@h˹W��Z�����J@F#�W<��@ٔ+��J@�O����t��z��J@�~�~���������J@���ڴ�LS8��J@1�䠴�', '53.34888 -6.2435, 53.34875 -6.24351, 53.34853 -6.24352, 53.34853 -6.2435, 53.34851 -6.2435, 53.3485 -6.24327, 53.34854 -6.24326, 53.34853 -6.24312, 53.34883 -6.24311, 53.34889 -6.2431, 53.34891 -6.24336, 53.34889 -6.24337, 53.3489 -6.24346, 53.34888 -6.24346, 53.34888 -6.2435'),
(4, 'St. James', 'Dublin', 'Ireland', '4', 'James\'s St, Ushers, Dublin 8, D08 NHY1', '+353892110549', 'virksaabnavjot@gmail.com', '\0\0\0\0\0\0\0\0\0\0\r\0\0\0LS8��J@1�䠴��]���J@�C����ht��J@�JZ�\r��N��1��J@X��\Z���{eު�J@�����1�����J@y<-?p��������J@øDk����m���J@h˹W��Z�����J@F#�W<��@ٔ+��J@�O����t��z��J@�~�~���������J@���ڴ�LS8��J@1�䠴�', '53.33975 -6.29497, 53.33974 -6.29489, 53.33979 -6.29474, 53.33983 -6.29449, 53.33995 -6.29398, 53.33976 -6.29387, 53.3397 -6.29409, 53.33979 -6.29415, 53.33975 -6.2943, 53.33967 -6.29428, 53.33962 -6.29444, 53.33971 -6.29453, 53.33963 -6.29483, 53.3396 -6.29506, 53.33958 -6.29524, 53.33933 -6.29506, 53.33956 -6.29502, 53.33959 -6.29482, 53.33939 -6.29466, 53.33942 -6.29451, 53.33938 -6.29444, 53.33939 -6.29436, 53.33958 -6.29448, 53.33962 -6.29425, 53.33945 -6.29412, 53.33946 -6.294, 53.3393 -6.29392, 53.33917 -6.29455, 53.33928 -6.29465, 53.33921 -6.2951, 53.33899 -6.29601, 53.33895 -6.29594, 53.33875 -6.29582, 53.33876 -6.29572, 53.33842 -6.29556, 53.33837 -6.29581, 53.33869 -6.29602, 53.33858 -6.2965, 53.33839 -6.29641, 53.33821 -6.29721, 53.3383 -6.29739, 53.33823 -6.29757, 53.3383 -6.29766, 53.33828 -6.29771, 53.33842 -6.29789, 53.33845 -6.29784, 53.33854 -6.29794, 53.33851 -6.298, 53.33867 -6.29817, 53.33868 -6.29807, 53.33928 -6.29871, 53.33913 -6.29862, 53.33907 -6.2987, 53.339'),
(5, 'National College of Dublin', 'Dublin', 'Ireland', '4', '24-34 Henrietta Hall, Mayor Street, Dublin 22, Ireland', '+353892110549', 'virksaabnavjot@gmail.com', '\0\0\0\0\0\0\0\0\0\0\r\0\0\0LS8��J@1�䠴��]���J@�C����ht��J@�JZ�\r��N��1��J@X��\Z���{eު�J@�����1�����J@y<-?p��������J@øDk����m���J@h˹W��Z�����J@F#�W<��@ٔ+��J@�O����t��z��J@�~�~���������J@���ڴ�LS8��J@1�䠴�', '53.294837 -6.426395, 53.294651 -6.426652, 53.294465 -6.426811, 53.294348 -6.426859 , 53.294277 -6.426878 , 53.294311 -6.427186  , 53.294420 -6.427167 , 53.294555 -6.427090,  53.294697 -6.426988, 53.294805 -6.426872 , 53.294906 -6.426733, 53.294970 -6.426615, 53.294837 -6.426395'),
(6, 'DIT', 'Dublin', 'Ireland', '4', 'DIT, Kings Inn Street, Dublin 22, Ireland', '+353892110549', 'virksaabnavjot@gmail.com', '\0\0\0\0\0\0\0\0\0\0\r\0\0\0LS8��J@1�䠴��]���J@�C����ht��J@�JZ�\r��N��1��J@X��\Z���{eު�J@�����1�����J@y<-?p��������J@øDk����m���J@h˹W��Z�����J@F#�W<��@ٔ+��J@�O����t��z��J@�~�~���������J@���ڴ�LS8��J@1�䠴�', '53.294837 -6.426395, 53.294651 -6.426652, 53.294465 -6.426811, 53.294348 -6.426859 , 53.294277 -6.426878 , 53.294311 -6.427186  , 53.294420 -6.427167 , 53.294555 -6.427090,  53.294697 -6.426988, 53.294805 -6.426872 , 53.294906 -6.426733, 53.294970 -6.426615, 53.294837 -6.426395'),
(7, 'SV Fitness', 'Dublin', 'Ireland', '4', '24-34 Henrietta Hall, Kings Inn Street, Dublin 22, Ireland', '+353892110549', 'virksaabnavjot@gmail.com', '\0\0\0\0\0\0\0\0\0\0\r\0\0\0LS8��J@1�䠴��]���J@�C����ht��J@�JZ�\r��N��1��J@X��\Z���{eު�J@�����1�����J@y<-?p��������J@øDk����m���J@h˹W��Z�����J@F#�W<��@ٔ+��J@�O����t��z��J@�~�~���������J@���ڴ�LS8��J@1�䠴�', '53.294837 -6.426395, 53.294651 -6.426652, 53.294465 -6.426811, 53.294348 -6.426859 , 53.294277 -6.426878 , 53.294311 -6.427186  , 53.294420 -6.427167 , 53.294555 -6.427090,  53.294697 -6.426988, 53.294805 -6.426872 , 53.294906 -6.426733, 53.294970 -6.426615, 53.294837 -6.426395');

-- --------------------------------------------------------

--
-- Table structure for table `mrp_companies`
--

CREATE TABLE `mrp_companies` (
  `companyId` int(120) NOT NULL,
  `name` varchar(240) COLLATE utf8_unicode_ci NOT NULL,
  `headquarters` varchar(480) COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `ceo` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `industry` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `tagline` varchar(120) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `mrp_companies`
--

INSERT INTO `mrp_companies` (`companyId`, `name`, `headquarters`, `website`, `email`, `ceo`, `industry`, `tagline`) VALUES
(1, 'National College of Ireland', 'Mayor Street, IFSC, Dublin 1,\r\n    D01 Y300, Ireland, Europe', 'https://ncirl.ie', 'contact@ncirl.ie', 'Gina Quin (President)', 'Education', 'NCI - Changing Lives through Education');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `roomId` int(120) NOT NULL,
  `buildingId` int(120) NOT NULL,
  `name` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `floorNumber` int(120) NOT NULL,
  `coordinates` point NOT NULL,
  `capacity` int(120) NOT NULL,
  `type` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `directions` varchar(480) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(1000) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`roomId`, `buildingId`, `name`, `floorNumber`, `coordinates`, `capacity`, `type`, `phone`, `email`, `directions`, `location`) VALUES
(6, 2, 'SCR1 Boyne', 1, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(7, 2, 'Fionna', 2, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at second floor right wing of the building', '53.294846 -6.426421'),
(8, 2, 'Chicku Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'I am chick room. This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(9, 2, 'oyne', 4, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Conference Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at forth floor right wing of the building', '53.294846 -6.426421'),
(10, 2, 'SCR3', 3, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Study Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at third floor right wing of the building', '53.294846 -6.426421'),
(11, 2, 'Protein Room', 2, '\0\0\0\0\0\0\0������J@{O崧��', 52, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(12, 2, 'Balle Boyne', 1, '\0\0\0\0\0\0\0������J@{O崧��', 34, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(13, 2, 'Babbu Mann Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(14, 3, 'Car Loyne', 4, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Conference Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at forth floor right wing of the building', '53.294846 -6.426421'),
(15, 3, 'SCR45', 3, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Study Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at third floor right wing of the building', '53.294846 -6.426421'),
(16, 3, 'Shaker Room', 2, '\0\0\0\0\0\0\0������J@{O崧��', 52, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(17, 3, 'Nasibo Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 34, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(18, 3, 'Garry Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(19, 3, 'Chi Loyne', 4, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Conference Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at forth floor right wing of the building', '53.294846 -6.426421'),
(20, 3, 'Enable Room', 3, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Study Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at third floor right wing of the building', '53.294846 -6.426421'),
(21, 3, 'Milk Room', 2, '\0\0\0\0\0\0\0������J@{O崧��', 52, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(22, 3, 'Sony Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 34, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(23, 3, 'Iphone Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(24, 4, 'Jashan', 4, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Conference Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at forth floor right wing of the building', '53.294846 -6.426421'),
(25, 4, 'Kittu', 3, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Study Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at third floor right wing of the building', '53.294846 -6.426421'),
(26, 4, 'Harman Room', 2, '\0\0\0\0\0\0\0������J@{O崧��', 52, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(27, 4, 'Singh Saab Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 34, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(28, 4, 'Garry Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(29, 4, 'Chi Loyne', 4, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Conference Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at forth floor right wing of the building', '53.294846 -6.426421'),
(30, 4, 'Enable Room', 3, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Study Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at third floor right wing of the building', '53.294846 -6.426421'),
(31, 4, 'Milk Room', 2, '\0\0\0\0\0\0\0������J@{O崧��', 52, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(32, 4, 'Sony Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 34, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(33, 4, 'Iphone Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 22, 'Meeting Room', '+353892110549', 'nvirk@navsingh.org.uk', 'This meeting room is located at first floor right wing of the building', '53.294846 -6.426421'),
(34, 5, 'Hello Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 3, 'Library', '+353892110549', 'virksaabnavjot@gmail.com', 'When you enter the building walk straight for 200 meters and turn left.The room is just 20 meters from there.', '53.294846 -6.426421'),
(35, 5, 'Hello Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 3, 'Library', '+353892110549', 'virksaabnavjot@gmail.com', 'When you enter the building walk straight for 200 meters and turn left.The room is just 20 meters from there.', '53.294846 -6.426421'),
(36, 6, 'Lounge Room', 1, '\0\0\0\0\0\0\0������J@{O崧��', 3, 'Lounge Room', '+353892110549', 'virksaabnavjot@gmail.com', 'When you enter the building walk straight for 200 meters and turn left.The room is just 20 meters from there.', '53.294846 -6.426421'),
(37, 7, 'Gym', 1, '\0\0\0\0\0\0\0������J@{O崧��', 3, 'Weights Area', '+353892110549', 'virksaabnavjot@gmail.com', 'When you enter the building walk straight for 200 meters and turn left.The room is just 20 meters from there.', '53.294846 -6.426421');

-- --------------------------------------------------------

--
-- Table structure for table `room_pictures`
--

CREATE TABLE `room_pictures` (
  `id` int(11) NOT NULL,
  `roomID` int(11) NOT NULL,
  `url` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `room_pictures`
--

INSERT INTO `room_pictures` (`id`, `roomID`, `url`) VALUES
(1, 6, 'uploads/d23968404122b53ec7057dcdab176682.jpg'),
(2, 6, 'uploads/f6b5f13bdb4ae27ea71ff474fb3e1f66.jpg'),
(3, 6, 'uploads/94abd2fd5eb3de56022e908f4c5e9078.jpg'),
(4, 6, 'uploads/25f8e13da395c775173525fbdae28a6a.jpg'),
(5, 7, 'uploads/9b465217296d015cb82bb9aa4a2aec59.jpg'),
(6, 6, 'uploads/1d627a46729a2ed624e8a2e86345c378.jpg'),
(7, 6, 'uploads/371b85e02dd1f0968df046ba3e9c48c3.jpg'),
(8, 6, 'uploads/3fa00e481a6c6f8eabb2cb0b23f7dcf5.jpg'),
(9, 24, 'uploads/5a635ca7bd4be068d83b81d106a816bc.jpg'),
(10, 6, 'uploads/5100099f1f64b98e9beb6d0845bd2cf1.jpg'),
(11, 6, 'uploads/e12e6f9983f9a044fc5ef88d9c63b0c8.jpg'),
(12, 6, 'uploads/8ec0411c29893fef3af04fb91b5824f5.jpg'),
(13, 6, 'uploads/a0783ba0c1dcd37f3ecbf0ab57c213bd.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `room_reviews`
--

CREATE TABLE `room_reviews` (
  `id` int(11) NOT NULL,
  `roomID` int(11) NOT NULL,
  `review` text COLLATE utf8_unicode_ci NOT NULL,
  `rating` float NOT NULL,
  `userID` int(11) NOT NULL,
  `userName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `room_reviews`
--

INSERT INTO `room_reviews` (`id`, `roomID`, `review`, `rating`, `userID`, `userName`, `time`) VALUES
(1, 6, 'fine room', 5, 1, 'first user', '2017-07-26 19:40:34'),
(2, 6, 'This is great.', 3.38, 4, 'Test', '2017-07-27 21:41:31'),
(3, 6, 'The meeting room is absolutely stunning ', 4.73, 5, 'Navjot Singh', '2017-07-28 23:29:29'),
(4, 7, 'Nice room', 3.51, 4, 'Test', '2017-07-29 11:22:52'),
(5, 10, 'First rating', 3.26667, 4, 'Test', '2017-07-29 13:03:53'),
(6, 6, 'Next', 3.4, 4, 'Test', '2017-07-29 13:04:20'),
(7, 6, 'The room is good', 3.725, 5, 'Navjot Singh', '2017-07-30 16:39:05'),
(8, 6, 'nice room', 4.325, 5, 'Navjot Singh', '2017-07-30 16:41:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `picture` text NOT NULL,
  `deviceToken` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `picture`, `deviceToken`, `password`) VALUES
(1, 'John Doe', 'john@mrpro.com', '+353892110542', 'uploads/80e0d91a74f1b433235a81726d893a40.jpg', '123', '123456'),
(2, 'Navjot Virk', 'navjot@mrpro.com', '+35389211086', 'uploads/45a4350c7541525b4b4cfc9386ed047b.jpg', 'SIMULATOR', '123456'),
(3, 'Eamon', 'eamon@mrpro.com', '+353892110378', 'uploads/60eb27b3639320cb2616af072a0f38e9.jpg', 'SIMULATOR', '123456'),
(4, 'Cristina', 'cristina@mrpro.com', '+35378234590', '', 'SIMULATOR', '123'),
(5, 'Navjot Singh', 'navjot@mrpro.com ', '+353892110549', '', 'SIMULATOR', 'password'),
(6, 'Nav', 'nav@nav.com', '+353892110548', '', 'SIMULATOR', 'password');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mrp_companies`
--
ALTER TABLE `mrp_companies`
  ADD PRIMARY KEY (`companyId`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`roomId`);

--
-- Indexes for table `room_pictures`
--
ALTER TABLE `room_pictures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_reviews`
--
ALTER TABLE `room_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `buildings`
--
ALTER TABLE `buildings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `roomId` int(120) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `room_pictures`
--
ALTER TABLE `room_pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `room_reviews`
--
ALTER TABLE `room_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
