-----------------------------------
-- Area: Lower Jeuno
--  NPC: Fephita
-- Type: Chocobo Renter
-- !pos -89.6 -0.100 -197.4 245
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 10003
local eventFail    = 10006

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end
