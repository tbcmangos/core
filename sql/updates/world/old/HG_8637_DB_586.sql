-- Darkspine siren & dawnblade summoner AI
update creature_ai_scripts set event_inverse_phase_mask = 6 where entryOrGUID in (25073,24978) and event_inverse_phase_mask = 13;
update creature_ai_scripts set event_inverse_phase_mask = 5 where entryOrGUID in (25073,24978) and event_inverse_phase_mask = 11;
update creature_ai_scripts set event_inverse_phase_mask = 3 where entryOrGUID in (25073,24978) and event_inverse_phase_mask = 7;

-- Nethergarde Infantry should not be attackable by alliance
update creature_template set unit_flags = 4096 where entry = 16831;

--  #000372 npc should be spawned by script only
delete from creature where id = 15958;
