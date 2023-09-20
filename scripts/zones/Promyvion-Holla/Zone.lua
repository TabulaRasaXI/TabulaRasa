-----------------------------------
-- Zone: Promyvion-Holla (16)
-----------------------------------
local ID = require('scripts/zones/Promyvion-Holla/IDs')
require('scripts/globals/promyvion')
require('scripts/globals/settings')
require('scripts/globals/status')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
--    UpdateNMSpawnPoint(ID.mob.CEREBRATOR)
--    GetMobByID(ID.mob.CEREBRATOR):setRespawnTime(math.random(3600, 21600))
    xi.promyvion.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(92.033, 0, 80.380, 255) -- To Floor 1 (R)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    xi.promyvion.onTriggerAreaEnter(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid >= 30 and csid <= 45 then
        for _, entry in pairs(player:getNotorietyList()) do
            entry:clearEnmity(player) -- reset hate on player after teleporting
        end
    end
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 46 and option == 1 then
        player:setPos(-225.682, -6.459, 280.002, 128, 14) -- To Hall of Transference (R)
    end
end

zoneObject.onGameDay = function(zone)
end

return zoneObject
