-- http://wowhead.com/npc=19294 This npc aggro on Fel Reaver when he walks near her. This should prevent that.
UPDATE `creature_template` SET `unit_flags`='4098' WHERE (`entry`='19294');