-- SSC/Lurker: Fix loot chances
update `reference_loot_template` set `ChanceOrQuestChance` = 0 where `entry` = 34098;
