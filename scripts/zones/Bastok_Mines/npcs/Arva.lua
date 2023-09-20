-----------------------------------
-- Area: Bastok Mines
--  NPC: Arva
-- Adventurer's Assistant
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(536, 1) == true
    then
        player:startEvent(4)
        player:addGil(xi.settings.main.GIL_RATE * 50)
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(3)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 4 then
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.main.GIL_RATE * 50)
    end
end

return entity
