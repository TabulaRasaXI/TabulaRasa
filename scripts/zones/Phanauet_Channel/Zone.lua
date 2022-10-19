-----------------------------------
-- Zone: Phanauet_Channel
-----------------------------------
local ID = require('scripts/zones/Phanauet_Channel/IDs')
require('scripts/globals/conquest')
require("scripts/globals/zone")
require("scripts/globals/barge")
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(-2, 2) + 0.15
        player:setPos(position, -2.000, -1.000, 190)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTransportEvent = function(player, transport)
    player:startEvent(100)
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 100 then
        player:setPos(0, 0, 0, 0, xi.zone.CARPENTERS_LANDING)
    end
end

return zoneObject
