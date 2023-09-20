-----------------------------------
-- Area: Port San d'Oria
--  NPC: Joulet
--  Starts The Competition
-- !pos -18 -2 -45 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.fishingAnimation(npc, 2)
end

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    local moatCarp = trade:getItemQty(4401)
    local forestCarp = trade:getItemQty(4289)
    local fishCountVar = player:getCharVar("theCompetitionFishCountVar")
    local totalFish = moatCarp + forestCarp + fishCountVar

    if moatCarp + forestCarp > 0 and moatCarp + forestCarp == count then
        if
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == QUEST_ACCEPTED and
            totalFish >= 10000
        then
            -- ultimate reward
            player:tradeComplete()
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:addGil((xi.settings.main.GIL_RATE * 10 * moatCarp) + (xi.settings.main.GIL_RATE * 15 * forestCarp))
            player:messageSpecial(ID.text.GIL_OBTAINED, moatCarp * 10 + forestCarp * 15)
            player:startEvent(307)
        elseif player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) >= QUEST_ACCEPTED then -- regular turn-ins. Still allowed after completion of the quest.
            player:tradeComplete()
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:addGil((xi.settings.main.GIL_RATE * 10 * moatCarp) + (xi.settings.main.GIL_RATE * 15 * forestCarp))
            player:setCharVar("theCompetitionFishCountVar", totalFish)
            player:startEvent(305)
            player:messageSpecial(ID.text.GIL_OBTAINED, moatCarp * 10 + forestCarp * 15)
        else
            player:startEvent(306)
        end
    end

    npc:setAnimation(0)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == QUEST_AVAILABLE and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == QUEST_AVAILABLE
    then
        -- If you haven't started either quest yet
        player:startEvent(304, 4401, 4289) -- Moat Carp = 4401, 4289 = Forest Carp
    elseif player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == QUEST_ACCEPTED then
        player:showText(npc, ID.text.JOULET_HELP_OTHER_BROTHER)
    elseif player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == QUEST_ACCEPTED then
        player:showText(npc, ID.text.JOULET_CARP_STATUS, 0, player:getCharVar("theCompetitionFishCountVar"))
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 307 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17386)
        else
            player:tradeComplete()
            player:addItem(17386)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17386)
            player:addTitle(xi.title.CARP_DIEM)
            player:addKeyItem(xi.ki.TESTIMONIAL)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TESTIMONIAL)
            player:setCharVar("theCompetitionFishCountVar", 0)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION)
        end
    elseif csid == 304 and option == 700 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION)
    end
end

return entity
