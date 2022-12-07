-- MGT/Kael'thas Sunstrider: Show loot recipes only to crafters

-- enchanting 333
update creature_loot_template
set lootcondition = 7, condition_value1 = 333, condition_value2 = 1
where entry = 24857 and item in (35298, 35299, 35297);

-- jewelcrafting 755
update creature_loot_template
set lootcondition = 7, condition_value1 = 755, condition_value2 = 1
where entry = 24857 and item in (35304, 35305, 35306, 35307);

-- tailoring 197
update creature_loot_template
set lootcondition = 7, condition_value1 = 197, condition_value2 = 1
where entry = 24857 and item = 35308;

-- engineering 202
update creature_loot_template
set lootcondition = 7, condition_value1 = 202, condition_value2 = 1
where entry = 24857 and item in (35310, 35311);

-- alchemy 171
update creature_loot_template
set lootcondition = 7, condition_value1 = 171, condition_value2 = 1
where entry = 24857 and item in (35295, 35294);

-- blacksmithing 164
update creature_loot_template
set lootcondition = 7, condition_value1 = 164, condition_value2 = 1
where entry = 24857 and item = 35296;
