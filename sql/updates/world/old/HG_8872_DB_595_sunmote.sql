-- 10%
-- Sunblade Protector
update creature_loot_template
set chanceorquestchance = 10
where item = 34664 and entry = 25595;

-- 20%
-- Sathrovarr
-- Brutallus
-- Felmyst
update creature_loot_template
set chanceorquestchance = 20
where item = 34664 and entry in (24882, 24892, 25038);

-- 30%
-- Entropius
update creature_loot_template
set chanceorquestchance = 30
where item = 34664 and entry = 25840;
