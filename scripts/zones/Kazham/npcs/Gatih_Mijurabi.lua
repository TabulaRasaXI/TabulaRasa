-----------------------------------
-- Area: Kazham
--  NPC: Gatih Mijurabi
-- Type: Standard NPC
-- !pos 58.249 -13.086 -49.084 250
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("BathedInScent") == 1 then
        if player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE) == QUEST_AVAILABLE then
            player:startEvent(191)
        elseif player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE) == QUEST_ACCEPTED then
            player:startEvent(192)
        else
            player:startEvent(195)
        end
    elseif
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE) == QUEST_ACCEPTED and
        player:getCharVar("BathedInScent") == 0
    then
        player:startEvent(193)
    else
        player:startEvent(196)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 191 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE)
    elseif csid == 193 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13247)
        else
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE)
            player:addItem(13247) -- Mithran Stone
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13247)
        end
    end
end

return entity
