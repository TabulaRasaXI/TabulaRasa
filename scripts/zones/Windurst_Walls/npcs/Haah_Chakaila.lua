-----------------------------------
-- Area: Windurst Walls
--  NPC: Haah Chakaila
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -25.577, y = -16.000, z = 138.649 },
    { x = -25.577, z = 138.649 },
    { x = -25.577, z = 138.649 },
    { x = -28.309, z = 144.618 },
    { x = -29.454, z = 147.434 },
    { x = -30.380, z = 149.713 },
    { x = -31.283, z = 151.936 },
    { x = -32.482, z = 154.887 },
    { x = -34.505, z = 166.549 },
    { x = -34.610, z = 170.204 },
    { x = -34.382, z = 171.540 },
    { x = -33.188, z = 174.336 },
    { x = -32.003, z = 177.033 },
    { x = -31.127, z = 178.391 },
    { x = -30.099, z = 179.719 },
    { x = -26.445, z = 184.250 },
    { x = -23.690, z = 186.289 },
    { x = -21.121, z = 187.977 },
    { x = -18.275, z = 189.020 },
    { x = -10.680, z = 191.481 },
    { x = -8.031, z = 191.653 },
    { x = -5.722, z = 191.791 },
    { x = 1.470, z = 192.018 },
    { x = 6.346, z = 191.383 },
    { x = 14.217, z = 190.079 },
    { x = 23.037, z = 187.774 },
    { x = 14.217, z = 190.079 },
    { x = 6.346, z = 191.383 },
    { x = 1.470, z = 192.018 },
    { x = -5.722, z = 191.791 },
    { x = -8.031, z = 191.653 },
    { x = -10.680, z = 191.481 },
    { x = -18.275, z = 189.020 },
    { x = -21.121, z = 187.977 },
    { x = -23.690, z = 186.289 },
    { x = -26.445, z = 184.250 },
    { x = -30.099, z = 179.719 },
    { x = -31.127, z = 178.391 },
    { x = -32.003, z = 177.033 },
    { x = -33.188, z = 174.336 },
    { x = -34.382, z = 171.540 },
    { x = -34.610, z = 170.204 },
    { x = -34.505, z = 166.549 },
    { x = -32.482, z = 154.887 },
    { x = -31.283, z = 151.936 },
    { x = -30.380, z = 149.713 },
    { x = -29.454, z = 147.434 },
    { x = -28.309, z = 144.618 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(330)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
