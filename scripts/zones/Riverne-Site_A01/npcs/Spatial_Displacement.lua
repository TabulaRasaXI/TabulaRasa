-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Spacial Displacement
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.DISPLACEMENT_OFFSET
    if npc:getID() == ID.npc.SPATIAL_OURYU then
        xi.bcnm.onTrigger(player, npc)
    else
        if offset >= 0 and offset <= 2 then
            player:startOptionalCutscene(offset + 2)
        elseif offset >= 7 and offset <= 39 then
            player:startOptionalCutscene(offset)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    if csid == 32003 then
        xi.bcnm.onEventUpdate(player, csid, option, extras)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 35 and option == 1 then
        player:setPos(12.527, 0.345, -539.602, 127, 31) -- to Monarch Linn (Retail confirmed)
    elseif csid == 10 and option == 1 then
        player:setPos(-538.526, -29.5, 359.219, 255, 25) -- back to Misareaux Coast (Retail confirmed)
    elseif csid == 32003 then
        xi.bcnm.onEventFinish(player, csid, option)
    end
end

return entity
