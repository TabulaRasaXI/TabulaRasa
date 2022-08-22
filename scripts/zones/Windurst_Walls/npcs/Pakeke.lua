-----------------------------------
-- Area: Windurst Walls
--  NPC: Pakeke
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -118.747, -5.000, 145.220, -- Force turn.
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.747, -5.000, 145.220, -- Force turn.
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(292)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
