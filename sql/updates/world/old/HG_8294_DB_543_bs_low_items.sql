-- Blacksmithing: Fix quality of some low-skill items
update `item_template` set `Quality` = 1, `DisenchantID` = 0 where `entry` in (3480,2857,3472);
