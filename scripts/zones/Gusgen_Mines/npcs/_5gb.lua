-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5gb (Lever B)
-- !pos 19.999 -40.561 -54.198 196
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local lever = npc:getID()

    npc:openDoor(2) -- Lever animation
    if GetNPCByID(lever - 6):getAnimation() == 9 then
        GetNPCByID(lever - 7):setAnimation(9) --close door C
        GetNPCByID(lever - 6):setAnimation(8) --open door B
        GetNPCByID(lever - 5):setAnimation(9) --close door A
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
