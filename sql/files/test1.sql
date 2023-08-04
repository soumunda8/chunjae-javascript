-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        11.0.2-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- edu 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `edu` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `edu`;

-- 테이블 edu.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `bno` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `author` varchar(16) DEFAULT NULL,
  `resdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `cnt` int(11) DEFAULT 0,
  PRIMARY KEY (`bno`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 edu.board:~8 rows (대략적) 내보내기
INSERT INTO `board` (`bno`, `title`, `content`, `author`, `resdate`, `cnt`) VALUES
	(1, '더미글1', '여기는 더미글1입니다', 'admin', '2023-07-28 01:12:34', 3),
	(2, '더미글2', '여기는 더미글2입니다', 'admin', '2023-07-28 01:13:34', 7),
	(3, '더미글3', '여기는 더미글3입니다', 'admin', '2023-07-28 01:13:40', 3),
	(4, '더미글4', '여기는 더미글4입니다', 'admin', '2023-07-28 01:13:47', 0),
	(5, '더미글5', '여기는 더미글5입니다', 'lee', '2023-07-28 01:14:05', 0),
	(6, '더미글6', '여기는 더미글6입니다', 'admin', '2023-07-28 01:14:24', 0),
	(7, '더미글7', '여기는 더미글7입니다', 'admin', '2023-07-28 01:14:32', 1),
	(8, '더미글8', '여기는 더미글8입니다', 'lee', '2023-07-28 01:22:48', 1);

-- 테이블 edu.board2 구조 내보내기
CREATE TABLE IF NOT EXISTS `board2` (
  `bno` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `author` varchar(16) DEFAULT NULL,
  `resdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `cnt` int(11) DEFAULT 0,
  PRIMARY KEY (`bno`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 edu.board2:~8 rows (대략적) 내보내기
INSERT INTO `board2` (`bno`, `title`, `content`, `author`, `resdate`, `cnt`) VALUES
	(1, '더미글1', '여기는 더미글1입니다', 'admin', '2023-07-28 01:12:34', 0),
	(2, '더미글2', '여기는 더미글2입니다', 'admin', '2023-07-28 01:13:34', 0),
	(3, '더미글3', '여기는 더미글3입니다', 'admin', '2023-07-28 01:13:40', 0),
	(4, '더미글4', '여기는 더미글4입니다', 'admin', '2023-07-28 01:13:47', 0),
	(5, '더미글5', '여기는 더미글5입니다', 'lee', '2023-07-28 01:14:05', 0),
	(6, '더미글6', '여기는 더미글6입니다', 'admin', '2023-07-28 01:14:24', 0),
	(7, '더미글7', '여기는 더미글7입니다', 'admin', '2023-07-28 01:14:32', 0),
	(8, '더미글8', '여기는 더미글8입니다', 'lee', '2023-07-28 01:22:48', 0);

-- 테이블 edu.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `id` varchar(16) NOT NULL,
  `pw` varchar(330) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tel` varchar(13) DEFAULT NULL,
  `regdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `POINT` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 edu.member:~5 rows (대략적) 내보내기
INSERT INTO `member` (`id`, `pw`, `NAME`, `email`, `tel`, `regdate`, `POINT`) VALUES
	('admin', '1234', '관리자', 'admin@edu.com', '010-1004-1004', '2023-07-28 00:50:49', 0),
	('hwang', '7979', '황교진', 'hwang@edu.com', '010-2848-7979', '2023-07-28 01:06:20', 0),
	('kim', '4321', '김현경', 'kim@edu.com', '010-7979-2848', '2023-07-28 01:06:20', 0),
	('lee', '1111', '이소윤', 'lee@edu.com', '010-2424-2424', '2023-07-28 01:06:20', 0),
	('oh', '2222', '오세훈', 'oh@edu.com', '010-2222-1234', '2023-07-28 01:06:20', 0);

-- 뷰 edu.writer_info 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `writer_info` (
	`id` VARCHAR(16) NOT NULL COLLATE 'utf8mb4_general_ci',
	`name` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`bno` INT(11) NOT NULL,
	`title` VARCHAR(200) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- 뷰 edu.writer_info 구조 내보내기
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `writer_info`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `writer_info` AS (SELECT a.id, a.name, a.email, b.bno, b.title FROM MEMBER a INNER JOIN board b ON a.id=b.author) ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
