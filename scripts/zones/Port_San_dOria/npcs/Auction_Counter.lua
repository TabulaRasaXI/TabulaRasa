-----------------------------------
-- Area: Port San d'Oria
--  NPC: Auction Counter
-- Working 100%
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.tutorial.onAuctionTrigger(player)
    player:sendMenu(3)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
