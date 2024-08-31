-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2024 at 08:34 AM
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
-- Database: `tenol`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `EXPIRY` ()  NO SQL BEGIN
SELECT p_id,sup_id,med_id,p_qty,p_cost,pur_date,mfg_date,exp_date FROM purchase where exp_date between CURDATE() and DATE_SUB(CURDATE(), INTERVAL -6 MONTH);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SEARCH_INVENTORY` (IN `search` VARCHAR(255))  NO SQL BEGIN
DECLARE mid DECIMAL(6);
DECLARE mname VARCHAR(50);
DECLARE mqty INT;
DECLARE mcategory VARCHAR(20);
DECLARE mprice DECIMAL(6,2);
DECLARE location VARCHAR(30);
DECLARE exit_loop BOOLEAN DEFAULT FALSE;
DECLARE MED_CURSOR CURSOR FOR SELECT MED_ID,MED_NAME,MED_QTY,CATEGORY,MED_PRICE,LOCATION_RACK FROM MEDS;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop=TRUE;
CREATE TEMPORARY TABLE IF NOT EXISTS T1 (medid decimal(6),medname varchar(50),medqty int,medcategory varchar(20),medprice decimal(6,2),medlocation varchar(30));
OPEN MED_CURSOR;
med_loop: LOOP
FETCH FROM MED_CURSOR INTO mid,mname,mqty,mcategory,mprice,location;
IF exit_loop THEN
LEAVE med_loop;
END IF;

IF(CONCAT(mid,mname,mcategory,location) LIKE CONCAT('%',search,'%')) THEN
INSERT INTO T1(medid,medname,medqty,medcategory,medprice,medlocation)
VALUES(mid,mname,mqty,mcategory,mprice,location);
END IF;
END LOOP med_loop;
CLOSE MED_CURSOR;
SELECT medid,medname,medqty,medcategory,medprice,medlocation FROM T1; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `STOCK` ()  NO SQL BEGIN
SELECT med_id, med_name,med_qty,category,med_price,location_rack FROM meds where med_qty<=50;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TOTAL_AMT` (IN `ID` INT, OUT `AMT` DECIMAL(8,2))  NO SQL BEGIN
UPDATE SALES SET S_DATE=SYSDATE(),S_TIME=CURRENT_TIMESTAMP(),TOTAL_AMT=(SELECT SUM(TOT_PRICE) FROM SALES_ITEMS WHERE SALES_ITEMS.SALE_ID=ID) WHERE SALES.SALE_ID=ID;
SELECT TOTAL_AMT INTO AMT FROM SALES WHERE SALE_ID=ID;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `P_AMT` (`start` DATE, `end` DATE) RETURNS DECIMAL(8,2) DETERMINISTIC NO SQL BEGIN
DECLARE PAMT DECIMAL(8,2) DEFAULT 0.0;
SELECT SUM(P_COST) INTO PAMT FROM PURCHASE WHERE PUR_DATE >= start AND PUR_DATE<= end;
RETURN PAMT;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `S_AMT` (`start` DATE, `end` DATE) RETURNS DECIMAL(8,2) NO SQL BEGIN
DECLARE SAMT DECIMAL(8,2) DEFAULT 0.0;
SELECT SUM(TOTAL_AMT) INTO SAMT FROM SALES WHERE S_DATE >= start AND S_DATE<= end;
RETURN SAMT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ID` decimal(7,0) NOT NULL,
  `A_USERNAME` varchar(50) NOT NULL,
  `A_PASSWORD` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `A_USERNAME`, `A_PASSWORD`) VALUES
(1, 'gerald', '1234567');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `C_ID` decimal(6,0) NOT NULL,
  `C_FNAME` varchar(30) NOT NULL,
  `C_LNAME` varchar(30) DEFAULT NULL,
  `C_AGE` int(11) NOT NULL,
  `C_SEX` varchar(6) NOT NULL,
  `C_PHNO` decimal(10,0) NOT NULL,
  `C_MAIL` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`C_ID`, `C_FNAME`, `C_LNAME`, `C_AGE`, `C_SEX`, `C_PHNO`, `C_MAIL`) VALUES
(987101, 'Sofia', 'Musila', 30, 'Female', 9632587415, 'sofia@gmail.com'),
(987102, 'Vicky', 'Karani', 42, 'Female', 9987565423, 'vicky@gmail.com'),
(987103, 'Salim', 'Amir', 45, 'Male', 7896541236, 'salim@hotmail.com'),
(987104, 'Agatha', 'Mbaru', 30, 'Female', 7845129635, 'agatha@gmail.com'),
(987105, 'Zayed', 'Jamal', 40, 'Male', 6789541235, 'zayed@hotmail.com'),
(987106, 'Zainab', 'Kareem', 60, 'Female', 8996574123, 'zainab@yahoo.com'),
(987107, 'John', 'Musyoka', 35, 'Male', 7845963259, 'john@gmail.com'),
(987109, 'Jane', 'Okoth', 45, 'Female', 7894561817, 'jane@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `emplogin`
--

CREATE TABLE `emplogin` (
  `E_ID` decimal(7,0) NOT NULL,
  `E_USERNAME` varchar(20) NOT NULL,
  `E_PASS` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emplogin`
