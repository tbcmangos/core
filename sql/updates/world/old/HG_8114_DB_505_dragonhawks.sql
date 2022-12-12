-- Eversong Woods: Fix arcane resistance for Dragonhawks
update `creature_template` set `resistance6` = 0 where `entry` in (15649, 15650);
