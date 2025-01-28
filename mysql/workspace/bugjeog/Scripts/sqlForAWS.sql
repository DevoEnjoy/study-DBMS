create database bugjeog;
use bugjeog;

CREATE TABLE `tbl_business` (
  `business_id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_email` varchar(500) NOT NULL,
  `business_password` varchar(500) NOT NULL,
  `business_ceo_name` varchar(500) NOT NULL,
  `business_number` varchar(500) NOT NULL,
  `business_company_name` varchar(500) NOT NULL,
  `business_phone_number` varchar(500) NOT NULL,
  `business_establishment_date` datetime NOT NULL,
  `business_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `business_status` int DEFAULT '1',
  `business_img_original_name` varchar(500) DEFAULT NULL,
  `business_img_uuid` varchar(500) DEFAULT NULL,
  `business_img_path` varchar(500) DEFAULT NULL,
  `business_location` varchar(500) DEFAULT NULL,
  `business_category` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`business_id`),
  UNIQUE KEY `business_email` (`business_email`),
  UNIQUE KEY `business_number` (`business_number`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_member definition
CREATE TABLE `tbl_member` (
  `member_id` int unsigned NOT NULL AUTO_INCREMENT,
  `member_email` varchar(500) NOT NULL,
  `member_password` varchar(500) NOT NULL,
  `member_phone_number` varchar(500) NOT NULL,
  `member_name` varchar(500) NOT NULL,
  `member_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `member_status` int DEFAULT '1',
  `member_img_original_name` varchar(500) DEFAULT NULL,
  `member_img_uuid` varchar(500) DEFAULT NULL,
  `member_img_path` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `member_email` (`member_email`),
  UNIQUE KEY `member_phone_number` (`member_phone_number`),
  UNIQUE KEY `member_img_uuid` (`member_img_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_notice definition
CREATE TABLE `tbl_notice` (
  `notice_id` int unsigned NOT NULL AUTO_INCREMENT,
  `notice_title` varchar(500) NOT NULL,
  `notice_content` varchar(500) NOT NULL,
  `notice_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_board_business definition
CREATE TABLE `tbl_board_business` (
  `board_business_id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned DEFAULT NULL,
  `board_business_title` varchar(500) NOT NULL,
  `board_business_content` varchar(500) NOT NULL,
  `board_business_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `board_business_update_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `board_business_status` int DEFAULT '1',
  PRIMARY KEY (`board_business_id`),
  KEY `fk_board_business` (`business_id`),
  CONSTRAINT `fk_board_business` FOREIGN KEY (`business_id`) REFERENCES `tbl_business` (`business_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_board_business_img definition
CREATE TABLE `tbl_board_business_img` (
  `board_business_img_id` int unsigned NOT NULL AUTO_INCREMENT,
  `board_business_id` int unsigned DEFAULT NULL,
  `board_business_img_original_name` varchar(500) NOT NULL,
  `board_business_img_uuid` varchar(500) NOT NULL,
  `board_business_img_path` varchar(500) NOT NULL,
  `main` char(1) DEFAULT '0',
  PRIMARY KEY (`board_business_img_id`),
  KEY `fk_img_business` (`board_business_id`),
  CONSTRAINT `fk_img_business` FOREIGN KEY (`board_business_id`) REFERENCES `tbl_board_business` (`board_business_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_board_free definition
CREATE TABLE `tbl_board_free` (
  `board_free_id` int unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned DEFAULT NULL,
  `business_id` int unsigned DEFAULT NULL,
  `board_free_title` varchar(500) NOT NULL,
  `board_free_content` varchar(500) NOT NULL,
  `board_free_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `board_free_update_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `board_free_like` int DEFAULT '0',
  PRIMARY KEY (`board_free_id`),
  KEY `fk_free_business` (`business_id`),
  KEY `fk_free_member` (`member_id`),
  CONSTRAINT `fk_free_business` FOREIGN KEY (`business_id`) REFERENCES `tbl_business` (`business_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_free_member` FOREIGN KEY (`member_id`) REFERENCES `tbl_member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_board_free_img definition
CREATE TABLE `tbl_board_free_img` (
  `board_free_img_id` int unsigned NOT NULL AUTO_INCREMENT,
  `board_free_id` int unsigned DEFAULT NULL,
  `board_free_img_original_name` varchar(500) DEFAULT NULL,
  `board_free_img_uuid` varchar(500) DEFAULT NULL,
  `board_free_img_path` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`board_free_img_id`),
  KEY `fk_board_free` (`board_free_id`),
  CONSTRAINT `fk_board_free` FOREIGN KEY (`board_free_id`) REFERENCES `tbl_board_free` (`board_free_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_board_inquiry definition
CREATE TABLE `tbl_board_inquiry` (
  `board_inquiry_id` int unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned DEFAULT NULL,
  `business_id` int unsigned DEFAULT NULL,
  `board_inquiry_title` varchar(500) NOT NULL,
  `board_inquiry_content` varchar(500) NOT NULL,
  `board_inquiry_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `board_inquiry_status` char(1) DEFAULT '1',
  PRIMARY KEY (`board_inquiry_id`),
  KEY `fk_inquiry_member` (`member_id`),
  KEY `fk_inquiry_business` (`business_id`),
  CONSTRAINT `fk_inquiry_business` FOREIGN KEY (`business_id`) REFERENCES `tbl_business` (`business_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_inquiry_member` FOREIGN KEY (`member_id`) REFERENCES `tbl_member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_board_inquiry_answer definition
CREATE TABLE `tbl_board_inquiry_answer` (
  `board_inquiry_answer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `board_inquiry_id` int unsigned DEFAULT NULL,
  `board_inquiry_answer_content` varchar(500) NOT NULL,
  `board_inquiry_answer_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_inquiry_answer_id`),
  KEY `fk_board_inquiry` (`board_inquiry_id`),
  CONSTRAINT `fk_board_inquiry` FOREIGN KEY (`board_inquiry_id`) REFERENCES `tbl_board_inquiry` (`board_inquiry_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_business_review definition
CREATE TABLE `tbl_business_review` (
  `review_id` int unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned DEFAULT NULL,
  `board_business_id` int unsigned DEFAULT NULL,
  `review_content` varchar(500) NOT NULL,
  `review_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `review_update_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `review_grade` int NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `fk_review_member` (`member_id`),
  KEY `fk_review_board_business` (`board_business_id`),
  CONSTRAINT `fk_review_board_business` FOREIGN KEY (`board_business_id`) REFERENCES `tbl_board_business` (`board_business_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_member` FOREIGN KEY (`member_id`) REFERENCES `tbl_member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_free_like definition
CREATE TABLE `tbl_free_like` (
  `free_like_id` int unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned DEFAULT NULL,
  `business_id` int unsigned DEFAULT NULL,
  `board_free_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`free_like_id`),
  KEY `fk_like_member` (`member_id`),
  KEY `fk_like_business` (`business_id`),
  KEY `fk_like_free` (`board_free_id`),
  CONSTRAINT `fk_like_business` FOREIGN KEY (`business_id`) REFERENCES `tbl_business` (`business_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_like_free` FOREIGN KEY (`board_free_id`) REFERENCES `tbl_board_free` (`board_free_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_like_member` FOREIGN KEY (`member_id`) REFERENCES `tbl_member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_free_reply definition
CREATE TABLE `tbl_free_reply` (
  `reply_id` int unsigned NOT NULL AUTO_INCREMENT,
  `board_free_id` int unsigned DEFAULT NULL,
  `member_id` int unsigned DEFAULT NULL,
  `business_id` int unsigned DEFAULT NULL,
  `reply_content` varchar(500) NOT NULL,
  `reply_register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `reply_update_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reply_id`),
  KEY `fk_reply_member` (`member_id`),
  KEY `fk_reply_business` (`business_id`),
  CONSTRAINT `fk_reply_business` FOREIGN KEY (`business_id`) REFERENCES `tbl_business` (`business_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reply_member` FOREIGN KEY (`member_id`) REFERENCES `tbl_member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- bugjeog.tbl_interesting_company definition
CREATE TABLE `tbl_interesting_company` (
  `interesting_company_id` int unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned DEFAULT NULL,
  `business_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`interesting_company_id`),
  KEY `fk_interesting_member` (`member_id`),
  KEY `fk_interesting_business` (`business_id`),
  CONSTRAINT `fk_interesting_business` FOREIGN KEY (`business_id`) REFERENCES `tbl_business` (`business_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_interesting_member` FOREIGN KEY (`member_id`) REFERENCES `tbl_member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;