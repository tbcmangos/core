-- Night Web Matriarch http://www.wowhead.com/npc=1688#drop
delete from creature_ai_scripts where entryOrGuid=1688;
INSERT INTO `creature_ai_scripts` VALUES ('168851', '1688', '0', '0', '100', '1', '3000', '5000', '8000', '15000', '11', '744', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Night Web Matriarch casts Poison');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '1688';


-- Muad  http://www.wowhead.com/npc=1910/muad
delete from creature_ai_scripts where entryOrGuid=1910;
INSERT INTO `creature_ai_scripts` VALUES ('191051', '1910', '0', '0', '100', '1', '1000', '2000', '3000', '4000', '11', '2607', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Muad casts Shock');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '1910';
UPDATE `creature` SET `spawntimesecs`='3600',`position_x`='2545.52', `position_y`='1425.54', `position_z`='-0.105187' WHERE (`guid`='43909');


-- Lost Soul http://www.wowhead.com/npc=1531/lost-soul#drops
delete from creature_ai_scripts where entryOrGuid=1531;
INSERT INTO `creature_ai_scripts` VALUES ('153151', '1531', '0', '0', '100', '1', '2000', '3000', '9000', '14000', '11', '7713', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Lost Soul casts Wailing Dead');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '1531';

UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='100' WHERE (`entry`='1531') AND (`item`='3322');
UPDATE `creature` SET `spawntimesecs`='3600' WHERE (`guid`='44863');
UPDATE `creature` SET `spawntimesecs`='7200', `spawndist`='7', `MovementType`='1' WHERE (`guid`='44864');

-- Bayne http://www.wowhead.com/npc=10356/bayne
UPDATE `creature` SET `spawntimesecs`='3600', `spawndist`='10',`position_x`='2347.84', `position_y`='958.843', `position_z`='61.8082' WHERE (`guid`='42142');
delete from creature_ai_scripts where entryOrGuid=10356;
INSERT INTO `creature_ai_scripts` VALUES ('1035651', '10356', '0', '0', '100', '1', '3000', '5000', '10000', '20000', '11', '13443', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Bayne casts Rend');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '10356';

-- Farmer Solliden http://www.wowhead.com/npc=1936
delete from creature_ai_scripts where entryOrGuid=1936;
INSERT INTO `creature_ai_scripts` VALUES ('193651', '1936', '0', '0', '100', '1', '2000', '5000', '5000', '10000', '11', '11976', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Farmer Solliden casts Strike');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '1936';
UPDATE `creature_addon` SET `path_id`='44569' WHERE (`guid`='44569');
UPDATE `creature` SET `spawntimesecs`='1500',`MovementType`='2' WHERE (`guid`='44569');
delete from waypoint_data where id=44569;
INSERT INTO `waypoint_data` VALUES ('44569', '1', '2272.56', '1314.44', '33.8873', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '2', '2275.9', '1314.6', '33.1053', '3', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '3', '2278.32', '1332.85', '33.6114', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '4', '2278.65', '1373.43', '33.3342', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '5', '2273.37', '1404.63', '33.3342', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '6', '2272.36', '1454.15', '33.334', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '7', '2263.83', '1493.85', '33.4799', '10', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '8', '2291.53', '1473.79', '33.3329', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '9', '2316.57', '1414.47', '33.3329', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '10', '2323.32', '1360.04', '33.3329', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '11', '2316.66', '1326.79', '33.7835', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '12', '2319.2', '1316.91', '33.149', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '13', '2326.55', '1316.05', '33.9349', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '14', '2327.33', '1307.02', '33.9867', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '15', '2340.43', '1315.87', '34.0122', '5', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '16', '2343.65', '1308.29', '34.0688', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '17', '2326.75', '1308.9', '33.9743', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '18', '2325.09', '1316.08', '33.9293', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '19', '2306.46', '1315.8', '31.6259', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('44569', '20', '2273.87', '1314.79', '33.3893', '0', '0', '0', '100', '0');


-- Tormented Spirit http://www.wowhead.com/npc=1533/tormented-spirit
delete from creature_ai_scripts where entryOrGuid=1533;
INSERT INTO `creature_ai_scripts` VALUES ('153351', '1533', '0', '0', '100', '1', '1500', '5000', '8000', '15000', '11', '7713', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Tormented Spirit casts Wailing Dead');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '1533';
UPDATE `creature` SET `spawntimesecs`='1200', `spawndist`='0', `MovementType`='2' WHERE (`guid`='49222');
delete from creature_addon where guid=49222;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES ('49222', '49222');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='100' WHERE (`entry`='1533') AND (`item`='3323');
delete from waypoint_data where id=49222;
INSERT INTO `waypoint_data` VALUES ('49222', '1', '2886.73', '981.045', '115.93', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '2', '2877.36', '996.839', '114.588', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '3', '2858.82', '1009.43', '118.347', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '4', '2823.3', '1006.41', '117.23', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '5', '2784.39', '993.786', '111.645', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '6', '2747.94', '970.203', '109.949', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '7', '2732.36', '948.612', '109.398', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '8', '2742.56', '918.001', '110.429', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '9', '2758.49', '889.008', '111.656', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '10', '2778.46', '852.821', '111.825', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '11', '2806.93', '831.345', '111.84', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '12', '2834.29', '837.67', '111.842', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '13', '2874.44', '841.818', '111.501', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '14', '2875.83', '872.774', '115.361', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '15', '2874.02', '892.332', '113.452', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '16', '2899.31', '922.548', '115.364', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '17', '2897.52', '962.518', '114.863', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('49222', '18', '2868.96', '976.368', '117.692', '0', '0', '0', '100', '0');


-- Deeb http://www.wowhead.com/npc=1911/deeb
UPDATE `creature` SET `position_x`='3058.34', `position_y`='-251.254', `position_z`='2.73294', `orientation`='1.89149', `spawntimesecs`='5400' WHERE (`guid`='42144');
-- http://wowwiki.wikia.com/Cranial_Thumper
DELETE FROM `reference_loot_template` WHERE (`entry`='24075') AND (`item`='4303');
delete from creature_loot_template where item=4303;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`) VALUES ('1911', '4303', '10');

-- Ressan the Needler http://www.wowhead.com/npc=10357/ressan-the-needler#abilities
UPDATE `creature` SET `spawntimesecs`='5400',`spawndist`='15' WHERE (`guid`='42141');

-- Sri'skulk http://www.wowhead.com/npc=10359/sriskulk#abilities
delete from creature_ai_scripts where entryOrGuid=10359;
INSERT INTO `creature_ai_scripts` VALUES ('1035951', '10359', '0', '0', '100', '1', '2000', '3000', '10000', '15000', '11', '3583', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sri skulk casts Deadly Poison');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '10359';
UPDATE `creature` SET `spawntimesecs`='5400', `spawndist`='8' WHERE (`guid`='86604');

-- Fellicent's Shade http://www.wowhead.com/npc=10358/fellicents-shade#abilities
UPDATE `creature` SET `spawntimesecs`='5400', `spawndist`='0', `MovementType`='2' WHERE (`guid`='42143');
delete from creature_ai_scripts where entryOrGuid=10358;
INSERT INTO `creature_ai_scripts` VALUES ('1035851', '10358', '0', '0', '100', '1', '2000', '3000', '6000', '12000', '11', '37361', '1', '4', '0', '0', '0', '0', '0', '0', '0', '0', 'Fellicents Shade casts Arcane Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('1035852', '10358', '9', '0', '100', '1', '0', '10', '10000', '16000', '11', '11975', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Fellicents Shade casts Arcane Explosion');
INSERT INTO `creature_ai_scripts` VALUES ('1035853', '10358', '4', '0', '100', '0', '0', '0', '0', '0', '11', '7068', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fellicents Shade casts Veil of Shadow');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '10358';

UPDATE `creature_addon` SET `path_id`='10358' WHERE (`guid`='42143');
delete from waypoint_data where id=10358;
INSERT INTO `waypoint_data` VALUES ('10358', '1', '2028.89', '-344.999', '35.4524', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '2', '2053.12', '-349.733', '35.3781', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '3', '2059.57', '-366.799', '35.4513', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '4', '2051.88', '-395.13', '35.5169', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '5', '2044.66', '-426.875', '35.4527', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '6', '2026.22', '-433.142', '35.3782', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '7', '2000.03', '-423.258', '35.4507', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '8', '1980.77', '-433.104', '35.2954', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '9', '1945.2', '-418.675', '35.4508', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '10', '1951.2', '-396.858', '35.4508', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '11', '1963.35', '-375.106', '35.4508', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '12', '1966.61', '-339.139', '35.4508', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '13', '1990.59', '-346.477', '35.4531', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '14', '2019.82', '-345.216', '35.4531', '0', '0', '0', '100', '0');
INSERT INTO `waypoint_data` VALUES ('10358', '15', '2048.2', '-359.297', '35.4529', '0', '0', '0', '100', '0');