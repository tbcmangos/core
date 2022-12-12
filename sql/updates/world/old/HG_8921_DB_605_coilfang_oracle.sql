-- Steamvault: Show [Formula: Enchant Bracer - Fortitude] only to enchanters and adjust drop rate
update creature_loot_template
set lootcondition = 7, condition_value1 = 333, condition_value2 = 1, chanceorquestchance = 2
where entry = 20622 and item = 22533;
