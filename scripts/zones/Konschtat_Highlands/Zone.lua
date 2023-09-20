-----------------------------------
-- Zone: Konschtat_Highlands (108)
-----------------------------------
local ID = require('scripts/zones/Konschtat_Highlands/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/chocobo')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    if xi.settings.main.ENABLE_WOTG then
        xi.mob.nmTODPersistCache(zone, ID.mob.HIGHLANDER_LIZARD)
        xi.mob.nmTODPersistCache(zone, ID.mob.GHILLIE_DHU)
    end

    xi.chocobo.initZone(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(521.922, 28.361, 747.85, 45)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 104
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onGameDay = function()
    SetServerVariable("[DIG]ZONE108_ITEMS", 0)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 104 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()

    if hour < 5 or hour >= 17 then
        local phase = VanadielMoonPhase()
        local haty = GetMobByID(ID.mob.HATY)
        local vran = GetMobByID(ID.mob.BENDIGEIT_VRAN)
        local time = os.time()

        if
            phase >= 90 and
            not haty:isSpawned() and
            time > haty:getLocalVar("cooldown")
        then
            SpawnMob(ID.mob.HATY)
        elseif
            phase <= 10 and
            not vran:isSpawned() and
            time > vran:getLocalVar("cooldown")
        then
            SpawnMob(ID.mob.BENDIGEIT_VRAN)
        end
    end
end

return zoneObject
