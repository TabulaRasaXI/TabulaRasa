-----------------------------------
-- Open Sesame
-----------------------------------
-- Log ID: 5, Quest ID: 165
-- Lokpix : !pos -61.942 3.949 224.900 114
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.OPEN_SESAME)

quest.reward =
{
    fameArea = xi.quest.fame_area.SELBINA_RABAO,
    fame     = 30,
    keyItem  = xi.ki.LOADSTONE,
}

local tradeItems =
{
    { xi.items.METEORITE,   1 },
    { xi.items.SOIL_GEM,    1 },
    { xi.items.SOIL_GEODE, 12 },
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            xi.settings.main.ENABLE_ABYSSEA == 1
        end,

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            ['Lokpix'] = quest:progressEvent(20),

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            ['Lokpix'] =
            {
                onTrade = function(player, npc, trade)
                    for _, tradeOption in ipairs(tradeItems) do
                        if npcUtil.tradeHasExactly(trade, { tradeOption, { xi.items.TREMORSTONE, 1 } }) then
                            return quest:progressEvent(22)
                        end
                    end

                    return quest:event(23)
                end,

                onTrigger = function(player, npc)
                    return quest:event(21)
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
