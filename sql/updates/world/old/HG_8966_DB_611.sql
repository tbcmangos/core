-- http://www.wowhead.com/npc=8964/blackrock-drake

UPDATE `creature` SET `MovementType`='2', `spawndist`='0' WHERE (`guid`='3343');
UPDATE `creature` SET `MovementType`='2', `spawndist`='0' WHERE (`guid`='3344');

UPDATE `creature_addon` SET `path_id`='3343' WHERE (`guid`='3343');
UPDATE `creature_addon` SET `path_id`='3344' WHERE (`guid`='3344');

delete from waypoint_data where id=3343;
INSERT INTO `waypoint_data` VALUES ('3343', '1', '-7550.33', '-1114.81', '308.152', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '2', '-7555.19', '-1092.27', '293.356', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '3', '-7593.13', '-1059.41', '288.778', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '4', '-7643.02', '-1078.42', '285.957', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '5', '-7646.65', '-1103.19', '274.729', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '6', '-7642.45', '-1136.92', '289.814', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '7', '-7607.44', '-1172.63', '314.802', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '8', '-7571.36', '-1170.33', '324.31', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '9', '-7545.18', '-1118.57', '325.758', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3343', '10', '-7579', '-1097.55', '316.815', '0', '0', '0', '100', '0');

delete from waypoint_data where id=3344;
INSERT INTO `waypoint_data` VALUES ('3344', '1', '-7663.81', '-1108.9', '276.422', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '2', '-7625.96', '-1071.83', '250.136', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '3', '-7558.87', '-1070.22', '241.197', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '4', '-7523.03', '-1119.8', '240.41', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '5', '-7542.57', '-1183.19', '235.97', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '6', '-7617.03', '-1161.33', '234.841', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '7', '-7657.68', '-1132.08', '252.505', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '8', '-7631.17', '-1072.35', '278.433', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '9', '-7556.53', '-1068.79', '297.693', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '10', '-7519.56', '-1157.63', '303.705', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '11', '-7550.2', '-1189.18', '319.529', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '12', '-7609.87', '-1160.01', '315.747', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('3344', '13', '-7591.1', '-1100.79', '356.274', '0', '0', '0', '100', '0');



-- http://www.wowwiki.com/Bloodsail_Mage  
-- rework of old fix. Now they shouldn't keep casting in flee mode.
delete from creature_ai_scripts where entryOrGUID=1562;
INSERT INTO `creature_ai_scripts` VALUES ('156211', '1562', '7', '0', '100', '0', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Set Phase to 0 on Evade');
INSERT INTO `creature_ai_scripts` VALUES ('156210', '1562', '2', '7', '100', '0', '15', '0', '0', '0', '21', '1', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', 'Bloodsail Mage - Start Combat Movement and Flee at 15% HP (Phase 3)');
INSERT INTO `creature_ai_scripts` VALUES ('156209', '1562', '2', '0', '100', '0', '15', '0', '0', '0', '22', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Set Phase 3 at 15% HP');
INSERT INTO `creature_ai_scripts` VALUES ('156208', '1562', '3', '11', '100', '1', '100', '30', '100', '100', '23', '-1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Set Phase 1 when Mana is above 30% (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES ('156207', '1562', '9', '13', '100', '0', '0', '5', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Start Combat Movement Below 5 Yards');
INSERT INTO `creature_ai_scripts` VALUES ('156206', '1562', '9', '13', '100', '0', '5', '15', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Prevent Combat Movement at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES ('156205', '1562', '9', '13', '100', '0', '35', '80', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Start Combat Movement at 35 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES ('156204', '1562', '3', '13', '100', '0', '15', '0', '0', '0', '21', '1', '0', '0', '23', '1', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES ('156203', '1562', '9', '13', '100', '1', '0', '40', '3000', '4000', '11', '20823', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Cast Fireball (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES ('156202', '1562', '4', '0', '100', '0', '0', '0', '0', '0', '11', '2601', '0', '2', '23', '1', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Cast Fire Shield III and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES ('156201', '1562', '1', '0', '100', '0', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bloodsail Mage - Prevent Combat Movement on Spawn');




-- http://www.wowhead.com/npc=15185/brood-of-nozdormu

UPDATE `creature` SET `MovementType`='2', `spawndist`='0' WHERE (`guid`='42900');
UPDATE `creature_addon` SET `path_id`='42900' WHERE (`guid`='42900');
delete from waypoint_data where id=42900;
INSERT INTO `waypoint_data` VALUES ('42900', '1', '-6651.86', '27.7306', '164.424', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '2', '-6611.32', '27.2501', '155.718', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '3', '-6567.26', '26.8585', '168.656', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '4', '-6519.79', '48.3686', '169.675', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '5', '-6500.63', '49.916', '186.731', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '6', '-6477.86', '90.4404', '174.826', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '7', '-6456.79', '136.016', '173.828', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '8', '-6477.23', '145.146', '189.844', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '9', '-6520.54', '148.635', '201.708', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '10', '-6593.94', '144.167', '195.499', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42900', '11', '-6651.88', '163.556', '178.177', '0', '0', '0', '100', '0');

UPDATE `creature` SET `MovementType`='2', `spawndist`='0' WHERE (`guid`='42902');
UPDATE `creature_addon` SET `path_id`='42902' WHERE (`guid`='42902');
delete from waypoint_data where id=42902;
INSERT INTO `waypoint_data` VALUES ('42902', '1', '-6701.48', '733.278', '165.099', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '2', '-6673.87', '755.072', '148.387', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '3', '-6657.13', '789.113', '155.124', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '4', '-6687.08', '840.867', '137.665', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '5', '-6725.16', '886.132', '147.761', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '6', '-6787.22', '890.191', '128.672', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '7', '-6817.84', '879.458', '115.164', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '8', '-6903.82', '880.592', '115.96', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '9', '-6920.82', '821.239', '123.825', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '10', '-6911.28', '743.245', '107.781', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '11', '-6858.53', '709.067', '120.246', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42902', '12', '-6826.96', '654.155', '149.363', '0', '0', '0', '100', '0');


UPDATE `creature` SET `MovementType`='2', `spawndist`='0' WHERE (`guid`='42901');
UPDATE `creature_addon` SET `path_id`='42901' WHERE (`guid`='42901');
delete from waypoint_data where id=42901;
INSERT INTO `waypoint_data` VALUES ('42901', '1', '-7955.84', '1743.64', '139.714', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '2', '-7977.98', '1716.75', '117.345', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '3', '-7986.5', '1685.18', '104.704', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '4', '-8019.01', '1646.91', '103.449', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '5', '-8075.32', '1636.35', '94.9479', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '6', '-8120.12', '1682.2', '111.684', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '7', '-8087.22', '1730.37', '118.691', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '8', '-8041.85', '1810.18', '129.199', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '9', '-8019.58', '1892', '132.807', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '10', '-7918.87', '1894.08', '124.654', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('42901', '11', '-7834.39', '1832.24', '117.641', '0', '0', '0', '100', '0');




-- http://www.wowhead.com/npc=25073/darkspine-siren too high speed!!!
UPDATE `creature_template` SET `speed`='1' WHERE (`entry`='25073');




-- quest 9280 urgent   
-- Quest 9409 shouldn't be acceptable before doing 1-2 previous( depends on race). 9369 is NON draenei version.
UPDATE `quest_template` SET `PrevQuestId`='9280' WHERE (`entry`='9409');
UPDATE `quest_template` SET `NextQuestId`='9409' WHERE (`entry`='9369');
UPDATE `quest_template` SET `PrevQuestId`='9409' WHERE (`entry`='9371');




-- Legion Fel Cannon http://www.wowhead.com/npc=21233/legion-fel-cannon#abilities
delete from creature_ai_scripts where entryOrGUID=21233;
INSERT INTO `creature_ai_scripts` VALUES ('2123351', '21233', '4', '0', '100', '0', '0', '0', '0', '0', '20', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', 'Legion Fel Cannon block autoattack and movement');
INSERT INTO `creature_ai_scripts` VALUES ('2123352', '21233', '9', '0', '100', '1', '0', '50', '2500', '3500', '11', '36238', '1', '8', '0', '0', '0', '0', '0', '0', '0', '0', 'Legion Fel Cannon casts Fel Cannon Blast');
UPDATE `creature_template` SET `AIName` = 'EventAI',`mechanic_immune_mask`='10502416' WHERE `entry` = '21233';




-- Putrid Claw http://www.wowhead.com/item=2855 http://www.wowhead.com/item=2855/putrid-claw low chance compare with wowhead.
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='1525') AND (`item`='2855');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='1526') AND (`item`='2855');

-- Darkhound Blood http://www.wowhead.com/item=2858  chance buff from 35 to 50 %.
update creature_loot_template set ChanceOrQuestChance='-50' where item=2858;

-- Duskbat Pelt http://www.wowhead.com/item=2876 same for other quest item.
update creature_loot_template set ChanceOrQuestChance='-50' where item=2876;






