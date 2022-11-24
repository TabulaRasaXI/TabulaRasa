-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Beryl-footed Molberry NM)
-- !pos -57 0 4 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.TONBERRY_RATTLE) and
        npcUtil.popFromQM(player, npc, ID.mob.BERYL_FOOTED_MOLBERRY)
    then
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NM_OFFSET)
end

return entity
