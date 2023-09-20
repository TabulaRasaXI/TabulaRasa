-----------------------------------
-- Area: Windurst Waters
--  NPC: Diroku-Oroku
-- Working 100%
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/events/starlight_celebrations")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc) then
            return
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(420)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
