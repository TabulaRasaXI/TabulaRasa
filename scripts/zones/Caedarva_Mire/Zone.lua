-----------------------------------
-- Zone: Caedarva_Mire (79)
-----------------------------------
local ID = require('scripts/zones/Caedarva_Mire/IDs')
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/helm')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    if xi.settings.main.ENABLE_TOAU == 1 then
        UpdateNMSpawnPoint(ID.mob.AYNU_KAYSEY)
        GetMobByID(ID.mob.AYNU_KAYSEY):setRespawnTime(math.random(900, 10800))
        GetMobByID(ID.mob.KHIMAIRA):setRespawnTime(math.random(12, 36)*3600) -- 12 to 36 hours after maintenance, in 1-hour increments
    end

    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(339.996, 2.5, -721.286, 200)
    end

    if prevZone == xi.zone.LEUJAOAM_SANCTUM then
        player:setPos(495.450, -28.25, -478.43, 32)
    end

    if prevZone == xi.zone.PERIQIA then
        player:setPos(-252.715, -7.666, -30.64, 128)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket("1pb1")
    player:entityVisualPacket("2pb1")
    player:entityVisualPacket("1pd1")
    player:entityVisualPacket("2pc1")
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 133 then -- enter instance, warp to periqia
        player:setPos(0, 0, 0, 0, 56)
    elseif csid == 130 then
        player:setPos(0, 0, 0, 0, 69)
    end
end

return zoneObject
