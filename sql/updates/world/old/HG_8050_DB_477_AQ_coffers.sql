-- Instance/Ahn'Qiraj: Fix Scarab Coffers

-- Set 2 h spawn time.
UPDATE `gameobject` SET `spawntimesecs` = 7200 WHERE `id` IN (180690, 180691);

-- Set locked flag.
UPDATE `gameobject_template` SET `flags` = 2 WHERE `entry` IN (180690, 180691);
