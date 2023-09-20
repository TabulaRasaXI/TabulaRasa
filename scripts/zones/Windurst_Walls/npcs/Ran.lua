-----------------------------------
-- Area: Windurst Walls
--  NPC: Ran
-- Working 100%
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if math.random() >= .5 then
        player:startEvent(272)
    else
        player:startEvent(273)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
