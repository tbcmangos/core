-- add spells procs for freshly hacked-in spells
INSERT INTO `spell_proc_event` VALUES
(45398,0,0,0,340,0,0,50,40),
(45396,0,0,0,65536,0,0,0,45);

-- extra: revisited alchemy specs
DELETE FROM `skill_extra_item_template` WHERE `spellId` = 11446; -- mind control
INSERT INTO `skill_extra_item_template` VALUES
-- potion majster
(2330,28675,14,4),
(17527,28675,14,4),
(17553,28675,14,4),
(17556,28675,14,4),
(17579,28675,14,4),
-- elixir majster
(11447,28677,14,4);

