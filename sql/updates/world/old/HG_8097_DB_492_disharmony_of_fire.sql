-- Quest/Blackrock Mountain: Fix prequest for Disharmony of Fire
UPDATE `quest_template` SET `PrevQuestId` = 3906 WHERE `entry` = 3907;
