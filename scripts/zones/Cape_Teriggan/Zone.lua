-----------------------------------
-- Zone: Cape_Teriggan (113)
-----------------------------------
local ID = require('scripts/zones/Cape_Teriggan/IDs')
-----------------------------------
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/conquest')
require('scripts/globals/world')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.KREUTZET)

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(315.644, -1.517, -60.633, 108)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    return cs
end

zoneObject.onZoneOut = function(player)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        player:delStatusEffect(xi.effect.BATTLEFIELD)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onZoneWeatherChange = function(weather)
    local kreutzet = GetMobByID(ID.mob.KREUTZET)

    if
        not kreutzet:isSpawned() and
        os.time() > GetServerVariable("\\[SPAWN\\]"..ID.mob.KREUTZET) and
        (weather == xi.weather.WIND or weather == xi.weather.GALES)
    then
        DisallowRespawn(kreutzet:getID(), false)
        kreutzet:setRespawnTime(math.random(30, 150)) -- pop 30-150 sec after wind weather starts
    end
end

return zoneObject
