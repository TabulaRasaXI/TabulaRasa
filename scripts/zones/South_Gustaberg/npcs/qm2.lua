-----------------------------------
-- Area: South Gustaberg
--  NPC: ???
-- Involved in Quest: Smoke on the Mountain
-- !pos 461 -21 -580 107
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if not player:needToZone() then
        player:setCharVar("SGusta_Sausage_Timer", 0)
    end
    if npcUtil.tradeHas(trade, 4372) then
        if player:getCharVar("SGusta_Sausage_Timer") == 0 then
            -- player puts sheep meat on the fire
            player:messageSpecial(ID.text.FIRE_PUT, 4372)
            player:confirmTrade()
            player:setCharVar("SGusta_Sausage_Timer", os.time() + 3600) -- 1 game day
            player:needToZone(true)
        else
            -- message given if sheep meat is already on the fire
            player:messageSpecial(ID.text.MEAT_ALREADY_PUT, 4372)
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
