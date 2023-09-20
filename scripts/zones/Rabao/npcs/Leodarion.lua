-----------------------------------
-- Area: Rabao
--  NPC: Leodarion
-- Involved in Quest: 20 in Pirate Years, I'll Take the Big Box, True Will
-- !pos -50 8 40 247
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/shop")
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX) == QUEST_ACCEPTED and
        player:getCharVar("illTakeTheBigBoxCS") == 2
    then
        if trade:hasItemQty(17098, 1) and trade:getItemCount() == 1 then -- Trade Oak Pole
            player:startEvent(92)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX) == QUEST_ACCEPTED then
        local illTakeTheBigBoxCS = player:getCharVar("illTakeTheBigBoxCS")

        if illTakeTheBigBoxCS == 1 then
            player:startEvent(90)
        elseif illTakeTheBigBoxCS == 2 then
            player:startEvent(91)
        elseif
            illTakeTheBigBoxCS == 3 and
            VanadielDayOfTheYear() == player:getCharVar("illTakeTheBigBox_Timer")
        then
            player:startEvent(93)
        elseif illTakeTheBigBoxCS == 3 then
            player:startEvent(94)
        elseif illTakeTheBigBoxCS == 4 then
            player:startEvent(95)
        end
    elseif player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRUE_WILL) == QUEST_ACCEPTED then
        local trueWillCS = player:getCharVar("trueWillCS")

        if trueWillCS == 1 then
            player:startEvent(97)
        elseif trueWillCS == 2 and not player:hasKeyItem(xi.ki.LARGE_TRICK_BOX) then
            player:startEvent(98)
        elseif player:hasKeyItem(xi.ki.LARGE_TRICK_BOX) then
            player:startEvent(99)
        end
    else
        player:startEvent(89)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 90 then
        player:setCharVar("illTakeTheBigBoxCS", 2)
    elseif csid == 92 then
        player:tradeComplete()
        player:setCharVar("illTakeTheBigBox_Timer", VanadielDayOfTheYear())
        player:setCharVar("illTakeTheBigBoxCS", 3)
    elseif csid == 94 then
        player:setCharVar("illTakeTheBigBox_Timer", 0)
        player:setCharVar("illTakeTheBigBoxCS", 4)
        player:addKeyItem(xi.ki.SEANCE_STAFF)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEANCE_STAFF)
    elseif csid == 97 then
        player:delKeyItem(xi.ki.OLD_TRICK_BOX)
        player:setCharVar("trueWillCS", 2)
    elseif csid == 99 then
        if
            npcUtil.completeQuest(player, xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRUE_WILL, {
                item = 13782, -- Ninja Chainmail
                fameArea = xi.quest.fame_area.NORG,
                title = xi.title.PARAGON_OF_NINJA_EXCELLENCE,
                var = "trueWillCS"
            })
        then
            player:delKeyItem(xi.ki.LARGE_TRICK_BOX)
        end
    end
end

return entity
