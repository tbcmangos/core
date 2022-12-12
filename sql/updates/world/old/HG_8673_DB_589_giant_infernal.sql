-- Mount Hyjal: Forbid enslaving of Giant Infernals
UPDATE `creature_template`
SET `mechanic_immune_mask` = `mechanic_immune_mask` | 1
WHERE `entry` = '17908';
