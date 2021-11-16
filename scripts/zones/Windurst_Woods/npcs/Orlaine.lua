-----------------------------------
-- Area: Windurst Woods
--  NPC: Orlaine
-- Type: Chocobo Vendor
-- !pos 133.24 -5.250 -126.76 241
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 10002
local eventFail    = 10005

entity.onTrade = function(player, npc, trade)
    xi.chocobo.renterOnTrade(player, npc, trade, eventSucceed, eventFail)
end

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
