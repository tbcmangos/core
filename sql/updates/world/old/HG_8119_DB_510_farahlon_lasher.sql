-- Netherstorm/Flora of the Eco-Domes: Properly reset faction of Farahlon Lasher
DELETE FROM `creature_ai_scripts` WHERE `entryOrGuid` = 20774;
INSERT INTO `creature_ai_scripts` VALUES
(2077401,20774,8,0,100,1,35772,-1,0,0,3,20983,0,0,11,3019,0,0,2,14,0,0,'Farahlon Lasher'),
(2077402,20774,4,0,100,0,0,0,0,0,11,12747,1,0,0,0,0,0,0,0,0,0,'Farahlon Lasher'),
(2077403,20774,0,0,100,1,1800,1800,16300,16300,11,36604,0,0,0,0,0,0,0,0,0,0,'Farahlon Lasher'),
(2077404,20774,11,0,100,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,'Farahlon Lasher - Reset faction on spawn');
