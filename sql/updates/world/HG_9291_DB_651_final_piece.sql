-- book from high chief winterfall should drop after previous quest is done, not the next
update creature_loot_template set condition_value1 = 5087 where entry = 10738 and item = 12842;