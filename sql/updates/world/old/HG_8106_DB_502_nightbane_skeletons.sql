-- Karazhan/Nightbane: Remove reputation award from Restless Skeletons
delete from creature_onkill_reputation where creature_id = 17261;
