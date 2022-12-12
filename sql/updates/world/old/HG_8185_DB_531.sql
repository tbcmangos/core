INSERT INTO `command` VALUES('arena spectate','4','8388608','Syntax: .arena spectate $targetname
Teleports you to target\'s arena, invisible and harmless'),('arena unspectate','4','8388608','Exit spectate mode');

INSERT INTO `hellground_string` (`entry`,`content_default`)VALUES
(812,'Specified target must be in arena'),
(813,'You are already spectating, use .arena unspectate first!'),
(814,'You entered spectate mode, to exit type .arena unspectate'),
(815,'You are not spectating and cannot use this command');
