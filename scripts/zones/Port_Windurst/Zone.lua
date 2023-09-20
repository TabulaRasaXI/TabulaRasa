-----------------------------------
-- Zone: Port_Windurst (240)
-----------------------------------
local ID = require('scripts/zones/Port_Windurst/IDs')
require('scripts/globals/events/starlight_celebrations')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/settings')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
    xi.events.starlightCelebration.applyStarlightDecorations(zone:getID())
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.WINDURST_JEUNO_AIRSHIP then
            cs = { 10004 }
            player:setPos(228.000, -3.000, 76.000, 160)
        else
            local position = math.random(1, 5) + 195
            player:setPos(position, -15.56, 258, 65)
        end
    end

    xi.moghouse.exitJobChange(player, prevZone)

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTransportEvent = function(player, transport)
    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
        player:startEvent(10002)
    else
        player:setPos(202.93, -6.25, 129.05, 161)
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 10002 then
        player:setPos(0, 0, 0, 0, 225)
    end

    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

return zoneObject
