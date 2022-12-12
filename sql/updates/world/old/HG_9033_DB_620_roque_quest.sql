-- Quest fix in close blizz-like style for 20 lvl rogue (skill ranks what you can learn from trainer at 20 lvl) by Firehex. 
-- http://www.wowhead.com/quest=2478/mission-possible-but-not-probable  http://wowhead.com/quest=2478#comments0 https://forum.nostalrius.org/viewtopic.php?f=45&t=2586 Just info what should happen with npc.
-- Mutated Venture Co. Drone http://wowhead.com/npc=7310#pick-pocketing
DELETE FROM creature_ai_scripts WHERE entryOrGuid=7310;
INSERT  INTO `creature_ai_scripts` VALUES ('731051', '7310', '8', '0', '100', '0', '8676', '-1', '0', '0', '37', '0', '0', '0', '33', '7310', '6', '0', '0', '0', '0', '0', 'Mutated Venture Co. Drone reaction on Ambush');
INSERT  INTO `creature_ai_scripts` VALUES ('731052', '7310', '8', '0', '100', '0', '703', '-1', '0', '0', '37', '0', '0', '0', '33', '7310', '6', '0', '0', '0', '0', '0', 'Mutated Venture Co. Drone reaction on Garrote');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7310';
-- Venture Co. Patroller http://wowhead.com/npc=7308   http://wowhead.com/spell=10266 debuff
DELETE FROM creature_ai_scripts WHERE entryOrGuid=7308;
INSERT INTO `creature_ai_scripts` VALUES ('730851', '7308', '8', '0', '100', '0', '1943', '-1', '0', '0', '11', '10266', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Venture Co. Patroller reaction on Rupture');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7308';
-- Venture Co. Lookout http://wowhead.com/npc=7307
DELETE FROM creature_ai_scripts WHERE entryOrGuid=7307;
INSERT INTO `creature_ai_scripts` VALUES ('730751', '7307', '8', '0', '100', '0', '6761', '-1', '0', '0', '37', '0', '0', '0', '12', '364', '0', '30000', '33', '7307', '6', '0', 'Venture Co. Lookout reaction on Eviscerate');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7307';
-- Slime http://wowhead.com/npc=364 just random slime which nowhere used.
UPDATE `creature_template` SET `minlevel`='23', `maxlevel`='23', `minhealth`='300', `maxhealth`='300', `faction_A`='14', `faction_H`='14', `mindmg`='7', `maxdmg`='10', `attackpower`='100', `baseattacktime`='2500',`flags_extra`='0'  WHERE (`entry`='364');
-- Grand Foreman Puzik Gallywix http://wowhead.com/npc=7288 That npc should die from ambush-vanish-ambush,but it's not so doable with eventAI,because players will not get loot from him. Script will get all damage credit.
DELETE FROM creature_ai_scripts WHERE entryOrGuid=7288;
INSERT INTO `creature_ai_scripts` VALUES ('728851', '7288', '8', '0', '100', '0', '8676', '-1', '0', '0', '17', '22', '907', '0', '11', '10371', '0', '2', '0', '0', '0', '0', 'Grand Foreman Puzik Gallywix reaction on Ambush');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7288';
DELETE FROM `creature_loot_template` WHERE (`entry`='7288') AND (`item`='8073');
DELETE FROM `creature_loot_template` WHERE (`entry`='7288') AND (`item`='1179');
UPDATE `creature_loot_template` SET `lootcondition`='9', `condition_value1`='2478' WHERE (`entry`='7288') AND (`item`='8074');
-- Touch of Zanzil http://wowhead.com/spell=9991  This will block Stealth if you're under this curse.
DELETE FROM spell_linked_spell WHERE spell_trigger=9991;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES ('9991', '-1785', '2', 'Touch of Zanzil blocks stealth (rank2)');