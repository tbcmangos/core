-- Sunwell: Add Sun-Drenched Scale Chestguard pattern to trash loot
INSERT INTO `reference_loot_template` VALUES (34091, 35219, 0, 1, 1, 1, 7, 165, 1);

-- Show specific recipes only to crafters
UPDATE `reference_loot_template` SET `lootcondition` = 7, `condition_value2` = 1 WHERE `entry` = 34091 AND `item` IN (35209, 35213, 35214);
