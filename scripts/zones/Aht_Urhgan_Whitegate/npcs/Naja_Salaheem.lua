-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Naja Salaheem
-- Type: Standard NPC
-- !pos 22.700 -8.804 -45.591 50
-----------------------------------
-- NOTE

-- Naja Salaheem interactions require the 9th argument in events set to 0.
-- This is because Aht Uhrgan Whitegate uses 2 different dats.
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/npc_util")
-----------------------------------
local whitegateShared = require("scripts/zones/Aht_Urhgan_Whitegate/Shared")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local needToZone = player:needToZone()

    if (player:getCurrentMission(TOAU) == xi.mission.id.toau.GUESTS_OF_THE_EMPIRE) then
        if (whitegateShared.doRoyalPalaceArmorCheck(player) == true) then
            if (player:getCharVar("AhtUrganStatus") == 0) then
                player:startEvent(3076, 1, 0, 0, 0, 0, 0, 0, 1, 0)
            else
                player:startEvent(3077, 1, 0, 0, 0, 0, 0, 0, 1, 0)
            end
        else
            if (player:getCharVar("AhtUrganStatus") == 0) then
                player:startEvent(3076, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            else
                player:startEvent(3077, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            end
        end
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.PASSING_GLORY and player:getCharVar("TOAUM18_STARTDAY") ~= VanadielDayOfTheYear() and needToZone == false) then
        player:startEvent(3090, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.IN_THE_BLOOD) then
        player:startEvent(3113, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.SENTINELS_HONOR) then
        if(player:getCharVar("TOAUM18_STARTDAY") ~= VanadielDayOfTheYear() and needToZone == false) then
            player:startEvent(3130, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        else
            player:startEvent(3120, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        end
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.FANGS_OF_THE_LION) then
        player:startEvent(3138, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and player:hasKeyItem(xi.ki.MYTHRIL_MIRROR) == false) then
        player:startEvent(3149, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.RAGNAROK) then
        player:startEvent(3139, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.IMPERIAL_CORONATION) then
        player:startEvent(3150, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.THE_EMPRESS_CROWNED) then
        player:startEvent(3144, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.ETERNAL_MERCENARY) then
        player:startEvent(3154, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        player:startEvent(3003, 1, 0, 0, 0, 0, 0, 0, 1, 0) -- go back to work

        -- player:messageSpecial(0)--  need to find correct normal chat CS..
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 3074) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.GHOSTS_OF_THE_PAST)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.GUESTS_OF_THE_EMPIRE)

        if(option == 2) then
            player:setCharVar("AhtUrganStatus", 1)
        end
    elseif (csid == 3090) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.PASSING_GLORY)
        player:setCharVar("TOAUM18_STARTDAY", 0)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.SWEETS_FOR_THE_SOUL)
    elseif (csid == 3113) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IN_THE_BLOOD)
        player:setCharVar("TOAUM33_STARTDAY", VanadielDayOfTheYear())
        player:needToZone(true)
        player:addItem(2187)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 2187)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.SENTINELS_HONOR)
    elseif (csid == 3130) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.SENTINELS_HONOR)
        player:setCharVar("TOAUM33_STARTDAY", 0)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.TESTING_THE_WATERS)
    elseif (csid == 3138) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.FANGS_OF_THE_LION)
        player:addKeyItem(xi.ki.MYTHRIL_MIRROR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MYTHRIL_MIRROR)
        player:setTitle(xi.title.NASHMEIRAS_LOYALIST)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.NASHMEIRAS_PLEA)
    elseif (csid == 3139) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.RAGNAROK)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IMPERIAL_CORONATION)
    elseif (csid == 3144) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_EMPRESS_CROWNED)
        player:addItem(16070)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 16070)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ETERNAL_MERCENARY)
    elseif (csid == 3149) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MYTHRIL_MIRROR)
        player:addKeyItem(xi.ki.MYTHRIL_MIRROR)
    elseif (csid == 3076 and option == 0) then
        player:setCharVar("AhtUrganStatus", 1)
    end
end

return entity
