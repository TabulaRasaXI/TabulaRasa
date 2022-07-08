-----------------------------------
-- Zone: Pashhow_Marshlands (109)
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/zone")
require("scripts/missions/amk/helpers")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.BOWHO_WARMONGER)
    GetMobByID(ID.mob.BOWHO_WARMONGER):setRespawnTime(75600 + math.random(600, 900)) -- 21 hours, plus 10 to 15 min

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.voidwalker.zoneOnInit(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(547.841, 23.192, 696.323, 136)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 13
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

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if csid == 13 then
        quests.rainbow.onEventUpdate(player)
    end
end

zone_object.onEventFinish = function( player, csid, option)
end

return zone_object
