-- Gesharahan  http://www.wowhead.com/npc=3398#abilities
delete from creature_ai_scripts where entryOrGuid=3398;
INSERT INTO `creature_ai_scripts` VALUES ('339851', '3398', '0', '0', '100', '1', '5000', '10000', '15000', '20000', '11', '3583', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Gesharahan casts Deadly Poison');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '3398';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='25' WHERE (`entry`='3398') AND (`item`='5183');
DELETE FROM `reference_loot_template` WHERE (`entry`='24060') AND (`item`='5182');
delete from creature_loot_template where item=5182;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`) VALUES ('3398', '5182', '50');

-- Boahn  http://www.wowhead.com/npc=3672
DELETE FROM `reference_loot_template` WHERE (`entry`='24060') AND (`item`='5422');
delete from creature_loot_template where item=5422;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`) VALUES ('3672', '5422', '50');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='50' WHERE (`entry`='3672') AND (`item`='5423');

-- Trigore the Lasher http://www.wowhead.com/npc=3652#comments  
UPDATE `creature_template` SET `faction_A`='14', `faction_H`='14', `mindmg`='25', `maxdmg`='30', `attackpower`='400' WHERE (`entry`='3652');
delete from creature_ai_scripts where entryOrGuid=3652;
INSERT INTO `creature_ai_scripts` VALUES ('365251', '3652', '0', '0', '100', '1', '2000', '5000', '10000', '15000', '11', '3391', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Trigore the Lasher casts Trash');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '3652';
delete from creature where id=3652;
INSERT INTO `creature` VALUES ('1885', '3652', '1', '1', '0', '0', '-670.206', '-2222.55', '12.3394', '6.2474', '3600', '2', '0', '482', '0', '0', '1');

-- Deviate Creeper http://wowhead.com/npc=3632#drops
UPDATE `creature_ai_scripts` SET `event_chance`='100', `event_param1`='5000', `event_param2`='7000' WHERE (`id`='363201');

-- Devouring Ectoplasm http://www.wowhead.com/npc=3638#comments 
delete from creature_ai_scripts where entryOrGuid=3638;
INSERT INTO `creature_ai_scripts` VALUES ('363851', '3638', '0', '0', '100', '0', '7000', '10000', '0', '0', '11', '7952', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Devouring Ectoplasm casts Clone');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '3638';

-- Deviate Slayer http://www.wowhead.com/npc=3633#comments
UPDATE `creature_ai_scripts` SET `event_param1`='50', `action1_param2`='0' WHERE (`id`='363301');

-- Inside instance

-- Evolving Ectoplasm http://www.wowhead.com/npc=3640#comments Here is problem: transformation changes only model color, but not resistances. Npc should be immune to element after spell hit.
delete from creature_ai_scripts where entryOrGuid=3640;
INSERT INTO `creature_ai_scripts` VALUES ('364051', '3640', '8', '0', '100', '1', '0', '32', '10000', '15000', '11', '7946', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Evolving Ectoplasm shadow spell hit');
INSERT INTO `creature_ai_scripts` VALUES ('364052', '3640', '8', '0', '100', '1', '0', '16', '10000', '15000', '11', '7944', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Evolving Ectoplasm frost spell hit');
INSERT INTO `creature_ai_scripts` VALUES ('364053', '3640', '8', '0', '100', '1', '0', '8', '10000', '15000', '11', '7945', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Evolving Ectoplasm nature spell hit');
INSERT INTO `creature_ai_scripts` VALUES ('364054', '3640', '8', '0', '100', '1', '0', '4', '10000', '15000', '11', '7943', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Evolving Ectoplasm fire spell hit');
UPDATE `creature_template` SET `AIName` = 'EventAI',`resistance4`='200' WHERE `entry` = '3640';
UPDATE `creature_template` SET `resistance5`='200' WHERE (`entry`='5778');
UPDATE `creature_template` SET `resistance3`='200' WHERE (`entry`='5777');
UPDATE `creature_template` SET `resistance2`='200' WHERE (`entry`='5776');

-- Druid of the Fang http://www.wowhead.com/npc=3840#abilities
UPDATE `creature_ai_scripts` SET `event_param3`='10000', `event_param4`='10000', `action1_param3`='33' WHERE (`id`='384011');
DELETE FROM `creature_ai_scripts` WHERE (`id`='384012');

-- Lord Cobrahn  http://www.wowhead.com/npc=3669#encounter 
UPDATE `creature_ai_scripts` SET `event_inverse_phase_mask`='13' WHERE (`id`='366912');
UPDATE `creature_ai_scripts` SET `event_inverse_phase_mask`='13', `action1_param3`='1' WHERE (`id`='366914');
UPDATE `creature_ai_scripts` SET `event_param1`='45',`comment`='Lord Cobrahn - Set Phase 3 at 45% HP' WHERE (`id`='366912');
UPDATE `creature_ai_scripts` SET `event_param1`='45' WHERE (`id`='366913');
UPDATE `creature_ai_scripts` SET `event_inverse_phase_mask`='7', `comment`='Lord Cobrahn - Cast Poison (Phase 3)' WHERE (`id`='366910');
DELETE FROM `creature_ai_scripts` WHERE (`id`='366911');

-- Lady Anacondra http://www.wowhead.com/npc=3671#encounter 
delete from creature_ai_scripts where id=367151;
delete from creature_ai_texts where entry='-3671';
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`, `comment`) VALUES ('-3671', 'None can stand against the Serpent Lords!', '1', 'Lady Anacondra aggro');
INSERT INTO `creature_ai_scripts` VALUES ('367151', '3671', '4', '0', '100', '0', '0', '0', '0', '0', '1', '-3671', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Lady Anacondra aggro phrase');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '3671';

-- Mutanus the Devourer http://www.wowhead.com/npc=3654#abilities
UPDATE `creature_ai_scripts` SET `action1_param2`='5' WHERE (`id`='365401');
UPDATE `creature_ai_scripts` SET `event_param1`='25000', `event_param2`='25000', `event_param3`='25000', `event_param4`='30000' WHERE (`id`='365402');