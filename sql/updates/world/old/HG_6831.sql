UPDATE `creature_template` SET `ScriptName`='npc_skywing' WHERE `entry`=22424;
DELETE FROM `creature` WHERE `guid`=85531;

DELETE FROM `script_waypoint` WHERE `entry`=22424;
INSERT INTO `script_waypoint` VALUES
(22424, 1, -3620.54, 4164.57, 1.81, 0, 'SKYWING_START'),
(22424, 2, -3624.78, 4149.65, 7.44, 0, ''),
(22424, 3, -3630.30, 4124.84, 21.28, 0, ''),
(22424, 4, -3629.14, 4093.65, 44.35, 0, ''),
(22424, 5, -3626.34, 4080.29, 52.39, 0, ''),
(22424, 6, -3619.35, 4063.86, 60.86, 3000, 'SAY_SKYWING_TREE_DOWN'),
(22424, 7, -3615.09, 4054.17, 62.46, 0, ''),
(22424, 8, -3611.39, 4046.60, 65.07, 0, ''),
(22424, 9, -3606.68, 4040.50, 66.00, 0, ''),
(22424, 10, -3600.88, 4038.69, 67.14, 0, ''),
(22424, 11, -3597.88, 4033.84, 68.53, 0, ''),
(22424, 12, -3602.19, 4027.89, 69.36, 0, ''),
(22424, 13, -3609.85, 4028.37, 70.78, 0, ''),
(22424, 14, -3613.01, 4031.10, 72.14, 0, ''),
(22424, 15, -3613.18, 4035.63, 73.52, 0, ''),
(22424, 16, -3609.84, 4039.73, 75.25, 0, ''),
(22424, 17, -3604.55, 4040.12, 77.01, 0, ''),
(22424, 18, -3600.61, 4036.03, 78.84, 0, ''),
(22424, 19, -3602.63, 4029.99, 81.01, 0, ''),
(22424, 20, -3608.87, 4028.64, 83.27, 0, ''),
(22424, 21, -3612.53, 4032.74, 85.24, 0, ''),
(22424, 22, -3611.08, 4038.13, 87.31, 0, ''),
(22424, 23, -3605.09, 4039.35, 89.55, 0, ''),
(22424, 24, -3601.87, 4035.44, 91.64, 0, ''),
(22424, 25, -3603.08, 4030.58, 93.66, 0, ''),
(22424, 26, -3608.47, 4029.23, 95.91, 0, ''),
(22424, 27, -3611.68, 4033.35, 98.09, 0, ''),
(22424, 28, -3609.51, 4038.25, 100.45, 0, ''),
(22424, 29, -3604.54, 4038.01, 102.72, 0, ''),
(22424, 30, -3602.40, 4033.48, 105.12, 0, ''),
(22424, 31, -3606.17, 4029.69, 107.63, 0, ''),
(22424, 32, -3609.93, 4031.26, 109.53, 0, ''),
(22424, 33, -3609.38, 4035.86, 110.67, 0, ''),
(22424, 34, -3603.58, 4043.03, 112.89, 0, ''),
(22424, 35, -3600.99, 4046.49, 111.81, 0, ''),
(22424, 36, -3602.32, 4051.77, 111.81, 3000, 'SAY_SKYWING_TREE_UP'),
(22424, 37, -3609.55, 4055.95, 112.00, 0, ''),
(22424, 38, -3620.93, 4043.77, 111.99, 0, ''),
(22424, 39, -3622.44, 4038.95, 111.99, 0, ''),
(22424, 40, -3621.64, 4025.39, 111.99, 0, ''),
(22424, 41, -3609.62, 4015.20, 111.99, 0, ''),
(22424, 42, -3598.37, 4017.72, 111.99, 0, ''),
(22424, 43, -3590.21, 4026.62, 111.99, 0, ''),
(22424, 44, -3586.55, 4034.13, 112.00, 0, ''),
(22424, 45, -3580.39, 4033.46, 112.00, 0, ''),
(22424, 46, -3568.83, 4032.53, 107.16, 0, ''),
(22424, 47, -3554.81, 4031.23, 105.31, 0, ''),
(22424, 48, -3544.39, 4030.10, 106.58, 0, ''),
(22424, 49, -3531.91, 4029.25, 111.70, 0, ''),
(22424, 50, -3523.50, 4030.24, 112.47, 0, ''),
(22424, 51, -3517.48, 4037.42, 112.66, 0, ''),
(22424, 52, -3510.40, 4040.77, 112.92, 0, ''),
(22424, 53, -3503.83, 4041.35, 113.17, 0, ''),
(22424, 54, -3498.31, 4040.65, 113.11, 0, ''),
(22424, 55, -3494.05, 4031.67, 113.11, 0, ''),
(22424, 56, -3487.71, 4025.58, 113.12, 0, ''),
(22424, 57, -3500.42, 4012.93, 113.11, 0, ''),
(22424, 58, -3510.86, 4010.15, 113.10, 0, ''),
(22424, 59, -3518.07, 4008.62, 112.97, 0, ''),
(22424, 60, -3524.74, 4014.55, 112.41, 2000, 'SAY_SKYWING_JUMP'),
(22424, 61, -3537.81, 4008.59, 92.53, 0, ''),
(22424, 62, -3546.25, 4008.81, 92.79, 0, ''),
(22424, 63, -3552.07, 4006.48, 92.84, 0, ''),
(22424, 64, -3556.29, 4000.14, 92.92, 0, ''),
(22424, 65, -3556.16, 3991.24, 92.92, 0, ''),
(22424, 66, -3551.48, 3984.28, 92.91, 0, ''),
(22424, 67, -3542.90, 3981.64, 92.91, 0, ''),
(22424, 68, -3534.82, 3983.98, 92.92, 0, ''),
(22424, 69, -3530.58, 3989.91, 92.85, 0, ''),
(22424, 70, -3529.85, 3998.77, 92.59, 0, ''),
(22424, 71, -3534.15, 4008.45, 92.34, 0, ''),
(22424, 72, -3532.87, 4012.97, 91.64, 0, ''),
(22424, 73, -3530.57, 4023.42, 86.82, 0, ''),
(22424, 74, -3528.24, 4033.91, 85.69, 0, ''),
(22424, 75, -3526.22, 4043.75, 87.26, 0, ''),
(22424, 76, -3523.84, 4054.29, 92.42, 0, ''),
(22424, 77, -3522.44, 4059.06, 92.92, 0, ''),
(22424, 78, -3514.26, 4060.72, 92.92, 0, ''),
(22424, 79, -3507.76, 4065.21, 92.92, 0, ''),
(22424, 80, -3503.24, 4076.63, 92.92, 0, 'SAY_SKYWING_SUMMON'),
(22424, 81, -3504.23, 4080.47, 92.92, 2000, ''),
(22424, 82, -3504.23, 4080.47, 92.92, 25000, 'SAY_SKYWING_END');

INSERT INTO `script_texts` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(-1900179,'%s squawks and heads toward Veil Shalas. Hurry and follow!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'skywing SAY_SKYWING_START'),
(-1900180,'%s pauses briefly before the tree and then heads inside.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'skywing SAY_SKYWING_TREE_DOWN'),
(-1900181,'%s seems to be looking for something. He wants you to follow.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'skywing SAY_SKYWING_TREE_UP'),
(-1900182,'%s flies to the platform below! You\'d better jump if you want to keep up. Hurry!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'skywing SAY_SKYWING_JUMP'),
(-1900183,'%s bellows a loud squawk!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'skywing SAY_SKYWING_SUMMON'),
(-1900184,'Free at last from that horrible curse! Thank you! Please send word to Rilak the Redeemed that I am okay. My mission lies in Skettis. Terokk must be defeated!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'skywing SAY_SKYWING_END');


