-- Pyrewood village rework by Firehex and Sand.
-- Now when event "Nights" start human npc despawn and appear worgens instead, some npc(in human form) sell items, added casts, remove elite status(was made around 2.4.0).
SET @GUID := (SELECT MAX(guid) FROM creature);
-- !!! @GUID := @GUID+1 the only right decision for INSERT-SELECT query with multiply rows !!!


DELETE FROM game_event_creature WHERE event IN ('27','-27');
-- Pyrewood Watcher http://wowhead.com/npc=1891 > http://wowhead.com/npc=1892  http://wowwiki.wikia.com/wiki/Moonrage_Watcher
UPDATE `creature_template` SET `minhealth`='273', `maxhealth`='300',`rank`='0' WHERE entry IN (1891,1892);
DELETE FROM creature WHERE id=1892;

INSERT INTO creature
	(guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType)
		SELECT @GUID := @GUID+1,1892,map,spawnMask,574,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType 
			FROM creature WHERE id=1891;
	
INSERT INTO game_event_creature (guid, event) SELECT guid, 27 FROM creature WHERE id=1892;
INSERT INTO game_event_creature (guid, event) SELECT guid, '-27' FROM creature WHERE id=1891;
DELETE FROM creature_ai_scripts WHERE entryOrGuid=1891;
INSERT INTO `creature_ai_scripts` VALUES ('189151', '1891', '9', '0', '100', '1', '5', '30', '2000', '3000', '11', '6660', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Pyrewood Watcher casts Shoot at 5-30 yards');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '1891';
-- Pyrewood Elder http://wowhead.com/npc=1895 > http://wowhead.com/npc=1896 http://wowwiki.wikia.com/wiki/Moonrage_Elder
UPDATE `creature_template` SET `minhealth`='276', `maxhealth`='301',`rank`='0',`AIName` = 'EventAI' WHERE entry IN (1895,1896);
DELETE FROM creature WHERE id=1896;
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType)
	SELECT @GUID := @GUID+1,1896,map,spawnMask,729,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType 
		FROM creature WHERE id=1895;

INSERT INTO game_event_creature (guid, event) SELECT guid, 27 FROM creature WHERE id=1896;
INSERT INTO game_event_creature (guid, event) SELECT guid, '-27' FROM creature WHERE id=1895;
DELETE FROM creature_ai_scripts WHERE entryOrGuid=1895;
INSERT INTO `creature_ai_scripts` VALUES ('189551', '1895', '14', '0', '100', '1', '180', '40', '7500', '10000', '11', '2053', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Pyrewood Elder casts Lesser Heal at ally');
DELETE FROM creature_ai_scripts WHERE entryOrGuid=1896;
INSERT INTO `creature_ai_scripts` VALUES ('189651', '1896', '0', '0', '100', '1', '2000', '3000', '15000', '30000', '11', '594', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Moonrage Elder casts Shadow Word: Pain');
-- Pyrewood Sentry http://wowhead.com/npc=1894#abilities > http://wowhead.com/npc=1893  http://wowwiki.wikia.com/wiki/Moonrage_Sentry
UPDATE `creature_template` SET `minhealth`='300', `maxhealth`='328',`rank`='0',`AIName` = 'EventAI' WHERE entry IN (1894,1893);
DELETE FROM creature WHERE id=1893;

INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType)
	SELECT @GUID := @GUID+1,1893,map,spawnMask,564,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType 
		FROM creature WHERE id=1894;
		
INSERT INTO game_event_creature (guid, event) SELECT guid, 27 FROM creature WHERE id=1893;
INSERT INTO game_event_creature (guid, event) SELECT guid, '-27' FROM creature WHERE id=1894;
DELETE FROM creature_ai_scripts WHERE entryOrGuid=1894;
INSERT INTO `creature_ai_scripts` VALUES ('189451', '1894', '1', '0', '100', '1', '500', '500', '180000', '180000', '11', '7164', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Pyrewood Sentry casts Defensive Stance');
INSERT INTO `creature_ai_scripts` VALUES ('189452', '1894', '13', '0', '100', '1', '15000', '15000', '0', '0', '11', '11972', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Pyrewood Sentry casts Shield Bash');
INSERT INTO `creature_ai_scripts` VALUES ('189453', '1894', '4', '0', '100', '0', '0', '0', '0', '0', '11', '12169', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Pyrewood Sentry casts Shield Block on aggro');
DELETE FROM creature_ai_scripts WHERE entryOrGuid=1893;
INSERT INTO `creature_ai_scripts` VALUES ('189351', '1893', '4', '0', '100', '0', '0', '0', '0', '0', '11', '6507', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Moonrage Sentry casts Battle Roar on aggro');
INSERT INTO `creature_ai_scripts` VALUES ('189352', '1893', '0', '0', '100', '1', '3000', '5000', '20000', '30000', '11', '13730', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Moonrage Sentry casts Demoralizing Shout');
-- Pyrewood Armorer http://wowhead.com/npc=3528  > http://wowhead.com/npc=3529  http://wowwiki.wikia.com/wiki/Moonrage_Armorer
UPDATE `creature_template` SET `minhealth`='328', `maxhealth`='356',`rank`='0' WHERE entry IN (3528,3529);
DELETE FROM creature WHERE id=3529;
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType)
	SELECT @GUID := @GUID+1,3529,map,spawnMask,729,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType 
		FROM creature WHERE id=3528;
INSERT INTO game_event_creature (guid, event) SELECT guid, 27 FROM creature WHERE id=3529;
INSERT INTO game_event_creature (guid, event) SELECT guid, '-27' FROM creature WHERE id=3528;
DELETE FROM npc_vendor WHERE entry= 3528;
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3528', '847');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3528', '848');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3528', '849');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3528', '850');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3528', '1202');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3528', '1845');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3528', '1846');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3528', '17187');
DELETE FROM creature_loot_template WHERE item IN (847,848,849,850,1202,1845,1846,17187);
-- Pyrewood Tailor http://wowhead.com/npc=3530 > http://wowhead.com/npc=3531  http://wowwiki.wikia.com/wiki/Moonrage_Tailor
UPDATE `creature_template` SET `minhealth`='300', `maxhealth`='328',`rank`='0',`AIName` = 'EventAI' WHERE entry IN (3530,3531);
DELETE FROM creature WHERE id=3531;
INSERT INTO creature (guid, id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType)
	SELECT @GUID := @GUID+1,3531,map,spawnMask,729,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType 
		FROM creature WHERE id=3530;
INSERT INTO game_event_creature (guid, event) SELECT guid, 27 FROM creature WHERE id=3531;
INSERT INTO game_event_creature (guid, event) SELECT guid, '-27' FROM creature WHERE id=3530;
DELETE FROM creature_ai_scripts WHERE entryOrGuid=3530;
INSERT INTO `creature_ai_scripts` VALUES ('353051', '3530', '0', '0', '100', '1', '2000', '5000', '15000', '20000', '11', '6713', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Pyrewood Tailor casts Disarm');
DELETE FROM creature_ai_scripts WHERE entryOrGuid=3531;
INSERT INTO `creature_ai_scripts` VALUES ('353151', '3531', '0', '0', '100', '1', '2000', '5000', '15000', '20000', '11', '7140', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Moonrage Tailor casts Expose Weakness');
DELETE FROM npc_vendor WHERE entry= 3530;
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3530', '3603');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3530', '3602');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3530', '793');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3530', '792');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3530', '794');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3530', '795');
DELETE FROM creature_loot_template WHERE item IN (792,793,794,795,3602,3603);
-- Pyrewood Leatherworker http://wowhead.com/npc=3532 >http://wowhead.com/npc=3533  http://wowwiki.wikia.com/wiki/Moonrage_Leatherworker
UPDATE `creature_template` SET `minhealth`='300', `maxhealth`='328',`rank`='0' WHERE entry IN (3532,3533);
DELETE FROM creature WHERE id=3533;
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType)
	SELECT @GUID := @GUID+1,3533,map,spawnMask,729,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType 
		FROM creature WHERE id=3532;
