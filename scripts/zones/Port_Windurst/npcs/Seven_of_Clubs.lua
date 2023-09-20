-----------------------------------
-- Area: Port Windurst
--  NPC: Seven of Clubs
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -16.732, y = -6.000, z = 150.484, wait = 5000 },
    { x = -25.016, z = 149.974 },
    { x = -30.555, z = 149.359 },
    { x = -30.553, z = 149.635, wait = 5000 },
    { x = -25.016, z = 149.974 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(220)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