--

INSERT INTO `emplogin` (`E_ID`, `E_USERNAME`, `E_PASS`) VALUES
(4567010, 'daniel', '003'),
(4567003, 'hassan', '004'),
(4567006, 'kelvin', '006'),
(4567002, 'mercy', '002'),
(4567009, 'niver', '005'),
(4567005, 'omar', '001'),
(4567001, 'victor', '007');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `E_ID` decimal(7,0) NOT NULL,
  `E_FNAME` varchar(30) NOT NULL,
  `E_LNAME` varchar(30) DEFAULT NULL,
  `BDATE` date NOT NULL,
  `E_AGE` int(11) NOT NULL,
  `E_SEX` varchar(6) NOT NULL,
  `E_TYPE` varchar(20) NOT NULL,
  `E_JDATE` date NOT NULL,
  `E_SAL` decimal(8,2) NOT NULL,
  `E_PHNO` decimal(10,0) NOT NULL,
  `E_MAIL` varchar(40) DEFAULT NULL,
  `E_ADD` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`E_ID`, `E_FNAME`, `E_LNAME`, `BDATE`, `E_AGE`, `E_SEX`, `E_TYPE`, `E_JDATE`, `E_SAL`, `E_PHNO`, `E_MAIL`, `E_ADD`) VALUES
(1, 'Admin', '-', '1989-05-24', 30, 'Male', 'Admin', '2024-06-24', 95000.00, 9874563219, 'admin@tenol.com', 'Chennai'),
(4567001, 'Victor ', 'Langa', '1995-10-05', 29, 'Male', 'Pharmacist', '2024-07-01', 25000.00, 7967845123, 'langa@hotmail.com', 'Namanga'),
(4567002, 'Mercy', 'Kalama', '1997-10-03', 27, 'Female', 'Pharmacist', '2024-07-01', 45000.00, 7546123566, 'anita@gmail.com', 'Malindi'),
(4567003, 'Hassan', 'Raj', '1994-02-01', 30, 'Male', 'Pharmacist', '2024-07-01', 21000.00, 7854123694, 'hassan@live.com', 'Mombasa'),
(4567005, 'Omar', 'Ahmed', '1992-08-02', 32, 'Male', 'Pharmacist', '2017-07-01', 32000.00, 7894532165, 'omara@gmail.com', 'Likoni'),
(4567006, 'Kelvin', 'Mwangi', '1990-12-11', 34, 'Male', 'Pharmacist', '2024-07-01', 28000.00, 7896541234, 'mwangi@mail.com', 'Kiambu'),
(4567009, 'Niver', 'Onzere', '1994-02-12', 30, 'Female', 'Manager', '2024-07-01', 80000.00, 7854123695, 'niver@gmail.com', 'Bamburi'),
(4567010, 'Daniel', 'Mutua', '1993-04-05', 31, 'Male', 'Pharmacist', '2024-07-01', 30000.00, 7896541235, 'daniel@gmail.com', 'Kitui');

-- --------------------------------------------------------

--
-- Table structure for table `meds`
--

