-----------------------------------
-- Area: Garlaige Citadel
--  NPC: _5ki (Banishing Gate #3)
-- !pos -100 -3.008 359 200
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Forked servers may optionally wish to remove this tag / requirement
    if xi.settings.main.ENABLE_WOTG == 1 then
        if player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) then
            -- Door opens from both sides.
            GetNPCByID(npc:getID()):openDoor(30)

            -- NOTE: In retail, this door doesn't display any messages.
            -- "Better than retail" case, considering how the other 2 gates behave.

            -- Only the south side SHOULD display a message when interacting.
            if player:getZPos() < 359 then
                player:messageSpecial(ID.text.THE_GATE_OPENS_FOR_YOU, xi.ki.POUCH_OF_WEIGHTED_STONES)
            end
        else
            -- South side EXPECTED regular interaction.
            if player:getZPos() < 359 then
                player:messageSpecial(ID.text.YOU_COULD_OPEN_THE_GATE, xi.ki.POUCH_OF_WEIGHTED_STONES)
            end
        end
    else
        player:messageSpecial(ID.text.A_GATE_OF_STURDY_STEEL)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
