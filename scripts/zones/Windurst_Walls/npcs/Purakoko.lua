-----------------------------------
-- Area: Windurst Walls
--  NPC: Purakoko
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local paths =
{
    { { x = -72.580, y = -10.500, z = 115.877, wait = 2000 } },
    { { x = -65.567, y = -11.000, z = 120.000, wait = 2000 } },
    { { x = -59.242, y = -12.500, z = 123.703, wait = 2000 } },
    { { wait = 2000, rotation = 0 } },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(paths[1]))
    npc:pathThrough(paths[1], xi.path.flag.PATROL)
end

entity.onPathComplete = function(npc)
    local index = math.random(1, #paths)
    npc:pathThrough(paths[index], xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(318)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
