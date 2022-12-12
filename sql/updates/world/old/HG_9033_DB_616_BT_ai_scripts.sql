-- npc casts for all demon hunters and monsters near black temple by Firehex.
-- NPC near BT entrance.
-- Demon Hunter Supplicant http://wowwiki.wikia.com/Demon_Hunter_Supplicant
DELETE FROM creature_ai_scripts WHERE entryOrGuid=21179;
INSERT INTO `creature_ai_scripts` VALUES ('2117951', '21179', '2', '0', '100', '0', '50', '0', '0', '0', '11', '37683', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Hunter Supplicant casts Evasion');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '21179';
-- Sunfury Summoner http://www.wowhead.com/npc=21505/sunfury-summoner#abilities
DELETE FROM creature_ai_scripts WHERE entryOrGUID=21505;
INSERT INTO `creature_ai_scripts` VALUES ('2150551', '21505', '0', '0', '100', '1', '500', '1000', '3000', '3500', '11', '13901', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Summoner casts Arcane Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('2150552', '21505', '4', '0', '100', '1', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Summoner blocks movement at aggro');
INSERT INTO `creature_ai_scripts` VALUES ('2150553', '21505', '1', '0', '100', '0', '500', '500', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Summoner unblocks movement');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '21505';
-- Sunfury Warlock http://wowwiki.wikia.com/Sunfury_Warlock
DELETE FROM creature_ai_scripts WHERE entryOrGUID=21503;
INSERT INTO `creature_ai_scripts` VALUES ('2150311', '21503', '7', '0', '100', '0', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Set Phase to 0 on Evade');
INSERT INTO `creature_ai_scripts` VALUES ('2150310', '21503', '2', '7', '100', '0', '15', '0', '0', '0', '21', '1', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', 'Sunfury Warlock - Start Combat Movement and Flee at 15% HP (Phase 3)');
INSERT INTO `creature_ai_scripts` VALUES ('2150309', '21503', '2', '0', '100', '0', '15', '0', '0', '0', '22', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Set Phase 3 at 15% HP');
INSERT INTO `creature_ai_scripts` VALUES ('2150308', '21503', '3', '11', '100', '1', '100', '30', '100', '100', '23', '-1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Set Phase 1 when Mana is above 30% (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES ('2150307', '21503', '9', '13', '100', '0', '0', '5', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Start Combat Movement Below 5 Yards');
INSERT INTO `creature_ai_scripts` VALUES ('2150306', '21503', '9', '13', '100', '0', '5', '15', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Prevent Combat Movement at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES ('2150305', '21503', '9', '13', '100', '0', '35', '80', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Start Combat Movement at 35 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES ('2150304', '21503', '3', '13', '100', '0', '15', '0', '0', '0', '21', '1', '0', '0', '23', '1', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES ('2150303', '21503', '9', '13', '100', '1', '0', '40', '3000', '4000', '11', '34344', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Cast Shadow Bolt (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES ('2150302', '21503', '4', '0', '100', '0', '0', '0', '0', '0', '11', '32707', '1', '0', '23', '1', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Cast Incinerate and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES ('2150301', '21503', '1', '0', '100', '0', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Warlock - Prevent Combat Movement on Spawn');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '21503';
-- Demon Hunter Initiate http://www.wowhead.com/npc=21180/demon-hunter-initiate#abilities
DELETE FROM creature_ai_scripts WHERE entryOrGUID=21180;
INSERT IGNORE INTO `creature_ai_scripts` VALUES ('2118051', '21180', '0', '0', '100', '1', '3000', '5000', '12000', '15000', '11', '35871', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Hunter Initiate casts Spellbreaker');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '21180';
-- Spellbound Terrorguard http://www.wowhead.com/npc=21908/spellbound-terrorguard#abilities
DELETE FROM creature_ai_scripts WHERE entryOrGuid=21908;
INSERT INTO `creature_ai_scripts` VALUES ('2190851', '21908', '0', '0', '100', '1', '5000', '10000', '15000', '20000', '11', '37488', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spellbound Terrorguard casts Fel Flames');
INSERT INTO `creature_ai_scripts` VALUES ('2190852', '21908', '0', '0', '100', '1', '2000', '4000', '9000', '17000', '11', '31553', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Spellbound Terrorguard casts Hamstring');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '21908';
-- Illidari Dreadlord http://www.wowhead.com/npc=21166/illidari-dreadlord#comments also adding immunity versus enslave,fear,snare and disease
DELETE FROM creature_ai_scripts WHERE entryOrGuid=21166;
INSERT INTO `creature_ai_scripts` VALUES ('2116651', '21166', '0', '0', '100', '1', '4000', '8000', '8000', '16000', '11', '17287', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Illidari Dreadlord casts Mind Blast');
INSERT INTO `creature_ai_scripts` VALUES ('2116652', '21166', '9', '0', '100', '1', '0', '8', '25000', '35000', '11', '13704', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Illidari Dreadlord casts Psychic Scream at 8 yard');
INSERT INTO `creature_ai_scripts` VALUES ('2116653', '21166', '0', '0', '100', '1', '10000', '15000', '25000', '30000', '11', '12098', '2', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Illidari Dreadlord casts Sleep on secondary aggro');
UPDATE `creature_template` SET `AIName` = 'EventAI', `mechanic_immune_mask`='2098193' WHERE `entry` = '21166';
-- Shadowhoof Summoner http://www.wowhead.com/npc=22859/shadowhoof-summoner#abilities
DELETE FROM creature_ai_scripts WHERE entryOrGuid=22859;
INSERT INTO `creature_ai_scripts` VALUES ('2285951', '22859', '0', '0', '100', '1', '3000', '5000', '5000', '10000', '11', '9613', '1', '8', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowhoof Summoner casts Shadow Bolt');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '22859';
-- Sunfury Eradicator http://www.wowhead.com/npc=21742/sunfury-eradicator#comments http://wowhead.com/npc=21742#abilities
DELETE FROM creature_ai_scripts WHERE entryOrGuid=21742;
INSERT INTO `creature_ai_scripts` VALUES ('2174251', '21742', '14', '0', '100', '1', '4000', '40', '7000', '10000', '11', '17137', '6', '8', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Eradicator casts Flash Heal at ally');
INSERT INTO `creature_ai_scripts` VALUES ('2174252', '21742', '4', '0', '100', '0', '0', '0', '0', '0', '11', '38008', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Eradicator casts Seal of Blood at aggro');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '21742';
-- Sunfury Blood Lord http://www.wowhead.com/npc=21743/sunfury-blood-lord#abilities
DELETE FROM creature_ai_scripts WHERE entryOrGuid=21743;
INSERT INTO `creature_ai_scripts` VALUES ('2174351', '21743', '0', '0', '100', '1', '4000', '6000', '12000', '15000', '11', '37577', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Blood Lord casts Debilitating Strike');
INSERT INTO `creature_ai_scripts` VALUES ('2174352', '21743', '0', '0', '100', '1', '7000', '10000', '15000', '25000', '11', '36104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Blood Lord casts Torrent of Flames');
INSERT INTO `creature_ai_scripts` VALUES ('2174353', '21743', '4', '0', '100', '0', '0', '0', '0', '0', '39', '40', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Sunfury Blood Lord call for help at aggro');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '21743';
-- Shadowmoon Slayer  http://www.wowhead.com/npc=22082/shadowmoon-slayer#abilities
DELETE FROM creature_ai_scripts WHERE entryOrGuid=22082;
INSERT INTO `creature_ai_scripts` VALUES ('2208251', '22082', '0', '0', '100', '1', '3000', '6000', '12000', '15000', '11', '37577', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowmoon Slayer  casts Debilitating Strike');
INSERT INTO `creature_ai_scripts` VALUES ('2208252', '22082', '2', '0', '100', '0', '50', '0', '0', '0', '11', '3019', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowmoon Slayer  casts Enrage at 50% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '22082';
-- Shadowmoon Eye of Kilrogg http://www.wowhead.com/npc=22134/shadowmoon-eye-of-kilrogg#comments проверить без скрипта
DELETE FROM creature_ai_scripts WHERE entryOrGuid=22134;
INSERT INTO `creature_ai_scripts` VALUES ('2213451', '22134', '4', '0', '100', '0', '0', '0', '0', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowmoon Eye of Kilrogg looking for help at aggro');
INSERT INTO `creature_ai_scripts` VALUES ('2213452', '22134', '0', '0', '100', '0', '2500', '2500', '0', '0', '41', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowmoon Eye of Kilrogg despawns after combat engage');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '22134';
-- Shadowsworn Drakonid http://www.wowhead.com/npc=22072/shadowsworn-drakonid#comments
DELETE FROM creature_ai_scripts WHERE entryOrGuid=22072;
INSERT INTO `creature_ai_scripts` VALUES ('2207251', '22072', '0', '0', '100', '1', '4000', '8000', '8000', '10000', '11', '15496', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowsworn Drakonid casts Cleave');
INSERT INTO `creature_ai_scripts` VALUES ('2207252', '22072', '0', '0', '100', '1', '2000', '10000', '10500', '14000', '11', '17547', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowsworn Drakonid casts Mortal Strike');
INSERT INTO `creature_ai_scripts` VALUES ('2207253', '22072', '0', '0', '100', '1', '6000', '12000', '15000', '20000', '11', '16145', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowsworn Drakonid casts Sunder Armor');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '22072';
-- Shadowmoon Chosen http://www.wowhead.com/npc=22084/shadowmoon-chosen
DELETE FROM creature_ai_scripts WHERE entryOrGuid=22084;
INSERT INTO `creature_ai_scripts` VALUES ('2208451', '22084', '0', '0', '100', '1', '3000', '5000', '10000', '15000', '11', '10966', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowmoon Chosen casts Uppercut');
INSERT INTO `creature_ai_scripts` VALUES ('2208452', '22084', '0', '0', '100', '1', '7000', '9000', '8000', '11000', '11', '38618', '0', '10', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowmoon Chosen casts Whirlwind');
UPDATE `creature_template` SET `AIName` = 'EventAI',`mechanic_immune_mask`='65536' WHERE `entry` = '22084';
-- Shadowmoon Darkweaver http://www.wowhead.com/npc=22081/shadowmoon-darkweaver
UPDATE `creature_ai_scripts` SET `action1_param2`='4' WHERE (`id`='6669934');
UPDATE `creature_ai_scripts` SET `event_type`='4', `event_param1`='0', `event_param2`='0', `event_param3`='0', `event_param4`='0', `action1_param3`='2',`comment`='Shadowmoon Darkweaver - Casts Nether Infusion on aggro' WHERE (`id`='6669932');
DELETE FROM creature_ai_scripts WHERE entryOrGuid=22081 AND id=2208151;
INSERT INTO `creature_ai_scripts` VALUES ('2208151', '22081', '1', '0', '100', '0', '1000', '1000', '0', '0', '11', '38442', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadowmoon Darkweaver casts Shadowmoon Warlock(visual spell)');
-- Shadowlord Deathwail http://www.wowhead.com/npc=22006/shadowlord-deathwail add flying mount for him.
UPDATE `creature_addon` SET `mount`='20684' WHERE (`guid`='119246');
-- Demon hunters for quest http://wowhead.com/quest=10651 
--  Alandien http://www.wowhead.com/npc=21171/alandien
DELETE FROM creature_ai_scripts WHERE entryOrGuid=21171;
INSERT INTO `creature_ai_scripts` VALUES ('2117151', '21171', '4', '0', '100', '0', '0', '0', '0', '0', '1', '-21171', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alandien aggro phrase');
INSERT INTO `creature_ai_scripts` VALUES ('2117152', '21171', '0', '0', '100', '1', '4000', '8000', '15000', '20000', '11', '39262', '1', '4', '0', '0', '0', '0', '0', '0', '0', '0', 'Alandien casts Mana Burn');
INSERT INTO `creature_ai_scripts` VALUES ('2117153', '21171', '0', '0', '100', '1', '8000', '12000', '15000', '25000', '11', '39082', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alandien casts Shadowfury');
INSERT  INTO `creature_ai_scripts` VALUES ('2117154', '21171', '2', '0', '100', '0', '50', '0', '0', '0', '11', '36298', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Alandien casts Metamorphosis');
UPDATE `creature_template` SET `mechanic_immune_mask`='2049',`AIName` = 'EventAI' WHERE `entry` = '21171';
DELETE FROM creature_ai_texts WHERE entry='-21171';
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `comment`) VALUES ('-21171', 'You dare fight me? I was trained by Illidan himself!', 'Alandien aggro');
-- Netharel http://www.wowhead.com/npc=21164/netharel 
DELETE FROM creature_ai_scripts WHERE entryOrGUID=21164;
INSERT INTO `creature_ai_scripts` VALUES ('2116451', '21164', '0', '0', '100', '1', '4000', '5000', '15000', '25000', '11', '39262', '1', '4', '0', '0', '0', '0', '0', '0', '0', '0', ' Netharel casts Mana Burn');
INSERT INTO `creature_ai_scripts` VALUES ('2116452', '21164', '9', '0', '100', '1', '0', '5', '12000', '18000', '11', '39135', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Netharel casts Debilitating Strike');
INSERT INTO `creature_ai_scripts` VALUES ('2116453', '21164', '2', '0', '100', '0', '50', '0', '0', '0', '11', '36298', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Netharel casts Metamorphosis');
INSERT INTO `creature_ai_scripts` VALUES ('2116454', '21164', '2', '0', '100', '0', '25', '0', '0', '0', '11', '37683', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Netharel casts Evasion');
UPDATE `creature_template` SET `mechanic_immune_mask`='2049',`AIName` = 'EventAI' WHERE (`entry`='21164');
-- Theras http://www.wowhead.com/npc=21168/theras#comments
DELETE FROM creature_ai_scripts WHERE entryOrGUID=21168;
INSERT INTO `creature_ai_scripts` VALUES ('2116851', '21168', '2', '0', '100', '0', '50', '0', '0', '0', '11', '36298', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Theras casts Metamorphosis');
INSERT INTO `creature_ai_scripts` VALUES ('2116852', '21168', '0', '0', '100', '1', '4000', '8000', '8000', '16000', '11', '39262', '1', '4', '0', '0', '0', '0', '0', '0', '0', '0', 'Theras casts Mana Burn');
INSERT INTO `creature_ai_scripts` VALUES ('2116853', '21168', '13', '0', '100', '1', '10000', '20000', '0', '0', '11', '23920', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Theras casts Spell Reflection');
INSERT INTO `creature_ai_scripts` VALUES ('2116854', '21168', '0', '0', '100', '1', '3000', '9000', '12000', '21000', '11', '35871', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Theras casts Spellbreaker');
UPDATE `creature_template` SET `mechanic_immune_mask`='2049',`AIName` = 'EventAI' WHERE `entry` = '21168';
-- Varedis http://www.wowhead.com/npc=21178/varedis
DELETE FROM creature_ai_scripts WHERE entryOrGUID=21178;
INSERT INTO `creature_ai_scripts` VALUES ('2117851', '21178', '0', '0', '100', '1', '6000', '12000', '15000', '30000', '11', '39262', '1', '4', '0', '0', '0', '0', '0', '0', '0', '0', 'Varedis casts Mana Burn');
INSERT INTO `creature_ai_scripts` VALUES ('2117852', '21178', '2', '0', '100', '1', '90', '0', '15000', '30000', '11', '38010', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Varedis casts Curse of Flames at 90% hp');
INSERT INTO `creature_ai_scripts` VALUES ('2117853', '21178', '2', '0', '100', '1', '75', '0', '20000', '40000', '11', '37683', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Varedis casts Evasion at 75% hp');
INSERT INTO `creature_ai_scripts` VALUES ('2117854', '21178', '0', '0', '100', '1', '10000', '15000', '25000', '35000', '11', '33803', '4', '6', '0', '0', '0', '0', '0', '0', '0', '0', 'Varedis casts Flame Wave');
INSERT INTO `creature_ai_scripts` VALUES ('2117855', '21178', '2', '0', '100', '0', '50', '0', '0', '0', '11', '37905', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Varedis casts Metamorphosis at 50% hp');
-- need extra spell function fix to work through spell immunity 
INSERT INTO `creature_ai_scripts` VALUES ('2117856', '21178', '8', '0', '100', '0', '37906', '-1', '0', '0', '28', '0', '37905', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Varedis remove Metamorphosis under quest spell');
UPDATE `creature_template` SET `AIName` = 'EventAI',`mechanic_immune_mask`='2049' WHERE `entry` = '21178';