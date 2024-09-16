-- --------------------------------------------------------
-- Διακομιστής:                  127.0.0.1
-- Έκδοση διακομιστή:            10.4.32-MariaDB - mariadb.org binary distribution
-- Λειτ. σύστημα διακομιστή:     Win64
-- HeidiSQL Έκδοση:              12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for adise23_ludo_game
CREATE DATABASE IF NOT EXISTS `adise23_ludo_game` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `adise23_ludo_game`;

-- Dumping structure for procedure adise23_ludo_game.B1_dice
DROP PROCEDURE IF EXISTS `B1_dice`;
DELIMITER //
CREATE PROCEDURE `B1_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'B1' ORDER BY `created_at` DESC LIMIT 1 ;
 
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.B1_highlight
DROP PROCEDURE IF EXISTS `B1_highlight`;
DELIMITER //
CREATE PROCEDURE `B1_highlight`()
BEGIN
SELECT b.x, b.y, b.b_path
FROM board b
JOIN dice d ON b.b_path >= d.prev_path AND b.b_path <= ( d.new_path)
WHERE d.piece='B1'
ORDER BY b.b_path ASC; 

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.B2_dice
DROP PROCEDURE IF EXISTS `B2_dice`;
DELIMITER //
CREATE PROCEDURE `B2_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'B2' ORDER BY `created_at` DESC LIMIT 1 ; 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.B2_highlight
DROP PROCEDURE IF EXISTS `B2_highlight`;
DELIMITER //
CREATE PROCEDURE `B2_highlight`()
BEGIN
SELECT b.x, b.y, b.b_path
FROM board b
JOIN dice d ON b.b_path >= d.prev_path AND b.b_path <= ( d.new_path)
WHERE d.piece='B2'
ORDER BY b.b_path ASC; 

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.B3_dice
DROP PROCEDURE IF EXISTS `B3_dice`;
DELIMITER //
CREATE PROCEDURE `B3_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'B3' ORDER BY `created_at` DESC LIMIT 1 ; 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.B3_highlight
DROP PROCEDURE IF EXISTS `B3_highlight`;
DELIMITER //
CREATE PROCEDURE `B3_highlight`()
BEGIN
SELECT b.x, b.y, b.b_path
FROM board b
JOIN dice d ON b.b_path >= d.prev_path AND b.b_path <= ( d.new_path)
WHERE d.piece='B3'
ORDER BY b.b_path ASC; 

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.B4_dice
DROP PROCEDURE IF EXISTS `B4_dice`;
DELIMITER //
CREATE PROCEDURE `B4_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'B4' ORDER BY `created_at` DESC LIMIT 1 ; 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.B4_highlight
DROP PROCEDURE IF EXISTS `B4_highlight`;
DELIMITER //
CREATE PROCEDURE `B4_highlight`()
BEGIN
SELECT b.x, b.y, b.b_path
FROM board b
JOIN dice d ON b.b_path >= d.prev_path AND b.b_path <= ( d.new_path)
WHERE d.piece='B4'
ORDER BY b.b_path ASC; 

