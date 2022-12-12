-- Mana Tombs/Escort: Text and emote cleanup

update script_texts set content_default = 'Hrm, now where is the next collector?' where entry = -1900241;
update script_texts set content_default = 'He was right, you know. I''ll have to take that tag-line for my own... It''s not like he''ll have a use for it anymore!' where entry = -1900251;

delete from script_texts where entry in (-1966601, -1966602);
insert into script_texts values
(-1966601, 'checks to make sure his body is intact.', null, null, null, null, null, null, null, null, 0, 2, 0, 0, '19666'),
(-1966602, 'expertly manipulates the control panel.', null, null, null, null, null, null, null, null, 0, 2, 0, 0, '19666');

delete from creature_ai_scripts where entryorguid = 19666;
insert into creature_ai_scripts values
(1966601,19666,11,0,100,6,0,0,0,0,1,-815,0,0,0,0,0,0,0,0,0,0,'Shadow Lord Xiraxis - Yell on Spawn'),
(1966602,19666,4,0,100,6,0,0,0,0,1,-816,0,0,0,0,0,0,0,0,0,0,'Shadow Lord Xiraxis - Say on Aggro');

delete from creature_ai_texts where entry = -815;
insert into creature_ai_texts values (-815, 'Bravo! Bravo! Good show... I couldn''t convince you to work for me, could I? No, I suppose the needless slaughter of my employees might negatively impact your employment application.', null, null, null, null, null, null, null, null, 0, 1, 0, 0, 19666);
update creature_ai_texts set content_default = 'Never underestimate the other ethereal''s greed!' where entry = -816;