INSERT INTO game_event_creature (guid, event) SELECT guid, 27 FROM creature WHERE id=3533;
INSERT INTO game_event_creature (guid, event) SELECT guid, '-27' FROM creature WHERE id=3532;
DELETE FROM npc_vendor WHERE entry= 3532;
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3532', '796');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3532', '797');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3532', '798');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3532', '799');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3532', '1839');
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES ('3532', '1840');
DELETE FROM creature_loot_template WHERE item IN (796,797,798,799,1839,1840);
-- Apothecary Berard http://wowwiki.wikia.com/wiki/Apothecary_Berard http://wowhead.com/npc=2106 
UPDATE `creature_template` SET `minhealth`='350', `maxhealth`='350', `rank`='0' WHERE (`entry`='2106');
-- Pyrewood Council http://wowwiki.wikia.com/wiki/Pyrewood_Council
-- Councilman Wilhelm http://wowhead.com/npc=2063#drop
-- Councilman Thatcher  http://wowhead.com/npc=2061
-- Councilman Smithers http://wowhead.com/npc=2060
-- Councilman Higarth http://wowhead.com/npc=2066
-- Councilman Hendricks http://wowhead.com/npc=2062#drop
-- Councilman Hartin http://wowhead.com/npc=2064
-- Councilman Cooper http://wowhead.com/npc=2065
-- Councilman Brunswick http://wowhead.com/npc=2067
-- Lord Mayor Morrison http://wowhead.com/npc=2068
UPDATE `creature_template` SET `minhealth`='330', `maxhealth`='330', `rank`='0' WHERE (`entry`='2068');
UPDATE `creature_template` SET `minhealth`='250', `maxhealth`='250', `rank`='0' WHERE (`entry`='2060');
UPDATE `creature_template` SET `minhealth`='270', `maxhealth`='270', `rank`='0' WHERE entry IN (2063,2061,2066,2062,2064,2065,2067,2068);
-- Deathstalker Faerleia http://wowhead.com/npc=2058#drop Shoudn't have any loot
DELETE FROM creature_loot_template WHERE entry=2058;
UPDATE `creature_template` SET `lootid`='0' WHERE (`entry`='2058');