-----------------------------------
-- Area: Heaven's Tower
--  NPC: Vestal Chamber (chamber of the Star Sibyl)
-- !pos 0.1 -49 37 242
-----------------------------------
local ID = require("scripts/zones/Heavens_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(WINDURST)
    local missionStatus = player:getMissionStatus(player:getNation())

    if currentMission == xi.mission.id.windurst.A_NEW_JOURNEY and missionStatus == 0 then
        player:startEvent(153)
    elseif currentMission == xi.mission.id.windurst.DOLL_OF_THE_DEAD and missionStatus == 2 then
        player:startEvent(362)
    elseif currentMission == xi.mission.id.windurst.MOON_READING and missionStatus == 0 then
        player:startEvent(384)
    elseif
        currentMission == xi.mission.id.windurst.MOON_READING and
        missionStatus == 1 and
        player:hasKeyItem(xi.ki.ANCIENT_VERSE_OF_ROMAEVE) and
        player:hasKeyItem(xi.ki.ANCIENT_VERSE_OF_ALTEPA) and player:hasKeyItem(xi.ki.ANCIENT_VERSE_OF_UGGALEPIH)
    then
        player:startEvent(385)
    elseif currentMission == xi.mission.id.windurst.MOON_READING and missionStatus == 3 then
        player:startEvent(386)
    elseif currentMission == xi.mission.id.windurst.MOON_READING and missionStatus == 4 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 183)
        else
            player:startEvent(407)
        end
    else
        player:startEvent(154)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 153 then
        player:setMissionStatus(player:getNation(), 1)
        player:delKeyItem(xi.ki.STAR_CRESTED_SUMMONS_1)
        player:addKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_TO_THE_AMBASSADOR)
    elseif csid == 362 then
        player:setMissionStatus(player:getNation(), 3)
    elseif csid == 384 then
        player:setMissionStatus(player:getNation(), 1)
    elseif csid == 385 then
        player:setMissionStatus(player:getNation(), 2)
    elseif csid == 386 then
        player:setMissionStatus(player:getNation(), 4)
    elseif csid == 407 then
        player:setPos(0, -16.750, 130, 64, 239)
    end
end

return entity
