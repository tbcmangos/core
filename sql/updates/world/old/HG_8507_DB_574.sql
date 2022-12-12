-- #000495 obsidian shard/chunks
delete from  gameobject_loot_template where entry in (17883,17884);
insert into gameobject_loot_template values
(17883,7076,3.8,1,1,1,0,0,0),(17883,12363,0.8,1,1,1,0,0,0),(17883,12364,0.8,1,1,1,0,0,0),
(17883,12800,0.8,1,1,1,0,0,0),(17883,22202,90,1,1,1,0,0,0),(17883,22203,3.8,1,1,1,0,0,0),
(17884,7076,8,1,1,1,0,0,0),(17884,12363,2,1,1,1,0,0,0),(17884,12364,2,1,1,1,0,0,0),
(17884,12800,2,1,1,1,0,0,0),(17884,22202,48,1,2,3,0,0,0),(17884,22203,38,1,1,1,0,0,0);

update creature_template set AiName = "EventAI" where entry in (15338,15355);

insert into creature_ai_scripts values
(1526205,15262,6,0,30,2,0,0,0,0,104,181069,0,0,0,0,0,0,0,0,0,0, "Obisdian Eradicator - spawn shard at death"),
(1527713,15277,6,0,100,2,0,0,0,0,104,181069,0,0,0,0,0,0,0,0,0,0, "Anubisath Defender - spawn shard at death"),
(1533801,15338,6,0,75,2,0,0,0,0,104,181068,0,0,0,0,0,0,0,0,0,0, "Obisdian Destroyer - spawn shard at death"),
(1535501,15355,6,0,75,2,0,0,0,0,104,181068,0,0,0,0,0,0,0,0,0,0, "Anubisath Guardian - spawn shard at death");