-- Arcatraz: Set proper script for Negaton Screamer
update `creature_template`
set `scriptname` = 'npc_negaton_screamer'
where `entry` in (20875, 21604);
