-----------------------------------
-- Zone: Sauromugue_Champaign (120)
-----------------------------------
local ID = require('scripts/zones/Sauromugue_Champaign/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.ROC)

    GetNPCByID(ID.npc.QM2 + math.random(0, 5)):setLocalVar('Quest[2][70]Option', 1) -- Determine which QM is active today for THF AF2
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-103.991, -25.956, -425.221, 190)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameDay = function(zone)
    for i = ID.npc.QM2, ID.npc.QM2 + 5 do
        GetNPCByID(i):resetLocalVars()
    end

    GetNPCByID(ID.npc.QM2 + math.random(0, 5)):setLocalVar('Quest[2][70]Option', 1) -- Determine which QM is active today for THF AF2

    -- Chocobo digging
    SetServerVariable("[DIG]ZONE120_ITEMS", 0)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 3 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
