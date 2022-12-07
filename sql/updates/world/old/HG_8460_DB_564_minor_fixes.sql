-- #000570 shadowy necromancers mind controll
update creature_template set spell1 = 31626 where entry = 17899;
-- not reported, warp splinter should give rep up to exalted
update creature_onkill_reputation set maxstanding1 = 7 where creature_id in (17977,21582);
-- #000098 Harisson Jones gossip
replace into npc_gossip values (1354945,12135);
