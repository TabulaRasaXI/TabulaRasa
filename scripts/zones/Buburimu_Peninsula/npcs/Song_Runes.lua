-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Song Runes
--  Finishes Quest: The Old Monument
-- !pos -244 16 -280 118
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
-----------------------------------
local entity = {}

local parchmentID = 917
local poeticParchmentID = 634

entity.onTrade = function(player, npc, trade)
    -- THE OLD MONUMENT (parchment)
    if
        player:getCharVar("TheOldMonument_Event") == 3 and
        trade:hasItemQty(parchmentID, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(2)
    end
end

entity.onTrigger = function(player, npc)
    -- THE OLD MONUMENT
    if player:getCharVar("TheOldMonument_Event") == 2 then
        player:startEvent(0)
    elseif player:getCharVar("TheOldMonument_Event") == 3 then
        player:messageSpecial(ID.text.SONG_RUNES_REQUIRE, 917)

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.SONG_RUNES_DEFAULT)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 0 then
        player:setCharVar("TheOldMonument_Event", 3)
    elseif csid == 2 then
        player:tradeComplete()
        player:messageSpecial(ID.text.SONG_RUNES_WRITING, 917)
        player:addItem(poeticParchmentID, 1)
        player:messageSpecial(ID.text.ITEM_OBTAINED, poeticParchmentID)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_OLD_MONUMENT)
        player:addTitle(xi.title.RESEARCHER_OF_CLASSICS)
        player:addFame(xi.quest.fame_area.BASTOK, 10)
        player:addFame(xi.quest.fame_area.SANDORIA, 10)
        player:addFame(xi.quest.fame_area.WINDURST, 10)
    end
end

return entity
