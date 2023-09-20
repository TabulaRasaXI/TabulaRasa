-----------------------------------
-- Zone: Tavnazian_Safehold (26)
-----------------------------------
local ID = require('scripts/zones/Tavnazian_Safehold/IDs')
require('scripts/globals/conquest')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NOTE: On Retail, Trigger Area 1 appears to be a cylindrical area (no Z-axis) that is quite large.  Managed to trigger
    -- it on the top floor while moving up the ramp from homepoint.
    zone:registerTriggerArea(1, -5, -24, 18, 5, -20, 27)
    zone:registerTriggerArea(2, 104, -42, -88, 113, -38, -77)
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
        player:setPos(27.971, -14.068, 43.735, 66)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
