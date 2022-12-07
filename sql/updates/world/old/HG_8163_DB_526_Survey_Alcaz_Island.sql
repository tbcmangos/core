-- http://letswow.ru/wowhead/?quest=11142

delete from quest_start_scripts where id=11142;
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`) VALUES ('11142', '2', '15', '42295', '0');
UPDATE `quest_template` SET `StartScript`='11142',`CompleteScript`='11142' WHERE entry=11142;

INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`, `x`, `y`,`z`,`o`) VALUES ('11142','0','6','1','0', '-3820.591','-4513.08','10.8','2.55'); 
INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`, `x`, `y`,`z`,`o`) VALUES ('11142','0','3','0','1', '-3819.164','-4509.362','11.19','3.31'); 
delete from quest_end_scripts where id=11142;
INSERT INTO `quest_end_scripts` (`id`,`delay`,`command`, `dataint`) VALUES ('11142','1', '0', '2000000078');
INSERT INTO `quest_end_scripts` (`id`,`delay`,`command`, `dataint`) VALUES ('11142','2', '0', '2000000079');
INSERT INTO `quest_end_scripts` (`id`,`delay`,`command`, `dataint`) VALUES ('11142','4', '0', '2000000080');
INSERT INTO `quest_end_scripts` (`id`,`delay`,`command`, `dataint`) VALUES ('11142','6', '0', '2000000081');
INSERT INTO `quest_end_scripts` (`id`,`delay`,`command`, `dataint`) VALUES ('11142','9', '0', '2000000082');
INSERT INTO `quest_end_scripts` (`id`,`delay`,`command`, `dataint`) VALUES ('11142','12', '0','2000000083');

delete from db_script_string where entry in (2000000078,2000000079,2000000080,2000000081,2000000082,2000000083);
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000078', 'Perhaps I should explain...');
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000079', 'I had arranged for a secret summit between Warchief Thrall and King Wrynn, here in Theramore.');
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000080', 'The King was to travel here by ship, in secret. But the ship never arrived, and King Wrynn disappeared.');
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000081', 'Your help enabled us to connect the Defias to the mastermind behind the abduction, Onyxia, who was posing as a member of the royal court.');
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000082', 'Meanwhile, the king managed to escape his captors, and returned to Stormwind to deal with Onyxia.');
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES ('2000000083', 'I will send word that you have discovered the link to the Defias. I was a fool to think them broken with the defeat of Edwin Van Cleef, and King Wrynn will want to make an example of all who remain.');