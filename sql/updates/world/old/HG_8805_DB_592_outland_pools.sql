-- cleanup random mineral pools on IOQD
delete from pool_template where entry in (4870,4871,4872,4873,4874,4875);
delete from gameobject where guid in
(54674,62132,62133,62135,62137,62138,62140,62141,62142,62143,62146,62147);
-- create outland mineral pools by vein type
insert into pool_template values
(4870,150,"MASTER 530 fel iron"), -- 150 of 436
(4871,100,"MASTER 530 adamantite"), -- 100 of 281
(4872,20,"MASTER 530 rich adamantite"), -- 20 of 58
(4873,14,"MASTER 530 khorium"); -- 14 of 31
insert into pool_gameobject (select guid,"4870","0","fel iron map 530" from gameobject where id = 181555 and map = 530);
insert into pool_gameobject (select guid,"4871","0","adamantite map 530" from gameobject where id = 181556 and map = 530);
insert into pool_gameobject (select guid,"4872","0","rich adamantite map 530" from gameobject where id = 181569 and map = 530);
insert into pool_gameobject (select guid,"4872","0","rich adamantite map 530" from gameobject where id = 181570 and map = 530);
insert into pool_gameobject (select guid,"4873","0","khorium map 530" from gameobject where id = 181557 and map = 530);

-- lower 530 vein respawn time to 25 mins
update gameobject set spawntimesecs = 1500 where guid in (select guid from pool_gameobject where pool_entry in (4870,4871,4872,4873));
-- lower 530 herbs respawn time to 25 mins
update gameobject set spawntimesecs = 1500 where guid in (select guid from pool_gameobject where pool_entry in (972,973,974,975,976,977,978));