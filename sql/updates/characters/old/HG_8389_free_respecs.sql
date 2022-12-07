DROP TABLE IF EXISTS `character_freerespecs`;
CREATE TABLE `character_freerespecs` (
`guid` int(11) unsigned NOT NULL DEFAULT '0',
`expiration_date` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE='InnoDB' COLLATE 'utf8_general_ci'; 