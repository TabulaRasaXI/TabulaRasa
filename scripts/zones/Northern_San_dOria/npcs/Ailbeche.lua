-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ailbeche
-- Starts and Finishes Quest: Father and Son, Sharpening the Sword, A Boy's Dream (start)
-- !pos 4 -1 24 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/events/starlight_celebrations")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc) then
            return
        end
    end

    if player:getCharVar("aBoysDreamCS") >= 3 then
        if
            npcUtil.tradeHasExactly(trade, xi.items.GIANT_SHELL_BUG) and
            player:getCharVar("aBoysDreamCS") == 3
        then
            player:startEvent(15) -- During Quest "A Boy's Dream" (trading bug) madame ?
        elseif
            npcUtil.tradeHasExactly(trade, xi.items.ODONTOTYRANNUS) and
            player:getCharVar("aBoysDreamCS") == 4
        then
            player:startEvent(47) -- During Quest "A Boy's Dream" (trading odontotyrannus)
        end
    end
end

entity.onTrigger = function(player, npc)
    local fatherAndSon = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON)
    local sharpeningTheSword = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD)
    local aBoysDream = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_BOY_S_DREAM)

    -- Checking levels and jobs for af quest
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()
    -- Check if they have key item "Ordelle whetStone"
    local hasOrdelleWhetstone = player:hasKeyItem(xi.ki.ORDELLE_WHETSTONE)
    local sharpeningTheSwordCS = player:getCharVar("sharpeningTheSwordCS")
    local aBoysDreamCS = player:getCharVar("aBoysDreamCS")

    -- Additional Dialog after completing "Father and Son", but is not displayed from prior conditions:
    -- CSID: 12
    if
        sharpeningTheSword == QUEST_AVAILABLE and
        fatherAndSon == QUEST_COMPLETED and
        player:getCharVar("Quest[0][4]Prog") == 0
    then
    -- "Sharpening the Sword" Quest Dialogs
        if mJob == xi.job.PLD and mLvl >= 40 and sharpeningTheSwordCS == 0 then
            player:startEvent(45) -- Start Quest "Sharpening the Sword" with thank you for the rod
        elseif mJob == xi.job.PLD and mLvl >= 40 and sharpeningTheSwordCS == 1 then
            player:startEvent(43) -- Start Quest "Sharpening the Sword"
        end
    elseif sharpeningTheSword == QUEST_ACCEPTED and not hasOrdelleWhetstone then
        player:startEvent(42) -- During Quest "Sharpening the Sword"
    elseif sharpeningTheSword == QUEST_ACCEPTED and hasOrdelleWhetstone then
        player:startEvent(44) -- Finish Quest "Sharpening the Sword"
    -- "A Boy's Dream" Quest Dialogs
    elseif aBoysDream == QUEST_AVAILABLE and mJob == xi.job.PLD and mLvl >= 50 and player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD) == QUEST_COMPLETED then
        if aBoysDreamCS == 0 then
            player:startEvent(41) -- Start Quest "A Boy's Dream" (long cs)
        else
            player:startEvent(40) -- Start Quest "A Boy's Dream" (shot cs)
        end
    elseif aBoysDreamCS == 2 then
        player:startEvent(46) -- During Quest "A Boy's Dream"
    elseif aBoysDreamCS == 3 then
        player:startEvent(39) -- During Quest "A Boy's Dream" (after exoroche cs)
    elseif aBoysDreamCS == 4 then
        player:startEvent(60) -- During Quest "A Boy's Dream" (after trading bug) madame ?
    elseif aBoysDreamCS == 5 then
        player:startEvent(47) -- During Quest "A Boy's Dream" (after trading odontotyrannus)
    elseif aBoysDreamCS >= 6 then
        player:startEvent(25) -- During Quest "A Boy's Dream" (after Zaldon CS)
    elseif
        player:hasKeyItem(xi.ki.KNIGHTS_CONFESSION) and
        player:getCharVar("UnderOathCS") == 6
    then
        player:startEvent(59) -- During Quest "Under Oath" (he's going fishing in Jugner)
    elseif player:getCharVar("UnderOathCS") == 8 then
        player:startEvent(13) -- During Quest "Under Oath" (After jugner CS)
    else
        player:startEvent(868) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- "Sharpening the Sword"
    if (csid == 45 or csid == 43) and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD)
        player:setCharVar("sharpeningTheSwordCS", 2)
        player:setCharVar("returnedAilbecheRod", 0)
    elseif csid == 45 and option == 0 then
        player:setCharVar("sharpeningTheSwordCS", 1)
    elseif csid == 44 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17643)
        else
            player:delKeyItem(xi.ki.ORDELLE_WHETSTONE)
            player:addItem(17643)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17643) -- Honor Sword
            player:setCharVar("sharpeningTheSwordCS", 0)
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD)
        end
    -- "A Boy's Dream"
    elseif (csid == 41 or csid == 40) and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_BOY_S_DREAM)
        player:setCharVar("aBoysDreamCS", 2)
    elseif csid == 41 and option == 0 then
        player:setCharVar("aBoysDreamCS", 1)
    elseif csid == 15 and player:getCharVar("aBoysDreamCS") == 3 then
        player:setCharVar("aBoysDreamCS", 4)
    elseif csid == 47 and player:getCharVar("aBoysDreamCS") == 4 then
        player:setCharVar("aBoysDreamCS", 5)
    elseif csid == 25 and player:getCharVar("aBoysDreamCS") == 6 then
        player:setCharVar("aBoysDreamCS", 7)
    elseif csid == 59 then
        player:setCharVar("UnderOathCS", 7)
    end
end

return entity
