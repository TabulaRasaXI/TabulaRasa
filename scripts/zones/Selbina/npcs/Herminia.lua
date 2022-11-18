-----------------------------------
-- Area: Selbina
--  NPC: Herminia
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12456,  552,    -- Hachimaki
        12584,  833,    -- Kenpogi
        12608, 1274,    -- Tunic
        12712,  458,    -- Tekko
        12736,  596,    -- Mitts
        12840,  666,    -- Sitabaki
        12968,  424,    -- Kyahan
        12992,  544,    -- Solea
    }

    player:showText(npc, ID.text.HERMINIA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.quest.fame_area.SELBINA_RABAO)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
