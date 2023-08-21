-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost:3306
-- Thời gian đã tạo: Th8 21, 2023 lúc 01:34 PM
-- Phiên bản máy phục vụ: 8.0.33-0ubuntu0.20.04.4
-- Phiên bản PHP: 7.4.3-4ubuntu2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `ngoc_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Attendance`
--

CREATE TABLE `Attendance` (
  `AttendanceID` int NOT NULL,
  `SlotID` int DEFAULT NULL,
  `RFID` varchar(50) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `Attendance`
--

INSERT INTO `Attendance` (`AttendanceID`, `SlotID`, `RFID`, `Status`) VALUES
(1, 3, '13E856FC', 'Attended'),
(2, 3, '331880F5', 'Absent'),
(3, 3, '337466FC', 'Attended'),
(6, 3, 'A3619BFC', 'Absent'),
(7, 3, 'B38489FD', 'Attended'),
(8, 3, 'B3D4D6FC', 'Absent'),
(9, 4, '13E856FC', 'Absent'),
(10, 4, '331880F5', 'Absent'),
(11, 4, '337466FC', 'Absent'),
(14, 4, 'A3619BFC', 'Absent'),
(15, 4, 'B38489FD', 'Attended'),
(16, 4, 'B3D4D6FC', 'Absent'),
(27, 6, '337466FC', 'Absent'),
(30, 6, 'A3619BFC', 'Absent'),
(31, 6, 'B38489FD', 'Attended'),
(46, 8, 'A3619BFC', 'Absent'),
(47, 8, 'B38489FD', 'Attended'),
(48, 8, 'B3D4D6FC', 'Absent'),
(49, 9, '13E856FC', 'Absent'),
(50, 9, '331880F5', 'Absent'),
(51, 9, '337466FC', 'Absent'),
(52, 9, '337C95FC', 'Absent'),
(54, 9, 'A3619BFC', 'Absent'),
(55, 9, 'B38489FD', 'Attended'),
(56, 9, 'B3D4D6FC', 'Absent'),
(73, 12, '13E856FC', 'Attended'),
(74, 12, '331880F5', 'Absent'),
(75, 12, '337466FC', 'Attended'),
(76, 12, '337C95FC', 'Attended'),
(78, 12, 'A3619BFC', 'Attended'),
(79, 12, 'B38489FD', 'Attended'),
(80, 12, 'B3D4D6FC', 'Attended'),
(193, 32, '13E856FC', 'Absent'),
(194, 32, '331880F5', 'Absent'),
(195, 32, '337466FC', 'Absent'),
(196, 32, '337C95FC', 'Absent'),
(197, 32, '538C9DFC', 'Absent'),
(198, 32, 'A3619BFC', 'Absent'),
(199, 32, 'B38489FD', 'Attended'),
(200, 32, 'B3D4D6FC', 'Absent'),
(201, 33, '13E856FC', 'Attended'),
(202, 33, '331880F5', 'Absent'),
(203, 33, '337466FC', 'Attended'),
(204, 33, '337C95FC', 'Attended'),
(205, 33, '538C9DFC', 'Absent'),
(206, 33, 'A3619BFC', 'Absent'),
(207, 33, 'B38489FD', 'Attended'),
(208, 33, 'B3D4D6FC', 'Attended'),
(209, 34, '13E856FC', 'Attended'),
(210, 34, '331880F5', 'Absent'),
(211, 34, '337466FC', 'Attended'),
(212, 34, '337C95FC', 'Attended'),
(213, 34, '538C9DFC', 'Attended'),
(214, 34, 'A3619BFC', 'Attended'),
(215, 34, 'B38489FD', 'Attended'),
(216, 34, 'B3D4D6FC', 'Attended'),
(217, 35, '13E856FC', 'Attended'),
(218, 35, '331880F5', 'Not Yet'),
(219, 35, '337466FC', 'Attended'),
(220, 35, '337C95FC', 'Attended'),
(221, 35, '538C9DFC', 'Attended'),
(222, 35, 'A3619BFC', 'Attended'),
(223, 35, 'B38489FD', 'Attended'),
(224, 35, 'B3D4D6FC', 'Attended'),
(225, 36, '13E856FC', 'Not Yet'),
(226, 36, '331880F5', 'Not Yet'),
(227, 36, '337466FC', 'Not Yet'),
(228, 36, '337C95FC', 'Not Yet'),
(229, 36, '538C9DFC', 'Not Yet'),
(230, 36, 'A3619BFC', 'Not Yet'),
(231, 36, 'B38489FD', 'Not Yet'),
(232, 36, 'B3D4D6FC', 'Not Yet'),
(233, 37, '13E856FC', 'Not Yet'),
(234, 37, '331880F5', 'Not Yet'),
(235, 37, '337466FC', 'Not Yet'),
(236, 37, '337C95FC', 'Not Yet'),
(237, 37, '538C9DFC', 'Not Yet'),
(238, 37, '63795FFC', 'Not Yet'),
(239, 37, 'A3619BFC', 'Not Yet'),
(240, 37, 'B38489FD', 'Not Yet'),
(241, 37, 'B3D4D6FC', 'Not Yet');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Slot`
--

CREATE TABLE `Slot` (
  `SlotID` int NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `TimeIn` datetime DEFAULT NULL,
  `TimeOut` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `Slot`
--

INSERT INTO `Slot` (`SlotID`, `Name`, `TimeIn`, `TimeOut`) VALUES
(3, '1', '2023-08-08 07:30:00', '2023-08-08 09:00:00'),
(4, '2', '2023-08-08 09:10:00', '2023-08-08 10:40:00'),
(6, '3', '2023-08-08 10:50:00', '2023-08-08 12:20:00'),
(8, '4', '2023-08-08 12:50:00', '2023-08-08 14:20:00'),
(9, '5', '2023-08-08 14:30:00', '2023-08-08 16:00:00'),
(12, '6', '2023-08-08 16:10:00', '2023-08-08 17:40:00'),
(32, '8', '2023-08-14 19:30:00', '2023-08-14 21:00:00'),
(33, '1', '2023-08-15 07:30:00', '2023-08-15 09:00:00'),
(34, '2', '2023-08-15 09:10:00', '2023-08-15 10:40:00'),
(35, '3', '2023-08-15 10:50:00', '2023-08-15 12:20:00'),
(36, '4', '2023-08-15 12:50:00', '2023-08-15 14:20:00'),
(37, '6', '2023-08-15 16:10:00', '2023-08-15 17:40:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Student`
--

CREATE TABLE `Student` (
  `RFID` varchar(255) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Student_Code` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Avatar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `Student`
--

INSERT INTO `Student` (`RFID`, `Name`, `Student_Code`, `Email`, `Avatar`) VALUES
('13E856FC', 'Truong Tan Phuc', 'GCD210070', 'phuc@fpt.edu.vn', 'phuc.png'),
('331880F5', 'Ngoc Ngu', 'GCD2100202323', 'ngoctest@gmail.com', 'shiba.jpg'),
('337466FC', 'Nguyen Hai Viet', 'GCD210136', 'viet@fpt.edu.vn', 'ImageHandler.jpg'),
('337C95FC', 'Nguyen Van Thang', 'GCD210184', 'thang@fpt.edu.vn', 'thang.png'),
('538C9DFC', 'Tran Huy Hoang', 'GCD210489', 'hoang@fpt.edu.vn', 'hoang.png'),
('63795FFC', 'Truong Quoc Kiet', 'GCD210125', 'kiet@fpt.edu.vn', 'kiet.png'),
('838FD7FC', 'Nguyen Van Hung', 'GCD210230', 'hung@fpt.edu.vn', 'ImageHandler-3.jpg'),
('93C9AFFC', 'New Student', NULL, NULL, NULL),
('A3619BFC', 'Tra Quang Duy', 'GCD210340', 'duy@fpt.edu.vn', 'duy.png'),
('B38489FD', 'Nguyen Quang Ngoc', 'GCD210069', 'ngocnqgcd210069@fpt.edu.vn', 'ngoc.png'),
('B3D4D6FC', 'Duong Van Hieu', 'GCD210486', 'hieu@fpt.edu.vn', 'hieu.png');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `Attendance`
--
ALTER TABLE `Attendance`
  ADD PRIMARY KEY (`AttendanceID`),
  ADD KEY `SlotID` (`SlotID`),
  ADD KEY `RFID` (`RFID`);

--
-- Chỉ mục cho bảng `Slot`
--
ALTER TABLE `Slot`
  ADD PRIMARY KEY (`SlotID`);

--
-- Chỉ mục cho bảng `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`RFID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `Attendance`
--
ALTER TABLE `Attendance`
  MODIFY `AttendanceID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT cho bảng `Slot`
--
ALTER TABLE `Slot`
  MODIFY `SlotID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `Attendance`
--
ALTER TABLE `Attendance`
  ADD CONSTRAINT `Attendance_ibfk_1` FOREIGN KEY (`SlotID`) REFERENCES `Slot` (`SlotID`),
  ADD CONSTRAINT `Attendance_ibfk_2` FOREIGN KEY (`RFID`) REFERENCES `Student` (`RFID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
