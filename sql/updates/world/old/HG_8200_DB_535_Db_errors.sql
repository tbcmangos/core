-- some fixes (4603 lines of errors before this)
update item_template set BuyCount = 1 where entry = 66666;
update item_template set Quality = 6 where entry = 99966;
update creature set curhealth = 11650 where id in( 5595,68,3296,3084,5624,4262,16733);
update creature set curhealth = 2500 where id = 4293;
update creature set curmana = 8995 where id = 23101;
update creature set curhealth = 12000 where id = 25851;
update creature_template set minhealth= 345586 where entry = 25593;
update creature set curhealth= 345586 where id =25593;
update creature set curhealth= 14000 where id= 17855;
update creature set spawndist= 0 where id = 18797;
update creature set curhealth= 21543 where id=23076;

delete from creature_loot_template where entry not in (select entry from creature_template);