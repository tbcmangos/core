
-- Darkmoon Faire fixes
--  http://wowhead.com/item=11027#comments
UPDATE `npc_vendor` SET `maxcount`='2', `incrtime`='900' WHERE (`entry`='14860') AND (`item`='11027');
-- http://letswow.ru/wowhead/?item=11325 http://wowhead.com/item=11325 This item shouldn't be dropped by any npc.
delete from creature_loot_template where item=11325; 
DELETE FROM `gameobject_loot_template` WHERE (`entry`='11282') AND (`item`='11325');


-- Corrosion Prevention
-- http://www.wowhead.com/quest=11174#.
delete from creature_ai_scripts where entryOrGuid=4393;
INSERT INTO `creature_ai_scripts` VALUES ('439351', '4393', '8', '0', '100', '0', '42489', '-1', '0', '0', '33', '23797', '6', '0', '37', '0', '0', '0', '0', '0', '0', '0', 'ytdb');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '4393';  
delete from creature_ai_scripts where entryOrGuid=4394;
INSERT INTO `creature_ai_scripts` VALUES ('439451', '4394', '8', '0', '100', '0', '42489', '-1', '0', '0', '11', '42486', '6', '0', '37', '0', '0', '0', '0', '0', '0', '0', 'Acidic Swamp Ooze quest credit');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '4394'; 


