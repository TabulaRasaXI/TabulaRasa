-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm10 (???)
-- Spawns Bugul Noz
-- !pos -608 -1 -397 218
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- xi.abyssea.qmOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
