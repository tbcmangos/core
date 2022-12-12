-- Slave Pens: Fix Coilfang Scale-Healer AI
DELETE FROM `creature_ai_scripts` WHERE `entryOrGuid` = 21126;
INSERT INTO `creature_ai_scripts` VALUES
(2112601,21126,0,0,100,3,4400,8100,12100,13400,11,34944,0,0,0,0,0,0,0,0,0,0,'Coilfang Scale-Healer (Normal) - Cast Holy Nova'),
(2112602,21126,0,0,100,5,4400,8100,12100,13400,11,37669,0,0,0,0,0,0,0,0,0,0,'Coilfang Scale-Healer (Heroic) - Cast Holy Nova'),
(2112603,21126,0,0,100,3,10500,13300,12100,12100,11,17139,0,0,0,0,0,0,0,0,0,0,'Coilfang Scale-Healer (Normal) - Cast Power Word: Shield'),
(2112604,21126,0,0,100,5,10500,13300,12100,12100,11,36052,0,0,0,0,0,0,0,0,0,0,'Coilfang Scale-Healer (Heroic) - Cast Power Word: Shield'),
(2112605,21126,14,0,100,3,4000,40,0,0,11,34945,6,0,0,0,0,0,0,0,0,0,'Coilfang Scale-Healer (Normal) - Cast Heal on Friendlies'),
(2112606,21126,14,0,100,5,8000,40,0,0,11,39378,6,0,0,0,0,0,0,0,0,0,'Coilfang Scale-Healer (Heroic) - Cast Heal on Friendlies');
