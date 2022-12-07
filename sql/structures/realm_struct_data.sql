/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `accchange_log` */

DROP TABLE IF EXISTS `accchange_log`;

CREATE TABLE `accchange_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `old_acc` int(11) NOT NULL,
  `new_acc` int(11) NOT NULL,
  `date` char(25) NOT NULL,
  `char` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `account_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pass_hash` char(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token_key` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `gmlevel` smallint(3) NOT NULL DEFAULT '0',
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `registration_ip` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `expansion_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `account_state_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `locale_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `failed_logins` int(10) unsigned NOT NULL DEFAULT '0',
  `last_ip` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `last_local_ip` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `opcodes_disabled` int(10) unsigned NOT NULL DEFAULT '0',
  `account_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `client_os_version_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `recruiter` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_account_state_id` (`account_state_id`),
  KEY `FK_client_os_version_id` (`client_os_version_id`),
  KEY `FK_expansion_id` (`expansion_id`),
  KEY `online` (`online`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `account_friends` */

DROP TABLE IF EXISTS `account_friends`;

CREATE TABLE `account_friends` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `friend_id` int(11) unsigned NOT NULL DEFAULT '0',
  `bind_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Bring Date',
  `expire_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Expire Date',
  PRIMARY KEY (`id`,`friend_id`),
  KEY `id` (`id`),
  KEY `friend_id` (`friend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores accounts for Refer-a-Friend System.';

/*Table structure for table `account_login` */

DROP TABLE IF EXISTS `account_login`;

CREATE TABLE `account_login` (
  `account_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Account Id',
  `login_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `local_ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `LocId` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `account_id` (`account_id`),
  KEY `login_date` (`login_date`),
  KEY `ip` (`ip`),
  KEY `local_ip` (`local_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `account_permissions` */

DROP TABLE IF EXISTS `account_permissions`;

CREATE TABLE `account_permissions` (
  `account_id` int(10) unsigned NOT NULL,
  `realm_id` int(10) unsigned NOT NULL,
  `permission_mask` bigint(20) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`account_id`,`realm_id`),
  KEY `FK_account_permissions_realm_id` (`realm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `account_punishment` */

DROP TABLE IF EXISTS `account_punishment`;

CREATE TABLE `account_punishment` (
  `account_id` int(10) unsigned NOT NULL,
  `punishment_type_id` tinyint(3) unsigned NOT NULL,
  `punishment_date` int(11) NOT NULL,
  `expiration_date` int(11) NOT NULL,
  `punished_by` varchar(45) NOT NULL,
  `reason` varchar(100) NOT NULL DEFAULT 'no reason',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`account_id`,`punishment_type_id`,`punishment_date`),
  KEY `FK_punishment_type_id` (`punishment_type_id`),
  KEY `punishment_date` (`punishment_date`),
  KEY `expiration_date` (`expiration_date`),
  KEY `account_id` (`account_id`),
  KEY `punishment_date_2` (`punishment_date`,`expiration_date`),
  KEY `punishment_type_id` (`punishment_type_id`,`punishment_date`,`expiration_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `account_session` */

DROP TABLE IF EXISTS `account_session`;

CREATE TABLE `account_session` (
  `account_id` int(10) unsigned NOT NULL,
  `session_key` varchar(80) NOT NULL DEFAULT '',
  `v` varchar(80) NOT NULL DEFAULT '',
  `s` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `account_state` */

DROP TABLE IF EXISTS `account_state`;

CREATE TABLE `account_state` (
  `account_state_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`account_state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `account_state` */

insert  into `account_state`(`account_state_id`,`name`) values (1,'Active');
insert  into `account_state`(`account_state_id`,`name`) values (2,'IP locked');
insert  into `account_state`(`account_state_id`,`name`) values (3,'Frozen');

/*Table structure for table `account_support` */

DROP TABLE IF EXISTS `account_support`;

CREATE TABLE `account_support` (
  `account_id` int(10) unsigned NOT NULL,
  `support_points` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `client_os_version` */

DROP TABLE IF EXISTS `client_os_version`;

CREATE TABLE `client_os_version` (
  `client_os_version_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`client_os_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `client_os_version` */

insert  into `client_os_version`(`client_os_version_id`,`name`) values (0,'Unknown');
insert  into `client_os_version`(`client_os_version_id`,`name`) values (1,'Microsoft Windows');
insert  into `client_os_version`(`client_os_version_id`,`name`) values (2,'Apple Macintosh OSX');
insert  into `client_os_version`(`client_os_version_id`,`name`) values (3,'Custom WoW Chat Client');

/*Table structure for table `email_banned` */

DROP TABLE IF EXISTS `email_banned`;

CREATE TABLE `email_banned` (
  `email` varchar(50) NOT NULL,
  `ban_date` int(11) NOT NULL,
  `banned_by` varchar(16) NOT NULL,
  `ban_reason` varchar(100) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `email_log` */

DROP TABLE IF EXISTS `email_log`;

CREATE TABLE `email_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `old_email` char(50) NOT NULL,
  `new_email` char(50) NOT NULL,
  `date` char(25) NOT NULL,
  `acc` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `expansion` */

DROP TABLE IF EXISTS `expansion`;

CREATE TABLE `expansion` (
  `expansion_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`expansion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `expansion` */

insert  into `expansion`(`expansion_id`,`name`) values (0,'World of Warcraft');
insert  into `expansion`(`expansion_id`,`name`) values (1,'World of Warcraft: The Burning Crusade');
insert  into `expansion`(`expansion_id`,`name`) values (2,'World of Warcraft: Wrath of the Lich King');
insert  into `expansion`(`expansion_id`,`name`) values (3,'World of Warcraft: Cataclysm');

/*Table structure for table `ip_banned` */

DROP TABLE IF EXISTS `ip_banned`;

CREATE TABLE `ip_banned` (
  `ip` char(16) NOT NULL,
  `punishment_date` int(11) NOT NULL,
  `expiration_date` int(11) NOT NULL,
  `punished_by` varchar(16) NOT NULL,
  `ban_reason` varchar(100) NOT NULL,
  `active` decimal(1,0) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ip`,`punishment_date`),
  KEY `expiration_date` (`expiration_date`),
  KEY `punishment_date` (`punishment_date`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Banned IPs';

/*Table structure for table `ip2nation` */

DROP TABLE IF EXISTS `ip2nation`;

CREATE TABLE `ip2nation` (
  `ip` int(11) unsigned NOT NULL DEFAULT '0',
  `country` char(2) NOT NULL DEFAULT '',
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `ip2nationCountries` */

DROP TABLE IF EXISTS `ip2nationCountries`;

CREATE TABLE `ip2nationCountries` (
  `code` varchar(4) NOT NULL DEFAULT '',
  `iso_code_2` varchar(2) NOT NULL DEFAULT '',
  `iso_code_3` varchar(3) DEFAULT '',
  `iso_country` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(255) NOT NULL DEFAULT '',
  `lat` float NOT NULL DEFAULT '0',
  `lon` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `locale` */

DROP TABLE IF EXISTS `locale`;

CREATE TABLE `locale` (
  `locale_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`locale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `locale` */

insert  into `locale`(`locale_id`,`name`) values (0,'enUS');
insert  into `locale`(`locale_id`,`name`) values (1,'koKR');
insert  into `locale`(`locale_id`,`name`) values (2,'frFR');
insert  into `locale`(`locale_id`,`name`) values (3,'deDE');
insert  into `locale`(`locale_id`,`name`) values (4,'zhCN');
insert  into `locale`(`locale_id`,`name`) values (5,'zhTW');
insert  into `locale`(`locale_id`,`name`) values (6,'esES');
insert  into `locale`(`locale_id`,`name`) values (7,'esMX');
insert  into `locale`(`locale_id`,`name`) values (8,'ruRU');

/*Table structure for table `pattern_banned` */

DROP TABLE IF EXISTS `pattern_banned`;

CREATE TABLE `pattern_banned` (
  `pattern_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_pattern` varchar(255) NOT NULL,
  `local_ip_pattern` varchar(255) NOT NULL,
  `comment` char(100) NOT NULL,
  PRIMARY KEY (`pattern_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `punishment_type` */

DROP TABLE IF EXISTS `punishment_type`;

CREATE TABLE `punishment_type` (
  `punishment_type_id` tinyint(3) unsigned NOT NULL,
  `name` char(30) NOT NULL,
  PRIMARY KEY (`punishment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `punishment_type` */

insert  into `punishment_type`(`punishment_type_id`,`name`) values (1,'Account mute');
insert  into `punishment_type`(`punishment_type_id`,`name`) values (2,'Account ban');

/*Table structure for table `realm_characters` */

DROP TABLE IF EXISTS `realm_characters`;

CREATE TABLE `realm_characters` (
  `realm_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `characters_count` tinyint(3) unsigned NOT NULL DEFAULT '0',
  KEY `FK_realm_characters_realm_id` (`realm_id`),
  KEY `FK_realm_characters_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `realms` */

DROP TABLE IF EXISTS `realms`;

CREATE TABLE `realms` (
  `realm_id` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '127.0.0.1',
  `port` int(10) unsigned NOT NULL DEFAULT '8085',
  `icon` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `flags` tinyint(3) unsigned NOT NULL DEFAULT '6' COMMENT 'Supported masks: 0x1 (invalid, not show in realm list), 0x2 (offline, set by core), 0x4 (show version and build), 0x20 (recommended), 0x40 (new players)',
  `timezone` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `required_permission_mask` bigint(20) unsigned NOT NULL DEFAULT '1',
  `population` float unsigned NOT NULL DEFAULT '0',
  `allowed_builds` varchar(64) NOT NULL DEFAULT '8606',
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm System';

/*Table structure for table `unqueue_account` */

DROP TABLE IF EXISTS `unqueue_account`;

CREATE TABLE `unqueue_account` (
  `accid` int(11) unsigned NOT NULL,
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` text,
  PRIMARY KEY (`accid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/* Trigger structure for table `account` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `account_creation` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `account_creation` AFTER INSERT ON `account` FOR EACH ROW BEGIN
    replace INTO `account_permissions` (`account_id`, `realm_id`)
        SELECT NEW.`account_id`, `realm_id` FROM realms;
    replace INTO `account_support` (`account_id`)
        VALUES (NEW.`account_id`);
    replace INTO `account_session` (`account_id`)
        VALUES (NEW.`account_id`);
    replace INTO `realm_characters` (`account_id`, `realm_id`)
        SELECT NEW.`account_id`, `realm_id` FROM realms;
END */$$


DELIMITER ;

/* Trigger structure for table `account` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `email_upd_check` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `email_upd_check` BEFORE UPDATE ON `account` FOR EACH ROW BEGIN
	IF NEW.email != OLD.email THEN
		INSERT INTO email_log VALUES ('XXX', OLD.email, NEW.email, NOW(), NEW.account_id);
	END IF;
  END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
