 -----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: qm2 (???)
-- Involved In Quest: 20 in Pirate Years
-- !pos 47.852 -7.808 403.391 114
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local twentyInPirateYearsCS = player:getCharVar("twentyInPirateYearsCS")
    local tsuchigumoKilled = player:getCharVar("TsuchigumoKilled")

    if
        twentyInPirateYearsCS == 3 and
        tsuchigumoKilled <= 1 and
        not GetMobByID(ID.mob.TSUCHIGUMO_OFFSET):isSpawned() and
        not GetMobByID(ID.mob.TSUCHIGUMO_OFFSET + 1):isSpawned()
    then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.TSUCHIGUMO_OFFSET)
        SpawnMob(ID.mob.TSUCHIGUMO_OFFSET + 1)
    elseif twentyInPirateYearsCS == 3 and tsuchigumoKilled >= 2 then
        player:addKeyItem(xi.ki.TRICK_BOX)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TRICK_BOX)
        player:setCharVar("twentyInPirateYearsCS", 4)
        player:setCharVar("TsuchigumoKilled", 0)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
