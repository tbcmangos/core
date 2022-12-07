ALTER TABLE `gm_tickets` ADD COLUMN `response` TEXT NOT NULL AFTER `comment`; 
-- ALTER TABLE `ticket_history` ADD COLUMN `response` TEXT NOT NULL AFTER `comment`; 
-- if you use ticket history trigger - update ticket history table too :)