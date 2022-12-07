-- Need for a Cure / Finding the Antidote #000527
UPDATE creature_template SET npcflag=npcflag|3 WHERE entry=3189;
-- [NPC/Ventor] Kira Songshine <Traveling Baker> #000522
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z) VALUES
(1647, 22, -9550.16, -68.9811, 57.4588),
(1647, 23, -9543.96, -40.0566, 56.5451),
(1647, 24, -9507.09, 35.1121, 56.517),
(1647, 25, -9492.11, 57.8834, 55.8784),
(1647, 26, -9483.70, 65.0161, 56.1693),
(1647, 27, -9455.61, 63.4114, 55.8832),
(1647, 28, -9393.01, 104.486, 59.2978),
(1647, 29, -9363.17, 113.038, 61.4675),
(1647, 30, -9328.93, 133.697, 64.341),
(1647, 31, -9298.35, 149.504, 66.412),
(1647, 32, -9257.91, 161.229, 67.623),
(1647, 33, -9233.09, 190.265, 67.82),
(1647, 34, -9194.35, 230.449, 71.8101),
(1647, 35, -9184.62, 259.409, 73.981),
(1647, 36, -9183.56, 314.518, 79.2184),
(1647, 37, -9181.78, 326.43, 81.1904),
(1647, 38, -9175.93, 342.185, 84.2532),
(1647, 39, -9160.48, 359.541, 89.109),
(1647, 40, -9145.05, 375.98, 90.7306);
-- [NPC] Jandice Barov isn't spawned #000160
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (NULL, 10503, 289, 1, 11073, 0, 268.223, 73.633, 95.9245, 1.64061, 43200, 0, 0, 30180, 7458, 0, 0);