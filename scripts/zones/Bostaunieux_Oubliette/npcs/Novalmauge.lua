-----------------------------------
-- Area: Bostaunieux Obliette
--  NPC: Novalmauge
-- Starts and Finishes Quest: The Rumor, Souls in Shadow
-- Involved in Quest: The Holy Crest, Trouble at the Sluice
-- !pos 70 -24 21 167
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local path =
{
    {x = 41.169430, y = -24.000000, z = 19.860674},
    {x = 42.256676, y = -24.000000, z = 19.885197},
    {x = 41.168694, y = -24.000000, z = 19.904638},
    {x = 21.859211, y = -24.010996, z = 19.792259},
    {x = 51.917370, y = -23.924366, z = 19.970068},
    {x = 74.570229, y = -24.024828, z = 20.103880},
    {x = 44.533886, y = -23.947662, z = 19.926519},
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
    if player:getCharVar("troubleAtTheSluiceVar") == 2 and npcUtil.tradeHas(trade, 959) then -- Dahlia
        player:startEvent(17)
    elseif player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RUMOR) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 930) then -- Beastman Blood
        player:startEvent(12)
    end
end

entity.onTrigger = function(player, npc)
    local troubleAtTheSluiceStat = player:getCharVar("troubleAtTheSluiceVar")
    local theHolyCrestStat = player:getCharVar("TheHolyCrest_Event")
    local theRumor = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RUMOR)

    -- THE HOLY CREST
    if theHolyCrestStat == 1 then
        player:startEvent(6)
    elseif theHolyCrestStat == 2 and player:getCharVar("theHolyCrestCheck") == 0 then
        player:startEvent(7)

    -- TROUBLE AT THE SLUICE
    elseif troubleAtTheSluiceStat == 1 then
        player:startEvent(15)
    elseif troubleAtTheSluiceStat == 2 then
        player:startEvent(16)

    -- THE RUMOR
    elseif theRumor == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3 and player:getMainLvl() >= 10 then
        player:startEvent(13)
    elseif theRumor == QUEST_ACCEPTED then
        player:startEvent(11)
    elseif theRumor == QUEST_COMPLETED then
        player:startEvent(14) -- Standard dialog after "The Rumor"
    else
        player:startEvent(10) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 6 then
        player:setCharVar("TheHolyCrest_Event", 2)
    elseif csid == 7 then
        player:setCharVar("theHolyCrestCheck", 1)
    elseif csid == 12 and npcUtil.completeQuest(player, xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RUMOR, {item = 4853}) then
        player:confirmTrade()
    elseif csid == 13 and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RUMOR)
    elseif csid == 14 then
        player:setCharVar("theHolyCrestCheck", 0)
    elseif csid == 15 then
        player:setCharVar("troubleAtTheSluiceVar", 2)
    elseif csid == 17 then
        npcUtil.giveKeyItem(player, xi.ki.NEUTRALIZER)
        player:setCharVar("troubleAtTheSluiceVar", 0)
        player:setCharVar("theHolyCrestCheck", 0)
        player:confirmTrade()
    end
end

return entity
