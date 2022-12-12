/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `arena_fights` */

DROP TABLE IF EXISTS `arena_fights`;

CREATE TABLE `arena_fights` (
  `fight_guid` int(10) unsigned NOT NULL,
  `type` char(1) NOT NULL COMMENT '2, 3, 5',
  `winners_id` int(10) unsigned NOT NULL,
  `losers_id` int(10) unsigned NOT NULL,
  `winners_rating` int(10) unsigned NOT NULL,
  `losers_rating` int(10) unsigned NOT NULL,
  `rating_change` int(10) unsigned NOT NULL,
  `timestamp` datetime DEFAULT NULL,
  `length` int(6) unsigned NOT NULL DEFAULT '0' COMMENT 'time in seconds',
  PRIMARY KEY (`fight_guid`),
  KEY `winners_id` (`winners_id`),
  KEY `losers_id` (`losers_id`),
  KEY `timestamp` (`timestamp`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `arena_fights_detailed` */

DROP TABLE IF EXISTS `arena_fights_detailed`;

CREATE TABLE `arena_fights_detailed` (
  `fight_guid` int(10) unsigned NOT NULL,
  `player_guid` int(10) unsigned NOT NULL,
  `team_id` int(10) unsigned NOT NULL,
  `damage_done` int(10) unsigned NOT NULL DEFAULT '0',
  `healing_done` int(10) unsigned NOT NULL DEFAULT '0',
  `kills` char(1) NOT NULL DEFAULT '0',
  `personal_rating` int(10) unsigned NOT NULL,
  `rating_change` int(11) NOT NULL,
  PRIMARY KEY (`fight_guid`,`player_guid`),
  KEY `player_guid` (`player_guid`),
  KEY `team_id` (`team_id`),
  KEY `fight_guid` (`fight_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `arena_team` */

DROP TABLE IF EXISTS `arena_team`;

CREATE TABLE `arena_team` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `captainguid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BackgroundColor` int(10) unsigned NOT NULL DEFAULT '0',
  `EmblemStyle` int(10) unsigned NOT NULL DEFAULT '0',
  `EmblemColor` int(10) unsigned NOT NULL DEFAULT '0',
  `BorderStyle` int(10) unsigned NOT NULL DEFAULT '0',
  `BorderColor` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`arenateamid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `arena_team_member` */

DROP TABLE IF EXISTS `arena_team_member`;

CREATE TABLE `arena_team_member` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT '0',
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `played_week` int(10) unsigned NOT NULL DEFAULT '0',
  `wons_week` int(10) unsigned NOT NULL DEFAULT '0',
  `played_season` int(10) unsigned NOT NULL DEFAULT '0',
  `wons_season` int(10) unsigned NOT NULL DEFAULT '0',
  `personal_rating` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`arenateamid`,`guid`),
  KEY `arenateamid` (`arenateamid`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `arena_team_stats` */

DROP TABLE IF EXISTS `arena_team_stats`;

CREATE TABLE `arena_team_stats` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT '0',
  `rating` int(10) unsigned NOT NULL DEFAULT '0',
  `games` int(10) unsigned NOT NULL DEFAULT '0',
  `wins` int(10) unsigned NOT NULL DEFAULT '0',
  `played` int(10) unsigned NOT NULL DEFAULT '0',
  `wins2` int(10) unsigned NOT NULL DEFAULT '0',
  `rank` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`arenateamid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `auctionhouse` */

DROP TABLE IF EXISTS `auctionhouse`;

CREATE TABLE `auctionhouse` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `houseid` int(11) unsigned NOT NULL DEFAULT '0',
  `itemguid` int(11) unsigned NOT NULL DEFAULT '0',
  `item_template` int(11) unsigned NOT NULL DEFAULT '0',
  `item_count` int(11) unsigned NOT NULL DEFAULT '0',
  `item_randompropertyid` int(11) NOT NULL DEFAULT '0',
  `itemowner` int(11) unsigned NOT NULL DEFAULT '0',
  `buyoutprice` int(11) NOT NULL DEFAULT '0',
  `time` bigint(40) NOT NULL DEFAULT '0',
  `buyguid` int(11) unsigned NOT NULL DEFAULT '0',
  `lastbid` int(11) NOT NULL DEFAULT '0',
  `startbid` int(11) NOT NULL DEFAULT '0',
  `deposit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `itemguid` (`itemguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `boss_fights` */

DROP TABLE IF EXISTS `boss_fights`;

CREATE TABLE `boss_fights` (
  `kill_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mob_id` int(5) unsigned NOT NULL,
  `instance_id` int(5) unsigned NOT NULL,
  `guild_id` int(5) unsigned zerofill DEFAULT NULL,
  `length` int(5) unsigned NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`kill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4382 DEFAULT CHARSET=utf8;

/*Table structure for table `boss_fights_detailed` */

DROP TABLE IF EXISTS `boss_fights_detailed`;

CREATE TABLE `boss_fights_detailed` (
  `kill_id` int(10) unsigned NOT NULL,
  `player_guid` int(10) unsigned NOT NULL,
  `damage` int(10) unsigned DEFAULT NULL,
  `healing` int(10) unsigned DEFAULT NULL,
  `deaths` int(2) unsigned DEFAULT NULL,
  PRIMARY KEY (`kill_id`,`player_guid`),
  KEY `player_guid` (`player_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `boss_fights_loot` */

DROP TABLE IF EXISTS `boss_fights_loot`;

CREATE TABLE `boss_fights_loot` (
  `kill_id` int(10) unsigned NOT NULL,
  `item_id` int(6) unsigned NOT NULL,
  `count` int(2) DEFAULT NULL,
  PRIMARY KEY (`kill_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `boss_id_locations` */

DROP TABLE IF EXISTS `boss_id_locations`;

CREATE TABLE `boss_id_locations` (
  `boss_id` int(2) unsigned NOT NULL,
  `boss_location` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`boss_id`),
  CONSTRAINT `boss_id_locations_ibfk_1` FOREIGN KEY (`boss_id`) REFERENCES `boss_id_names` (`boss_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `boss_id_names` */

DROP TABLE IF EXISTS `boss_id_names`;

CREATE TABLE `boss_id_names` (
  `boss_id` int(5) unsigned NOT NULL,
  `boss_name` varchar(26) NOT NULL,
  PRIMARY KEY (`boss_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `bugreport` */

DROP TABLE IF EXISTS `bugreport`;

CREATE TABLE `bugreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '',
  `content` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_action` */

DROP TABLE IF EXISTS `character_action`;

CREATE TABLE `character_action` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `button` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `action` smallint(5) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `misc` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`button`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_aura` */

DROP TABLE IF EXISTS `character_aura`;

CREATE TABLE `character_aura` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `caster_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `effect_index` int(11) unsigned NOT NULL DEFAULT '0',
  `stackcount` int(11) NOT NULL DEFAULT '1',
  `amount` int(11) NOT NULL DEFAULT '0',
  `maxduration` int(11) NOT NULL DEFAULT '0',
  `remaintime` int(11) NOT NULL DEFAULT '0',
  `remaincharges` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`,`effect_index`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_bgcoord` */

DROP TABLE IF EXISTS `character_bgcoord`;

CREATE TABLE `character_bgcoord` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `bgid` int(10) unsigned NOT NULL DEFAULT '0',
  `bgteam` int(10) unsigned NOT NULL DEFAULT '0',
  `bgmap` int(10) unsigned NOT NULL DEFAULT '0',
  `bgx` float NOT NULL DEFAULT '0',
  `bgy` float NOT NULL DEFAULT '0',
  `bgz` float NOT NULL DEFAULT '0',
  `bgo` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_declinedname` */

DROP TABLE IF EXISTS `character_declinedname`;

CREATE TABLE `character_declinedname` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `genitive` varchar(15) NOT NULL DEFAULT '',
  `dative` varchar(15) NOT NULL DEFAULT '',
  `accusative` varchar(15) NOT NULL DEFAULT '',
  `instrumental` varchar(15) NOT NULL DEFAULT '',
  `prepositional` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_freerespecs` */

DROP TABLE IF EXISTS `character_freerespecs`;

CREATE TABLE `character_freerespecs` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `expiration_date` int(11) unsigned NOT NULL DEFAULT '0',
  KEY `guid` (`guid`),
  KEY `expiration_date` (`expiration_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_gifts` */

DROP TABLE IF EXISTS `character_gifts`;

CREATE TABLE `character_gifts` (
  `guid` int(20) unsigned NOT NULL DEFAULT '0',
  `item_guid` int(11) unsigned NOT NULL DEFAULT '0',
  `entry` int(20) unsigned NOT NULL DEFAULT '0',
  `flags` int(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_guid`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_homebind` */

DROP TABLE IF EXISTS `character_homebind`;

CREATE TABLE `character_homebind` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `map` int(11) unsigned NOT NULL DEFAULT '0',
  `zone` int(11) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_instance` */

DROP TABLE IF EXISTS `character_instance`;

CREATE TABLE `character_instance` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `instance` int(11) unsigned NOT NULL DEFAULT '0',
  `permanent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_inventory` */

DROP TABLE IF EXISTS `character_inventory`;

CREATE TABLE `character_inventory` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `bag` int(11) unsigned NOT NULL DEFAULT '0',
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `item` int(11) unsigned NOT NULL DEFAULT '0',
  `item_template` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`item`),
  KEY `guid` (`guid`),
  KEY `item_template` (`item_template`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_pet` */

DROP TABLE IF EXISTS `character_pet`;

CREATE TABLE `character_pet` (
  `id` int(11) unsigned NOT NULL,
  `entry` int(11) unsigned NOT NULL DEFAULT '0',
  `owner` int(11) unsigned NOT NULL DEFAULT '0',
  `modelid` int(11) unsigned DEFAULT '0',
  `CreatedBySpell` int(11) unsigned NOT NULL DEFAULT '0',
  `PetType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `level` int(11) unsigned NOT NULL DEFAULT '1',
  `exp` int(11) unsigned NOT NULL DEFAULT '0',
  `Reactstate` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `loyaltypoints` int(11) NOT NULL DEFAULT '0',
  `loyalty` int(11) unsigned NOT NULL DEFAULT '0',
  `trainpoint` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT 'Pet',
  `renamed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `slot` int(11) unsigned NOT NULL DEFAULT '0',
  `curhealth` int(11) unsigned NOT NULL DEFAULT '1',
  `curmana` int(11) unsigned NOT NULL DEFAULT '0',
  `curhappiness` int(11) unsigned NOT NULL DEFAULT '0',
  `savetime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `resettalents_cost` int(11) unsigned NOT NULL DEFAULT '0',
  `resettalents_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `abdata` longtext,
  `teachspelldata` longtext,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_pet_declinedname` */

DROP TABLE IF EXISTS `character_pet_declinedname`;

CREATE TABLE `character_pet_declinedname` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `owner` int(11) unsigned NOT NULL DEFAULT '0',
  `genitive` varchar(12) NOT NULL DEFAULT '',
  `dative` varchar(12) NOT NULL DEFAULT '',
  `accusative` varchar(12) NOT NULL DEFAULT '',
  `instrumental` varchar(12) NOT NULL DEFAULT '',
  `prepositional` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_queststatus` */

DROP TABLE IF EXISTS `character_queststatus`;

CREATE TABLE `character_queststatus` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `quest` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `rewarded` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `explored` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timer` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mobcount1` int(11) unsigned NOT NULL DEFAULT '0',
  `mobcount2` int(11) unsigned NOT NULL DEFAULT '0',
  `mobcount3` int(11) unsigned NOT NULL DEFAULT '0',
  `mobcount4` int(11) unsigned NOT NULL DEFAULT '0',
  `itemcount1` int(11) unsigned NOT NULL DEFAULT '0',
  `itemcount2` int(11) unsigned NOT NULL DEFAULT '0',
  `itemcount3` int(11) unsigned NOT NULL DEFAULT '0',
  `itemcount4` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_queststatus_daily` */

DROP TABLE IF EXISTS `character_queststatus_daily`;

CREATE TABLE `character_queststatus_daily` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `quest` int(11) unsigned NOT NULL DEFAULT '0',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`quest`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_reputation` */

DROP TABLE IF EXISTS `character_reputation`;

CREATE TABLE `character_reputation` (
  `guid` bigint(10) NOT NULL DEFAULT '0',
  `faction` bigint(10) NOT NULL DEFAULT '0',
  `standing` bigint(10) DEFAULT NULL,
  `flags` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`guid`,`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_social` */

DROP TABLE IF EXISTS `character_social`;

CREATE TABLE `character_social` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `friend` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `note` varchar(48) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`,`friend`,`flags`),
  KEY `guid` (`guid`),
  KEY `friend` (`friend`),
  KEY `guid_flags` (`guid`,`flags`),
  KEY `friend_flags` (`friend`,`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_spell` */

DROP TABLE IF EXISTS `character_spell`;

CREATE TABLE `character_spell` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `slot` int(11) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `disabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_spell_cooldown` */

DROP TABLE IF EXISTS `character_spell_cooldown`;

CREATE TABLE `character_spell_cooldown` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `item` int(11) unsigned NOT NULL DEFAULT '0',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_stats_ro` */

DROP TABLE IF EXISTS `character_stats_ro`;

CREATE TABLE `character_stats_ro` (
  `guid` bigint(8) unsigned NOT NULL,
  `honor` bigint(8) unsigned NOT NULL,
  `honorablekills` bigint(8) unsigned NOT NULL,
  `dailyarenawins` smallint(5) unsigned DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `honorablekills` (`honorablekills`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `character_tutorial` */

DROP TABLE IF EXISTS `character_tutorial`;

CREATE TABLE `character_tutorial` (
  `account` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `realmid` int(11) unsigned NOT NULL DEFAULT '0',
  `tut0` int(11) unsigned NOT NULL DEFAULT '0',
  `tut1` int(11) unsigned NOT NULL DEFAULT '0',
  `tut2` int(11) unsigned NOT NULL DEFAULT '0',
  `tut3` int(11) unsigned NOT NULL DEFAULT '0',
  `tut4` int(11) unsigned NOT NULL DEFAULT '0',
  `tut5` int(11) unsigned NOT NULL DEFAULT '0',
  `tut6` int(11) unsigned NOT NULL DEFAULT '0',
  `tut7` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`account`,`realmid`),
  KEY `account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `characters` */

DROP TABLE IF EXISTS `characters`;

CREATE TABLE `characters` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `account` int(11) unsigned NOT NULL DEFAULT '0',
  `data` longtext,
  `name` varchar(12) NOT NULL DEFAULT '',
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `xp` int(10) unsigned NOT NULL DEFAULT '0',
  `money` int(10) unsigned NOT NULL DEFAULT '0',
  `playerBytes` int(10) unsigned NOT NULL DEFAULT '0',
  `playerBytes2` int(10) unsigned NOT NULL DEFAULT '0',
  `playerFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `level` tinyint(3) unsigned DEFAULT '1',
  `title` bigint(30) unsigned DEFAULT NULL COMMENT 'Character''s title',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `map` int(11) unsigned NOT NULL DEFAULT '0',
  `instance_id` int(11) unsigned NOT NULL DEFAULT '0',
  `dungeon_difficulty` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `taximask` longtext,
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cinematic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `totaltime` int(11) unsigned NOT NULL DEFAULT '0',
  `leveltime` int(11) unsigned NOT NULL DEFAULT '0',
  `logout_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `is_logout_resting` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rest_bonus` float NOT NULL DEFAULT '0',
  `resettalents_cost` int(11) unsigned NOT NULL DEFAULT '0',
  `resettalents_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `trans_x` float NOT NULL DEFAULT '0',
  `trans_y` float NOT NULL DEFAULT '0',
  `trans_z` float NOT NULL DEFAULT '0',
  `trans_o` float NOT NULL DEFAULT '0',
  `transguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `extra_flags` int(11) unsigned NOT NULL DEFAULT '0',
  `stable_slots` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `at_login` int(11) unsigned NOT NULL DEFAULT '0',
  `zone` int(11) unsigned NOT NULL DEFAULT '0',
  `death_expire_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxi_path` text,
  `arena_pending_points` int(10) unsigned NOT NULL DEFAULT '0',
  `latency` int(11) unsigned NOT NULL DEFAULT '0',
  `grantableLevels` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `changeRaceTo` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `account` (`account`),
  KEY `online` (`online`),
  KEY `name` (`name`),
  FULLTEXT KEY `name_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `characters_goldsy` */

DROP TABLE IF EXISTS `characters_goldsy`;

CREATE TABLE `characters_goldsy` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `account` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(12) NOT NULL DEFAULT '',
  `money` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `corpse` */

DROP TABLE IF EXISTS `corpse`;

CREATE TABLE `corpse` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `player` int(11) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `zone` int(11) unsigned NOT NULL DEFAULT '38',
  `map` int(11) unsigned NOT NULL DEFAULT '0',
  `data` longtext,
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `corpse_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `instance` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `corpse_type` (`corpse_type`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `creature_respawn` */

DROP TABLE IF EXISTS `creature_respawn`;

CREATE TABLE `creature_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) NOT NULL DEFAULT '0',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `custom_transmogrification` */

DROP TABLE IF EXISTS `custom_transmogrification`;

CREATE TABLE `custom_transmogrification` (
  `GUID` int(10) unsigned NOT NULL COMMENT 'Item guidLow',
  `FakeEntry` int(10) unsigned NOT NULL COMMENT 'Item entry',
  `Owner` int(10) unsigned NOT NULL COMMENT 'Player guidLow',
  PRIMARY KEY (`GUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='version 4.0';

/*Table structure for table `deleted_chars` */

DROP TABLE IF EXISTS `deleted_chars`;

CREATE TABLE `deleted_chars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_guid` int(10) unsigned NOT NULL,
  `oldname` varchar(15) NOT NULL,
  `acc` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14466 DEFAULT CHARSET=utf8;

/*Table structure for table `game_event_condition_save` */

DROP TABLE IF EXISTS `game_event_condition_save`;

CREATE TABLE `game_event_condition_save` (
  `event_id` mediumint(8) unsigned NOT NULL,
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `done` float DEFAULT '0',
  PRIMARY KEY (`event_id`,`condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `game_event_save` */

DROP TABLE IF EXISTS `game_event_save`;

CREATE TABLE `game_event_save` (
  `event_id` mediumint(8) unsigned NOT NULL,
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `next_start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `gameobject_respawn` */

DROP TABLE IF EXISTS `gameobject_respawn`;

CREATE TABLE `gameobject_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) NOT NULL DEFAULT '0',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `gm_tickets` */

DROP TABLE IF EXISTS `gm_tickets`;

CREATE TABLE `gm_tickets` (
  `guid` int(10) NOT NULL AUTO_INCREMENT,
  `playerGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(15) NOT NULL,
  `message` text NOT NULL,
  `createtime` int(10) NOT NULL,
  `map` int(11) NOT NULL DEFAULT '0',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `timestamp` int(10) NOT NULL DEFAULT '0',
  `assignedto` int(10) NOT NULL DEFAULT '0',
  `closed` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `group_instance` */

DROP TABLE IF EXISTS `group_instance`;

CREATE TABLE `group_instance` (
  `leaderGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `instance` int(11) unsigned NOT NULL DEFAULT '0',
  `permanent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`leaderGuid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `group_member` */

DROP TABLE IF EXISTS `group_member`;

CREATE TABLE `group_member` (
  `leaderGuid` int(11) unsigned NOT NULL,
  `memberGuid` int(11) unsigned NOT NULL,
  `assistant` tinyint(1) unsigned NOT NULL,
  `subgroup` smallint(6) unsigned NOT NULL,
  PRIMARY KEY (`leaderGuid`,`memberGuid`),
  KEY `memberGuid` (`memberGuid`),
  KEY `leaderGuid` (`leaderGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `group_saved_loot` */

DROP TABLE IF EXISTS `group_saved_loot`;

CREATE TABLE `group_saved_loot` (
  `creatureId` int(11) NOT NULL DEFAULT '0',
  `instanceId` int(11) NOT NULL DEFAULT '0',
  `itemId` int(11) NOT NULL DEFAULT '0',
  `itemCount` int(11) DEFAULT NULL,
  `summoned` tinyint(1) DEFAULT '0',
  `position_x` float DEFAULT NULL,
  `position_y` float DEFAULT NULL,
  `position_z` float DEFAULT NULL,
  `playerGuids` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`creatureId`,`instanceId`,`itemId`),
  KEY `summoned` (`summoned`),
  KEY `creatureId` (`creatureId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `groups` */

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `leaderGuid` int(11) unsigned NOT NULL,
  `mainTank` int(11) unsigned NOT NULL,
  `mainAssistant` int(11) unsigned NOT NULL,
  `lootMethod` tinyint(4) unsigned NOT NULL,
  `looterGuid` int(11) unsigned NOT NULL,
  `lootThreshold` tinyint(4) unsigned NOT NULL,
  `icon1` int(11) unsigned NOT NULL,
  `icon2` int(11) unsigned NOT NULL,
  `icon3` int(11) unsigned NOT NULL,
  `icon4` int(11) unsigned NOT NULL,
  `icon5` int(11) unsigned NOT NULL,
  `icon6` int(11) unsigned NOT NULL,
  `icon7` int(11) unsigned NOT NULL,
  `icon8` int(11) unsigned NOT NULL,
  `isRaid` tinyint(1) unsigned NOT NULL,
  `difficulty` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`leaderGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild` */

DROP TABLE IF EXISTS `guild`;

CREATE TABLE `guild` (
  `guildid` int(6) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `leaderguid` int(6) unsigned NOT NULL DEFAULT '0',
  `EmblemStyle` int(5) NOT NULL DEFAULT '0',
  `EmblemColor` int(5) NOT NULL DEFAULT '0',
  `BorderStyle` int(5) NOT NULL DEFAULT '0',
  `BorderColor` int(5) NOT NULL DEFAULT '0',
  `BackgroundColor` int(5) NOT NULL DEFAULT '0',
  `info` text NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `createdate` datetime DEFAULT NULL,
  `BankMoney` bigint(20) NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild_announce_cooldown` */

DROP TABLE IF EXISTS `guild_announce_cooldown`;

CREATE TABLE `guild_announce_cooldown` (
  `guild_id` int(10) unsigned NOT NULL,
  `cooldown_end` bigint(20) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild_bank_eventlog` */

DROP TABLE IF EXISTS `guild_bank_eventlog`;

CREATE TABLE `guild_bank_eventlog` (
  `guildid` int(11) unsigned NOT NULL DEFAULT '0',
  `LogGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `LogEntry` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `PlayerGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `ItemOrMoney` int(11) unsigned NOT NULL DEFAULT '0',
  `ItemStackCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DestTabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `TimeStamp` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`LogGuid`),
  KEY `PlayerGuid` (`PlayerGuid`),
  KEY `LogGuid` (`LogGuid`),
  KEY `TimeStamp` (`TimeStamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild_bank_item` */

DROP TABLE IF EXISTS `guild_bank_item`;

CREATE TABLE `guild_bank_item` (
  `guildid` int(11) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `SlotId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `item_guid` int(11) unsigned NOT NULL DEFAULT '0',
  `item_entry` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`TabId`,`SlotId`),
  KEY `guildid` (`guildid`),
  KEY `item_guid` (`item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild_bank_right` */

DROP TABLE IF EXISTS `guild_bank_right`;

CREATE TABLE `guild_bank_right` (
  `guildid` int(11) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rid` int(11) unsigned NOT NULL DEFAULT '0',
  `gbright` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SlotPerDay` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`TabId`,`rid`),
  KEY `guildid` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild_bank_tab` */

DROP TABLE IF EXISTS `guild_bank_tab`;

CREATE TABLE `guild_bank_tab` (
  `guildid` int(11) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `TabName` varchar(100) NOT NULL DEFAULT '',
  `TabIcon` varchar(100) NOT NULL DEFAULT '',
  `TabText` text,
  PRIMARY KEY (`guildid`,`TabId`),
  KEY `guildid` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild_eventlog` */

DROP TABLE IF EXISTS `guild_eventlog`;

CREATE TABLE `guild_eventlog` (
  `guildid` int(11) NOT NULL,
  `LogGuid` int(11) NOT NULL,
  `EventType` tinyint(1) NOT NULL,
  `PlayerGuid1` int(11) NOT NULL,
  `PlayerGuid2` int(11) NOT NULL,
  `NewRank` tinyint(2) NOT NULL,
  `TimeStamp` bigint(20) NOT NULL,
  PRIMARY KEY (`guildid`,`LogGuid`),
  KEY `PlayerGuid1` (`PlayerGuid1`),
  KEY `PlayerGuid2` (`PlayerGuid2`),
  KEY `LogGuid` (`LogGuid`),
  KEY `TimeStamp` (`TimeStamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild_member` */

DROP TABLE IF EXISTS `guild_member`;

CREATE TABLE `guild_member` (
  `guildid` int(6) unsigned NOT NULL DEFAULT '0',
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `rank` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `pnote` varchar(255) NOT NULL DEFAULT '',
  `offnote` varchar(255) NOT NULL DEFAULT '',
  `BankResetTimeMoney` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemMoney` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab0` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab0` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab1` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab1` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab2` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab2` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab3` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab3` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab4` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab4` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab5` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab5` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `guildid` (`guildid`),
  KEY `guildid_rank` (`guildid`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guild_rank` */

DROP TABLE IF EXISTS `guild_rank`;

CREATE TABLE `guild_rank` (
  `guildid` int(6) unsigned NOT NULL DEFAULT '0',
  `rid` int(11) unsigned NOT NULL,
  `rname` varchar(255) NOT NULL DEFAULT '',
  `rights` int(3) unsigned NOT NULL DEFAULT '0',
  `BankMoneyPerDay` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `hidden_rating` */

DROP TABLE IF EXISTS `hidden_rating`;

CREATE TABLE `hidden_rating` (
  `guid` int(11) unsigned NOT NULL,
  `rating2` int(10) unsigned NOT NULL DEFAULT '1500',
  `rating3` int(10) unsigned NOT NULL DEFAULT '1500',
  `rating5` int(10) unsigned NOT NULL DEFAULT '1500',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `instance` */

DROP TABLE IF EXISTS `instance`;

CREATE TABLE `instance` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `map` int(11) unsigned NOT NULL DEFAULT '0',
  `resettime` bigint(40) NOT NULL DEFAULT '0',
  `difficulty` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `data` longtext,
  PRIMARY KEY (`id`),
  KEY `map` (`map`),
  KEY `resettime` (`resettime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `instance_reset` */

DROP TABLE IF EXISTS `instance_reset`;

CREATE TABLE `instance_reset` (
  `mapid` int(11) unsigned NOT NULL DEFAULT '0',
  `resettime` bigint(40) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `item_instance` */

DROP TABLE IF EXISTS `item_instance`;

CREATE TABLE `item_instance` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `owner_guid` int(11) unsigned NOT NULL DEFAULT '0',
  `data` longtext,
  PRIMARY KEY (`guid`),
  KEY `owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `item_text` */

DROP TABLE IF EXISTS `item_text`;

CREATE TABLE `item_text` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `text` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `mail` */

DROP TABLE IF EXISTS `mail`;

CREATE TABLE `mail` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `messageType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stationery` tinyint(3) NOT NULL DEFAULT '41',
  `mailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `sender` int(11) unsigned NOT NULL DEFAULT '0',
  `receiver` int(11) unsigned NOT NULL DEFAULT '0',
  `subject` longtext,
  `itemTextId` int(11) unsigned NOT NULL DEFAULT '0',
  `has_items` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `expire_time` bigint(40) NOT NULL DEFAULT '0',
  `deliver_time` bigint(40) NOT NULL DEFAULT '0',
  `money` int(11) unsigned NOT NULL DEFAULT '0',
  `cod` int(11) unsigned NOT NULL DEFAULT '0',
  `checked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `receiver` (`receiver`),
  KEY `expire_time` (`expire_time`),
  KEY `deliver_time` (`deliver_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `mail_external` */

DROP TABLE IF EXISTS `mail_external`;

CREATE TABLE `mail_external` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `receiver` bigint(20) unsigned NOT NULL,
  `subject` varchar(200) DEFAULT 'Support Message',
  `message` varchar(500) DEFAULT 'Support Message',
  `money` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `mail_items` */

DROP TABLE IF EXISTS `mail_items`;

CREATE TABLE `mail_items` (
  `mail_id` int(11) NOT NULL DEFAULT '0',
  `item_guid` int(11) NOT NULL DEFAULT '0',
  `item_template` int(11) NOT NULL DEFAULT '0',
  `receiver` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_guid`),
  KEY `receiver` (`receiver`),
  KEY `idx_mail_id` (`mail_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `map_template` */

DROP TABLE IF EXISTS `map_template`;

CREATE TABLE `map_template` (
  `entry` int(3) unsigned NOT NULL COMMENT 'MapID',
  `visibility` float unsigned DEFAULT '533' COMMENT 'VisibilityRadius',
  `pathfinding` smallint(1) unsigned DEFAULT '6' COMMENT 'PathFinding Prioririty',
  `lineofsight` smallint(1) unsigned DEFAULT '6' COMMENT 'LineOfSight Prioririty',
  `ainotifyperiod` smallint(4) unsigned DEFAULT '1000' COMMENT 'Interval between AI notifications about relocation',
  `viewupdatedistance` smallint(2) unsigned DEFAULT '10' COMMENT 'ViewUpdate minimal distance',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `map_template` */

insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('0','110','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('1','110','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('13','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('25','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('29','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('33','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('34','120','6','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('36','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('43','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('47','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('48','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('70','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('90','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('109','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('129','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('169','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('189','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('209','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('229','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('230','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('249','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('269','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('289','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('309','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('329','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('349','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('369','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('389','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('409','200','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('429','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('449','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('450','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('451','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('489','250','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('509','120','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('530','100','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('531','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('532','130','3','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('533','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('534','380','3','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('540','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('542','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('543','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('544','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('545','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('546','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('547','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('548','160','3','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('550','200','3','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('552','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('553','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('554','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('555','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('556','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('557','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('558','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('559','250','6','6','500','1');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('560','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('562','250','6','6','500','1');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('564','250','3','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('565','160','3','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('566','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('568','160','3','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('572','250','6','6','500','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('580','200','6','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('585','160','2','6','1000','5');
insert into `map_template` (`entry`, `visibility`, `pathfinding`, `lineofsight`, `ainotifyperiod`, `viewupdatedistance`) values('598','160','2','6','1000','5');



/*Table structure for table `opcodes_cooldown` */

DROP TABLE IF EXISTS `opcodes_cooldown`;

CREATE TABLE `opcodes_cooldown` (
  `opcode` varchar(20) NOT NULL COMMENT 'Opcode name',
  `cooldown` int(4) unsigned DEFAULT '1000' COMMENT 'Opcode cooldown',
  PRIMARY KEY (`opcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `opcodes_cooldown` */

insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_ADD_FRIEND   ','1000');
insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_CHANNEL_LIST','1000');
insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_GAMEOBJ_USE','500');
insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_GROUP_CHANGE_SU','1000');
insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_GROUP_INVITE   ','1000');
insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_GUILD_BANK_SWAP','1000');
insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_INSPECT','2000');
insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_WHO','2000');
insert into `opcodes_cooldown` (`opcode`, `cooldown`) values('CMSG_WHOIS','1000');

/*Table structure for table `pet_aura` */

DROP TABLE IF EXISTS `pet_aura`;

CREATE TABLE `pet_aura` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `caster_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `effect_index` int(11) unsigned NOT NULL DEFAULT '0',
  `stackcount` int(11) NOT NULL DEFAULT '1',
  `amount` int(11) NOT NULL DEFAULT '0',
  `maxduration` int(11) NOT NULL DEFAULT '0',
  `remaintime` int(11) NOT NULL DEFAULT '0',
  `remaincharges` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`,`effect_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `pet_spell` */

DROP TABLE IF EXISTS `pet_spell`;

CREATE TABLE `pet_spell` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `slot` int(11) unsigned NOT NULL DEFAULT '0',
  `active` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `pet_spell_cooldown` */

DROP TABLE IF EXISTS `pet_spell_cooldown`;

CREATE TABLE `pet_spell_cooldown` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `petition` */

DROP TABLE IF EXISTS `petition`;

CREATE TABLE `petition` (
  `ownerguid` int(10) unsigned NOT NULL,
  `petitionguid` int(10) unsigned DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ownerguid`,`type`),
  UNIQUE KEY `ownerguid_petitionguid` (`ownerguid`,`petitionguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `petition_sign` */

DROP TABLE IF EXISTS `petition_sign`;

CREATE TABLE `petition_sign` (
  `ownerguid` int(10) unsigned NOT NULL,
  `petitionguid` int(11) unsigned NOT NULL DEFAULT '0',
  `playerguid` int(11) unsigned NOT NULL DEFAULT '0',
  `player_account` int(11) unsigned NOT NULL DEFAULT '0',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`petitionguid`,`playerguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `premium` */

DROP TABLE IF EXISTS `premium`;

CREATE TABLE `premium` (
  `AccountId` int(11) unsigned NOT NULL,
  `active` int(11) unsigned NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `reserved_name` */

DROP TABLE IF EXISTS `reserved_name`;

CREATE TABLE `reserved_name` (
  `name` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player Reserved Names';

/*Table structure for table `saved_variables` */

DROP TABLE IF EXISTS `saved_variables`;

CREATE TABLE `saved_variables` (
  `NextArenaPointDistributionTime` bigint(40) unsigned NOT NULL DEFAULT '0',
  `HeroicQuest` int(5) unsigned NOT NULL DEFAULT '0',
  `NormalQuest` int(5) unsigned NOT NULL DEFAULT '0',
  `CookingQuest` int(5) unsigned NOT NULL DEFAULT '0',
  `FishingQuest` int(5) unsigned NOT NULL DEFAULT '0',
  `PVPAlliance` int(5) unsigned NOT NULL DEFAULT '0',
  `PVPHorde` int(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `spell_disabled` */

DROP TABLE IF EXISTS `spell_disabled`;

CREATE TABLE `spell_disabled` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell entry',
  `disable_mask` int(8) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Disabled Spell System';

/*Data for the table `spell_disabled` */

insert  into `spell_disabled`(`entry`,`disable_mask`,`comment`) values (1852,7,'Silenced (GM Tool) Spell bugged');
insert  into `spell_disabled`(`entry`,`disable_mask`,`comment`) values (46642,7,'5k gold');

/*Table structure for table `ticket_history` */

DROP TABLE IF EXISTS `ticket_history`;

CREATE TABLE `ticket_history` (
  `guid` int(10) NOT NULL AUTO_INCREMENT,
  `playerGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(15) NOT NULL,
  `message` text NOT NULL,
  `createtime` int(10) NOT NULL,
  `timestamp` int(10) NOT NULL DEFAULT '0',
  `closed` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB AUTO_INCREMENT=63324 DEFAULT CHARSET=utf8;

/*Table structure for table `titles_to_award` */

DROP TABLE IF EXISTS `titles_to_award`;

CREATE TABLE `titles_to_award` (
  `guid` int(10) unsigned NOT NULL,
  `mask` int(14) unsigned NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `uptime` */

DROP TABLE IF EXISTS `uptime`;

CREATE TABLE `uptime` (
  `starttime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `startstring` varchar(64) NOT NULL DEFAULT '',
  `uptime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Uptime system';

/* Trigger structure for table `characters` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `accchange_upd_check` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `accchange_upd_check` BEFORE UPDATE ON `characters` FOR EACH ROW BEGIN
	IF NEW.account != OLD.account THEN
		INSERT INTO realm.accchange_log VALUES ('XXX', OLD.account, NEW.account, NOW(), NEW.guid);
	END IF;
  END */$$


DELIMITER ;

/* Trigger structure for table `gm_tickets` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `ticket_insert_check` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `ticket_insert_check` BEFORE INSERT ON `gm_tickets` FOR EACH ROW BEGIN
    INSERT INTO ticket_history VALUES ('XXX', NEW.playerGuid, NEW.name, NEW.message, NEW.createtime, NEW.timestamp, NEW.closed, NEW.comment);
  END */$$


DELIMITER ;

/* Trigger structure for table `gm_tickets` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `ticket_upd_check` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `ticket_upd_check` BEFORE UPDATE ON `gm_tickets` FOR EACH ROW BEGIN
    UPDATE ticket_history
    SET message = NEW.message, name = NEW.name, timestamp = NEW.timestamp, closed = NEW.closed, comment = NEW.comment
    WHERE playerGuid = NEW.playerGuid AND createtime = NEW.createtime;
  END */$$


DELIMITER ;

/* Procedure structure for procedure `PreventCharDelete` */

/*!50003 DROP PROCEDURE IF EXISTS  `PreventCharDelete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `PreventCharDelete`(IN charguid INT UNSIGNED)
BEGIN
    INSERT INTO deleted_chars VALUES ('XXX', charguid, (SELECT name FROM characters WHERE guid = charguid), (SELECT account FROM characters WHERE guid = charguid), CAST(NOW() AS DATETIME));
    UPDATE characters SET account = 1 WHERE guid = charguid;
    UPDATE characters SET name = CONCAT('DEL', name, 'DEL') WHERE guid = charguid;
    DELETE FROM character_social WHERE guid = charguid OR friend = charguid;
    DELETE FROM mail WHERE receiver = charguid;
    DELETE FROM mail_items WHERE receiver = charguid;
END */$$
DELIMITER ;

/*Table structure for table `arena_fights_detailed_view` */

DROP TABLE IF EXISTS `arena_fights_detailed_view`;

/*!50001 DROP VIEW IF EXISTS `arena_fights_detailed_view` */;
/*!50001 DROP TABLE IF EXISTS `arena_fights_detailed_view` */;

/*!50001 CREATE TABLE  `arena_fights_detailed_view`(
 `fight_guid` int(10) unsigned ,
 `type` char(1) ,
 `nick` varchar(12) ,
 `arena_team_name` varchar(100) ,
 `team_id` int(10) unsigned ,
 `damage_done` int(10) unsigned ,
 `healing_done` int(10) unsigned ,
 `kills` char(1) ,
 `personal_rating` int(10) unsigned ,
 `rating_change` int(11) ,
 `timestamp` datetime ,
 `length` int(6) unsigned 
)*/;

/*Table structure for table `arena_fights_view` */

DROP TABLE IF EXISTS `arena_fights_view`;

/*!50001 DROP VIEW IF EXISTS `arena_fights_view` */;
/*!50001 DROP TABLE IF EXISTS `arena_fights_view` */;

/*!50001 CREATE TABLE  `arena_fights_view`(
 `fight_guid` int(10) unsigned ,
 `type` char(1) ,
 `winners_name` varchar(100) ,
 `winners_id` int(10) unsigned ,
 `winners_rating` int(10) unsigned ,
 `losers_name` varchar(100) ,
 `losers_id` int(10) unsigned ,
 `losers_rating` int(10) unsigned ,
 `rating_change` int(10) unsigned ,
 `timestamp` datetime ,
 `length` int(6) unsigned 
)*/;

/*Table structure for table `boss_fights_detailed_view` */

DROP TABLE IF EXISTS `boss_fights_detailed_view`;

/*!50001 DROP VIEW IF EXISTS `boss_fights_detailed_view` */;
/*!50001 DROP TABLE IF EXISTS `boss_fights_detailed_view` */;

/*!50001 CREATE TABLE  `boss_fights_detailed_view`(
 `kill_id` int(10) unsigned ,
 `player_name` varchar(12) ,
 `player_guid` int(10) unsigned ,
 `healing` int(10) unsigned ,
 `damage` int(10) unsigned ,
 `deaths` int(2) unsigned 
)*/;

/*Table structure for table `boss_fights_loot_view` */

DROP TABLE IF EXISTS `boss_fights_loot_view`;

/*!50001 DROP VIEW IF EXISTS `boss_fights_loot_view` */;
/*!50001 DROP TABLE IF EXISTS `boss_fights_loot_view` */;

/*!50001 CREATE TABLE  `boss_fights_loot_view`(
 `kill_id` int(10) unsigned ,
 `item_id` int(6) unsigned ,
 `name` varchar(255) ,
 `count` int(2) 
)*/;

/*Table structure for table `boss_fights_view` */

DROP TABLE IF EXISTS `boss_fights_view`;

/*!50001 DROP VIEW IF EXISTS `boss_fights_view` */;
/*!50001 DROP TABLE IF EXISTS `boss_fights_view` */;

/*!50001 CREATE TABLE  `boss_fights_view`(
 `kill_id` int(10) unsigned ,
 `boss_name` varchar(26) ,
 `mob_id` int(5) unsigned ,
 `location` varchar(40) ,
 `instance_id` int(5) unsigned ,
 `name` varchar(255) ,
 `guild_id` int(5) unsigned zerofill ,
 `length` int(5) unsigned ,
 `date` datetime 
)*/;

/*View structure for view arena_fights_detailed_view */

/*!50001 DROP TABLE IF EXISTS `arena_fights_detailed_view` */;
/*!50001 DROP VIEW IF EXISTS `arena_fights_detailed_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`elyrion` SQL SECURITY DEFINER VIEW `arena_fights_detailed_view` AS (select `d`.`fight_guid` AS `fight_guid`,`t`.`type` AS `type`,`c`.`name` AS `nick`,`w`.`name` AS `arena_team_name`,`d`.`team_id` AS `team_id`,`d`.`damage_done` AS `damage_done`,`d`.`healing_done` AS `healing_done`,`d`.`kills` AS `kills`,`d`.`personal_rating` AS `personal_rating`,`d`.`rating_change` AS `rating_change`,`t`.`timestamp` AS `timestamp`,`t`.`length` AS `length` from (((`arena_fights_detailed` `d` join `arena_fights` `t` on((`d`.`fight_guid` = `t`.`fight_guid`))) left join `arena_team` `w` on((`w`.`arenateamid` = `d`.`team_id`))) left join `characters` `c` on((`d`.`player_guid` = `c`.`guid`))) where (`t`.`timestamp` < (sysdate() - interval 12 hour)) order by `t`.`timestamp` desc) */;

/*View structure for view arena_fights_view */

/*!50001 DROP TABLE IF EXISTS `arena_fights_view` */;
/*!50001 DROP VIEW IF EXISTS `arena_fights_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`elyrion` SQL SECURITY DEFINER VIEW `arena_fights_view` AS (select `f`.`fight_guid` AS `fight_guid`,`f`.`type` AS `type`,`w`.`name` AS `winners_name`,`f`.`winners_id` AS `winners_id`,`f`.`winners_rating` AS `winners_rating`,`l`.`name` AS `losers_name`,`f`.`losers_id` AS `losers_id`,`f`.`losers_rating` AS `losers_rating`,`f`.`rating_change` AS `rating_change`,`f`.`timestamp` AS `timestamp`,`f`.`length` AS `length` from ((`arena_fights` `f` join `arena_team` `w` on((`f`.`winners_id` = `w`.`arenateamid`))) left join `arena_team` `l` on((`f`.`losers_id` = `l`.`arenateamid`))) where (`f`.`timestamp` < (sysdate() - interval 12 hour)) order by `f`.`timestamp` desc) */;

/*View structure for view boss_fights_detailed_view */

/*!50001 DROP TABLE IF EXISTS `boss_fights_detailed_view` */;
/*!50001 DROP VIEW IF EXISTS `boss_fights_detailed_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`elyrion` SQL SECURITY DEFINER VIEW `boss_fights_detailed_view` AS (select `b`.`kill_id` AS `kill_id`,`c`.`name` AS `player_name`,`b`.`player_guid` AS `player_guid`,`b`.`healing` AS `healing`,`b`.`damage` AS `damage`,`b`.`deaths` AS `deaths` from (`boss_fights_detailed` `b` left join `characters` `c` on((`c`.`guid` = `b`.`player_guid`)))) */;

/*View structure for view boss_fights_loot_view */

/*!50001 DROP TABLE IF EXISTS `boss_fights_loot_view` */;
/*!50001 DROP VIEW IF EXISTS `boss_fights_loot_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`elyrion` SQL SECURITY DEFINER VIEW `boss_fights_loot_view` AS (select `l`.`kill_id` AS `kill_id`,`l`.`item_id` AS `item_id`,`t`.`name` AS `name`,`l`.`count` AS `count` from (`characters`.`boss_fights_loot` `l` left join `world`.`item_template` `t` on((`t`.`entry` = `l`.`item_id`)))) */;

/*View structure for view boss_fights_view */

/*!50001 DROP TABLE IF EXISTS `boss_fights_view` */;
/*!50001 DROP VIEW IF EXISTS `boss_fights_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`elyrion` SQL SECURITY DEFINER VIEW `boss_fights_view` AS (select `f`.`kill_id` AS `kill_id`,`n`.`boss_name` AS `boss_name`,`f`.`mob_id` AS `mob_id`,`l`.`boss_location` AS `location`,`f`.`instance_id` AS `instance_id`,`g`.`name` AS `name`,`f`.`guild_id` AS `guild_id`,`f`.`length` AS `length`,`f`.`date` AS `date` from (((`boss_fights` `f` join `boss_id_names` `n` on((`f`.`mob_id` = `n`.`boss_id`))) left join `guild` `g` on((`f`.`guild_id` = `g`.`guildid`))) join `boss_id_locations` `l` on((`n`.`boss_id` = `l`.`boss_id`)))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
