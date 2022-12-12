-- Thousand Needles/Galak Windchaser: Fix loot
delete from `creature_loot_template` where `entry` = 4096 and `item` in (30302, 30322);