CREATE TABLE `meds` (
  `MED_ID` decimal(6,0) NOT NULL,
  `MED_NAME` varchar(50) NOT NULL,
  `MED_QTY` int(11) NOT NULL,
  `CATEGORY` varchar(20) DEFAULT NULL,
  `MED_PRICE` decimal(6,2) NOT NULL,
  `LOCATION_RACK` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meds`
--

INSERT INTO `meds` (`MED_ID`, `MED_NAME`, `MED_QTY`, `CATEGORY`, `MED_PRICE`, `LOCATION_RACK`) VALUES
(123001, 'Atenolol', 782, 'Tablet', 15.00, 'rack 5'),
(123002, 'Enaril 5mg', 791, 'Tablet', 20.50, 'rack 6'),
(123003, 'Propranolol', 538, 'Tablet', 10.00, 'rack 3'),
(123004, 'Nadolol', 444, 'Tablet', 20.00, 'rack 4'),
(123005, 'Bisoprolol', 250, 'Tablet', 20.00, 'rack 5'),
(123006, 'Metoprolol', 34, 'Tablet', 50.00, 'rack 10'),
(123007, 'Carvedilol', 44, 'Tablet', 40.00, 'rack 7'),
(123008, 'Deprex', 130, 'Tablet', 30.00, 'rack 8'),
(123009, 'Omeprazole', 43, 'Capsule', 40.00, 'rack 1'),
(123010, 'Concur 5 MG', 848, 'Tablet', 30.00, 'rack 9'),
(123011, 'Enalapril', 110, 'Tablet', 40.00, 'rack 7'),
(123012, 'Amitriptyline', 140, 'Tablet', 140.00, 'Rack 11');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `P_ID` decimal(4,0) NOT NULL,
  `SUP_ID` decimal(3,0) NOT NULL,
  `MED_ID` decimal(6,0) NOT NULL,
  `P_QTY` int(11) NOT NULL,
  `P_COST` decimal(8,2) NOT NULL,
  `PUR_DATE` date NOT NULL,
  `MFG_DATE` date NOT NULL,
  `EXP_DATE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`P_ID`, `SUP_ID`, `MED_ID`, `P_QTY`, `P_COST`, `PUR_DATE`, `MFG_DATE`, `EXP_DATE`) VALUES
(1001, 136, 123010, 200, 1500.50, '2024-07-01', '2023-05-05', '2026-05-10'),
(1002, 123, 123002, 1000, 3000.00, '2024-07-01', '2023-06-01', '2027-12-05'),
(1003, 145, 123006, 20, 800.00, '2024-07-01', '2022-02-05', '2024-08-01'),
(1004, 156, 123004, 250, 1000.00, '2024-07-01', '2023-05-06', '2026-05-06'),
(1005, 123, 123005, 200, 1200.00, '2024-07-01', '2019-08-02', '2024-07-11'),
(1006, 162, 123010, 500, 1500.00, '2024-07-01', '2023-01-01', '2027-05-02'),
(1007, 123, 123001, 500, 450.00, '2024-07-01', '2023-01-05', '2027-03-06');

--
-- Triggers `purchase`
--
DELIMITER $$
CREATE TRIGGER `QTYDELETE` AFTER DELETE ON `purchase` FOR EACH ROW BEGIN
UPDATE meds SET MED_QTY=MED_QTY-old.P_QTY WHERE meds.MED_ID=old.MED_ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `QTYINSERT` AFTER INSERT ON `purchase` FOR EACH ROW BEGIN
UPDATE meds SET MED_QTY=MED_QTY+new.P_QTY WHERE meds.MED_ID=new.MED_ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `QTYUPDATE` AFTER UPDATE ON `purchase` FOR EACH ROW BEGIN
UPDATE meds SET MED_QTY=MED_QTY-old.P_QTY WHERE meds.MED_ID=new.MED_ID;
UPDATE meds SET MED_QTY=MED_QTY+new.P_QTY WHERE meds.MED_ID=new.MED_ID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `SALE_ID` int(11) NOT NULL,
  `C_ID` decimal(6,0) NOT NULL,
  `S_DATE` date DEFAULT NULL,
  `S_TIME` time DEFAULT NULL,
  `TOTAL_AMT` decimal(8,2) DEFAULT NULL,
  `E_ID` decimal(7,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`SALE_ID`, `C_ID`, `S_DATE`, `S_TIME`, `TOTAL_AMT`, `E_ID`) VALUES
(24, 987106, '2024-07-14', '17:36:46', 397.50, 4567009),
(25, 987107, '2024-07-15', '13:59:48', 1141.00, 4567009),
(26, 987106, '2024-07-19', '12:09:31', 781.00, 4567009);

--
-- Triggers `sales`
--
DELIMITER $$
CREATE TRIGGER `SALE_ID_DELETE` BEFORE DELETE ON `sales` FOR EACH ROW BEGIN
DELETE from sales_items WHERE sales_items.SALE_ID=old.SALE_ID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_items`
--

CREATE TABLE `sales_items` (
  `SALE_ID` int(11) NOT NULL,
  `MED_ID` decimal(6,0) NOT NULL,
  `SALE_QTY` int(11) NOT NULL,
  `TOT_PRICE` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales_items`
--

