-----------------------------------
-- Area: Windurst Waters
--  NPC: Churano-Shurano
-- !pos -60.8 -11.2 98.9 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Magicked Astrolabe is OOE for ASB, keeping in case servers want to manually re-add
    -- if not player:hasKeyItem(xi.ki.MAGICKED_ASTROLABE) then
    --     local cost = 10000
    --     if player:getLocalVar("Astrolabe") == 0 then
    --         player:startEvent(1080, cost)
    --     else
    --         player:startEvent(1081, cost)
    --     end
    -- else
    --     player:startEvent(280)
    -- end

    local hour = VanadielHour()
    if hour >= 4 and hour < 20 then
        player:startEvent(280)
    else
        player:startEvent(281)
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 1080 or csid == 1081 then
        if option == 1 and player:getGil() >= 10000 then
            player:updateEvent(xi.ki.MAGICKED_ASTROLABE)
        else
            player:updateEvent(0)
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1080 and option ~= xi.ki.MAGICKED_ASTROLABE then
        player:setLocalVar("Astrolabe", 1)
    elseif
        (csid == 1080 or csid == 1081) and
        option == xi.ki.MAGICKED_ASTROLABE and
        player:getGil() >= 10000
    then
        npcUtil.giveKeyItem(player, xi.ki.MAGICKED_ASTROLABE)
        player:delGil(10000)
    end
end

return entity
