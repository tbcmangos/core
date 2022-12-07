-- Instance/AQ40: Remove Obsidian Eradicator/Nullifier OOC mana zeroing
DELETE FROM `creature_ai_scripts` WHERE `id` IN (1526201, 1531201);
