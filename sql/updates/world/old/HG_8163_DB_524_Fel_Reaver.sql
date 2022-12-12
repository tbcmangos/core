delete from creature_ai_scripts where entryOrGuid=18733;
INSERT INTO `creature_ai_scripts` VALUES ('1873351', '18733', '0', '0', '100', '1', '5000', '8000', '15000', '20000', '11', '41534', '0', '10', '0', '0', '0', '0', '0', '0', '0', '0', 'Fel Reaver casts War Stomp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '18733';


UPDATE `waypoint_data` SET `position_x`='-756.111', `position_y`='4154.117', `position_z`='51.63' WHERE (`id`='8989') AND (`point`='31');
UPDATE `waypoint_data` SET `position_x`='-748.535', `position_y`='4192.78', `position_z`='49.31' WHERE (`id`='8989') AND (`point`='32');
UPDATE `waypoint_data` SET `position_x`='-704.01', `position_y`='4229.127', `position_z`='53.8292' WHERE (`id`='8989') AND (`point`='33');
UPDATE `waypoint_data` SET `position_x`='-299.612', `position_y`='4653.372', `position_z`='24.6515' WHERE (`id`='8989') AND (`point`='46');
UPDATE `waypoint_data` SET `position_x`='-268.944', `position_y`='4682.863', `position_z`='16.0178' WHERE (`id`='8989') AND (`point`='47');