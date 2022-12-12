
-- water elem BT wp remake
delete from waypoint_data where id=12869;
INSERT INTO `waypoint_data` VALUES ('12869', '1', '252.829', '918.804', '-42.934', '0', '0', '0', '100', '223958');
INSERT INTO `waypoint_data` VALUES ('12869', '2', '252.824', '937.116', '-52.416', '0', '0', '0', '100', '223960');
INSERT INTO `waypoint_data` VALUES ('12869', '3', '252.65', '949.365', '-58.9897', '0', '0', '0', '100', '223962');
INSERT INTO `waypoint_data` VALUES ('12869', '4', '251.526', '955.607', '-61.2448', '0', '0', '0', '100', '223964');
INSERT INTO `waypoint_data` VALUES ('12869', '5', '247.052', '969.012', '-62.5962', '0', '0', '0', '100', '223966');
INSERT INTO `waypoint_data` VALUES ('12869', '6', '256.074', '965.129', '-62.6298', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('12869', '7', '254.065', '951.988', '-60.3984', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('12869', '8', '253.852', '929.761', '-48.4755', '0', '0', '0', '100', '0');

-- http://letswow.ru/wowhead/?item=30431 very low drop for quest item. Little increase.
update creature_loot_template set ChanceOrQuestChance=5 where item=30431;

-- Recipe Hot Apple Cider for Alliance
UPDATE `quest_template` SET `RewMailTemplateId`='187', `RewMailDelaySecs`='30' WHERE (`entry`='7045');


-- Nova Terra
-- http://wowhead.com/npc=20297#comments 
delete from creature where id=20297;
delete from creature_addon where guid=3844;
INSERT INTO `creature` VALUES ('3844', '20297', '530', '1', '0', '0', '2384.147', '3197.86', '152.837', '5.1531', '600', '0', '0', '8', '3155', '0', '0');
delete from creature_ai_scripts where entryOrGuid=20297;
INSERT INTO `creature_ai_scripts` VALUES ('2029751', '20297', '11', '0', '100', '0', '0', '0', '0', '0', '11', '1784', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Nova Terra casts stealth on spawn');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '20297';


-- Kroshius' Infernal Core
-- http://www.wowhead.com/quest=7603#.  http://www.wowhead.com/npc=659/el-pollo-grande#comments
 UPDATE `quest_template` SET `CompleteScript`='7603' WHERE (`entry`='7603');
 delete from quest_end_scripts where id=7603;
 INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES ('7603', '3', '10', '659', '120000', '5420.597', '-727.608', '343.639', '3.54');
 INSERT INTO `quest_end_scripts` (`id`, `delay`,`datalong`, `datalong2`,`dataint`) VALUES ('7603','1', '3', '0','2000000091');
 INSERT INTO `quest_end_scripts` (`id`, `delay`,`datalong`, `datalong2`,`dataint`) VALUES ('7603','4', '3', '0','2000000092');
 INSERT INTO `quest_end_scripts` (`id`, `delay`,`datalong`, `datalong2`,`dataint`) VALUES ('7603','7', '3', '0','2000000093');
  
 delete from db_script_string where entry in (2000000091,2000000092,2000000093);
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000091', 'Stand back! Stand clear! The infernal will need to be given a wide berth!'); 
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000092', 'BOW DOWN TO THE ALMIGHTY! BOW DOWN BEFORE MY INFERNAL DESTRO... chicken?'); 
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000093', 'Silence, servant! Vengeance will be mine! Death to Stormwind! Death by chicken!');   
 delete from gameobject where id=300049;
 INSERT INTO `gameobject` VALUES ('13615822', '300049', '1', '1', '5784.19', '-964.472', '413.645', '0.985319', '0', '0', '0.472971', '0.881078', '25', '0', '1');
 delete  from creature_loot_template where entry=659;
 delete  from creature where id=14467;

-- Highlord Kruul
-- http://www.wowhead.com/npc=18338/highlord-kruul#comments
UPDATE `creature_template` SET `equipment_id`='1268',`mindmg`='989', `maxdmg`='1000', `attackpower`='11500', `lootid`='12397' WHERE (`entry`='18338');
delete from creature where id=18338;
INSERT INTO `creature` VALUES ('2800', '18338', '0', '1', '0', '0', '-12257.3', '-2457.02', '2.19384', '5.65633', '3600', '1', '0', '640000', '0', '0', '1');

-- Fix guid of Omen
UPDATE `game_event_creature` SET `guid`='2468' WHERE (`guid`='705') AND (`event`='7');
