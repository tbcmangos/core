-- #000207 Encrusted surf crawler
UPDATE creature_template SET InhabitType=3 WHERE entry=3108;
-- #000447 Targrom
insert into creature values (NULL, '19248', '530', '1', '0', '0', '-2278.49', '5567.23', '67.082', '1.16937', '300', '0', '0', '1400', '5751', '0', '0');
-- #000132 Soryn
replace into npc_vendor values (26092,31979,0,0,1497),(26092,31981,0,0,1485),(26092,31983,0,0,1494);
-- #000065 Thunderbrew Lager
update creature_template set npcflag = 3 where entry = 239;