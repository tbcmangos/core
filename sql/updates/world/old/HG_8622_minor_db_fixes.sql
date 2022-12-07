-- rare outland mobs spawn timer to 8hrs
update creature set spawntimesecs = 28800 where id in (17144,18677,18678,18679,18680,18681,18682,18683,18684,18685,18686,18689,18690,18692,18693,18694,18695,18696,18697,18698,20932);
-- fix silvermoon guards
update creature_template set AIName = "guard_silvermoon" where AIName = "npc_silvermoon_guard";
-- remove aggresive imp near trainer
delete from creature_ai_scripts where entryorguid = 6374;