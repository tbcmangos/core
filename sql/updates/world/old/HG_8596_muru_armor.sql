-- Sunwell Plateau/M'uru: Adjust armor values

set @Muru := 25741;
set @FuryMage := 25799;
set @Berserker := 25798;
set @VoidSentinel := 25772;

update `creature_template` set `armor` = 7700 where `entry` = @Muru;
update `creature_template` set `armor` = 5700 where `entry` = @FuryMage;
update `creature_template` set `armor` = 7100 where `entry` = @Berserker;
update `creature_template` set `armor` = 6800 where `entry` = @VoidSentinel;
