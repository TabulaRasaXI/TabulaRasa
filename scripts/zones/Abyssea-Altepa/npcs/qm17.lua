-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm17 (???)
-- Spawns Dragua
-- !pos -221 0.8 -350 218
-----------------------------------
local ID = require('scripts/zones/Abyssea-Altepa/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.DRAGUA_1, { xi.ki.BLOODIED_DRAGON_EAR })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
