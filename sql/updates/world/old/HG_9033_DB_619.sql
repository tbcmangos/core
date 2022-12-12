-- http://www.wowhead.com/quest=10426/flora-of-the-eco-domes Current problem with that quest: player can keep using item on same mob again and again. Rework by Firehex.
-- Farahlon Lasher http://www.wowhead.com/npc=20774/farahlon-lasher#comments
DELETE FROM creature_ai_scripts WHERE entryOrGuid=20774;
INSERT INTO `creature_ai_scripts` VALUES ('2077451', '20774', '0', '0', '100', '1', '1000', '2000', '10000', '15000', '11', '12747', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Farahlon Lasher casts Entangling Roots');
INSERT INTO `creature_ai_scripts` VALUES ('2077452', '20774', '2', '0', '100', '1', '50', '0', '30000', '45000', '11', '36604', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Farahlon Lasher casts Flanking Growth at 50% hp');
INSERT INTO `creature_ai_scripts` VALUES ('2077453', '20774', '8', '0', '100', '0', '35772', '-1', '0', '0', '36', '20983', '0', '0', '11', '3019', '0', '3', '13', '50', '6', '0', 'Farahlon Lasher reaction on Energy Field Modulator');
-- http://wowhead.com/npc=21331 this npc from summon spell and shouldn't be in world
DELETE FROM creature WHERE id=21331;
-- http://wowhead.com/npc=20983  this npc can appear only after quest item cast
DELETE FROM creature WHERE id=20983;