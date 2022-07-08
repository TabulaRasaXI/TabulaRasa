-----------------------------------
-- Zone: Jugner_Forest (104)
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/helm")
require("scripts/globals/zone")
require("scripts/missions/amk/helpers")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -484, 10, 292, 0, 0, 0) -- Sets Mark for "Under Oath" Quest cutscene.

    UpdateNMSpawnPoint(ID.mob.FRAELISSA)
    GetMobByID(ID.mob.FRAELISSA):setRespawnTime(math.random(900, 10800))

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.LOGGING)

    local respawnTime = 900 + math.random(0, 6) * 1800 -- 0:15 to 3:15 spawn timer in 30 minute intervals
    for offset = 1, 10 do
        GetMobByID(ID.mob.KING_ARTHRO - offset):setRespawnTime(respawnTime)
    end

    xi.voidwalker.zoneOnInit(zone)
end

zone_object.onZoneIn = function( player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos( 342, -5, 15.117, 169)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 15
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zone_object.onZoneOut = function(player)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        player:delStatusEffect(xi.effect.BATTLEFIELD)
	end
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function( player, region)
    if region:GetRegionID() == 1 and player:getCharVar("UnderOathCS") == 7 then -- Quest: Under Oath - PLD AF3
        player:startEvent(14)
    end
end

zone_object.onEventUpdate = function( player, csid, option)
    if csid == 15 then
        quests.rainbow.onEventUpdate(player)
    end
end

zone_object.onEventFinish = function( player, csid, option)
    if csid == 14 then
        player:setCharVar("UnderOathCS", 8) -- Quest: Under Oath - PLD AF3
    end
end

return zone_object
