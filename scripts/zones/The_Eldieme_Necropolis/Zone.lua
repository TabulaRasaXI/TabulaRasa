-----------------------------------
-- Zone: The Eldieme Necropolis (195)
-----------------------------------
local ID = require('scripts/zones/The_Eldieme_Necropolis/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.treasure.initZone(zone)

    -- NM Persistance
    xi.mob.nmTODPersistCache(zone, ID.mob.ANEMONE_ONE)
    xi.mob.nmTODPersistCache(zone, ID.mob.ANEMONE_TWO)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- RNG AF2
    if player:getCharVar("fireAndBrimstone") == 2 then
        cs = 4
    end

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-438.878, -26.091, 540.004, 126)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 4 then
        player:setCharVar("fireAndBrimstone", 3)
    end
end

return zoneObject
