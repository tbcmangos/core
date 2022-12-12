-- Relic Coffer http://wowhead.com/object=160836#contains
UPDATE `gameobject_template` SET `faction`='94', `flags`='0',`data12`='1', `data15`='1' WHERE (`entry`='160836');
-- Dark Coffer http://www.wowhead.com/object=160845/dark-coffer#comments  http://wowhead.com/object=160845#contains:0+12+1
UPDATE `gameobject_template` SET `faction`='94', `flags`='0' WHERE (`entry`='160845');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='50' WHERE (`entry`='11103') AND (`item`='11751');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='50' WHERE (`entry`='11103') AND (`item`='11752');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='50' WHERE (`entry`='11103') AND (`item`='11753');
-- Secret Safe http://wowhead.com/object=161495 http://www.wowhead.com/object=161495/secret-safe#contains
UPDATE `gameobject_template` SET `flags`='0' WHERE (`entry`='161495');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='25', `groupid`='1' WHERE (`entry`='11104') AND (`item`='22205');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='25', `groupid`='1' WHERE (`entry`='11104') AND (`item`='22254');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='25', `groupid`='1' WHERE (`entry`='11104') AND (`item`='22255');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='25', `groupid`='1' WHERE (`entry`='11104') AND (`item`='22256');
-- The Heart of the Mountain http://wowhead.com/item=11309#contained-in-object Only 1 GOB should have it in loot
DELETE FROM `gameobject_loot_template` WHERE (`entry`='11104') AND (`item`='11309');
DELETE FROM `gameobject_loot_template` WHERE (`entry`='11103') AND (`item`='11309');
-- http://wowhead.com/object=165554
DELETE FROM `gameobject_loot_template` WHERE entry=11160 AND item<>11309;
DELETE FROM gameobject WHERE id=165554;
INSERT INTO `gameobject` VALUES ('15496451', '165554', '230', '1', '803.8', '-356.88', '-48.95', '0.752139', '0', '0', '0.942003', '-0.335604', '165554', '0', '1');