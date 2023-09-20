-----------------------------------
-- Zone: Mhaura (249)
-----------------------------------
local ID = require('scripts/zones/Mhaura/IDs')
require('scripts/globals/conquest')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onGameHour = function(zone)
    -- Script for Laughing Bison sign flip animations
    local timer = 1152 - ((os.time() - 1009810802)%1152)

    -- Next ferry is Al Zhabi for higher values.
    if timer >= 576 then
        GetNPCByID(ID.npc.LAUGHING_BISON):setAnimationSub(1)
    else
        GetNPCByID(ID.npc.LAUGHING_BISON):setAnimationSub(0)
    end

    SetServerVariable("Mhaura_Destination", math.random(1, 100))
end

zoneObject.onInitialize = function(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if
            prevZone == xi.zone.SHIP_BOUND_FOR_MHAURA or
            prevZone == xi.zone.OPEN_SEA_ROUTE_TO_MHAURA or
            prevZone == xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES
        then
            local ship = GetNPCByID(ID.npc.SHIP)

            ship:setAnimBegin(VanadielTime())
            cs = 202
            player:setPos(14.960, -3.430, 18.423, 192)
        else
            player:setPos(0.003, -6.252, 117.971, 65)
        end
    end

    if player:getZPos() < 1.6 then -- fixing player position if logged off / crashed on ship
        player:setPos(8.23, -1.3, 4.48)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTransportEvent = function(player, transport)
    if player:getLocalVar('[BOAT]Paid') == 1 then
        if transport == 47 or transport == 46 then
            if not player:hasKeyItem(xi.ki.BOARDING_PERMIT) or xi.settings.main.ENABLE_TOAU == 0 then
                player:setPos(8.200, -1.363, 3.445, 192)
                player:messageSpecial(ID.text.DO_NOT_POSSESS, xi.ki.BOARDING_PERMIT)
            else
                player:startEvent(200)
            end
        else
            player:startEvent(200)
        end
    else
        player:setPos(48.1156, -8.0000, 40.8011, 66)
        player:setLocalVar('[BOAT]Paid', 0)
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 200 then
        local DepartureTime = VanadielHour()

        if DepartureTime % 8 == 0 then
            if GetServerVariable("Mhaura_Destination") >= 89 then
                player:setPos(0, 0, 0, 0, xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES)
            else
                player:setPos(0, 0, 0, 0, xi.zone.SHIP_BOUND_FOR_SELBINA)
            end
        elseif DepartureTime % 8 == 4 then
            player:setPos(0, 0, 0, 0, xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI)
        else
            player:setPos(8, -1, 5, 62, 249) -- Something went wrong, dump them on the dock for safety.
        end
    elseif csid == 220 and option == 0 then
        player:setLocalVar('[BOAT]Paid', 0)

    elseif csid == 202 then
        player:setLocalVar('[BOAT]Paid', 1)
    end
end

return zoneObject
