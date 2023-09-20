-----------------------------------
-- Area: Windurst Waters
--  NPC: Rabiri-Tabiri
-- Working 100%
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -109.833, y = -2.000, z = 49.970, rotation = 32, wait = 6000 },
    { x = -97.530, z = 50.283, rotation = 118, wait = 6000 },
    { x = -104.014, z = 42.639, rotation = 214, wait = 6000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

entity.onTrade = function(player, npc, trade)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc) then
            return
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(568)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
