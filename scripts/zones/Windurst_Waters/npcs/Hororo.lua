-----------------------------------
-- Area: Windurst Waters
--  NPC: Hororo
-- Working 100%
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -3.357, y = -1.000, z = 72.110 },
    { x = -1.515, y = -1.000, z = 74.222 },
    { x = -0.882, y = -1.049, z = 75.426 },
    { x = -0.446, y = -1.732, z = 77.128 },
    { x = 0.140, y = -3.025, z = 80.003 },
    { x = 0.635, y = -4.285, z = 82.479 },
    { x = 1.022, y = -5.000, z = 84.439 },
    { x = 0.906, y = -5.000, z = 85.585 },
    { x = 0.451, y = -5.000, z = 86.603 },
    { x = -1.006, y = -5.000, z = 89.196 },
    { x = -1.887, y = -5.000, z = 90.184 },
    { x = -3.032, y = -5.000, z = 90.623 },
    { x = -3.785, y = -5.000, z = 90.813 },
    { x = -5.889, y = -5.000, z = 91.243 },
    { x = -7.119, y = -5.000, z = 90.895 },
    { x = -7.830, y = -5.000, z = 90.544 },
    { x = -8.612, y = -5.000, z = 90.125 },
    { x = -10.465, y = -5.000, z = 88.799 },
    { x = -11.703, y = -5.000, z = 86.927 },
    { x = -12.198, y = -5.000, z = 86.112 },
    { x = -12.725, y = -5.000, z = 85.238 },
    { x = -12.808, y = -5.000, z = 84.916 },
    { x = -12.808, y = -5.000, z = 84.916 },
    { x = -12.808, y = -5.000, z = 84.916 },
    { x = -12.808, y = -5.000, z = 84.916 },
    { x = -12.808, y = -5.000, z = 84.916 },
    { x = -12.808, y = -5.000, z = 84.916 },
    { x = -12.754, y = -4.490, z = 83.009 },
    { x = -12.702, y = -3.628, z = 81.166 },
    { x = -12.653, y = -2.785, z = 79.410 },
    { x = -12.611, y = -2.033, z = 77.917 },
    { x = -12.532, y = -1.070, z = 75.112 },
    { x = -11.532, y = -1.002, z = 72.400 },
    { x = -10.140, y = -1.000, z = 71.435 },
    { x = -8.912, y = -1.000, z = 71.263 },
    { x = -7.203, y = -1.000, z = 71.262 },
    { x = -4.422, y = -1.000, z = 71.349 },
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
    player:startEvent(570)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
