-----------------------------------
-- Zone: West_Ronfaure (100)
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-24.427, -53.107, 140, 127)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 51
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
    if csid == 51 then
        quests.rainbow.onEventUpdate(player)
    end
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
