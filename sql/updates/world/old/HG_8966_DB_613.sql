-- http://www.wowhead.com/npc=19298/warbringer-arixamal#comments
delete from creature_ai_scripts where entryOrGuid=19298;
INSERT INTO `creature_ai_scripts` VALUES ('1929851', '19298', '11', '0', '100', '0', '0', '0', '0', '0', '11', '32008', '0', '35', '0', '0', '0', '0', '0', '0', '0', '0', 'Warbringer ArixAmal casts Fel Fire');
INSERT INTO `creature_ai_scripts` VALUES ('1929852', '19298', '0', '0', '100', '1', '2000', '8000', '7000', '10000', '11', '15496', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Warbringer ArixAmal casts Cleave');
INSERT INTO `creature_ai_scripts` VALUES ('1929853', '19298', '0', '0', '100', '1', '5000', '7500', '10000', '15000', '11', '32009', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Warbringer ArixAmal casts Cutdown');
INSERT INTO `creature_ai_scripts` VALUES ('1929854', '19298', '0', '0', '100', '1', '10000', '12000', '15000', '25000', '11', '33803', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Warbringer ArixAmal casts Flame Wave');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '19298';


-- http://www.wowhead.com/quest=10250/bloody-vengeance quest 
-- http://www.youtube.com/watch?v=eefF29PA0vQ
UPDATE `creature_template` SET `mindmg`='70', `maxdmg`='80' WHERE (`entry`='20137');
UPDATE `creature_template` SET `mindmg`='90', `maxdmg`='95' WHERE (`entry`='19862');

delete from creature_ai_texts where entry='-16907';
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`, `comment`) VALUES ('-16907', 'Your bones will be devoured!', '0', 'Bleeding Hollow Peon aggro');
delete from creature_ai_scripts where entryOrGuid=16907 and event_type=4;
INSERT INTO `creature_ai_scripts` VALUES ('1690752', '16907', '4', '0', '33', '0', '0', '0', '0', '0', '1', '-16907', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Bleeding Hollow Peon aggro phrase');

delete from creature_ai_scripts where entryOrGuid=19862;
INSERT  INTO `creature_ai_scripts` VALUES ('1986251', '19862', '11', '0', '100', '0', '0', '0', '0', '0', '1', '-19862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ' Urtrak spawn phrase');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '19862';
delete from creature_ai_texts where entry='-19862';
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`, `comment`) VALUES ('-19862', 'Urtrak kill you', '0', 'Urtrak spawn');

delete from creature_ai_scripts where entryOrGuid=19864;
INSERT  INTO `creature_ai_scripts` VALUES ('1986451', '19864', '11', '0', '100', '0', '0', '0', '0', '0', '1', '-19864', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ' Vengeful Unyielding Captain spawn phrase');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '19862';
delete from creature_ai_texts where entry='-19864';
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`, `comment`) VALUES ('-19864', 'Vengeance is ours!Attack my brothers!', '0', 'Vengeful Unyielding Captain spawn');

delete from event_scripts where id=12823;
INSERT INTO `event_scripts` VALUES ('12823', '0', '10', '19862', '60000', '0', '-1175.41', '2264.59', '53.1733', '3.15905');
INSERT INTO `event_scripts` VALUES ('12823', '4', '10', '20137', '60000', '0', '-1190.11', '2258.2', '46.6871', '1.36136');
INSERT INTO `event_scripts` VALUES ('12823', '4', '10', '20137', '60000', '0', '-1196.75', '2264.76', '47.9826', '6.19592');
INSERT INTO `event_scripts` VALUES ('12823', '4', '10', '20137', '60000', '0', '-1193.53', '2259.04', '47.484', '0.820305');
INSERT INTO `event_scripts` VALUES ('12823', '4', '10', '20137', '60000', '0', '-1190.24', '2269.2', '46.0973', '4.97419');
INSERT INTO `event_scripts` VALUES ('12823', '4', '10', '19864', '60000', '0', '-1195.85', '2270.93', '47.35', '5.95');
INSERT INTO `event_scripts` VALUES ('12823', '4', '10', '20137', '60000', '0', '-1195.592', '2261.33', '47.77', '0.72');

-- adding weapons for ghosts
UPDATE `creature_template` SET `equipment_id`='881' WHERE `entry` in ('19864','20137');