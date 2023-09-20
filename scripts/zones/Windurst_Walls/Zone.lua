-----------------------------------
-- Zone: Windurst_Walls (239)
-----------------------------------
local ID = require('scripts/zones/Windurst_Walls/IDs')
require('scripts/globals/events/starlight_celebrations')
require('scripts/globals/conquest')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        xi.events.starlightCelebration.applyStarlightDecorations(zone:getID())
    end
    zone:registerTriggerArea(1, -2, -17, 140, 2, -16, 142)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(1, 5) - 123
        player:setPos(-257.5, -5.05, position, 0)
    end

    xi.moghouse.exitJobChange(player, prevZone)

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function()  -- Heaven's Tower enter portal
            player:startEvent(86)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 86 then
        player:setPos(0, 0, -22.40, 192, 242)
    end

    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

return zoneObject
