DROP TABLE IF EXISTS `map_specifics`;
CREATE TABLE `map_specifics`(
`entry` INT(3) UNSIGNED NOT NULL COMMENT 'MapID',
`visibility` FLOAT(3) UNSIGNED DEFAULT '533.0' COMMENT 'VisibilityRadius',
`pathfinding` SMALLINT(1) UNSIGNED DEFAULT '6' COMMENT 'PathFinding Prioririty',
`lineofsight` SMALLINT(1) UNSIGNED DEFAULT '6' COMMENT 'LineOfSightPrioririty', 
PRIMARY KEY (`entry`));

INSERT INTO `map_specifics` (`entry`, `visibility`, `pathfinding`) VALUES
(0, 80, 1),
(1, 80, 1),
(13, 130, 1),
(25, 130, 1),
(29, 130, 1),
(30, 170, 1),
(33, 130, 1),
(34, 130, 1),
(36, 130, 1),
(43, 130, 1),
(47, 130, 1),
(48, 130, 1),
(70, 130, 1),
(90, 130, 1),
(109, 130, 1),
(129, 130, 1),
(169, 130, 1),
(189, 130, 1),
(209, 130, 1),
(229, 130, 1),
(230, 130, 1),
(249, 130, 1),
(269, 130, 1),
(289, 130, 1),
(309, 130, 1),
(329, 130, 1),
(349, 130, 1),
(369, 130, 1),
(389, 130, 1),
(409, 130, 1),
(429, 130, 1),
(449, 130, 1),
(450, 130, 1),
(451, 130, 1),
(469, 130, 1),
(489, 170, 1),
(509, 130, 1),
(529, 170, 1),
(530, 80, 1),
(531, 130, 1),
(532, 130, 3),
(533, 130, 1),
(534, 175, 3),
(540, 130, 2),
(542, 130, 2),
(543, 130, 2),
(544, 130, 1),
(545, 130, 2),
(546, 130, 2),
(547, 130, 2),
(548, 130, 3),
(550, 175, 3),
(552, 130, 2),
(553, 130, 2),
(554, 130, 2),
(555, 130, 2),
(556, 130, 2),
(557, 130, 2),
(558, 130, 2),
(559, 200, 6),
(560, 130, 2),
(562, 200, 6),
(564, 175, 3),
(565, 130, 3),
(566, 170, 2),
(568, 130, 3),
(572, 200, 6), 
(580, 130, 3),
(585, 130, 2),
(598, 130, 2);