-- http://www.wowwiki.com/Gnomeregan

-- Namdo Bizzfizzle http://wowhead.com/npc=2683#comments 
delete from creature where id=2683;
INSERT INTO `creature` VALUES ('1822', '2683', '0', '1', '0', '753', '-4918.19', '715.902', '253.097', '5.69883', '300', '0', '0', '720', '0', '0', '0');

-- Techbot http://wowhead.com/npc=6231#comments http://www.wowwiki.com/Techbot 
delete from creature_ai_scripts where entryOrGuid=6231;
delete from creature_ai_texts where entry in ('-6231','-6232','-6233');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`,`comment`) VALUES ('-6231', 'Techbot is sensitive and those words hurt my ears. :[ Please be nice to me. I just want to help.', '1','Techbot phrase 1');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`,`comment`) VALUES ('-6232', 'If you have been muted, or have questions about the Muting/UnMuting process, please visit...zzzzttt!!', '1','Techbot phrase 2');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`,`comment`) VALUES ('-6233', 'Some topics I can help you with are: | drivers | commands | lag | bots....zzzzzzzzttt!!', '1','Techbot phrase 1');
INSERT INTO `creature_ai_scripts` VALUES ('623151', '6231', '0', '0', '100', '1', '0', '1000', '15000', '30000', '1', '-6231', '-6232', '-6233', '0', '0', '0', '0', '0', '0', '0', '0', 'Techbot random phrases');
INSERT INTO `creature_ai_scripts` VALUES ('623152', '6231', '0', '0', '100', '1', '7000', '10000', '13000', '20000', '11', '10855', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Techbot casts Lag');
INSERT INTO `creature_ai_scripts` VALUES ('623153', '6231', '0', '0', '100', '1', '2000', '4000', '9000', '18000', '11', '10852', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Techbot casts Battle Net');
INSERT INTO `creature_ai_scripts` VALUES ('623155', '6231', '1', '0', '100', '1', '5000', '10000', '25000', '30000', '11', '10858', '0', '2', '11', '10858', '0', '2', '0', '0', '0', '0', 'Techbot casts Summon Dupe Bug');
UPDATE `creature_template` SET `AIName` = 'EventAI',`faction_A`='1693', `faction_H`='1693' WHERE `entry` = '6231';
UPDATE `creature_template` SET `faction_A`='1692', `faction_H`='1692' WHERE (`entry`='7732');
delete from creature where id=7732;

-- Caverndeep Invader http://wowhead.com/npc=6208#comments http://letswow.ru/wowhead/?npc=6208#abilities
delete from creature_ai_scripts where entryOrGuid=6208;
INSERT INTO `creature_ai_scripts` VALUES ('620851', '6208', '1', '0', '100', '1', '2000', '90000', '90000', '5500', '11', '9798', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Invader casts Radiation');
INSERT INTO `creature_ai_scripts` VALUES ('620852', '6208', '0', '0', '100', '1', '6000', '10000', '15000', '20000', '11', '12540', '1', '10', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Invader casts Gouge');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6208';

-- Caverndeep Pillager http://wowhead.com/npc=6210 http://letswow.ru/wowhead/?npc=6210 
delete from creature_ai_scripts where entryOrGuid=6210;
INSERT INTO `creature_ai_scripts` VALUES ('621051', '6210', '0', '0', '100', '1', '5000', '7000', '12000', '15000', '11', '12540', '1', '10', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Pillager casts Gouge');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6210';

-- Caverndeep Looter http://wowhead.com/npc=6209#comments
delete from creature_ai_scripts where entryOrGuid=6209;
INSERT INTO `creature_ai_scripts` VALUES ('620951', '6209', '9', '0', '100', '1', '0', '5', '15000', '20000', '11', '10851', '1', '10', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Pillager casts Grab Weapon');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6209';

-- Sprok http://wowhead.com/npc=8320#comments 
UPDATE `creature_template` SET `faction_A`='120', `faction_H`='120' WHERE (`entry`='8320');

-- Irradiated Invader http://letswow.ru/wowhead/?npc=6213#abilities
delete from creature_ai_scripts where entryOrGuid=6213;
INSERT INTO `creature_ai_scripts` VALUES ('621351', '6213', '0', '0', '100', '1', '2000', '6000', '4000', '8000', '11', '9771', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Irradiated Invader casts Radiation Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('621352', '6213', '1', '0', '100', '1', '1000', '1500', '90000', '90000', '11', '9798', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Irradiated Invader casts Radiation');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6213';

-- INSTANSE INSIDE

-- Caverndeep Burrower http://letswow.ru/wowhead/?npc=6206#abilities
delete from creature_ai_scripts where entryOrGuid=6206;
INSERT INTO `creature_ai_scripts` VALUES ('620651', '6206', '1', '0', '100', '1', '500', '1000', '180000', '180000', '11', '7164', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Burrower casts Defensive Stance');
INSERT INTO `creature_ai_scripts` VALUES ('620652', '6206', '9', '0', '100', '1', '0', '5', '5000', '7000', '11', '16145', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Burrower casts Sunder Armor');
INSERT INTO `creature_ai_scripts` VALUES ('620653', '6206', '1', '0', '100', '1', '1000', '1500', '90000', '90000', '11', '9798', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Burrower casts Radiation');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6206';

-- Caverndeep Ambusher http://wowhead.com/npc=6207#comments  
delete from creature_ai_scripts where entryOrGuid=6207;
INSERT INTO `creature_ai_scripts` VALUES ('620751', '6207', '0', '0', '100', '1', '4000', '8000', '5000', '9000', '11', '2590', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Ambusher casts Backstab');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6207';

-- Event Grubbis and Chooper  http://wowhead.com/npc=7361#encounter http://letswow.ru/wowhead/?npc=6215#abilities
-- Blastmaster Emi Shortfuse http://letswow.ru/wowhead/?npc=7998
delete from creature_ai_texts where entry='-7998';
INSERT INTO `creature_ai_texts` (`entry`, `content_default`,`comment`) VALUES ('-7998', 'Look! Over there at the tunnel wall!',' Blastmaster Emi Shortfuse');
delete from creature_ai_summons where id=50;
INSERT INTO `creature_ai_summons` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `comment`) VALUES ('50', '-514.934', '-97.153', '-153.111', '4.9', '60000', 'Blastmaster Emi Shortfuse');
delete from creature_ai_scripts where entryOrGuid=7998;
INSERT INTO `creature_ai_scripts` VALUES ('799851', '7998', '10', '0', '100', '0', '1', '15', '0', '0', '32', '7361', '0', '50', '1', '-7998', '0', '0', '0', '0', '0', '0', 'Blastmaster Emi Shortfuse summon Grubbis');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7998';
delete from creature_ai_scripts where entryOrGuid=7361;
INSERT INTO `creature_ai_scripts` VALUES ('736151', '7361', '0', '0', '100', '1', '4000', '8000', '5000', '9000', '11', '12057', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Grubbis casts Strike');
INSERT INTO `creature_ai_scripts` VALUES ('736152', '7361', '11', '0', '100', '0', '0', '0', '0', '0', '12', '6215', '1', '90000', '1', '-7361', '0', '0', '0', '0', '0', '0', 'Grubbis summons Chomper');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7361';
delete from creature_ai_texts where entry='-7361';
INSERT INTO `creature_ai_texts` (`entry`, `content_default`,`comment`) VALUES ('-7361', 'We come from below! You can never stop us!','Grubbis phrase');

-- Irradiated Slime http://letswow.ru/wowhead/?npc=6218#abilities http://wowhead.com/npc=6218#abilities
delete from creature_ai_scripts where entryOrGuid=6218;
INSERT INTO `creature_ai_scripts` VALUES ('621851', '6218', '6', '0', '100', '0', '0', '0', '0', '0', '11', '10341', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', 'Irradiated Slime casts Radiation Cloud');
INSERT INTO `creature_ai_scripts` VALUES ('621852', '6218', '11', '0', '100', '0', '0', '0', '0', '0', '11', '21862', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', 'Irradiated Slime casts Radiation on spawn');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6218';

-- Irradiated Horror http://wowhead.com/npc=6220#comments 
delete from creature_ai_scripts where entryOrGuid=6220;
INSERT INTO `creature_ai_scripts` VALUES ('622051', '6220', '0', '0', '100', '1', '4000', '5000', '5000', '15000', '11', '8211', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Irradiated Horror casts Chain Burn');
INSERT INTO `creature_ai_scripts` VALUES ('622052', '6220', '11', '0', '100', '0', '0', '0', '0', '0', '11', '21862', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', 'Irradiated Horror casts Radiation on spawn');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6220';

-- Corrosive Lurker http://letswow.ru/wowhead/?npc=6219#abilities http://wowhead.com/npc=6219#comments
delete from creature_ai_scripts where entryOrGuid=6219;
INSERT INTO `creature_ai_scripts` VALUES ('621951', '6219', '11', '0', '100', '0', '0', '0', '0', '0', '11', '9460', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Corrosive Lurkerr casts Corrosive Ooze on spawn');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6219';

-- Viscous Fallout http://wowhead.com/npc=7079#comments
delete from creature_ai_scripts where entryOrGuid=7079;
INSERT INTO `creature_ai_scripts` VALUES ('707951', '7079', '0', '0', '100', '1', '3000', '6000', '7000', '10000', '11', '21687', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Viscous Fallout casts Toxic Volley');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7079';

-- Caverndeep Reaver http://wowhead.com/npc=6211#abilities
delete from creature_ai_scripts where entryOrGuid=6211;
INSERT INTO `creature_ai_scripts` VALUES ('621151', '6211', '0', '0', '100', '1', '3000', '5000', '4000', '8000', '11', '15496', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Caverndeep Reavert casts Cleave');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6211';

-- Holdout Medic http://wowhead.com/npc=6392#abilities  проверить каст хила
delete from creature_ai_scripts where entryOrGuid=6392;
INSERT INTO `creature_ai_scripts` VALUES ('639251', '6392', '14', '0', '100', '1', '1500', '40', '8000', '12000', '11', '22167', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Holdout Medic casts Heal on ally');
INSERT INTO `creature_ai_scripts` VALUES ('639252', '6392', '14', '0', '100', '1', '1000', '40', '13000', '18000', '11', '22168', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Holdout Medic casts Renew on ally');
INSERT INTO `creature_ai_scripts` VALUES ('639253', '6392', '10', '1', '100', '1', '1', '30', '30000', '45000', '11', '13864', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Holdout Medic casts Power Word: Fortitude on ally');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6392';

-- Holdout Technician http://wowhead.com/npc=6407#abilities
delete from creature_ai_scripts where entryOrGuid=6407;
INSERT INTO `creature_ai_scripts` VALUES ('640751', '6407', '9', '0', '100', '1', '5', '30', '1000', '2000', '11', '6660', '1', '0', '21', '0', '0', '0', '0', '0', '0', '0', 'Holdout Technician casts Shoot 5-30 range');
INSERT INTO `creature_ai_scripts` VALUES ('640752', '6407', '0', '0', '100', '1', '5000', '8000', '12000', '15000', '11', '8858', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Holdout Technician casts Bomb');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6407';

-- Holdout Warrior http://wowhead.com/npc=6391#comments
delete from creature_ai_scripts where entryOrGuid=6391;
INSERT INTO `creature_ai_scripts` VALUES ('639151', '6391', '0', '0', '100', '1', '5000', '8000', '6000', '9000', '11', '11976', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Holdout Warrior casts Stike');
INSERT INTO `creature_ai_scripts` VALUES ('639152', '6391', '13', '0', '100', '1', '10000', '15000', '0', '0', '11', '12555', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Holdout Warrior casts Pummel');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6391';

-- Mobile Alert System http://wowhead.com/npc=7849#comments http://www.wowwiki.com/Mobile_Alert_System 
delete from creature_ai_scripts where entryOrGuid=7849;
delete from creature_ai_texts where entry='-7849';
INSERT INTO `creature_ai_scripts` VALUES ('784951', '7849', '1', '0', '100', '1', '5000', '10000', '10000', '15000', '11', '1543', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Mobile Alert System casts Flare');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`,`sound`, `comment`) VALUES ('-7849', 'Warning! Warning! Intruder alert! Intruder alert!', '1','5805', 'Mobile Alert System yell');
INSERT INTO `creature_ai_scripts` VALUES ('784952', '7849', '0', '0', '100', '0', '1000', '1000', '0', '0', '1', '-7849', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mobile Alert System first phrase');
INSERT INTO `creature_ai_scripts` VALUES ('784953', '7849', '0', '0', '100', '0', '5000', '5000', '0', '0', '1', '-7849', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mobile Alert System second phrase');
INSERT INTO `creature_ai_scripts` VALUES ('784954', '7849', '0', '0', '100', '0', '8000', '8000', '0', '0', '1', '-7849', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mobile Alert System third phrase');
INSERT INTO `creature_ai_scripts` VALUES ('784955', '7849', '0', '0', '100', '0', '11000', '11000', '0', '0', '12', '6234', '1', '30000', '12', '6234', '4', '30000', '0', '0', '0', '0', 'Mobile Alert System summons Mechanized Guardians');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7849';

-- Mechanized Guardian http://wowhead.com/npc=6234#comments http://www.wowwiki.com/Mechanized_Guardian  
delete from creature_ai_scripts where entryOrGuid=6234;
INSERT INTO `creature_ai_scripts` VALUES ('623451', '6234', '0', '0', '100', '1', '1000', '1500', '10000', '12000', '11', '11820', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Mechanized Guardian casts Electrified Net');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6234';

-- Leprous Defender http://wowhead.com/npc=6223#comments фразы
delete from creature_ai_scripts where entryOrGuid=6223;
delete from creature_ai_texts where entry in ('-6223','-6224','-6225','-6226');
INSERT INTO `creature_ai_scripts` VALUES ('622351', '6223', '9', '0', '100', '1', '5', '30', '8000', '12000', '11', '14443', '1', '7', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Defender casts Multi-Shot 5-30 range');
INSERT INTO `creature_ai_scripts` VALUES ('622352', '6223', '9', '0', '100', '1', '5', '30', '1000', '2000', '11', '6660', '1', '0', '21', '0', '0', '0', '0', '0', '0', '0', 'Leprous Defender casts Shoot 5-30 range');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `comment`) VALUES ('-6223', 'A foul trogg if ever I saw one. Die!', 'Gnomeregan phrase 1');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `comment`) VALUES ('-6224', 'This sickness clouds my vision, but I know you must be a trogg. Die foul invader!', 'Gnomeregan phrase 2');
INSERT INTO `creature_ai_scripts` VALUES ('622353', '6223', '4', '0', '30', '0', '0', '0', '0', '0', '1', '-6223', '-6224', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Defender says random phrase');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6223';

-- Leprous Assistant http://wowhead.com/npc=7603#comments фразы
delete from creature_ai_scripts where entryOrGuid=7603;
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `comment`) VALUES ('-6225', 'No gnome will be left behind.', 'Gnomeregan phrase 3');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `comment`) VALUES ('-6226', 'The troggs...they never stop coming. Die trogg! Die!', 'Gnomeregan phrase 4');
INSERT INTO `creature_ai_scripts` VALUES ('760351', '7603', '4', '0', '30', '0', '0', '0', '0', '0', '1', '-6224', '-6225', '-6226', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Assistant says random phrase');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7603';

-- Leprous Technician http://wowhead.com/npc=6222#comments 
delete from creature_ai_scripts where entryOrGuid=6222;
INSERT INTO `creature_ai_scripts` VALUES ('622251', '6222', '4', '0', '30', '0', '0', '0', '0', '0', '1', '-6225', '-6223', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Techniciant says random phrase');
INSERT INTO `creature_ai_scripts` VALUES ('622252', '6222', '14', '0', '100', '1', '500', '15', '10000', '15000', '11', '10732', '6', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Techniciant casts Supercharge on ally');
INSERT INTO `creature_ai_scripts` VALUES ('622253', '6222', '10', '0', '100', '1', '1', '5', '25000', '30000', '11', '10348', '6', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Techniciant casts Tune Up on ally');
INSERT INTO `creature_ai_scripts` VALUES ('622254', '6222', '9', '0', '100', '1', '0', '30', '1000', '2500', '11', '13398', '1', '2', '21', '0', '0', '0', '0', '0', '0', '0', 'Leprous Techniciant casts Throw Wrench');
UPDATE `creature_template` SET `AIName` = 'EventAI',`spell2`='10732', `spell3`='10348' WHERE `entry` = '6222';

-- Peacekeeper Security Suit http://wowhead.com/npc=6230#abilities
delete from creature_ai_scripts where entryOrGuid=6230;
INSERT INTO `creature_ai_scripts` VALUES ('623051', '6230', '0', '0', '100', '1', '1000', '2000', '8000', '10000', '11', '6533', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Peacekeeper Security Suit casts Net');
INSERT INTO `creature_ai_scripts` VALUES ('623052', '6230', '9', '0', '100', '1', '0', '5', '10000', '15000', '11', '10730', '4', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Peacekeeper Security Suit casts Pacify');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6230';

-- Electrocutioner 6000  http://www.wowhead.com/npc=6235#comments
delete from creature_ai_scripts where entryOrGuid=6235;
delete from creature_ai_texts where entry='-6235';
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `type`,`sound`, `comment`) VALUES ('-6235', 'Electric justice!', '1','5811','Electrocutioner 6000 yell');
INSERT INTO `creature_ai_scripts` VALUES ('623551', '6235', '4', '0', '100', '0', '0', '0', '0', '0', '1', '-6235', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Electrocutioner 6000 aggro phrase');
INSERT INTO `creature_ai_scripts` VALUES ('623552', '6235', '0', '0', '100', '1', '8000', '10000', '8500', '15000', '11', '11085', '4', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Electrocutioner 6000 casts Chain Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('623553', '6235', '0', '0', '100', '1', '4500', '7000', '6000', '12000', '11', '11082', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Electrocutioner 6000 casts Megavolt');
INSERT INTO `creature_ai_scripts` VALUES ('623554', '6235', '9', '0', '100', '1', '0', '20', '7000', '15000', '11', '11084', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Electrocutioner 6000 casts Shock');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6235';

-- Mechano-Tank http://www.wowhead.com/npc=6225#abilities
delete from creature_ai_scripts where entryOrGuid=6225;
INSERT INTO `creature_ai_scripts` VALUES ('622551', '6225', '9', '0', '100', '1', '5', '30', '5000', '10000', '11', '10346', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Mechano-Tank casts Machine Gun 5-30 range');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6225';

-- Mechano-Flamewalker http://www.wowhead.com/npc=6226#comments
delete from creature_ai_scripts where entryOrGuid=6226;
INSERT INTO `creature_ai_scripts` VALUES ('622651', '6226', '0', '0', '100', '1', '4000', '6000', '4000', '10000', '11', '11970', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mechano-Flamewalker casts Fire Nova');
INSERT INTO `creature_ai_scripts` VALUES ('622652', '6226', '0', '0', '100', '1', '5000', '12000', '7000', '13000', '11', '10733', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Mechano-Flamewalker casts Flame Spray');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6226';

-- Crowd Pummeler 9-60  http://www.wowhead.com/npc=6229#abilities
delete from creature_ai_scripts where entryOrGuid=6229;
INSERT INTO `creature_ai_scripts` VALUES ('622951', '6229', '0', '0', '100', '1', '4000', '5000', '8000', '12000', '11', '8374', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Crowd Pummeler 9-60 casts Arcing Smash');
INSERT INTO `creature_ai_scripts` VALUES ('622952', '6229', '0', '0', '100', '1', '10000', '10000', '10000', '15000', '11', '10887', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Crowd Pummeler 9-60 casts Crowd Pummel');
INSERT INTO `creature_ai_scripts` VALUES ('622953', '6229', '0', '0', '100', '1', '13000', '15000', '6000', '11500', '11', '5568', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Crowd Pummeler 9-60 casts Trample');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6229';

-- Leprous Machinesmith http://www.wowhead.com/npc=6224#comments мк тест
delete from creature_ai_scripts where entryOrGuid=6224;
INSERT INTO `creature_ai_scripts` VALUES ('622451', '6224', '4', '0', '20', '0', '0', '0', '0', '0', '1', '-6225', '-6223', '-6224', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Machinesmith says random phrase');
INSERT INTO `creature_ai_scripts` VALUES ('622452', '6224', '14', '0', '100', '1', '500', '15', '10000', '15000', '11', '10732', '6', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Machinesmith casts Supercharge on ally');
INSERT INTO `creature_ai_scripts` VALUES ('622453', '6224', '10', '0', '100', '1', '1', '5', '25000', '30000', '11', '10348', '6', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Leprous Machinesmith casts Tune Up on ally');
INSERT INTO `creature_ai_scripts` VALUES ('622454', '6224', '9', '0', '100', '1', '0', '30', '1000', '2500', '11', '13398', '1', '2', '21', '0', '0', '0', '0', '0', '0', '0', 'Leprous Machinesmith casts Throw Wrench');
UPDATE `creature_template` SET `AIName` = 'EventAI',`spell1`='13398', `spell2`='10732', `spell3`='10348' WHERE `entry` = '6224';

-- Mechano-Frostwalker http://www.wowhead.com/npc=6227#abilities
delete from creature_ai_scripts where entryOrGuid=6227;
INSERT INTO `creature_ai_scripts` VALUES ('622751', '6227', '9', '0', '100', '1', '0', '10', '12000', '15000', '11', '11264', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Mechano-Frostwalker casts Ice Blast');
INSERT INTO `creature_ai_scripts` VALUES ('622752', '6227', '0', '0', '100', '1', '3000', '4500', '12000', '16000', '11', '10734', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Mechano-Frostwalker casts Hail Storm');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6227';

-- Arcane Nullifier X-21 http://www.wowhead.com/npc=6232#comments
delete from creature_ai_scripts where entryOrGuid=6232;
INSERT INTO `creature_ai_scripts` VALUES ('623251', '6232', '15', '0', '100', '1', '0', '10', '5000', '10000', '11', '10832', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Arcane Nullifier X-21 casts Mass Nullify');
INSERT INTO `creature_ai_scripts` VALUES ('623252', '6232', '0', '0', '100', '1', '500', '1000', '10000', '20000', '11', '10831', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Arcane Nullifier X-21 casts Reflection Field');
INSERT INTO `creature_ai_scripts` VALUES ('623253', '6232', '0', '0', '100', '1', '1500', '2000', '15000', '17000', '11', '31589', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Arcane Nullifier X-21 casts Slow');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6232';

-- Dark Iron Ambassador http://www.wowhead.com/npc=6228#abilities http://www.wowwiki.com/Dark_Iron_Ambassador 
delete from creature where id=6228;
INSERT INTO `creature` VALUES ('1828', '6228', '90', '1', '0', '97', '-641.316', '693.145', '-327.06', '2.90007', '300', '0', '0', '3660', '1512', '0', '0');
delete from creature_ai_scripts where entryOrGuid=6228;
INSERT INTO `creature_ai_scripts` VALUES ('622851', '6228', '11', '0', '100', '1', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Dark Iron Ambassador block movement on spawn');
INSERT INTO `creature_ai_scripts` VALUES ('622852', '6228', '1', '0', '100', '1', '0', '0', '60000', '60000', '11', '184', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Dark Iron Ambassador casts Fire Shield II');
INSERT INTO `creature_ai_scripts` VALUES ('622853', '6228', '0', '0', '100', '1', '1000', '1000', '3000', '4000', '11', '9053', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Dark Iron Ambassador casts Fireball');
INSERT INTO `creature_ai_scripts` VALUES ('622854', '6228', '1', '0', '100', '1', '1000', '2000', '240000', '240000', '11', '10870', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Dark Iron Ambassador casts Summon Burning Servant');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '6228';

-- Burning Servant http://www.wowhead.com/npc=7738#comments
delete from creature_ai_scripts where entryOrGuid=7738;
INSERT INTO `creature_ai_scripts` VALUES ('773851', '7738', '0', '0', '100', '1', '1000', '3000', '30000', '60000', '12', '7266', '4', '30000', '12', '7266', '4', '60000', '12', '7266', '4', '30000', 'Burning Servant Summon 3 Embers');
UPDATE `creature_template` SET `AIName` = 'EventAI',`minhealth`='400', `maxhealth`='400' WHERE `entry` = '7738';
UPDATE `creature_template` SET `faction_A`='14', `faction_H`='14' WHERE (`entry`='7266');

-- Mekgineer Thermaplugg http://www.wowhead.com/npc=7800#abilities глянуть спелы http://www.wowwiki.com/Sicco_Thermaplugg  http://letswow.ru/wowhead/?spell=35919  
delete from creature_ai_scripts where entryOrGuid=7800;
INSERT INTO `creature_ai_scripts` VALUES ('780051', '7800', '4', '0', '100', '0', '0', '0', '0', '0', '1', '-188', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg aggro phrase');
INSERT INTO `creature_ai_scripts` VALUES ('780052', '7800', '0', '0', '100', '1', '4000', '8000', '6000', '12000', '11', '35919', '1', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg casts Welding Beam');
INSERT INTO `creature_ai_scripts` VALUES ('780053', '7800', '0', '0', '100', '1', '9000', '10000', '8000', '15000', '11', '11130', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg casts Knock Away');
INSERT INTO `creature_ai_scripts` VALUES ('780054', '7800', '5', '0', '100', '0', '0', '0', '0', '0', '1', '-191', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg kill player phrase');
INSERT INTO `creature_ai_scripts` VALUES ('780055', '7800', '2', '0', '100', '0', '50', '0', '0', '0', '1', '-189', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg low hp phrase');
INSERT INTO `creature_ai_scripts` VALUES ('780056', '7800', '0', '0', '100', '1', '15000', '20000', '18000', '50000', '11', '11518', '0', '0', '11', '11511', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg bomb 1');
INSERT INTO `creature_ai_scripts` VALUES ('780057', '7800', '0', '0', '100', '1', '13000', '25000', '38000', '45000', '11', '11521', '0', '0', '11', '11511', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg bomb 2');
INSERT INTO `creature_ai_scripts` VALUES ('780058', '7800', '0', '0', '100', '1', '15000', '28000', '21000', '48000', '11', '11798', '0', '0', '11', '11511', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg bomb 3');
INSERT INTO `creature_ai_scripts` VALUES ('780059', '7800', '0', '0', '100', '1', '19000', '29000', '13000', '30000', '11', '11524', '0', '0', '11', '11795', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg bomb 4');
INSERT INTO `creature_ai_scripts` VALUES ('780060', '7800', '0', '0', '100', '1', '11000', '27000', '15000', '39000', '11', '11526', '0', '0', '11', '11795', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg bomb 5');
INSERT INTO `creature_ai_scripts` VALUES ('780061', '7800', '0', '0', '100', '1', '10000', '29000', '34000', '49000', '11', '11527', '0', '0', '11', '11795', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg bomb 6');
INSERT INTO `creature_ai_scripts` VALUES ('780062', '7800', '0', '0', '100', '1', '15000', '20000', '5000', '5000', '39', '80', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg call for help');
INSERT INTO `creature_ai_scripts` VALUES ('780063', '7800', '0', '0', '100', '1', '15000', '20000', '15000', '30000', '1', '-190', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mekgineer Thermaplugg random time phrase about bombs');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '7800';
delete from event_scripts where id in (2721,2723,2816,2725,2726,2727);
INSERT INTO `event_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES ('2721', '10', '7915', '15000', '-547.839', '646.424', '-327.125', '0.99');
INSERT INTO `event_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES ('2723', '10', '7915', '15000', '-525.958', '641.841', '-327.110', '1.75');
INSERT INTO `event_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES ('2816', '10', '7915', '15000', '-503.600', '657.585', '-327.146', '2.65');
INSERT INTO `event_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES ('2725', '10', '7915', '15000', '-503.267', '683.646', '-327.161', '3.6');
INSERT INTO `event_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES ('2726', '10', '7915', '15000', '-523.861', '699.648', '-327.145', '4.47');
INSERT INTO `event_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES ('2727', '10', '7915', '15000', '-549.687', '693.907', '-327.142', '5.38');

-- Walking Bomb http://www.wowhead.com/npc=7915#comments http://letswow.ru/wowhead/?npc=7915 
delete from creature_loot_template where entry=7915;
UPDATE `creature_ai_scripts` SET `event_type`='9', `event_param2`='10', `event_param3`='0', `event_param4`='0', `comment`='Walking Bomb - Cast Walking Bomb Effect' WHERE (`id`='791501');

-- Grime-Encrusted Ring http://letswow.ru/wowhead/?item=9326 http://wowhead.com/item=9326#comments
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='15' WHERE (`entry`='6212') AND (`item`='9326');

-- Discombobulator Ray http://wowhead.com/item=4388#comments
delete from creature_loot_template where item=4388;