-- two unused tables
DROP TABLE `version`;
DROP TABLE `game_event_pool`;

-- db errors
-- bg emisaries normalize
UPDATE `creature_template` SET `minhealth` = 7200, `maxhealth` = 7200 WHERE `entry` in (14990,14991,15102,15103,15105,15106,22013,22015);
UPDATE `creature` SET `curhealth` = 7200 WHERE `id` in (14990,14991,15102,15103,15105,15106,22013,22015);
-- gadzetzan guards
UPDATE `creature` SET `curhealth` = 12652 WHERE `id` = 21448;
-- some npcs clean spam
UPDATE `creature` SET `spawndist` = 0 WHERE `spawndist` != 0 AND `MovementType` = 0;