END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.blue_win_pieces
DROP TABLE IF EXISTS `blue_win_pieces`;
CREATE TABLE IF NOT EXISTS `blue_win_pieces` (
  `piece` varchar(50) NOT NULL,
  `piece_color` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`piece`,`piece_color`,`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.blue_win_pieces: ~0 rows (approximately)
DELETE FROM `blue_win_pieces`;

-- Dumping structure for πίνακας adise23_ludo_game.board
DROP TABLE IF EXISTS `board`;
CREATE TABLE IF NOT EXISTS `board` (
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `b_color` enum('R','G','B','Y','W','MIX','GR','BR','BY','GY') NOT NULL,
  `piece_color` enum('R','G','B','Y') DEFAULT NULL,
  `piece` varchar(3) DEFAULT NULL,
  `y_path` int(11) DEFAULT NULL CHECK (`y_path` is null or `y_path` >= 1 and `y_path` <= 44),
  `b_path` int(11) DEFAULT NULL CHECK (`b_path` is null or `b_path` >= 1 and `b_path` <= 44),
  `r_path` int(11) DEFAULT NULL CHECK (`r_path` is null or `r_path` >= 1 and `r_path` <= 44),
  `g_path` int(11) DEFAULT NULL CHECK (`g_path` is null or `g_path` >= 1 and `g_path` <= 44),
  PRIMARY KEY (`x`,`y`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.board: ~137 rows (approximately)
DELETE FROM `board`;
INSERT INTO `board` (`x`, `y`, `b_color`, `piece_color`, `piece`, `y_path`, `b_path`, `r_path`, `g_path`) VALUES
	(1, 1, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 2, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 3, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 4, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 5, 'W', NULL, NULL, 7, 16, 25, 34),
	(1, 6, 'W', NULL, NULL, 8, 17, 26, 35),
	(1, 7, 'W', NULL, NULL, 9, 18, 27, NULL),
	(1, 8, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 9, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 10, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 11, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 1, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 2, 'W', 'Y', 'Y3', NULL, NULL, NULL, NULL),
	(2, 3, 'W', 'Y', 'Y1', NULL, NULL, NULL, NULL),
	(2, 4, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 5, 'W', NULL, NULL, 6, 15, 24, 33),
	(2, 6, 'G', NULL, NULL, NULL, NULL, NULL, 36),
	(2, 7, 'G', NULL, NULL, 10, 19, 28, 1),
	(2, 8, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 9, 'W', 'G', 'G3', NULL, NULL, NULL, NULL),
	(2, 10, 'W', 'G', 'G1', NULL, NULL, NULL, NULL),
	(2, 11, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 1, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 2, 'W', 'Y', 'Y4', NULL, NULL, NULL, NULL),
	(3, 3, 'W', 'Y', 'Y2', NULL, NULL, NULL, NULL),
	(3, 4, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 5, 'W', NULL, NULL, 5, 14, 23, 32),
	(3, 6, 'G', NULL, NULL, NULL, NULL, NULL, 37),
	(3, 7, 'W', NULL, NULL, 11, 20, 29, 2),
	(3, 8, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 9, 'W', 'G', 'G4', NULL, NULL, NULL, NULL),
	(3, 10, 'W', 'G', 'G2', NULL, NULL, NULL, NULL),
	(3, 11, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 1, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 2, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 3, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 4, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 5, 'W', 'B', 'B1', 4, 13, 22, 31),
	(4, 6, 'G', NULL, NULL, NULL, NULL, NULL, 38),
	(4, 7, 'W', NULL, NULL, 12, 21, 30, 3),
	(4, 8, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 9, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 10, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 11, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 1, 'W', NULL, NULL, NULL, 9, 18, 27),
	(5, 2, 'Y', NULL, NULL, 1, 10, 19, 28),
	(5, 3, 'W', NULL, NULL, 2, 11, 20, 29),
	(5, 4, 'W', NULL, NULL, 3, 12, 21, 30),
	(5, 5, 'GY', NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 6, 'G', NULL, NULL, NULL, NULL, NULL, 39),
	(5, 7, 'GR', NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 8, 'W', NULL, NULL, 13, 22, 31, 4),
	(5, 9, 'W', NULL, NULL, 14, 23, 32, 5),
	(5, 10, 'W', NULL, NULL, 15, 24, 33, 6),
	(5, 11, 'W', NULL, NULL, 16, 25, 34, 7),
	(6, 1, 'W', NULL, NULL, 35, 8, 17, 26),
	(6, 2, 'Y', NULL, NULL, 36, NULL, NULL, NULL),
	(6, 3, 'Y', NULL, NULL, 37, NULL, NULL, NULL),
	(6, 4, 'Y', NULL, NULL, 38, NULL, NULL, NULL),
	(6, 5, 'Y', NULL, NULL, 39, NULL, NULL, NULL),
	(6, 6, 'MIX', NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 7, 'R', NULL, NULL, NULL, NULL, 39, NULL),
	(6, 8, 'R', NULL, NULL, NULL, NULL, 38, NULL),
	(6, 9, 'R', NULL, NULL, NULL, NULL, 37, NULL),
	(6, 10, 'R', NULL, NULL, NULL, NULL, 36, NULL),
	(6, 11, 'W', NULL, NULL, 17, 26, 35, 8),
	(7, 1, 'W', NULL, NULL, 34, 7, 16, 25),
	(7, 2, 'W', NULL, NULL, 33, 6, 15, 24),
	(7, 3, 'W', NULL, NULL, 32, 5, 14, 23),
	(7, 4, 'W', 'R', 'R1', 31, 4, 13, 22),
	(7, 5, 'BY', NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 6, 'B', NULL, NULL, NULL, 39, NULL, NULL),
	(7, 7, 'BR', NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 8, 'W', NULL, NULL, 21, 30, 3, 12),
	(7, 9, 'W', NULL, NULL, 20, 29, 2, 11),
	(7, 10, 'R', 'R', 'R2', 19, 28, 1, 10),
	(7, 11, 'W', NULL, NULL, 18, 27, NULL, 9),
	(8, 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 5, 'W', NULL, NULL, 30, 3, 12, 21),
	(8, 6, 'B', NULL, NULL, NULL, 38, NULL, NULL),
	(8, 7, 'W', NULL, NULL, 22, 31, 4, 13),
	(8, 8, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 9, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 10, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 11, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 2, 'W', 'B', 'B3', NULL, NULL, NULL, NULL),
	(9, 3, 'W', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 5, 'W', NULL, NULL, 29, 2, 11, 20),
	(9, 6, 'B', NULL, NULL, NULL, 37, NULL, NULL),
	(9, 7, 'W', NULL, NULL, 23, 32, 5, 14),
	(9, 8, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 9, 'W', 'R', 'R3', NULL, NULL, NULL, NULL),
	(9, 10, 'W', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 11, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 2, 'W', 'B', 'B4', NULL, NULL, NULL, NULL),
	(10, 3, 'W', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 5, 'B', 'B', 'B2', 28, 1, 10, 19),
	(10, 6, 'B', NULL, NULL, NULL, 36, NULL, NULL),
	(10, 7, 'W', NULL, NULL, 24, 33, 6, 15),
	(10, 8, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 9, 'W', 'R', 'R4', NULL, NULL, NULL, NULL),
	(10, 10, 'W', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 11, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 5, 'W', NULL, NULL, 27, NULL, 9, 18),
	(11, 6, 'W', NULL, NULL, 26, 35, 8, 17),
	(11, 7, 'W', NULL, NULL, 25, 34, 7, 16),
	(11, 8, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 9, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 10, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 11, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(20, 1, '', NULL, NULL, NULL, 41, NULL, NULL),
	(20, 2, '', NULL, NULL, NULL, 42, NULL, NULL),
	(20, 3, '', NULL, NULL, NULL, 43, NULL, NULL),
	(20, 4, '', NULL, NULL, NULL, 44, NULL, NULL),
	(30, 1, '', NULL, NULL, NULL, NULL, 41, NULL),
	(30, 2, '', NULL, NULL, NULL, NULL, 42, NULL),
	(30, 3, '', NULL, NULL, NULL, NULL, 43, NULL),
	(30, 4, '', NULL, NULL, NULL, NULL, 44, NULL),
	(40, 1, '', NULL, NULL, NULL, NULL, NULL, 41),
	(40, 2, '', NULL, NULL, NULL, NULL, NULL, 42),
	(40, 3, '', NULL, NULL, NULL, NULL, NULL, 43),
	(40, 4, '', NULL, NULL, NULL, NULL, NULL, 44),
	(100, 1, '', NULL, NULL, 41, NULL, NULL, NULL),
	(100, 2, '', NULL, NULL, 42, NULL, NULL, NULL),
	(100, 3, '', NULL, NULL, 43, NULL, NULL, NULL),
	(100, 4, '', NULL, NULL, 44, NULL, NULL, NULL);

-- Dumping structure for πίνακας adise23_ludo_game.board_empty
DROP TABLE IF EXISTS `board_empty`;
CREATE TABLE IF NOT EXISTS `board_empty` (
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `b_color` enum('R','G','B','Y','W','MIX','GR','BR','BY','GY') NOT NULL,
  `piece_color` enum('R','G','B','Y') DEFAULT NULL,
  `piece` varchar(3) DEFAULT NULL,
  `y_path` int(11) DEFAULT NULL CHECK (`y_path` is null or `y_path` >= 1 and `y_path` <= 44),
  `b_path` int(11) DEFAULT NULL CHECK (`b_path` is null or `b_path` >= 1 and `b_path` <= 44),
  `r_path` int(11) DEFAULT NULL CHECK (`r_path` is null or `r_path` >= 1 and `r_path` <= 44),
  `g_path` int(11) DEFAULT NULL CHECK (`g_path` is null or `g_path` >= 1 and `g_path` <= 44),
  PRIMARY KEY (`x`,`y`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.board_empty: ~134 rows (approximately)
DELETE FROM `board_empty`;
INSERT INTO `board_empty` (`x`, `y`, `b_color`, `piece_color`, `piece`, `y_path`, `b_path`, `r_path`, `g_path`) VALUES
	(1, 1, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 2, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 3, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 4, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 5, 'W', NULL, NULL, 7, 16, 25, 34),
	(1, 6, 'W', NULL, NULL, 8, 17, 26, 35),
	(1, 7, 'W', NULL, NULL, 9, 18, 27, NULL),
	(1, 8, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 9, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 10, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 11, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 1, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 2, 'W', 'Y', 'Y3', NULL, NULL, NULL, NULL),
	(2, 3, 'W', 'Y', 'Y1', NULL, NULL, NULL, NULL),
	(2, 4, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 5, 'W', NULL, NULL, 6, 15, 24, 33),
	(2, 6, 'G', NULL, NULL, NULL, NULL, NULL, 36),
	(2, 7, 'G', NULL, NULL, 10, 19, 28, 1),
	(2, 8, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 9, 'W', 'G', 'G3', NULL, NULL, NULL, NULL),
	(2, 10, 'W', 'G', 'G1', NULL, NULL, NULL, NULL),
	(2, 11, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 1, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 2, 'W', 'Y', 'Y4', NULL, NULL, NULL, NULL),
	(3, 3, 'W', 'Y', 'Y2', NULL, NULL, NULL, NULL),
	(3, 4, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 5, 'W', NULL, NULL, 5, 14, 23, 32),
	(3, 6, 'G', NULL, NULL, NULL, NULL, NULL, 37),
	(3, 7, 'W', NULL, NULL, 11, 20, 29, 2),
	(3, 8, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 9, 'W', 'G', 'G4', NULL, NULL, NULL, NULL),
	(3, 10, 'W', 'G', 'G2', NULL, NULL, NULL, NULL),
	(3, 11, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 1, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 2, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 3, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 4, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 5, 'W', NULL, NULL, 4, 13, 22, 31),
	(4, 6, 'G', NULL, NULL, NULL, NULL, NULL, 38),
	(4, 7, 'W', NULL, NULL, 12, 21, 30, 3),
	(4, 8, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 9, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 10, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 11, 'G', NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 1, 'W', NULL, NULL, NULL, 9, 18, 27),
	(5, 2, 'Y', NULL, NULL, 1, 10, 19, 28),
	(5, 3, 'W', NULL, NULL, 2, 11, 20, 29),
	(5, 4, 'W', NULL, NULL, 3, 12, 21, 30),
	(5, 5, 'GY', NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 6, 'G', NULL, NULL, NULL, NULL, NULL, 39),
	(5, 7, 'GR', NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 8, 'W', NULL, NULL, 13, 22, 31, 4),
	(5, 9, 'W', NULL, NULL, 14, 23, 32, 5),
	(5, 10, 'W', NULL, NULL, 15, 24, 33, 6),
	(5, 11, 'W', NULL, NULL, 16, 25, 34, 7),
	(6, 1, 'W', NULL, NULL, 35, 8, 17, 26),
	(6, 2, 'Y', NULL, NULL, 36, NULL, NULL, NULL),
	(6, 3, 'Y', NULL, NULL, 37, NULL, NULL, NULL),
	(6, 4, 'Y', NULL, NULL, 38, NULL, NULL, NULL),
	(6, 5, 'Y', NULL, NULL, 39, NULL, NULL, NULL),
	(6, 6, 'MIX', NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 7, 'R', NULL, NULL, NULL, NULL, 39, NULL),
	(6, 8, 'R', NULL, NULL, NULL, NULL, 38, NULL),
	(6, 9, 'R', NULL, NULL, NULL, NULL, 37, NULL),
	(6, 10, 'R', NULL, NULL, NULL, NULL, 36, NULL),
	(6, 11, 'W', NULL, NULL, 17, 26, 35, 8),
	(7, 1, 'W', NULL, NULL, 34, 7, 16, 25),
	(7, 2, 'W', NULL, NULL, 33, 6, 15, 24),
	(7, 3, 'W', NULL, NULL, 32, 5, 14, 23),
	(7, 4, 'W', NULL, NULL, 31, 4, 13, 22),
	(7, 5, 'BY', NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 6, 'B', NULL, NULL, NULL, 39, NULL, NULL),
	(7, 7, 'BR', NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 8, 'W', NULL, NULL, 21, 30, 3, 12),
	(7, 9, 'W', NULL, NULL, 20, 29, 2, 11),
	(7, 10, 'R', NULL, NULL, 19, 28, 1, 10),
	(7, 11, 'W', NULL, NULL, 18, 27, NULL, 9),
	(8, 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 5, 'W', NULL, NULL, 30, 3, 12, 21),
	(8, 6, 'B', NULL, NULL, NULL, 38, NULL, NULL),
	(8, 7, 'W', NULL, NULL, 22, 31, 4, 13),
	(8, 8, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 9, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 10, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 11, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 2, 'W', 'B', 'B3', NULL, NULL, NULL, NULL),
	(9, 3, 'W', 'B', 'B1', NULL, NULL, NULL, NULL),
	(9, 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 5, 'W', NULL, NULL, 29, 2, 11, 20),
	(9, 6, 'B', NULL, NULL, NULL, 37, NULL, NULL),
	(9, 7, 'W', NULL, NULL, 23, 32, 5, 14),
	(9, 8, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 9, 'W', 'R', 'R3', NULL, NULL, NULL, NULL),
	(9, 10, 'W', 'R', 'R1', NULL, NULL, NULL, NULL),
	(9, 11, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 2, 'W', 'B', 'B4', NULL, NULL, NULL, NULL),
	(10, 3, 'W', 'B', 'B2', NULL, NULL, NULL, NULL),
	(10, 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 5, 'B', NULL, NULL, 28, 1, 10, 19),
	(10, 6, 'B', NULL, NULL, NULL, 36, NULL, NULL),
	(10, 7, 'W', NULL, NULL, 24, 33, 6, 15),
	(10, 8, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 9, 'W', 'R', 'R4', NULL, NULL, NULL, NULL),
	(10, 10, 'W', 'R', 'R2', NULL, NULL, NULL, NULL),
	(10, 11, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 5, 'W', NULL, NULL, 27, NULL, 9, 18),
	(11, 6, 'W', NULL, NULL, 26, 35, 8, 17),
	(11, 7, 'W', NULL, NULL, 25, 34, 7, 16),
	(11, 8, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 9, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 10, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 11, 'R', NULL, NULL, NULL, NULL, NULL, NULL),
	(20, 1, '', NULL, NULL, NULL, 41, NULL, NULL),
	(20, 2, '', NULL, NULL, NULL, 42, NULL, NULL),
	(20, 3, '', NULL, NULL, NULL, 43, NULL, NULL),
	(20, 4, '', NULL, NULL, NULL, 44, NULL, NULL),
	(30, 1, '', NULL, NULL, NULL, NULL, 41, NULL),
	(30, 2, '', NULL, NULL, NULL, NULL, 42, NULL),
	(30, 3, '', NULL, NULL, NULL, NULL, 43, NULL),
	(30, 4, '', NULL, NULL, NULL, NULL, 44, NULL),
	(40, 1, '', NULL, NULL, NULL, NULL, NULL, 41),
	(40, 2, '', NULL, NULL, NULL, NULL, NULL, 42),
	(40, 3, '', NULL, NULL, NULL, NULL, NULL, 43),
	(40, 4, '', NULL, NULL, NULL, NULL, NULL, 44),
	(100, 1, '', NULL, NULL, 41, NULL, NULL, NULL),
	(100, 2, '', NULL, NULL, 42, NULL, NULL, NULL),
	(100, 3, '', NULL, NULL, 43, NULL, NULL, NULL),
	(100, 4, '', NULL, NULL, 44, NULL, NULL, NULL);

-- Dumping structure for procedure adise23_ludo_game.check_spot
DROP PROCEDURE IF EXISTS `check_spot`;
DELIMITER //
CREATE PROCEDURE `check_spot`(
	IN `new_x` INT,
	IN `new_y` INT
)
BEGIN
    DECLARE other_piece VARCHAR(255);
  DECLARE p, p_color, piece_val VARCHAR(3);
     DECLARE prev_xspot_of_other_piece , prev_yspot_of_other_piece , destx, desty  INT;
     
     SET destx=new_x ;
     SET desty=new_y ;
   SELECT destx, desty;
	
    SELECT piece , prev_x, prev_y
    INTO other_piece , prev_xspot_of_other_piece, prev_yspot_of_other_piece
    FROM dice
    WHERE  prev_xspot_of_other_piece =  destx AND prev_yspot_of_other_piece = desty 
    LIMIT 1;
    
    -- If another piece is found, update its coordinates
    IF other_piece  = 'Y1' THEN
    CALL move_piece(destx,desty,2,3);
        UPDATE dice
        SET
        prev_x =destx,
        prev_y= desty,
            new_x = 2,  
            new_y = 3 
        WHERE piece  = 'Y1' ;
 
    END IF;
 
    
    
    
    
       IF other_piece  = 'Y2' THEN
  CALL move_piece(destx,desty,3,3);
        UPDATE dice
        SET
       prev_x =destx,
        prev_y= desty,
            new_x = 3,  
            new_y = 3  
        WHERE piece  = 'Y2' ;
    END IF;
    
    
    
     
           IF other_piece  = 'Y3' THEN
  CALL move_piece(destx,desty,2,2);
        UPDATE dice
        SET
           prev_x =destx,
        prev_y= desty,
            new_x = 2,  
            new_y = 2  
        WHERE piece  = 'Y3' ;
     END IF;
    
    
    
           IF other_piece  = 'Y4' THEN
  CALL move_piece(destx,desty,3,2);
        UPDATE dice
        SET
             prev_x =destx,
        prev_y= desty,
            new_x = 3,  
            new_y = 2  
        WHERE piece  = 'Y4' ;

    END IF;
    
    
    
    
    
    
           IF other_piece  = 'R1' THEN
  CALL move_piece(destx,desty,9,10);
        UPDATE dice
        SET
           prev_x =destx,
        prev_y= desty,
            new_x = 9,  
            new_y = 10  
        WHERE piece  = 'R1' ;
    END IF;
 
    
               IF other_piece  = 'R2' THEN
  CALL move_piece(destx,desty,10,10);
        UPDATE dice
        SET
                prev_x =destx,
        prev_y= desty,
            new_x = 10,  
            new_y = 10  
        WHERE piece  = 'R2' ;
    END IF;
 
    
    
           IF other_piece  = 'R3'  THEN
  CALL move_piece(destx,desty,9,9);
        UPDATE dice
        SET
           prev_x =destx,
        prev_y= desty,
            new_x = 9,  
            new_y = 9  
        WHERE piece  = 'R3'  ;
    END IF;
  
    
    
    
    
           IF other_piece  = 'R4' THEN
  CALL move_piece(destx,desty,10,9);
        UPDATE dice
        SET
               prev_x =destx,
        prev_y= desty,
            new_x = 10,  
            new_y = 9  
        WHERE piece  = 'R4' ;
 
    END IF;
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.check_turn
DROP PROCEDURE IF EXISTS `check_turn`;
DELIMITER //
CREATE PROCEDURE `check_turn`()
BEGIN

DECLARE current_second INT;
 DECLARE count_r INT;
    DECLARE count_y INT;
     DECLARE count_g INT;
    DECLARE count_b INT;
    
     DECLARE red_exists INT;
    DECLARE yellow_exists INT;
     DECLARE green_exists INT;
    DECLARE blue_exists INT;
    
       DECLARE count_players INT;
    


    SELECT COUNT(*) INTO count_r FROM game_status WHERE p_turn = 'R';
    SELECT COUNT(*) INTO count_y FROM game_status WHERE p_turn = 'Y';
     SELECT COUNT(*) INTO count_g FROM game_status WHERE p_turn = 'G';
    SELECT COUNT(*) INTO count_b FROM game_status WHERE p_turn = 'B';

SELECT COUNT(*) INTO red_exists FROM players WHERE piece_color = 'R' AND username IS NOT NULL;
SELECT COUNT(*) INTO yellow_exists FROM players WHERE piece_color = 'Y' AND username IS NOT NULL;
SELECT COUNT(*) INTO green_exists FROM players WHERE piece_color = 'G' AND username IS NOT NULL;
SELECT COUNT(*) INTO blue_exists FROM players WHERE piece_color = 'B' AND username IS NOT NULL;

SELECT   COUNT(*) INTO count_players  FROM players WHERE   username IS NOT NULL;
 
    
    
    		-- an einai i seira tou kokkinou
    		IF(count_r = 1) THEN 
    
      		-- an to plithos twn paiktwn einai 2
    			IF (count_players = 2) THEN
    	  			 -- an einai i seira tou kokkinou kai iparxoun sto paixnidi o kitrinos kai o kokkinos   
     				IF (yellow_exists =1)THEN         
   				UPDATE game_status SET p_turn = 'Y' WHERE p_turn = 'R';
         		END IF;
 
    	 
    	    		 -- an einai i seira tou kokkinou kai iparxoun sto paixnidi  o kokkinos kai o mple        
  					IF (blue_exists = 1)THEN         
   				UPDATE game_status SET p_turn = 'B' WHERE p_turn = 'R';
         		END IF;
         
      		     -- an einai i seira tou kokkinou kai iparxoun sto paixnidi  o kokkinos kai o prasinos      
  					IF (green_exists = 1)THEN         
   				UPDATE game_status SET p_turn = 'G' WHERE p_turn = 'R';
        	   	 END IF;
         	END IF;
    	
 
    	
   			  -- an to plithos twn paiktwn einai 3 enw paizei o kokkinos 
    			IF (count_players = 3) THEN
       		 -- an einai i seira tou kokkinou kai iparxoun sto paixnidi o kitrinos   kai o prasinos  
     				IF (yellow_exists =1 AND green_exists=1)THEN         
   				UPDATE game_status SET p_turn = 'G' WHERE p_turn = 'R';
       		   END IF;
        			  -- an einai i seira tou kokkinou kai iparxoun sto paixnidi o kitrinos kai mple
     				IF (yellow_exists =1 AND blue_exists)THEN         
   				UPDATE game_status SET p_turn = 'Y' WHERE p_turn = 'R';
        			 END IF;
        			 -- an einai i seira tou kokkinou kai iparxoun sto paixnidi o prasinos kai mple
     				IF (blue_exists =1 AND green_exists)THEN         
   				UPDATE game_status SET p_turn = 'G' WHERE p_turn = 'R';
        		   END IF;
    	      END IF;
    	
    	      -- an to plithos twn paiktwn einai 4
    			IF (count_players = 4 ) THEN
    	     		 UPDATE game_status SET p_turn = 'G' WHERE p_turn = 'R';
         	END IF;
	      END IF;
    
    
  			-- an einai i seira tou kitrinou
      	IF(count_y = 1) THEN 
      		-- an to plithos twn paiktwn einai 2
    			IF (count_players = 2) THEN
    	 	   -- an iparxoun sto paixnidi mono o kitrinos kai o mple enw i seira einai tou kitrinou
    	 	   IF(blue_exists=1) THEN UPDATE game_status SET p_turn='B' WHERE p_turn='Y';  END IF;
    	 	   -- an iparxoun sto paixnidi mono o kitrinos kai o kokkinjos enw i seira einai tou kitrinou
    		  	  IF(red_exists=1) THEN UPDATE game_status SET p_turn='R' WHERE p_turn='Y';  END IF;
    	  		  -- an iparxoun sto paixnidi mono o kitrinos kai o prasinos enw i seira einai tou kitrinou
    	  		 IF(green_exists=1) THEN UPDATE game_status SET p_turn='G' WHERE p_turn='Y';  END IF;
    	   END IF;
    		
    	
          -- an to plithos twn paiktwn einai 3
        	IF (count_players = 3) THEN
    			 -- an einai i seira tou kitrinou kai iparxoun sto paixnidi kai o mple kai prasinos  
     			IF (blue_exists =1 AND green_exists=1)THEN UPDATE game_status SET p_turn = 'B' WHERE p_turn = 'Y'; END IF;
       		 -- an einai i seira tou kitrinou kai iparxoun sto paixnidi kai o mple kai kokkinos  
     			IF (blue_exists =1 AND red_exists=1)THEN UPDATE game_status SET p_turn = 'B' WHERE p_turn = 'Y'; END IF; 
				 -- an einai i seira tou kitrinou kai iparxoun sto paixnidi kai o kokkinos kai prasinos  
     			IF (red_exists =1 AND green_exists=1)THEN UPDATE game_status SET p_turn = 'R' WHERE p_turn = 'Y'; END IF;
    	   END IF;
    	
       -- an to plithos twn paiktwn einai 4
    			IF (count_players = 4 ) THEN
    	   		UPDATE game_status SET p_turn = 'B' WHERE p_turn = 'Y';
    			END IF;
	 END IF;
	 
  -- an einai i seira tou prasinou
    IF(count_g = 1) THEN 
          -- an to plithos twn paiktwn einai 2
    	IF (count_players = 2) THEN
    	     -- an iparxoun sto paixnidi mono o  PRASINOS kai o mple enw i seira einai tou PRASINOU
    	    IF(blue_exists=1) THEN UPDATE game_status SET p_turn='B' WHERE p_turn='G';  END IF;
    	    -- an iparxoun sto paixnidi mono o PRASINOS kai o kokkinjos enw i seira einai tou  PRASINOU
    	    IF(red_exists=1) THEN UPDATE game_status SET p_turn='R' WHERE p_turn='G';  END IF;
    	    -- an iparxoun sto paixnidi mono o PRASINOS kai o KITRINOS enw i seira einai tou PRASINOU
    	    IF(yellow_exists=1) THEN UPDATE game_status SET p_turn='Y' WHERE p_turn='G';  END IF;
    	END IF;
    	
     -- an to plithos twn paiktwn einai 3
    	IF (count_players = 3) THEN
    		 -- an einai i seira tou PRASINOU kai iparxoun sto paixnidi kai o mple kai kitrinos
     		IF (blue_exists =1 AND yellow_exists=1)THEN UPDATE game_status SET p_turn = 'Y' WHERE p_turn = 'G'; END IF;
       	 -- an einai i seira tou PRASINOU kai iparxoun sto paixnidi kai o mple kai kokkinos  
     		IF (blue_exists =1 AND red_exists=1)THEN UPDATE game_status SET p_turn = 'B' WHERE p_turn = 'G'; END IF; 
			 -- an einai i seira tou PRASINOU kai iparxoun sto paixnidi kai o kokkinos kai kitrinos
     		IF (red_exists =1 AND yellow_exists=1)THEN UPDATE game_status SET p_turn = 'Y' WHERE p_turn = 'G'; END IF;
    	END IF;
    	
    	      -- an to plithos twn paiktwn einai 4
    	IF (count_players = 4 ) THEN
    	    UPDATE game_status SET p_turn = 'Y' WHERE p_turn = 'G'; END IF;
    	END IF;
 
 
	 
 -- an einai i seira tou mple
    IF(count_b = 1) THEN 
          -- an to plithos twn paiktwn einai 2
    	IF (count_players = 2) THEN
         
    	     -- an iparxoun sto paixnidi mono o  PRASINOS kai o mple enw i seira einai tou mple
    	    IF(green_exists=1) THEN UPDATE game_status SET p_turn='G' WHERE p_turn='B';  END IF;
    	    -- an iparxoun sto paixnidi mono o mple kai o kokkinjos enw i seira einai tou  mple
    	    IF(red_exists=1) THEN UPDATE game_status SET p_turn='R' WHERE p_turn='B';  END IF;
    	    -- an iparxoun sto paixnidi mono o mple kai o KITRINOS enw i seira einai tou mple
    	    IF(yellow_exists=1) THEN UPDATE game_status SET p_turn='Y' WHERE p_turn='B';  END IF;
    	END IF;
   
    	
     -- an to plithos twn paiktwn einai 3
    	IF (count_players = 3) THEN
    		 -- an einai i seira tou mple kai iparxoun sto paixnidi kai o prasinos kai kitrinos
     		IF (green_exists =1 AND yellow_exists=1)THEN UPDATE game_status SET p_turn = 'G' WHERE p_turn = 'B'; END IF;
       	 -- an einai i seira tou mple  kai iparxoun sto paixnidi kai o PRASINOS kai kokkinos  
     		IF (green_exists =1 AND red_exists=1)THEN UPDATE game_status SET p_turn = 'R' WHERE p_turn = 'B'; END IF; 
			 -- an einai i seira tou mple  kai iparxoun sto paixnidi kai o kokkinos kai kitrinos
     		IF (red_exists =1 AND yellow_exists=1)THEN UPDATE game_status SET p_turn = 'R' WHERE p_turn = 'B'; END IF;
    	END IF;
    	
    	      -- an to plithos twn paiktwn einai 4
    	IF (count_players = 4 ) THEN
    	    UPDATE game_status SET p_turn = 'R' WHERE p_turn = 'B';  
    	END IF;
	 END IF;
 
 
  
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.check_winner
DROP PROCEDURE IF EXISTS `check_winner`;
DELIMITER //
CREATE PROCEDURE `check_winner`()
BEGIN
DECLARE count_r_win_pieces INT;
DECLARE count_y_win_pieces INT;
DECLARE count_b_win_pieces INT;
DECLARE count_g_win_pieces INT;

    SELECT DISTINCT COUNT(*) INTO count_y_win_pieces FROM yellow_win_pieces  ;
    SELECT DISTINCT COUNT(*) INTO count_r_win_pieces FROM red_win_pieces   ;
 SELECT DISTINCT COUNT(*) INTO count_b_win_pieces FROM blue_win_pieces  ;
    SELECT DISTINCT COUNT(*) INTO count_g_win_pieces FROM green_win_pieces   ;
    
        

IF count_y_win_pieces=4 THEN
UPDATE game_status SET `status` ='ended' , result='Y';
END IF;

IF count_r_win_pieces=4 THEN
UPDATE game_status SET `status` ='ended' , result='R';
END IF;

IF count_b_win_pieces=4 THEN
UPDATE game_status SET `status` ='ended' , result='B';
END IF;

IF count_g_win_pieces=4 THEN
UPDATE game_status SET `status` ='ended' , result='G';
END IF;

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.clean_board
DROP PROCEDURE IF EXISTS `clean_board`;
DELIMITER //
CREATE PROCEDURE `clean_board`()
BEGIN
	REPLACE INTO  board SELECT * FROM  board_empty;
	
	
	DELETE FROM dice;
	  INSERT INTO dice(prev_x, prev_y, new_x, new_y, created_at ,p_turn, dice, piece)
        VALUES (2, 3, 5, 2,NULL, 'Y', 0, 'Y1'),
        (3,3,5,2,NULL,'Y',0,'Y2'),
        (2,2,5,2,NULL,'Y',0,'Y3'),
        (3,2,5,2,NULL,'Y',0,'Y4'),
        
        (2, 10, 2, 7,NULL, 'G', 0, 'G1'),
		  (3, 10, 2, 7,NULL, 'G', 0, 'G2'),
		  (2, 9, 2, 7,NULL, 'G', 0, 'G3'),
		  (3, 9, 2, 7,NULL, 'G', 0, 'G4'),
		  
		          (9, 3, 10, 5,NULL, 'B', 0, 'B1'),
		  (10, 3, 10, 5,NULL, 'B', 0, 'B2'),
		  (9, 2, 10, 5,NULL, 'B', 0, 'B3'),
		  (10, 2, 10, 5,NULL, 'B', 0, 'B4'),
        
 (9,10,7,10,NULL,'R',0,'R1'),
        (10,10,7,10,NULL,'R',0,'R2'),
        (9,9,7,10,NULL,'R',0,'R3'),
        (10,9,7,10,NULL,'R',0,'R4');
			  
   	DELETE FROM missing_pieces;
   		DELETE FROM yellow_win_pieces;
   		DELETE FROM red_win_pieces;
   				DELETE FROM green_win_pieces;
   		DELETE FROM blue_win_pieces;
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.clean_players
DROP PROCEDURE IF EXISTS `clean_players`;
DELIMITER //
CREATE PROCEDURE `clean_players`()
BEGIN
	REPLACE INTO  players SELECT * FROM players_empty;
END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.dice
DROP TABLE IF EXISTS `dice`;
CREATE TABLE IF NOT EXISTS `dice` (
  `prev_x` tinyint(4) DEFAULT NULL,
  `prev_y` tinyint(4) DEFAULT NULL,
  `new_x` tinyint(4) DEFAULT NULL,
  `new_y` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `p_turn` enum('R','G','B','Y') DEFAULT NULL,
  `piece` varchar(3) NOT NULL,
  `dice` tinyint(4) DEFAULT NULL,
  `prev_path` tinyint(4) DEFAULT NULL,
  `new_path` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`piece`,`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.dice: ~16 rows (approximately)
DELETE FROM `dice`;
INSERT INTO `dice` (`prev_x`, `prev_y`, `new_x`, `new_y`, `created_at`, `p_turn`, `piece`, `dice`, `prev_path`, `new_path`) VALUES
	(4, 5, 1, 7, '2024-01-10 16:20:10', 'B', 'B1', 5, 13, 18),
	(10, 5, 7, 2, '2024-01-10 16:20:10', 'B', 'B2', 5, 1, 6),
	(9, 2, 10, 5, '2024-01-10 16:20:10', 'B', 'B3', 5, NULL, 1),
	(10, 2, 10, 5, '2024-01-10 16:20:10', 'B', 'B4', 5, NULL, 1),
	(2, 10, 2, 7, '2024-01-10 16:20:10', 'G', 'G1', 5, NULL, 1),
	(3, 10, 2, 7, '2024-01-10 16:20:10', 'G', 'G2', 5, NULL, 1),
	(2, 9, 2, 7, '2024-01-10 16:20:10', 'G', 'G3', 5, NULL, 1),
	(3, 9, 2, 7, '2024-01-10 16:20:10', 'G', 'G4', 5, NULL, 1),
	(7, 4, 5, 1, '2024-01-10 16:20:10', 'R', 'R1', 5, 13, 18),
	(7, 10, 10, 7, '2024-01-10 16:20:10', 'R', 'R2', 5, 1, 6),
	(9, 9, 7, 10, '2024-01-10 16:20:10', 'R', 'R3', 5, NULL, 1),
	(10, 9, 7, 10, '2024-01-10 16:20:10', 'R', 'R4', 5, NULL, 1),
	(2, 3, 5, 2, '2024-01-10 16:20:10', 'Y', 'Y1', 5, NULL, 1),
	(3, 3, 5, 2, '2024-01-10 16:20:10', 'Y', 'Y2', 5, NULL, 1),
	(2, 2, 5, 2, '2024-01-10 16:20:10', 'Y', 'Y3', 5, NULL, 1),
	(3, 2, 5, 2, '2024-01-10 16:20:10', 'Y', 'Y4', 5, NULL, 1);

-- Dumping structure for πίνακας adise23_ludo_game.error_log
DROP TABLE IF EXISTS `error_log`;
CREATE TABLE IF NOT EXISTS `error_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.error_log: ~0 rows (approximately)
DELETE FROM `error_log`;
INSERT INTO `error_log` (`id`, `message`, `created_at`) VALUES
	(1, 'Invalid piece parameter.', '2023-11-27 11:42:17');

-- Dumping structure for procedure adise23_ludo_game.fill_winners_table
DROP PROCEDURE IF EXISTS `fill_winners_table`;
DELIMITER //
CREATE PROCEDURE `fill_winners_table`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE winPiece VARCHAR(10);

    -- Declare a cursor to select all possible pieces
    DECLARE allPiecesCursor CURSOR FOR
        SELECT 'G1' UNION SELECT 'G2' UNION SELECT 'G3' UNION SELECT 'G4'
        UNION SELECT 'B1' UNION SELECT 'B2' UNION SELECT 'B3' UNION SELECT 'B4'
      UNION  SELECT 'Y1' UNION SELECT 'Y2' UNION SELECT 'Y3' UNION SELECT 'Y4'
        UNION SELECT 'R1' UNION SELECT 'R2' UNION SELECT 'R3' UNION SELECT 'R4';
        
    -- Use a NOT FOUND handler to exit the loop
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  -- Open the cursor
    OPEN allPiecesCursor;

    -- Loop through all possible pieces
    read_loop: LOOP
        -- Fetch the next piece
        FETCH allPiecesCursor INTO winPiece;
        
   -- an ta KITRINA pionia einai stis krifes theseis     
  IF NOT EXISTS (SELECT 1 FROM yellow_win_pieces WHERE piece = winPiece  ) THEN    
 
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 100 AND y = 1 )) THEN
            INSERT INTO yellow_win_pieces (piece, piece_color,id) VALUES ('Y1', 'Y',1);
        END IF;
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 100 AND Y =   2 )) THEN
            INSERT INTO yellow_win_pieces (piece, piece_color,id) VALUES ('Y2', 'Y',2);
        END IF; 
		      IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 100 AND Y = 3 )) THEN
            INSERT INTO yellow_win_pieces (piece, piece_color,id) VALUES ('Y3', 'Y',3);
        END IF;
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 100 AND Y = 4 )) THEN
            INSERT INTO yellow_win_pieces (piece, piece_color,id) VALUES ('Y4', 'Y',4);
        END IF;
        END IF;
        
        
           -- an ta MPLE pionia einai stis krifes theseis     
  IF NOT EXISTS (SELECT 1 FROM blue_win_pieces WHERE piece = winPiece  ) THEN    
 
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 20 AND y = 1 )) THEN
            INSERT INTO blue_win_pieces (piece, piece_color,id) VALUES ('B1', 'B',1);
        END IF;
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 20 AND Y =   2 )) THEN
            INSERT INTO blue_win_pieces (piece, piece_color,id) VALUES ('B2', 'B',2);
        END IF; 
		      IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 20 AND Y = 3 )) THEN
            INSERT INTO blue_win_pieces (piece, piece_color,id) VALUES ('B3', 'B',3);
        END IF;
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 20 AND Y = 4 )) THEN
            INSERT INTO blue_win_pieces (piece, piece_color,id) VALUES ('B4', 'B',4);
        END IF;
        END IF;
        
         -- an ta KOKKINA pionia einai stis krifes theseis   
       IF NOT EXISTS (SELECT 1 FROM red_win_pieces WHERE piece = winPiece  ) THEN  
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 30 AND y = 1 )) THEN
            INSERT INTO red_win_pieces (piece, piece_color,id) VALUES ('R1', 'R',1);
        END IF;
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 30 AND Y =  2 )) THEN
            INSERT INTO red_win_pieces (piece, piece_color,id) VALUES ('R2', 'R',2);
        END IF;
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 30 AND Y =  3 )) THEN
            INSERT INTO red_win_pieces (piece, piece_color,id) VALUES ('R3', 'R',3);
        END IF;
             IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 30 AND Y =  4 )) THEN
            INSERT INTO red_win_pieces (piece, piece_color,id) VALUES ('R4', 'R',4);
        END IF;
        END IF;
        
         -- an ta PRASINA pionia einai stis krifes theseis     
  IF NOT EXISTS (SELECT 1 FROM green_win_pieces WHERE piece = winPiece  ) THEN    
 
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 40 AND y = 1 )) THEN
            INSERT INTO green_win_pieces (piece, piece_color,id) VALUES ('G1', 'G',1);
        END IF;
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 40 AND Y =   2 )) THEN
            INSERT INTO green_win_pieces (piece, piece_color,id) VALUES ('G2', 'G',2);
        END IF; 
		      IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 40 AND Y = 3 )) THEN
            INSERT INTO green_win_pieces (piece, piece_color,id) VALUES ('G3', 'G',3);
        END IF;
            IF EXISTS (SELECT 1 FROM board WHERE piece = winPiece AND (X = 40 AND Y = 4 )) THEN
            INSERT INTO green_win_pieces (piece, piece_color,id) VALUES ('G4', 'G',4);
        END IF;
        END IF;
        
       
		 CALL check_winner(); 
        
        -- Check if we are done
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE allPiecesCursor;
END
    -- Insert rows into the temporary table//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.G1_dice
DROP PROCEDURE IF EXISTS `G1_dice`;
DELIMITER //
CREATE PROCEDURE `G1_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'G1' ORDER BY `created_at` DESC LIMIT 1 ;
 
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.G1_highlight
DROP PROCEDURE IF EXISTS `G1_highlight`;
DELIMITER //
CREATE PROCEDURE `G1_highlight`()
BEGIN
SELECT b.x, b.y, b.g_path
FROM board b
JOIN dice d ON b.g_path >= d.prev_path AND b.g_path <= ( d.new_path)
WHERE d.piece='G1'
ORDER BY b.g_path ASC; 

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.G2_dice
DROP PROCEDURE IF EXISTS `G2_dice`;
DELIMITER //
CREATE PROCEDURE `G2_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'G2' ORDER BY `created_at` DESC LIMIT 1 ;
 
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.G2_highlight
DROP PROCEDURE IF EXISTS `G2_highlight`;
DELIMITER //
CREATE PROCEDURE `G2_highlight`()
BEGIN
SELECT b.x, b.y, b.g_path
FROM board b
JOIN dice d ON b.g_path >= d.prev_path AND b.g_path <= ( d.new_path)
WHERE d.piece='G2'
ORDER BY b.g_path ASC; 

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.G3_dice
DROP PROCEDURE IF EXISTS `G3_dice`;
DELIMITER //
CREATE PROCEDURE `G3_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'G3' ORDER BY `created_at` DESC LIMIT 1 ;
 
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.G3_highlight
DROP PROCEDURE IF EXISTS `G3_highlight`;
DELIMITER //
CREATE PROCEDURE `G3_highlight`()
BEGIN
SELECT b.x, b.y, b.g_path
FROM board b
JOIN dice d ON b.g_path >= d.prev_path AND b.g_path <= ( d.new_path)
WHERE d.piece='G3'
ORDER BY b.g_path ASC; 

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.G4_dice
DROP PROCEDURE IF EXISTS `G4_dice`;
DELIMITER //
CREATE PROCEDURE `G4_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'G4' ORDER BY `created_at` DESC LIMIT 1 ;
 
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.G4_highlight
DROP PROCEDURE IF EXISTS `G4_highlight`;
DELIMITER //
CREATE PROCEDURE `G4_highlight`()
BEGIN
SELECT b.x, b.y, b.g_path
FROM board b
JOIN dice d ON b.g_path >= d.prev_path AND b.g_path <= ( d.new_path)
WHERE d.piece='G4'
ORDER BY b.g_path ASC; 

END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.game_status
DROP TABLE IF EXISTS `game_status`;
CREATE TABLE IF NOT EXISTS `game_status` (
  `status` enum('not active','initialized','started','ended','aborded') NOT NULL DEFAULT 'not active',
  `p_turn` enum('R','G','B','Y') DEFAULT NULL,
  `result` enum('R','G','B','Y','D') DEFAULT NULL,
  `last_change` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.game_status: ~0 rows (approximately)
DELETE FROM `game_status`;
INSERT INTO `game_status` (`status`, `p_turn`, `result`, `last_change`) VALUES
	('started', 'R', 'G', '2024-01-10 16:21:05');

-- Dumping structure for πίνακας adise23_ludo_game.green_win_pieces
DROP TABLE IF EXISTS `green_win_pieces`;
CREATE TABLE IF NOT EXISTS `green_win_pieces` (
  `piece` varchar(50) NOT NULL,
  `piece_color` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`piece`,`piece_color`,`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.green_win_pieces: ~0 rows (approximately)
DELETE FROM `green_win_pieces`;

-- Dumping structure for πίνακας adise23_ludo_game.missing_pieces
DROP TABLE IF EXISTS `missing_pieces`;
CREATE TABLE IF NOT EXISTS `missing_pieces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `missing_piece` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2509 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.missing_pieces: ~0 rows (approximately)
DELETE FROM `missing_pieces`;

-- Dumping structure for procedure adise23_ludo_game.move_piece
DROP PROCEDURE IF EXISTS `move_piece`;
DELIMITER //
CREATE PROCEDURE `move_piece`(
	IN `x1` INT,
	IN `y1` INT,
	IN `x2` INT,
	IN `y2` INT
)
BEGIN
    DECLARE p, p_color, piece_val VARCHAR(3);
    DECLARE color_val ENUM('R','G','B','Y');

    -- Use exception handling to rollback on error
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
           ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'An error occurred, transaction rolled back.';
    END;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the piece exists at the source coordinates
    SELECT piece, piece_color INTO p, p_color
    FROM `board`
WHERE x = x1 AND y = y1;
 
 IF p IS NOT NULL AND (p_color IN ('Y', 'R', 'G', 'B')) THEN    -- Move the piece to the destination coordinates
 
    -- Move the piece to the destination coordinates
    UPDATE `board`
    SET piece = NULL, piece_color = NULL
    WHERE x = x1 AND y = y1;
COMMIT;
    UPDATE `board`
    SET piece = p, piece_color = p_color
    WHERE x = x2 AND y = y2;

    COMMIT;
    ELSE
        -- If the piece does not exist at the source coordinates, rollback the transaction
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Piece does not exist at the specified coordinates.';
    END IF;
END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.players
DROP TABLE IF EXISTS `players`;
CREATE TABLE IF NOT EXISTS `players` (
  `username` varchar(20) DEFAULT NULL,
  `piece_color` enum('B','R','G','Y') NOT NULL,
  `token` varchar(100) DEFAULT NULL,
  `last_action` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`piece_color`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.players: ~4 rows (approximately)
DELETE FROM `players`;
INSERT INTO `players` (`username`, `piece_color`, `token`, `last_action`) VALUES
	('b', 'B', 'c5c7987c5b955ab972159b6d84bc47b7', '2024-01-10 16:20:20'),
	('r', 'R', 'e06c684f8bd7b65e3b89886f7334f794', '2024-01-10 16:20:15'),
	(NULL, 'G', NULL, NULL),
	(NULL, 'Y', NULL, NULL);

-- Dumping structure for πίνακας adise23_ludo_game.players_empty
DROP TABLE IF EXISTS `players_empty`;
CREATE TABLE IF NOT EXISTS `players_empty` (
  `username` varchar(20) DEFAULT NULL,
  `piece_color` enum('B','R','G','Y') NOT NULL,
  `token` varchar(100) DEFAULT NULL,
  `last_action` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`piece_color`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.players_empty: ~4 rows (approximately)
DELETE FROM `players_empty`;
INSERT INTO `players_empty` (`username`, `piece_color`, `token`, `last_action`) VALUES
	(NULL, 'B', NULL, NULL),
	(NULL, 'R', NULL, NULL),
	(NULL, 'G', NULL, NULL),
	(NULL, 'Y', NULL, NULL);

-- Dumping structure for procedure adise23_ludo_game.R1_dice
DROP PROCEDURE IF EXISTS `R1_dice`;
DELIMITER //
CREATE PROCEDURE `R1_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'R1' ORDER BY `created_at` DESC LIMIT 1 ;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.R1_highlight
DROP PROCEDURE IF EXISTS `R1_highlight`;
DELIMITER //
CREATE PROCEDURE `R1_highlight`()
BEGIN
SELECT b.x, b.y, b.r_path
FROM board b
JOIN dice d ON b.r_path >= d.prev_path AND b.r_path <= ( d.new_path)
WHERE d.piece='R1'
ORDER BY b.r_path ASC; 

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.R2_dice
DROP PROCEDURE IF EXISTS `R2_dice`;
DELIMITER //
CREATE PROCEDURE `R2_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'R2' ORDER BY `created_at` DESC LIMIT 1 ;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.R2_highlight
DROP PROCEDURE IF EXISTS `R2_highlight`;
DELIMITER //
CREATE PROCEDURE `R2_highlight`()
BEGIN
SELECT b.x, b.y, b.r_path
FROM board b
JOIN dice d ON b.r_path >= d.prev_path AND b.r_path <= ( d.new_path)
WHERE d.piece='R2'
ORDER BY b.r_path ASC;

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.R3_dice
DROP PROCEDURE IF EXISTS `R3_dice`;
DELIMITER //
CREATE PROCEDURE `R3_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'R3' ORDER BY `created_at` DESC LIMIT 1 ;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.R3_highlight
DROP PROCEDURE IF EXISTS `R3_highlight`;
DELIMITER //
CREATE PROCEDURE `R3_highlight`()
BEGIN
SELECT b.x, b.y, b.r_path
FROM board b
JOIN dice d ON b.r_path >= d.prev_path AND b.r_path <= ( d.new_path)
WHERE d.piece='R3'
ORDER BY b.r_path ASC;

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.R4_dice
DROP PROCEDURE IF EXISTS `R4_dice`;
DELIMITER //
CREATE PROCEDURE `R4_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'R4' ORDER BY `created_at` DESC LIMIT 1 ;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.R4_highlight
DROP PROCEDURE IF EXISTS `R4_highlight`;
DELIMITER //
CREATE PROCEDURE `R4_highlight`()
BEGIN
SELECT b.x, b.y, b.r_path
FROM board b
JOIN dice d ON b.r_path >= d.prev_path AND b.r_path <= ( d.new_path)
WHERE d.piece='R4'
ORDER BY b.r_path ASC;

END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.red_win_pieces
DROP TABLE IF EXISTS `red_win_pieces`;
CREATE TABLE IF NOT EXISTS `red_win_pieces` (
  `piece` varchar(50) NOT NULL,
  `piece_color` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`piece`,`piece_color`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.red_win_pieces: ~0 rows (approximately)
DELETE FROM `red_win_pieces`;

-- Dumping structure for procedure adise23_ludo_game.return_losers_home
DROP PROCEDURE IF EXISTS `return_losers_home`;
DELIMITER //
CREATE PROCEDURE `return_losers_home`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE missingPiece VARCHAR(10);

    -- Declare a cursor to select all possible pieces
       DECLARE allPiecesCursor CURSOR FOR
        SELECT 'G1' UNION SELECT 'G2' UNION SELECT 'G3' UNION SELECT 'G4'
        UNION SELECT 'B1' UNION SELECT 'B2' UNION SELECT 'B3' UNION SELECT 'B4'
      UNION  SELECT 'Y1' UNION SELECT 'Y2' UNION SELECT 'Y3' UNION SELECT 'Y4'
        UNION SELECT 'R1' UNION SELECT 'R2' UNION SELECT 'R3' UNION SELECT 'R4';
        

    -- Declare continue handler to exit loop
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN allPiecesCursor;

    -- Loop through all possible pieces
    read_loop: LOOP
        -- Fetch the next piece
        FETCH allPiecesCursor INTO missingPiece;

        -- Check if the piece is missing in the 'board' table
       IF NOT EXISTS (SELECT 1 FROM board WHERE piece = missingPiece) 
    THEN
            -- Insert the missing piece into the 'missing_pieces' table
            INSERT INTO missing_pieces (missing_piece) VALUES (missingPiece);
         
			 -- an efage antipalos  pioni tou kitrinou
			 
			    IF missingPiece LIKE 'Y1' THEN
                -- Move 'Y1' to the board at coordinates (2, 3)
                 UPDATE   board  
                              SET piece_color='Y', piece= 'Y1', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=2  AND  y=3    ;
			 
			 
			 
			 
			   ELSEIF missingPiece LIKE 'Y2' THEN
			     	 UPDATE   board  
               SET piece_color='Y', piece= 'Y2', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=3  AND y=3    ;
          

   ELSEIF missingPiece LIKE 'Y3' THEN
    UPDATE   board  
			     	   SET piece_color='Y', piece= 'Y3', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=2  AND Y=2    ;
					 
					 
   ELSEIF missingPiece LIKE 'Y4' THEN
    UPDATE   board  
			        SET piece_color='Y', piece= 'Y4', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=3  AND Y=2    ;

       	 -- an efage antipalos  pioni tou kokkinou
			    
           ELSEIF missingPiece LIKE 'R1' THEN
 UPDATE   board  
                  SET piece_color='R', piece= 'R1', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=9  AND Y=10    ;

 ELSEIF missingPiece LIKE 'R2' THEN
 UPDATE   board  
                 SET piece_color='R', piece= 'R2', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=10  AND Y=10    ;

 ELSEIF missingPiece LIKE 'R3' THEN
 UPDATE   board  
                SET piece_color='R', piece= 'R3', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=9  AND Y=9    ;
					 
					 
 ELSEIF missingPiece LIKE 'R4' THEN
	 UPDATE   board  
                 SET piece_color='R', piece= 'R4', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=10 AND Y=9    ;
             
                    
-- an efage antipalos  pioni tou prasinou
			    
           ELSEIF missingPiece LIKE 'G1' THEN
 				UPDATE   board  
                  SET piece_color='G', piece= 'G1', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=2  AND Y=10    ;
					 						  
		           ELSEIF missingPiece LIKE 'G2' THEN
 						UPDATE   board  
                  SET piece_color='G', piece= 'G2', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=3  AND Y=10    ;		
					 
					   ELSEIF missingPiece LIKE 'G3' THEN
 						UPDATE   board  
                  SET piece_color='G', piece= 'G3', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=2  AND Y=9    ;	
					 
					  ELSEIF missingPiece LIKE 'G4' THEN
 						UPDATE   board  
                  SET piece_color='G', piece= 'G4', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=3  AND Y=9    ;			  
						  
						  
					-- an efage antipalos  pioni tou mple
			    
           ELSEIF missingPiece LIKE 'B1' THEN
 				UPDATE   board  
                  SET piece_color='B', piece= 'B1', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=9  AND Y=3  ;
					 						  
		           ELSEIF missingPiece LIKE 'B2' THEN
 						UPDATE   board  
                  SET piece_color='B', piece= 'B2', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=10  AND Y=3    ;		
					 
					   ELSEIF missingPiece LIKE 'B3' THEN
 						UPDATE   board  
                  SET piece_color='B', piece= 'B3', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=9  AND Y=2    ;	
					 
					  ELSEIF missingPiece LIKE 'B4' THEN
 						UPDATE   board  
                  SET piece_color='B', piece= 'B4', y_path= NULL,b_path =NULL,r_path =NULL,g_path= NULL
					 WHERE  X=10 AND Y=2    ;			  
						  	  
				 END IF;		   
      END IF;
                
 
        -- Check if we are done
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE allPiecesCursor;
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.roll_dice
DROP PROCEDURE IF EXISTS `roll_dice`;
DELIMITER //
CREATE PROCEDURE `roll_dice`(
	IN `piece_num` VARCHAR(10),
	IN `@generated_dice_result` INT
)
BEGIN
    DECLARE current_x  INT;
    DECLARE current_y INT;
    DECLARE current_ypath INT;
    DECLARE current_rpath INT;
      DECLARE current_gpath INT;
    DECLARE current_bpath INT;
    DECLARE new_x  INT;
    DECLARE new_y  INT;
        DECLARE new_path INT;
         DECLARE prev_path INT;
    DECLARE new_ypath INT;
    DECLARE new_rpath INT;
        DECLARE new_gpath INT;
    DECLARE new_bpath INT;
    DECLARE dice_result INT;
    DECLARE generated_dice_result INT;
 

    -- Use exception handling to rollback on error
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION

    -- Start the transaction
    START TRANSACTION;


SET  generated_dice_result = @generated_dice_result;

-- Update the dice table with the generated dice result
UPDATE dice SET dice =  generated_dice_result;
  CASE piece_num
        WHEN 1 THEN
            -- Get the current coordinates of the piece
            SELECT x, y, y_path INTO current_x, current_y, current_ypath
            FROM board
            WHERE piece_color = 'Y' AND piece = 'Y1'; 
IF (current_ypath IS NULL) THEN
    SET new_x = 5;
    SET new_y = 2;
    SET new_path=1;
    
  -- call check_spot(new_x, new_y);
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'Y',
        dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'Y1';
     
ELSE
    SET new_ypath = current_ypath +  @generated_dice_result;
IF new_ypath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE y_path = new_ypath;
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'Y',
        dice =  @generated_dice_result,
        prev_path=current_ypath,
        new_path=new_ypath
    WHERE piece = 'Y1'  ;
 -- IF new_ypath  = 39 THEN
 



  END IF;
 
 
 IF (new_ypath >38 OR (new_x=100 AND new_y=1)) THEN
    UPDATE dice
    SET
    prev_x = current_x,
        prev_y = current_y ,
        new_x = 100,
        new_y = 1,
        p_turn = 'Y',
       dice =  @generated_dice_result,
        prev_path=current_ypath,
        new_path=41
    WHERE piece = 'Y1';
     
    END IF;
    
END IF;
   -- CALL `move_piece`(current_x, current_y, new_x, new_y);
-- Commit the transaction if everything is successful

        -- CALL Y1_dice();
 
            -- Rest of your Y1 case...

        WHEN 2 THEN
             -- Get the current coordinates of the piece
            SELECT x, y, y_path INTO current_x, current_y, current_ypath
            FROM board
            WHERE piece_color = 'Y' AND piece = 'Y2';
              
				  
			
    
IF (current_ypath IS NULL) THEN
    SET new_x = 5;
    SET new_y = 2;
        SET new_path=1;
    --   call check_spot(new_x, new_y);
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'Y',
         dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'Y2';
ELSE

    SET new_ypath = current_ypath +  @generated_dice_result;
IF new_ypath <=   39 THEN
	  
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE y_path = new_ypath;
    
  
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'Y',
       dice =  @generated_dice_result,
        prev_path=current_ypath,
        new_path=new_ypath
    WHERE piece = 'Y2';
 
 

END IF;
 IF (new_ypath  >38 OR new_x=100   AND new_y=2) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 100,
        new_y = 2,
        p_turn = 'Y',
       dice =  @generated_dice_result,
        prev_path=current_ypath,
        new_path=42
    WHERE piece = 'Y2';
    
    END IF;
END IF;
         -- CALL Y2_dice();

        WHEN 3 THEN
             -- Get the current coordinates of the piece
            SELECT x, y, y_path INTO current_x, current_y, current_ypath
            FROM board
            WHERE piece_color = 'Y' AND piece = 'Y3';
IF (current_ypath IS NULL) THEN
    SET new_x = 5;
    SET new_y = 2;
        SET new_path=1;
   --    call check_spot(new_x, new_y);
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'Y',
         dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'Y3';
ELSE
    SET new_ypath = current_ypath +  @generated_dice_result;
IF new_ypath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE y_path = new_ypath;
    
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'Y',
         dice =  @generated_dice_result,
        prev_path=current_ypath,
        new_path=new_ypath
    WHERE piece = 'Y3';
END IF;
 IF (new_ypath >38 OR new_x=100 AND new_y=3) THEN
    UPDATE dice
    SET
    prev_x = current_x,
        prev_y = current_y ,
        new_x = 100,
        new_y = 3,
        p_turn = 'Y',
       dice =  @generated_dice_result,
        prev_path=current_ypath,
        new_path=43
    WHERE piece = 'Y3';
      
     END IF;
END IF;
         --  CALL Y3_dice();

        WHEN 4 THEN
              -- Get the current coordinates of the piece
            SELECT x, y, y_path INTO current_x, current_y, current_ypath
            FROM board
            WHERE piece_color = 'Y' AND piece = 'Y4';
IF (current_ypath IS NULL) THEN
    SET new_x = 5;
    SET new_y = 2;
        SET new_path=1;
      -- call check_spot(new_x, new_y);
       
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'Y',
       dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'Y4';
ELSE
    SET new_ypath = current_ypath +  @generated_dice_result;
IF new_ypath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE y_path = new_ypath;

   
   
   
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'Y',
      dice =  @generated_dice_result,
        prev_path=current_ypath,
        new_path=new_ypath
    WHERE piece = 'Y4';
END IF;
 IF (new_ypath  >38 OR new_x=100   AND new_y=4) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 100,
        new_y = 4,
        p_turn = 'Y',
       dice =  @generated_dice_result,
        prev_path=current_ypath,
        new_path=44
    WHERE piece = 'Y4';
     
    END IF;
END IF;
 
-- pioni 1  tou mple
WHEN 11 THEN
            -- Get the current coordinates of the piece
            SELECT x, y, b_path INTO current_x, current_y, current_bpath
            FROM board
            WHERE piece_color = 'B' AND piece = 'B1'; 
IF (current_bpath IS NULL) THEN
    SET new_x = 10;
    SET new_y = 5;
    SET new_path=1;
 
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'B',
        dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'B1';
     
ELSE
    SET new_bpath = current_bpath +  @generated_dice_result;
IF new_bpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE b_path = new_bpath;
 
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'B',
        dice =  @generated_dice_result,
        prev_path=current_bpath,
        new_path=new_bpath
    WHERE piece = 'B1'  ;
 -- IF new_ypath  = 39 THEN
 



  END IF;
 
 
 IF (new_bpath >38 OR (new_x=20 AND new_y=1)) THEN
    UPDATE dice
    SET
    prev_x = current_x,
        prev_y = current_y ,
        new_x = 20,
        new_y = 1,
        p_turn = 'B',
       dice =  @generated_dice_result,
        prev_path=current_bpath,
        new_path=41
    WHERE piece = 'B1';
     
    END IF;
    
END IF;
 
-- pioni 2 tou mple
WHEN 22 THEN
            -- Get the current coordinates of the piece
            SELECT x, y, b_path INTO current_x, current_y, current_bpath
            FROM board
            WHERE piece_color = 'B' AND piece = 'B2'; 
IF (current_bpath IS NULL) THEN
    SET new_x = 10;
    SET new_y = 5;
    SET new_path=1;
    
  -- call check_spot(new_x, new_y);
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'B',
        dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'B2';
     
ELSE
    SET new_bpath = current_bpath +  @generated_dice_result;
IF new_bpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE b_path = new_bpath;
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'B',
        dice =  @generated_dice_result,
        prev_path=current_bpath,
        new_path=new_bpath
    WHERE piece = 'B2'  ;
 
  END IF;
 
 
 IF (new_bpath >38 OR (new_x=20 AND new_y=2)) THEN
    UPDATE dice
    SET
    prev_x = current_x,
        prev_y = current_y ,
        new_x = 20,
        new_y = 2,
        p_turn = 'B',
       dice =  @generated_dice_result,
        prev_path=current_bpath,
        new_path=42
    WHERE piece = 'B2';
     
    END IF;
    
END IF;
 
-- pioni 3 tou mple
WHEN 33 THEN
            -- Get the current coordinates of the piece
            SELECT x, y, b_path INTO current_x, current_y, current_bpath
            FROM board
            WHERE piece_color = 'B' AND piece = 'B3'; 
IF (current_bpath IS NULL) THEN
    SET new_x = 10;
    SET new_y = 5;
    SET new_path=1;
 
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'B',
        dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'B3';
     
ELSE
    SET new_bpath = current_bpath +  @generated_dice_result;
IF new_bpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE b_path = new_bpath;
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'B',
        dice =  @generated_dice_result,
        prev_path=current_bpath,
        new_path=new_bpath
    WHERE piece = 'B3'  ;
 
  END IF;
 
 
 IF (new_bpath >38 OR (new_x=20 AND new_y=3)) THEN
    UPDATE dice
    SET
    prev_x = current_x,
        prev_y = current_y ,
        new_x = 20,
        new_y = 3,
        p_turn = 'B',
       dice =  @generated_dice_result,
        prev_path=current_bpath,
        new_path=43
    WHERE piece = 'B3';
     
    END IF;
    
END IF;
 
-- pioni 4 tou mple
WHEN 44 THEN
            -- Get the current coordinates of the piece
            SELECT x, y, b_path INTO current_x, current_y, current_bpath
            FROM board
            WHERE piece_color = 'B' AND piece = 'B4'; 
IF (current_bpath IS NULL) THEN
    SET new_x = 10;
    SET new_y = 5;
    SET new_path=1;
    
  -- call check_spot(new_x, new_y);
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'B',
        dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'B4';
     
ELSE
    SET new_bpath = current_bpath +  @generated_dice_result;
IF new_bpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE b_path = new_bpath;
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'B',
        dice =  @generated_dice_result,
        prev_path=current_bpath,
        new_path=new_bpath
    WHERE piece = 'B4'  ;
 

  END IF;
 
 
 IF (new_bpath >38 OR (new_x=20 AND new_y=4)) THEN
    UPDATE dice
    SET
    prev_x = current_x,
        prev_y = current_y ,
        new_x = 20,
        new_y = 4,
        p_turn = 'B',
       dice =  @generated_dice_result,
        prev_path=current_bpath,
        new_path=44
    WHERE piece = 'B4';
     
    END IF;
    
END IF;
 
         -- pioni 1 tou red
        WHEN 111 THEN
        SELECT x, y, r_path INTO current_x, current_y, current_rpath
FROM board
WHERE piece_color = 'R' AND piece = 'R1';

        
-- If the piece exists, calculate the new coordinates
IF (current_rpath IS NULL) THEN
    SET new_x = 7;
    SET new_y = 10;
      SET new_path=1;
    
      -- call check_spot(new_x, new_y);
       
       
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'R1';
ELSE
    SET new_rpath = current_rpath +  @generated_dice_result;
IF new_rpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE r_path = new_rpath;

 
   
    
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path= current_rpath,
        new_path=new_rpath
    WHERE piece = 'R1';
END IF;
 IF (new_rpath  >38 OR new_x=30    AND new_y=1) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 30 ,
        new_y = 1,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path=current_rpath,
        new_path=41
    WHERE piece = 'R1';
     
END IF;
END IF;
        
        -- pioni 2 tou red
        WHEN 222 THEN
                SELECT x, y, r_path INTO current_x, current_y, current_rpath
FROM board
WHERE piece_color = 'R' AND piece = 'R2';

        
-- If the piece exists, calculate the new coordinates
IF (current_rpath IS NULL) THEN
    SET new_x = 7;
    SET new_y = 10;
        SET new_path=1;
    
     --  call check_spot(new_x, new_y);
       
       
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'R2';
   
ELSE
    SET new_rpath = current_rpath +  @generated_dice_result;
IF new_rpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE r_path = new_rpath;


   
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path=current_rpath,
        new_path=new_rpath
    WHERE piece = 'R2';
END IF;
 IF (new_rpath  >38 OR new_x=30   AND new_y=2) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 30 ,
        new_y = 2,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path=current_rpath,
        new_path=42
    WHERE piece = 'R2';
        
    END IF;
END IF;

          
-- pioni 3 tou red
        WHEN 333 THEN
                SELECT x, y, r_path INTO current_x, current_y, current_rpath
FROM board
WHERE piece_color = 'R' AND piece = 'R3';

        
-- If the piece exists, calculate the new coordinates
IF (current_rpath IS NULL) THEN
    SET new_x = 7;
    SET new_y = 10;
        SET new_path=1;
      -- call check_spot(new_x, new_y);
       
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'R',
        dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'R3';
ELSE
    SET new_rpath = current_rpath +  @generated_dice_result;
IF new_rpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE r_path = new_rpath;


   call check_spot(new_x, new_y);
   
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'R',
        dice =  @generated_dice_result,
        prev_path=current_rpath,
        new_path=new_rpath
    WHERE piece = 'R3';
END IF;
 IF (new_rpath  >38 OR new_x=30    AND new_y=3) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 30 ,
        new_y = 3,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path=current_rpath,
        new_path=43
    WHERE piece = 'R3';
    
    END IF;
END IF;

             -- CALL R3_dice();
-- pioni 4 tou red
        WHEN 444 THEN
        
                SELECT x, y, r_path INTO current_x, current_y, current_rpath
FROM board
WHERE piece_color = 'R' AND piece = 'R4';

        
-- If the piece exists, calculate the new coordinates
IF (current_rpath IS NULL) THEN
    SET new_x = 7;
    SET new_y = 10;
      SET new_path=1;
     --  call check_spot(new_x, new_y);
       
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'R4';
ELSE
    SET new_rpath = current_rpath +  @generated_dice_result;
IF new_rpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE r_path = new_rpath;
    
   
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'R',
        dice =  @generated_dice_result,
        prev_path=current_rpath,
        new_path=new_rpath
    WHERE piece = 'R4';
END IF;
 IF (new_rpath  >38 OR new_x=30     AND new_y=4) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 30 ,
        new_y = 4,
        p_turn = 'R',
       dice =  @generated_dice_result,
        prev_path=current_rpath,
        new_path=44
    WHERE piece = 'R4';
    
    END IF;
END IF;



   -- pioni 1 tou green
        WHEN 1111 THEN
        SELECT x, y, g_path INTO current_x, current_y, current_gpath
FROM board
WHERE piece_color = 'G' AND piece = 'G1';

        
-- If the piece exists, calculate the new coordinates
IF (current_gpath IS NULL) THEN
    SET new_x = 2;
    SET new_y = 7;
      SET new_path=1;
    
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'G1';
ELSE
    SET new_gpath = current_gpath +  @generated_dice_result;
IF new_gpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE g_path = new_gpath;

 
   
    
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path= current_gpath,
        new_path=new_gpath
    WHERE piece = 'G1';
END IF;
 IF (new_gpath  >38 OR new_x=40    AND new_y=1) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 40 ,
        new_y = 1,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path=current_gpath,
        new_path=41
    WHERE piece = 'G1';
     
END IF;
END IF;
 
 
 
   -- pioni 2 tou green
        WHEN 2222 THEN
        SELECT x, y, g_path INTO current_x, current_y, current_gpath
FROM board
WHERE piece_color = 'G' AND piece = 'G2';

        
-- If the piece exists, calculate the new coordinates
IF (current_gpath IS NULL) THEN
    SET new_x = 2;
    SET new_y = 7;
      SET new_path=1;
    
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'G2';
ELSE
    SET new_gpath = current_gpath +  @generated_dice_result;
IF new_gpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE g_path = new_gpath;

 
   
    
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path= current_gpath,
        new_path=new_gpath
    WHERE piece = 'G2';
END IF;
 IF (new_gpath  >38 OR new_x=40    AND new_y=2) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 40 ,
        new_y = 2,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path=current_gpath,
        new_path=42
    WHERE piece = 'G2';
     
END IF;
END IF;
 
 
 
   -- pioni 3 tou green
        WHEN 3333 THEN
        SELECT x, y, g_path INTO current_x, current_y, current_gpath
FROM board
WHERE piece_color = 'G' AND piece = 'G3';

        
-- If the piece exists, calculate the new coordinates
IF (current_gpath IS NULL) THEN
    SET new_x = 2;
    SET new_y = 7;
      SET new_path=1;
    
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'G3';
ELSE
    SET new_gpath = current_gpath +  @generated_dice_result;
IF new_gpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE g_path = new_gpath;

 
   
    
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path= current_gpath,
        new_path=new_gpath
    WHERE piece = 'G3';
END IF;
 IF (new_gpath  >38 OR new_x=40    AND new_y=3) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 40 ,
        new_y = 3,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path=current_gpath,
        new_path=43
    WHERE piece = 'G3';
     
END IF;
END IF;
 
 
 
   -- pioni 4 tou green
        WHEN 4444 THEN
        SELECT x, y, g_path INTO current_x, current_y, current_gpath
FROM board
WHERE piece_color = 'G' AND piece = 'G4';

        
-- If the piece exists, calculate the new coordinates
IF (current_gpath IS NULL) THEN
    SET new_x = 2;
    SET new_y = 7;
      SET new_path=1;
    
 
    -- Update the existing record in the dice table
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path= NULL,
        new_path=1
    WHERE piece = 'G4';
ELSE
    SET new_gpath = current_gpath +  @generated_dice_result;
IF new_gpath <= 39 THEN
    -- Calculate the new coordinates
    SELECT X, Y INTO new_x, new_y
    FROM `board`
    WHERE g_path = new_gpath;

 
   
    
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y,
        new_x = new_x,
        new_y = new_y,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path= current_gpath,
        new_path=new_gpath
    WHERE piece = 'G4';
END IF;
 IF (new_gpath  >38 OR new_x=40    AND new_y=4) THEN
    UPDATE dice
    SET
        prev_x = current_x,
        prev_y = current_y ,
        new_x = 40 ,
        new_y = 4,
        p_turn = 'G',
       dice =  @generated_dice_result,
        prev_path=current_gpath,
        new_path=44
    WHERE piece = 'G4';
     
END IF;
END IF;
 
       -- CALL R4_dice();
        ELSE
            -- Default case
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid piece parameter.';
    END CASE;
    COMMIT;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.roll_diceOUT
DROP PROCEDURE IF EXISTS `roll_diceOUT`;
DELIMITER //
CREATE PROCEDURE `roll_diceOUT`(
	OUT `generated_dice_result` INT
)
BEGIN
  
    -- Generate a random number between 1 and 6
    SET  generated_dice_result = FLOOR(1 + RAND() * 6);
 SELECT  generated_dice_result ;
 
 -- prwtos paiktis yellow
 CALL roll_dice(1, generated_dice_result); 
 CALL roll_dice(2,generated_dice_result); 
 CALL roll_dice(3, generated_dice_result);
 CALL roll_dice(4, generated_dice_result);
 
 -- paiktis blue
  CALL roll_dice(11, generated_dice_result); 
 CALL roll_dice(22,generated_dice_result); 
 CALL roll_dice(33, generated_dice_result);
 CALL roll_dice(44, generated_dice_result);
 
 
 -- paiktis red
 CALL roll_dice(111, generated_dice_result);
 CALL roll_dice(222, generated_dice_result);
 CALL roll_dice(333, generated_dice_result);
 CALL roll_dice(444, generated_dice_result);
 
 
 -- paiktis green
  CALL roll_dice(1111, generated_dice_result);
 CALL roll_dice(2222, generated_dice_result);
 CALL roll_dice(3333, generated_dice_result);
 CALL roll_dice(4444, generated_dice_result);
 
 
END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.temp
DROP TABLE IF EXISTS `temp`;
CREATE TABLE IF NOT EXISTS `temp` (
  `prev_x` tinyint(4) DEFAULT NULL,
  `prev_y` tinyint(4) DEFAULT NULL,
  `new_x` tinyint(4) DEFAULT NULL,
  `new_y` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `p_turn` enum('R','G','B','Y') DEFAULT NULL,
  PRIMARY KEY (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.temp: ~11 rows (approximately)
DELETE FROM `temp`;
INSERT INTO `temp` (`prev_x`, `prev_y`, `new_x`, `new_y`, `created_at`, `p_turn`) VALUES
	(2, 3, 5, 2, '2023-11-25 17:12:11', NULL),
	(3, 7, NULL, NULL, '2023-11-25 17:15:33', NULL),
	(6, 11, NULL, NULL, '2023-11-25 17:16:24', NULL),
	(NULL, NULL, 5, 2, '2023-11-25 17:17:12', NULL),
	(3, 5, NULL, NULL, '2023-11-25 17:18:05', NULL),
	(6, 11, 7, 8, '2023-11-25 17:23:58', NULL),
	(7, 8, 10, 7, '2023-11-25 17:25:30', NULL),
	(10, 7, 10, 5, '2023-11-25 17:54:42', NULL),
	(10, 5, 7, 4, '2023-11-25 17:54:45', NULL),
	(6, 2, NULL, NULL, '2023-11-25 17:55:41', NULL),
	(7, 4, 7, 2, '2023-11-25 17:55:43', NULL);

-- Dumping structure for procedure adise23_ludo_game.timer_decrease
DROP PROCEDURE IF EXISTS `timer_decrease`;
DELIMITER //
CREATE PROCEDURE `timer_decrease`()
BEGIN

DECLARE current_second INT;
 DECLARE count_r INT;
    DECLARE count_y INT;
     DECLARE count_g INT;
    DECLARE count_b INT;
    
     DECLARE red_exists INT;
    DECLARE yellow_exists INT;
     DECLARE green_exists INT;
    DECLARE blue_exists INT;
    
       DECLARE count_players INT;
    


    SELECT COUNT(*) INTO count_r FROM game_status WHERE p_turn = 'R';
    SELECT COUNT(*) INTO count_y FROM game_status WHERE p_turn = 'Y';
     SELECT COUNT(*) INTO count_g FROM game_status WHERE p_turn = 'G';
    SELECT COUNT(*) INTO count_b FROM game_status WHERE p_turn = 'B';

SELECT COUNT(*) INTO red_exists FROM players WHERE piece_color = 'R' AND username IS NOT NULL;
SELECT COUNT(*) INTO yellow_exists FROM players WHERE piece_color = 'Y' AND username IS NOT NULL;
SELECT COUNT(*) INTO green_exists FROM players WHERE piece_color = 'G' AND username IS NOT NULL;
SELECT COUNT(*) INTO blue_exists FROM players WHERE piece_color = 'B' AND username IS NOT NULL;

SELECT   COUNT(*) INTO count_players  FROM players WHERE   username IS NOT NULL;
-- meionw kata ena  defterolepto se kathe klisi
    UPDATE timer_table
    SET second = second - 1
    WHERE id = 1;
  
        IF (SELECT second FROM timer_table WHERE id = 1) <= -1 THEN         
        UPDATE timer_table
        SET    minute = 0  ,
            SECOND = 30
        WHERE id = 1;
        END IF;
    
    -- an termatisei o xronos
       IF (SELECT second FROM timer_table WHERE id = 1)  = 0 THEN
    
   CALL check_turn();
 
 
 
      END IF;   
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.timer_reset
DROP PROCEDURE IF EXISTS `timer_reset`;
DELIMITER //
CREATE PROCEDURE `timer_reset`()
BEGIN
    UPDATE timer_table
    SET SECOND =  30
    WHERE id = 1;
      SELECT minute, second FROM timer_table WHERE id = 1; 
END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.timer_table
DROP TABLE IF EXISTS `timer_table`;
CREATE TABLE IF NOT EXISTS `timer_table` (
  `minute` int(11) DEFAULT NULL,
  `second` int(11) DEFAULT NULL,
  `id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.timer_table: ~0 rows (approximately)
DELETE FROM `timer_table`;
INSERT INTO `timer_table` (`minute`, `second`, `id`) VALUES
	(0, 30, 1);

-- Dumping structure for procedure adise23_ludo_game.timer_value
DROP PROCEDURE IF EXISTS `timer_value`;
DELIMITER //
CREATE PROCEDURE `timer_value`()
BEGIN
DECLARE current_second INT;
CALL timer_decrease();
 
    
    

    SELECT minute, second FROM timer_table WHERE id = 1; 
 

END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `usersId` int(11) NOT NULL AUTO_INCREMENT,
  `usersName` varchar(128) NOT NULL,
  `usersEmail` varchar(128) NOT NULL,
  `usersPwd` varchar(128) NOT NULL,
  PRIMARY KEY (`usersId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.users: ~4 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`usersId`, `usersName`, `usersEmail`, `usersPwd`) VALUES
	(1, 'Dimitris', 'dimitris121997@gmail.com', '$2y$10$wHp4pOtEadNxnRBCmhUOjOf7fXJjRUCE2TIf4okRtEJRol1pDwuVq'),
	(3, 'test', 'test@gmail.com', '$2y$10$WQt5m/LDZ627ioDYj2T6peGwMeRHjq5RHlnjSGzQX1e/K1x/KC5Oy'),
	(4, 'blue', 'margarita.iliopoulou@hotmail.com', '$2y$10$jlYZYN4gCf4i8dHMsi9iC.FyIz9MWo6iCG0wqMKDQEJXT2bq0WLF2'),
	(5, 'red', 'red@email.com', '$2y$10$58ZhHJiHD6U4JKjkht2Ko.H9dKZJQDhmY4ieoQfdFIbJfECvawynW');

-- Dumping structure for procedure adise23_ludo_game.Y1_dice
DROP PROCEDURE IF EXISTS `Y1_dice`;
DELIMITER //
CREATE PROCEDURE `Y1_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'Y1' ORDER BY `created_at` DESC LIMIT 1 ;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.Y1_highlight
DROP PROCEDURE IF EXISTS `Y1_highlight`;
DELIMITER //
CREATE PROCEDURE `Y1_highlight`()
BEGIN
SELECT b.x, b.y, b.y_path
FROM board b
JOIN dice d ON b.y_path >= d.prev_path AND b.y_path <= ( d.new_path)
WHERE d.piece='Y1'
ORDER BY b.y_path ASC;

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.Y2_dice
DROP PROCEDURE IF EXISTS `Y2_dice`;
DELIMITER //
CREATE PROCEDURE `Y2_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'Y2' ORDER BY `created_at` DESC LIMIT 1 ;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.Y2_highlight
DROP PROCEDURE IF EXISTS `Y2_highlight`;
DELIMITER //
CREATE PROCEDURE `Y2_highlight`()
BEGIN
SELECT b.x, b.y, b.y_path
FROM board b
JOIN dice d ON b.y_path >= d.prev_path AND b.y_path <= ( d.new_path)
WHERE d.piece='Y2'
ORDER BY b.y_path ASC;

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.Y3_dice
DROP PROCEDURE IF EXISTS `Y3_dice`;
DELIMITER //
CREATE PROCEDURE `Y3_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'Y3' ORDER BY `created_at` DESC LIMIT 1 ;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.Y3_highlight
DROP PROCEDURE IF EXISTS `Y3_highlight`;
DELIMITER //
CREATE PROCEDURE `Y3_highlight`()
BEGIN
SELECT b.x, b.y, b.y_path
FROM board b
JOIN dice d ON b.y_path >= d.prev_path AND b.y_path <= ( d.new_path)
WHERE d.piece='Y3'
ORDER BY b.y_path ASC;

END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.Y4_dice
DROP PROCEDURE IF EXISTS `Y4_dice`;
DELIMITER //
CREATE PROCEDURE `Y4_dice`()
BEGIN
   SELECT * FROM  dice WHERE piece = 'Y4' ORDER BY `created_at` DESC LIMIT 1 ;
 
END//
DELIMITER ;

-- Dumping structure for procedure adise23_ludo_game.Y4_highlight
DROP PROCEDURE IF EXISTS `Y4_highlight`;
DELIMITER //
CREATE PROCEDURE `Y4_highlight`()
BEGIN
SELECT b.x, b.y, b.y_path
FROM board b
JOIN dice d ON b.y_path >= d.prev_path AND b.y_path <= ( d.new_path)
WHERE d.piece='Y4'
ORDER BY b.y_path ASC;

END//
DELIMITER ;

-- Dumping structure for πίνακας adise23_ludo_game.yellow_win_pieces
DROP TABLE IF EXISTS `yellow_win_pieces`;
CREATE TABLE IF NOT EXISTS `yellow_win_pieces` (
  `piece` varchar(50) NOT NULL,
  `piece_color` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`piece`,`piece_color`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table adise23_ludo_game.yellow_win_pieces: ~0 rows (approximately)
DELETE FROM `yellow_win_pieces`;

-- Dumping structure for trigger adise23_ludo_game.game_status_update
DROP TRIGGER IF EXISTS `game_status_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER game_status_update BEFORE UPDATE
ON game_status
FOR EACH ROW BEGIN
SET NEW.last_change = NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
