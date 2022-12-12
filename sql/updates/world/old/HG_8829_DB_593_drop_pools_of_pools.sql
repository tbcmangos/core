-- remove template data about child pools
delete from pool_template where entry >= 3000 and entry < 4870;
delete from pool_template where entry >= 4880 and entry < 5000;
-- remove template data about mother pool
delete from pool_template where entry = 2017;
-- move objects from child pools to mother pools
update pool_gameobject set pool_entry =2000,chance = 0 where pool_entry >= 3000 and pool_entry< 3082; -- alterac
update pool_gameobject set pool_entry =2001,chance = 0 where pool_entry >= 3082 and pool_entry< 3200; -- alterac
update pool_gameobject set pool_entry =2002,chance = 0 where pool_entry >= 3200 and pool_entry< 3494; -- arathi
update pool_gameobject set pool_entry =2003,chance = 0 where pool_entry >= 3494 and pool_entry< 3600; -- arathi
update pool_gameobject set pool_entry =2004,chance = 0 where pool_entry >= 3600 and pool_entry< 3900; -- badlands
update pool_gameobject set pool_entry =2005,chance = 0 where pool_entry >= 3900 and pool_entry< 4010; -- blasted lands
update pool_gameobject set pool_entry =2006,chance = 0 where pool_entry >= 4010 and pool_entry< 4100; -- blasted lands
update pool_gameobject set pool_entry =2007,chance = 0 where pool_entry >= 4100 and pool_entry< 4400; -- burning steppes
update pool_gameobject set pool_entry =2009,chance = 0 where pool_entry >= 4400 and pool_entry< 4600; -- duskwood
update pool_gameobject set pool_entry =2010,chance = 0 where pool_entry >= 4600 and pool_entry< 4700; -- eastern plaguelands
update pool_gameobject set pool_entry =2013,chance = 0 where pool_entry >= 4700 and pool_entry< 4750; -- ghostlands
update pool_gameobject set pool_entry =2014,chance = 0 where pool_entry >= 4750 and pool_entry< 4819; -- hillsbrad foothills
update pool_gameobject set pool_entry =2015,chance = 0 where pool_entry >= 4819 and pool_entry< 4870; -- hillsbrad foothills
update pool_gameobject set pool_entry =2018,chance = 0 where pool_entry >= 4880 and pool_entry< 5000; -- loch modan

drop table pool_pool; -- hue
drop table pool_creature; -- also hue