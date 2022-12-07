-- Move Recipe: Insane Strength Potion from creature to reference loot template
delete from creature_loot_template
where item = 22903;

insert into reference_loot_template
values (24092, 22903, 0, 1, 1, 1, 0, 0, 0);
