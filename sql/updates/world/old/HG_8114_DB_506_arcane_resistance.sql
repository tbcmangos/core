-- Fix arcane resistance values
update `creature_template` set `resistance6` = 0 where `entry` in (17034, 17035, 17039, 17053); -- HP/Kalari mobs
update `creature_template` set `resistance6` = 0, `spell1` = 1754 where `entry` in (19027, 19030); -- Kurenai cats
update `creature_template` set `resistance6` = 1000 where `entry` = 15339; -- Ossirian the Unscarred
