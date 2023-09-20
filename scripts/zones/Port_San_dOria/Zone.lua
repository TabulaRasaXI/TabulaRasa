-----------------------------------
-- Zone: Port_San_dOria (232)
-----------------------------------
local ID = require('scripts/zones/Port_San_dOria/IDs')
require('scripts/quests/flyers_for_regine')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    quests.ffr.initZone(zone) -- register trigger areas 1 through 5
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.SAN_DORIA_JEUNO_AIRSHIP then
            cs = { 702 }
            player:setPos(-1.000, 0.000, 44.000, 0)
        else
            player:setPos(80, -16, -135, 165)
        end
    end

    xi.moghouse.exitJobChange(player, prevZone)

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    quests.ffr.onTriggerAreaEnter(player, triggerArea) -- player approaching Flyers for Regine NPCs
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, transport)
    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
        player:startEvent(700)
    else
        player:setPos(-37.55, -8, 27.96, 126)
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 700 then
        player:setPos(0, 0, 0, 0, 223)
    end

    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

return zoneObject
