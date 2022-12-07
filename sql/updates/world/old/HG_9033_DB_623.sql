-- http://wowhead.com/npc=7770#comments0 just add phrase for her
UPDATE creature_template SET `npcflag`='1' WHERE (`entry`='7770');
DELETE FROM npc_gossip WHERE npc_guid=23110;
INSERT INTO `npc_gossip` (`npc_guid`, `textid`) VALUES ('23110', '23110');
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`) VALUES ('23110', 'Hey there, cutie! Mind rubbing some lotion on my exposed areas?', 'Hey there, cutie! Mind rubbing some lotion on my exposed areas?');