-- Challe's Home
-- http://www.wowhead.com/npc=23101/challe#. http://www.wowwiki.com/Challe's_Home_For_Little_Tykes
UPDATE `creature_template` SET `minlevel`='70', `maxlevel`='70',`minhealth`='8732', `maxhealth`='8732', `minmana`='8995', `maxmana`='8995',`npcflag`='1' WHERE (`entry`='23101');
delete from npc_text where ID=23101;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`) VALUES ('23101', 'Shh! Keep your voice down. The babes are sleeping.', 'Shh! Keep your voice down. The babes are sleeping.');
delete from npc_gossip where npc_guid=1953;
INSERT INTO `npc_gossip` (`npc_guid`, `textid`) VALUES ('1953', '23101');
delete from creature where id in (23101,23106,23108,23107);
INSERT INTO `creature` VALUES ('1953', '23101', '530', '1', '0', '0', '-480.918', '7498.14', '181.072', '3.34268', '300', '0', '0', '1', '0', '0', '0');
INSERT INTO `creature` VALUES ('2124', '23106', '530', '1', '0', '0', '-511.51', '7500.71', '182.98', '5.4829', '300', '0', '0', '1', '0', '0', '0');
INSERT INTO `creature` VALUES ('2281', '23108', '530', '1', '0', '0', '-476.271', '7468.2', '181.292', '2.38687', '300', '2', '0', '1', '0', '0', '1');
INSERT INTO `creature` VALUES ('2753', '23107', '530', '1', '0', '0', '-472.969', '7465.3', '181.501', '2.4065', '300', '2', '0', '1', '0', '0', '1');


-- Alicia add
-- http://wowhead.com/npc=24729#.
delete from creature where id=24729;
INSERT INTO `creature` VALUES ('2778', '24729', '0', '1', '0', '0', '-8397.46', '487.697', '123.76', '4.96721', '300', '0', '0', '1', '0', '0', '0');


-- Karazhan mini bosses
-- Rokad the Ravager  http://www.wowwiki.com/Rokad_the_Ravager  http://wowhead.com/npc=16181#comments
delete from creature_ai_scripts where entryOrGuid=16181;
INSERT INTO `creature_ai_scripts` VALUES ('1618151', '16181', '0', '0', '100', '1', '3000', '6000', '10000', '12000', '11', '29906', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Rokad the Ravager casts Ravage');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '16181';
delete from creature where id=16181;
INSERT INTO `creature` VALUES ('1960', '16181', '532', '1', '0', '0', '-10924.3', '-2049.96', '49.4739', '1.94977', '300', '0', '0', '227640', '0', '0', '0');

-- Hyakiss the Lurker http://wowhead.com/npc=16179#abilities  http://www.wowwiki.com/Hyakiss_the_Lurker 
delete from creature_ai_scripts where entryOrGuid=16179;
INSERT INTO `creature_ai_scripts` VALUES ('1617951', '16179', '1', '0', '100', '0', '500', '500', '0', '0', '11', '22766', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Hyakiss the Lurker casts Sneak');
INSERT INTO `creature_ai_scripts` VALUES ('1617952', '16179', '0', '0', '100', '1', '20000', '25000', '20000', '30000', '11', '29896', '1', '2', '13', '-10', '1', '0', '0', '0', '0', '0', 'Hyakiss the Lurker casts Hyakiss Web');
INSERT INTO `creature_ai_scripts` VALUES ('1617953', '16179', '0', '0', '100', '1', '3000', '5000', '5000', '5000', '11', '29901', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Hyakiss the Lurker casts Acidic Fang');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '16179';

-- Shadikith the Glider http://www.wowwiki.com/Shadikith_the_Glider  http://wowhead.com/npc=16180#abilities
UPDATE `creature_template` SET `armor`='7685', `mindmg`='4779', `maxdmg`='6758' WHERE (`entry`='16180');
delete from creature_ai_scripts where entryOrGuid=16180;
INSERT INTO `creature_ai_scripts` VALUES ('1618051', '16180', '0', '0', '100', '1', '8000', '10000', '20000', '30000', '11', '29904', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadikith the Glider casts Sonic Burst');
INSERT INTO `creature_ai_scripts` VALUES ('1618052', '16180', '0', '0', '100', '1', '15000', '20000', '25000', '40000', '11', '29903', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadikith the Glider casts Dive');
INSERT INTO `creature_ai_scripts` VALUES ('1618053', '16180', '0', '0', '100', '1', '6000', '12000', '18000', '30000', '11', '29905', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadikith the Glider casts Wing Buffet');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '16180';



-- Invisible npc
-- Lordaeron Citizen  http://www.wowhead.com/npc=3617#comments
delete from creature_ai_scripts where entryOrGUID=3617;
INSERT INTO `creature_ai_scripts` VALUES ('361751', '3617', '1', '0', '100', '0', '100', '100', '0', '0', '11', '16380', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Lordaeron Citizen casts Greater Invisibility');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '3617';
delete from creature where id=3617;
INSERT INTO `creature` VALUES ('4192', '3617', '0', '1', '0', '0', '1772.6', '254.482', '59.933', '5.95188', '300', '0', '0', '1400', '0', '0', '0');
INSERT INTO `creature` VALUES ('4294', '3617', '0', '1', '0', '0', '1770.64', '227.999', '60.0097', '0.271882', '300', '0', '0', '1400', '0', '0', '0');
INSERT INTO `creature` VALUES ('4447', '3617', '0', '1', '0', '0', '1765.77', '239.366', '60.6115', '6.23698', '300', '0', '0', '1400', '0', '0', '0');
INSERT INTO `creature` VALUES ('4605', '3617', '0', '1', '0', '0', '1775.27', '259.092', '59.6698', '5.7029', '300', '0', '0', '1400', '0', '0', '0');
INSERT INTO `creature` VALUES ('4663', '3617', '0', '1', '0', '0', '1775.93', '214.771', '59.7412', '0.684206', '300', '0', '0', '1400', '0', '0', '0');

-- Unseen http://www.wowhead.com/npc=3094
delete from creature_ai_scripts where entryOrGUID=3094;
INSERT INTO `creature_ai_scripts` VALUES ('309451', '3094', '1', '0', '100', '0', '100', '100', '0', '0', '11', '16380', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Unseen casts Greater  Invisibility');
UPDATE `creature_template` SET `AIName` = 'EventAI',`faction_A`='36', `faction_H`='36' WHERE `entry` = '3094';
delete from creature where id=3094;
INSERT INTO `creature` VALUES ('4713', '3094', '0', '1', '0', '0', '-10732', '366.447', '37.0714', '4.80072', '300', '0', '0', '2300', '0', '0', '0');
INSERT INTO `creature` VALUES ('4764', '3094', '0', '1', '0', '0', '-10694.2', '346.56', '39.7065', '2.46024', '300', '0', '0', '2200', '0', '0', '0');
INSERT INTO `creature` VALUES ('4773', '3094', '0', '1', '0', '0', '-10700.5', '349.398', '39.7235', '2.30316', '300', '0', '0', '2250', '0', '0', '0');
