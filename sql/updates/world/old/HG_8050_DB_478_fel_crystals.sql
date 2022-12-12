-- MGT/Selin Fireheart: Fix selectable Fel Crystals in heroic mode
UPDATE `creature_template` SET `unit_flags` = 33816576 WHERE `entry` = 25552;