INSERT INTO `sales_items` (`SALE_ID`, `MED_ID`, `SALE_QTY`, `TOT_PRICE`) VALUES
(24, 123001, 5, 75.00),
(24, 123002, 5, 102.50),
(24, 123004, 2, 40.00),
(24, 123006, 2, 100.00),
(24, 123009, 2, 80.00),
(25, 123001, 10, 150.00),
(25, 123002, 2, 41.00),
(25, 123003, 9, 90.00),
(25, 123004, 4, 80.00),
(25, 123005, 5, 100.00),
(25, 123006, 2, 100.00),
(25, 123008, 7, 210.00),
(25, 123009, 2, 80.00),
(25, 123011, 7, 280.00),
(26, 123001, 3, 45.00),
(26, 123002, 2, 41.00),
(26, 123003, 3, 30.00),
(26, 123005, 5, 100.00),
(26, 123006, 2, 100.00),
(26, 123007, 6, 240.00),
(26, 123008, 3, 90.00),
(26, 123009, 3, 120.00),
(26, 123010, 2, 60.00),
(26, 123011, 3, 120.00);

--
-- Triggers `sales_items`
--
DELIMITER $$
CREATE TRIGGER `SALEDELETE` AFTER DELETE ON `sales_items` FOR EACH ROW BEGIN
UPDATE meds SET MED_QTY=MED_QTY+old.SALE_QTY WHERE meds.MED_ID=old.MED_ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `SALEINSERT` AFTER INSERT ON `sales_items` FOR EACH ROW BEGIN
UPDATE meds SET MED_QTY=MED_QTY-new.SALE_QTY WHERE meds.MED_ID=new.MED_ID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `save_invoice`
--

CREATE TABLE `save_invoice` (
  `invoice_id` int(11) NOT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `SUP_ID` decimal(3,0) NOT NULL,
  `SUP_NAME` varchar(25) NOT NULL,
  `SUP_ADD` varchar(30) NOT NULL,
  `SUP_PHNO` decimal(10,0) NOT NULL,
  `SUP_MAIL` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`SUP_ID`, `SUP_NAME`, `SUP_ADD`, `SUP_PHNO`, `SUP_MAIL`) VALUES
(123, 'Beta Healthcare Int Ltd', 'Nairobi', 8745632145, 'Beta@gmail.com'),
(136, 'Dawa Pharmacies', 'Nairobi', 7894561235, 'dawa@pharmsupp.com'),
(145, 'Makadara Chemist', 'Mombasa', 7854699321, 'makadara@dpharma.com'),
(156, 'Kam Pharmacy', 'Nairobi', 9874585236, 'kam@gmail.com'),
(162, 'Centrechem Pharmacy', 'Mombasa', 7894561335, 'centrechem@pharmsupp.com'),
(171, 'Pharmaplus Pharmacy', 'Diani', 7894561217, 'pharmaplus@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`A_USERNAME`),
  ADD UNIQUE KEY `USERNAME` (`A_USERNAME`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`C_ID`),
  ADD UNIQUE KEY `C_PHNO` (`C_PHNO`),
  ADD UNIQUE KEY `C_MAIL` (`C_MAIL`);

--
-- Indexes for table `emplogin`
--
ALTER TABLE `emplogin`
  ADD PRIMARY KEY (`E_USERNAME`),
  ADD KEY `E_ID` (`E_ID`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`E_ID`);

--
-- Indexes for table `meds`
--
ALTER TABLE `meds`
  ADD PRIMARY KEY (`MED_ID`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`P_ID`,`MED_ID`),
  ADD KEY `SUP_ID` (`SUP_ID`),
  ADD KEY `MED_ID` (`MED_ID`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`SALE_ID`),
  ADD KEY `C_ID` (`C_ID`),
  ADD KEY `E_ID` (`E_ID`);

--
-- Indexes for table `sales_items`
--
ALTER TABLE `sales_items`
  ADD PRIMARY KEY (`SALE_ID`,`MED_ID`),
  ADD KEY `MED_ID` (`MED_ID`);

--
-- Indexes for table `save_invoice`
--
ALTER TABLE `save_invoice`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SUP_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `SALE_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `employee` (`E_ID`);

--
-- Constraints for table `emplogin`
--
ALTER TABLE `emplogin`
  ADD CONSTRAINT `emplogin_ibfk_1` FOREIGN KEY (`E_ID`) REFERENCES `employee` (`E_ID`);

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`SUP_ID`) REFERENCES `suppliers` (`SUP_ID`),
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`MED_ID`) REFERENCES `meds` (`MED_ID`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`C_ID`) REFERENCES `customer` (`C_ID`),
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`E_ID`) REFERENCES `employee` (`E_ID`);

--
-- Constraints for table `sales_items`
--
ALTER TABLE `sales_items`
  ADD CONSTRAINT `sales_items_ibfk_1` FOREIGN KEY (`SALE_ID`) REFERENCES `sales` (`SALE_ID`),
  ADD CONSTRAINT `sales_items_ibfk_2` FOREIGN KEY (`MED_ID`) REFERENCES `meds` (`MED_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
