-----------------------------------
-- Zone: Aht_Urhgan_Whitegate (50)
-----------------------------------
local ID = require('scripts/zones/Aht_Urhgan_Whitegate/IDs')
require('scripts/globals/keyitems')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1,   57, -1.0,  -70,   62,  1.0,  -65) -- Sets Mark for "Got It All" Quest cutscene.
    zone:registerTriggerArea(2,  -96, -7.0,  121,  -64, -5.0,  137) -- Sets Mark for "Vanishing Act" Quest cutscene.
    zone:registerTriggerArea(3,   20, -7.2,  -51,   39, -7.2,  -40) -- ToAU Mission 1, X region. Salaheem's Sentinels, second platform.
    zone:registerTriggerArea(4,   68, -1.0,   30,   91,  1.0,   53) -- ToAU Mission 4 region. Walahra Temple.
    zone:registerTriggerArea(5,   64, -7.0, -137,   95, -5.0, -123) -- ToAU Mission 4 region. Shaharat Teahouse.
    zone:registerTriggerArea(6,   30, -6.6,  -60,   39, -6.6,  -50) -- ToAU Mission 11 region. Salaheem's Sentinels, first platform.
    zone:registerTriggerArea(7,   69,  0.0,    7,   73,  0.0,   11) -- Sets Mark for "Led Astry" Quest cutscene.
    zone:registerTriggerArea(8,   10,  2.0,  -96,   14,  2.0,  -92) -- Sets Mark for "Led Astry" Quest cutscene.
    zone:registerTriggerArea(9, -103,  0.0,  -16, -100,  0.0,  -12) -- Sets Mark for "Striking a Balance" Quest cutscene.
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI then
            cs = 201
        elseif prevZone == xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI then
            cs = 204
        elseif prevZone == xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU then
            cs = 204
        else
            -- MOG HOUSE EXIT
            local position = math.random(1, 5) - 83
            player:setPos(-100, 0, position, 0)
        end
    end

    xi.moghouse.exitJobChange(player, prevZone)

    return cs
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket("1pb1")
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function()  -- Cutscene for Got It All quest.
            if player:getCharVar("gotitallCS") == 5 then
                player:startEvent(526)
            end
        end,

        [2] = function() -- CS for Vanishing Act Quest
            if player:getCharVar("vanishingactCS") == 3 then
                player:startEvent(44)
            end
        end,

        [5] = function() -- AH mission
            if
                player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_COMPLETED and
                player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.COR and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL
            then
                player:startEvent(797)
            end
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, transport)
    if transport == 46 or transport == 47 then
        player:startEvent(200)
    elseif transport == 58 or transport == 59 then
        player:startEvent(203)
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 44 then
        player:setCharVar("vanishingactCS", 4)
        player:setPos(-80, -6, 122, 5)
    elseif csid == 200 then
        player:setPos(0, -2, 0, 0, 47)
    elseif csid == 201 then
        player:setPos(-11, 2, -142, 192)
    elseif csid == 203 then
        player:setPos(0, -2, 0, 0, 58)
    elseif csid == 204 then
        player:setPos(11, 2, 142, 64)
    elseif csid == 526 then
        player:setCharVar("gotitallCS", 6)
        player:setPos(60, 0, -71, 38)
    elseif csid == 797 then
        player:setCharVar("AgainstAllOdds", 1) -- Set For Corsair BCNM
        player:addQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) -- Start of af 3 not completed yet
        player:addKeyItem(xi.ki.LIFE_FLOAT) -- BCNM KEY ITEM TO ENTER BCNM
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIFE_FLOAT)
        player:setCharVar("AgainstAllOddsTimer", getMidnight())
    end

    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

return zoneObject
