-----------------------------------
-- Area: Port Windurst
--  NPC: Door: Departures Exit
-- !pos 218 -5 114 240
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) and player:getGil() >= 200 then
        player:startEvent(181, 0, 8, 0, 0, 0, 0, 0, 200)
    else
        player:startEvent(183, 0, 8)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 181 then
        local xPos = player:getXPos()

        if xPos >= 221 and xPos <= 225 then
            player:delGil(200)
        end
    end
end

return entity
