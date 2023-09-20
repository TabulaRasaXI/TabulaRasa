-----------------------------------
-- Area: Port Jeuno
--  NPC: Karl
-- Starts and Finishes Quest: Child's Play
-- !pos -60 0.1 -8 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHILD_S_PLAY) == QUEST_ACCEPTED and
        trade:hasItemQty(776, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(1) -- Finish quest
    end
end

entity.onTrigger = function(player, npc)
    local childsPlay = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHILD_S_PLAY)
    local wildcatJeuno = player:getCharVar("WildcatJeuno")

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatJeuno, 16)
    then
        player:startEvent(316)

    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_WONDER_MAGIC_SET) == QUEST_ACCEPTED and
        childsPlay == QUEST_AVAILABLE
    then
        player:startEvent(0) -- Start quest

    elseif childsPlay == QUEST_ACCEPTED then
        player:startEvent(61) -- mid quest CS

    else
        player:startEvent(58) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 0 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHILD_S_PLAY)
    elseif csid == 1 then
        player:addTitle(xi.title.TRADER_OF_MYSTERIES)
        player:addKeyItem(xi.ki.WONDER_MAGIC_SET)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WONDER_MAGIC_SET)
        player:addFame(xi.quest.fame_area.JEUNO, 30)
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHILD_S_PLAY)
    elseif csid == 316 then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 16, true))
    end
end

return entity
