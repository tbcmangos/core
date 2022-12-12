-- Lord Lakmaeran  http://www.wowwiki.com/Lord_Lakmaeran 
UPDATE `creature_template` SET `armor`='4344', `mindmg`='1618', `maxdmg`='2147' WHERE (`entry`='12803');
UPDATE `creature` SET `spawntimesecs`='1200' WHERE (`guid`='49970' and id='12803');
delete from creature_ai_scripts where entryOrGuid=12803;
INSERT INTO `creature_ai_scripts` VALUES ('1280351', '12803', '1', '0', '100', '1', '500', '500', '600000', '600000', '11', '41151', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Lord Lakmaeran casts Lightning Shield');
INSERT INTO `creature_ai_scripts` VALUES ('1280352', '12803', '0', '0', '100', '1', '5000', '10000', '12000', '20000', '11', '20542', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Lord Lakmaeran casts Static Conduit');
INSERT INTO `creature_ai_scripts` VALUES ('1280353', '12803', '0', '0', '100', '1', '3000', '8000', '25000', '30000', '11', '41151', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Lord Lakmaeran recasts Lightning Shield ');
INSERT INTO `creature_ai_scripts` VALUES ('1280354', '12803', '2', '0', '100', '1', '50', '0', '20000', '20000', '11', '34971', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Lord Lakmaeran casts Enrage at 50% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '12803';

-- Chimaerok http://letswow.ru/wowhead/?npc=12800#abilities
delete from creature_ai_scripts where entryOrGuid=12800;
INSERT INTO `creature_ai_scripts` VALUES ('1280051', '12800', '0', '0', '100', '1', '500', '1000', '3000', '10000', '11', '20629', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Chimaerok casts Corrosive Venom Spit');
INSERT INTO `creature_ai_scripts` VALUES ('1280052', '12800', '0', '0', '100', '1', '4000', '8000', '4500', '15000', '11', '15797', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Chimaerok casts Lightning Breath');
INSERT INTO `creature_ai_scripts` VALUES ('1280053', '12800', '9', '0', '100', '1', '0', '5', '10000', '15000', '11', '5708', '1', '2', '21', '0', '0', '0', '0', '0', '0', '0', 'Chimaerok casts Swoop at 5 yards');
INSERT INTO `creature_ai_scripts` VALUES ('1280054', '12800', '4', '0', '100', '0', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Chimaerok block movement on aggro');

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '12800';

-- Arcane Chimaerok http://letswow.ru/wowhead/?npc=12801#abilities
delete from creature_ai_scripts where entryOrGuid=12801;
INSERT INTO `creature_ai_scripts` VALUES ('1280151', '12801', '13', '0', '100', '1', '20000', '25000', '0', '0', '11', '15122', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Arcane Chimaerok casts Counterspell');
INSERT INTO `creature_ai_scripts` VALUES ('1280152', '12801', '0', '0', '100', '1', '1000', '1500', '2500', '3000', '11', '15797', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Arcane Chimaerok casts Lightning Breath');
INSERT INTO `creature_ai_scripts` VALUES ('1280153', '12801', '0', '0', '100', '1', '15000', '20000', '25000', '30000', '11', '20223', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Arcane Chimaerok casts Magic Reflection');
INSERT INTO `creature_ai_scripts` VALUES ('1280154', '12801', '4', '0', '100', '0', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Arcane Chimaerok block movement on aggro');

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '12801';

-- Chimaerok Devourer http://letswow.ru/wowhead/?npc=12802
delete from creature_ai_scripts where entryOrGuid=12802;
INSERT  INTO `creature_ai_scripts` VALUES ('1280251', '12802', '0', '0', '100', '1', '5000', '5500', '5000', '8000', '11', '7938', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Chimaerok Devourer casts Fatal Bite');
INSERT  INTO `creature_ai_scripts` VALUES ('1280252', '12802', '2', '0', '100', '0', '25', '0', '0', '0', '11', '8599', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Chimaerok Devourer casts Enrage at 25% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '12802';

-- Lord Shalzaru http://www.wowwiki.com/Lord_Shalzaru
delete from creature_ai_scripts where entryOrGuid=8136;
INSERT INTO `creature_ai_scripts` VALUES ('813651', '8136', '0', '0', '100', '1', '2000', '4000', '7000', '10000', '11', '10472', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Lord Shalzaru casts Frost Shock');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '8136';

-- Lady Szallah http://wowhead.com/npc=5343#comments  сделать инсерт и таймер реса побольше
delete from creature where id=5343;
INSERT INTO `creature` VALUES ('51679', '5343', '1', '1', '0', '145', '-5740.45', '3725.78', '-7.08008', '5.16124', '18000', '2', '0', '1919', '1587', '0', '1');
delete from creature_ai_scripts where entryOrGuid=5343;
INSERT INTO `creature_ai_scripts` VALUES ('534351', '5343', '0', '0', '100', '1', '1000', '2000', '3000', '3500', '11', '10392', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Lady Szallah casts Lightning Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('534352', '5343', '0', '0', '100', '1', '5000', '10000', '15000', '20000', '11', '15535', '4', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Lady Szallah casts Enveloping Winds');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5343';

-- Hatecrest Sorceress http://letswow.ru/wowhead/?npc=5336#abilities
delete from creature_ai_scripts where entryOrGuid=5336;
INSERT INTO `creature_ai_scripts` VALUES ('533651', '5336', '0', '0', '100', '1', '1000', '1500', '3500', '4000', '11', '20822', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Sorceress casts Frost Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('533652', '5336', '0', '0', '100', '1', '6000', '12000', '15000', '20000', '11', '44178', '4', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Sorceress casts Blizzard');
INSERT INTO `creature_ai_scripts` VALUES ('533653', '5336', '2', '0', '100', '0', '15', '0', '0', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Sorceress flee at 15% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5336';

-- Hatecrest Screamer http://wowhead.com/npc=5335#comments
delete from creature_ai_scripts where entryOrGuid=5335;
INSERT INTO `creature_ai_scripts` VALUES ('533551', '5335', '2', '0', '100', '1', '65', '0', '15000', '15000', '11', '10927', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Screamer casts Renew');
INSERT INTO `creature_ai_scripts` VALUES ('533552', '5335', '0', '0', '100', '1', '5000', '7000', '8000', '13000', '11', '8281', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Screamer casts Sonic Burst');
INSERT INTO `creature_ai_scripts` VALUES ('533553', '5335', '2', '0', '100', '0', '15', '0', '0', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Screamer flee at 15% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5335';

-- Hatecrest Warrior http://wowhead.com/npc=5331#comments
delete from creature_ai_scripts where entryOrGuid=5331;
INSERT INTO `creature_ai_scripts` VALUES ('533151', '5331', '0', '0', '100', '1', '3000', '5000', '10000', '15000', '11', '30013', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Warrior casts Disarm');
INSERT INTO `creature_ai_scripts` VALUES ('533152', '5331', '2', '0', '100', '0', '15', '0', '0', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Warrior flee at 15% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5331';

-- Hatecrest Siren http://wowhead.com/npc=5337#comments
delete from creature_ai_scripts where entryOrGuid=5337;
INSERT INTO `creature_ai_scripts` VALUES ('533751', '5337', '0', '0', '100', '1', '1000', '1500', '3000', '3500', '11', '9532', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Siren casts Lightning Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('533752', '5337', '2', '0', '100', '0', '15', '0', '0', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Siren flee at 15% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5337';

-- Hatecrest Wave Rider http://wowhead.com/npc=5332#comments
delete from creature_ai_scripts where entryOrGuid=5332;
INSERT INTO `creature_ai_scripts` VALUES ('533251', '5332', '0', '0', '100', '1', '1000', '3000', '7000', '14000', '11', '10987', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Wave Rider casts Geyser');
INSERT INTO `creature_ai_scripts` VALUES ('533252', '5332', '2', '0', '100', '0', '15', '0', '0', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Wave Ride flee at 15% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5337';

-- Hatecrest Serpent Guard http://letswow.ru/wowhead/?npc=5333#abilities
delete from creature_ai_scripts where entryOrGuid=5333;
INSERT  INTO `creature_ai_scripts` VALUES ('533351', '5333', '0', '0', '100', '1', '2000', '4000', '8000', '12000', '11', '8058', '1', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Serpent Guard casts Frost Shock');
INSERT INTO `creature_ai_scripts` VALUES ('533352', '5333', '2', '0', '100', '0', '15', '0', '0', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Serpent Guard flee at 15% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5333';

-- Hatecrest Myrmidon http://letswow.ru/wowhead/?npc=5334#abilities
delete from creature_ai_scripts where entryOrGuid=5334;
INSERT INTO `creature_ai_scripts` VALUES ('533451', '5334', '0', '0', '100', '1', '1000', '1000', '8500', '11000', '11', '6533', '1', '3', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Myrmidon casts Net');
INSERT INTO `creature_ai_scripts` VALUES ('533452', '5334', '2', '0', '100', '0', '15', '0', '0', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hatecrest Myrmidon flee at 15% hp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5334';

-- Longtooth Runner http://wowhead.com/npc=5286#abilities
delete from creature_ai_scripts where entryOrGuid=5286;
INSERT INTO `creature_ai_scripts` VALUES ('528651', '5286', '4', '0', '100', '0', '0', '0', '0', '0', '11', '3149', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Longtooth Runner casts Furious Howl');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5286';

-- Coast Crawl Deepseer http://wowhead.com/npc=5328#comments
delete from creature_ai_scripts where entryOrGuid=5328;
INSERT INTO `creature_ai_scripts` VALUES ('532851', '5328', '1', '0', '100', '1', '500', '500', '1800000', '1800000', '11', '12544', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Coast Crawl Deepseer casts Frost Armor');
INSERT INTO `creature_ai_scripts` VALUES ('532852', '5328', '0', '0', '100', '1', '500', '1000', '3500', '5000', '11', '9672', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Coast Crawl Deepseer casts Frostbolt');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5328';

-- Coast Crawl Snapclaw http://wowhead.com/npc=5327#abilities
delete from creature_ai_scripts where entryOrGuid=5327;
INSERT INTO `creature_ai_scripts` VALUES ('532751', '5327', '0', '0', '100', '1', '1500', '3000', '8000', '12000', '11', '5424', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Coast Crawl Snapclaw casts Claw Grasp');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5327';

-- Diamond Head http://letswow.ru/wowhead/?npc=5345
delete from creature_ai_scripts where entryOrGuid=5345;
INSERT INTO `creature_ai_scripts` VALUES ('534551', '5345', '0', '0', '100', '1', '4000', '6000', '8000', '15000', '11', '5164', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Diamond Head casts Knockdown');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '5345';