-- Underbog/Underbat: Fix Tentacle Lash target
update creature_ai_scripts set action1_param2 = 1 where id in (1772401, 1772402);
