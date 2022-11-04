-----------------------------------
-- Zone: Silver_Sea_route_to_Al_Zahbi
-----------------------------------
local ID = require('scripts/zones/Silver_Sea_route_to_Al_Zahbi/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    return cs
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onTransportEvent = function(player, transport)
    player:startEvent(1025)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 1025 then
        player:setPos(0, 0, 0, 0, 50)
    end
end

return zoneObject
