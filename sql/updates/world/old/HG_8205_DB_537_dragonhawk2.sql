-- Eversong Woods: Fix Red Dragonhawk Hatchling faction
update `creature_template` set `faction_A` = 188, `faction_H` = 188 where `entry` = 21064;
