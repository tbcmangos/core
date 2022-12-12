-- Desperate Prayer or Starshards should not be affected by inner focus
update spell_affect set `SpellFamilyMask` = `SpellFamilyMask` - 0x01200000 where `entry` = 14751;