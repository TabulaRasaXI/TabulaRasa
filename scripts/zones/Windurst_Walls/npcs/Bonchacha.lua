-----------------------------------
-- Area: Windurst Walls
--  NPC: Bonchacha
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -80.942, y = -5.086, z = 129.429, wait = 8000 },
    { x = -86.921, y = -5.302, z = 134.786, wait = 8000 },
    { x = -80.942, y = -5.086, z = 129.429, wait = 8000 },
    { x = -86.921, y = -5.302, z = 134.786, wait = 8000 },
    { x = -79.194, y = -5.006, z = 131.891, wait = 8000 },
    { x = -86.921, y = -5.302, z = 134.786, wait = 8000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(294)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
