-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_bloodeye_vileberry (???)
-- Spawns Bloodeye Vileberry
-- !pos 554.000 24.198 714.000 15
-- !pos 539.000 24.198 714.000 15
-- !pos 554.000 23.098 699.000 15
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.BLOODEYE_VILEBERRY_1, { xi.ki.TWISTED_TONBERRY_CROWN })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
