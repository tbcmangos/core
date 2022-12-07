-- ZA/Amani'shi Beast Tamer: Add combat pulse on aggro
delete from creature_ai_scripts where entryOrGuid = 24059;

insert into creature_ai_scripts values
(2405901,24059,0,0,100,3,1000,10000,30000,60000,11,43361,4,0,0,0,0,0,0,0,0,0,"Amani'shi Beast Tamer - Cast Domesticate"),
(2405902,24059,0,0,100,3,5000,10000,10000,15000,11,43359,5,0,0,0,0,0,0,0,0,0,"Amani'shi Beast Tamer - Cast Eye of The Beast"),
(2405903,24059,4,0,100,3,0,0,0,0,38,0,0,0,0,0,0,0,0,0,0,0,"Amani'shi Beast Tamer - Combat Pulse on Aggro");
