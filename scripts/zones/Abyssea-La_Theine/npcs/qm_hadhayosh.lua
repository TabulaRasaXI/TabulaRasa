-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_hadhayosh (???)
-- Spawns Hadhayosh
-- !pos 434 24 41 132
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
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.HADHAYOSH_1, { xi.ki.MARBLED_MUTTON_CHOP, xi.ki.BLOODIED_SABER_TOOTH, xi.ki.GLITTERING_PIXIE_CHOKER, xi.ki.BLOOD_SMEARED_GIGAS_HELM })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
