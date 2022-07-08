-----------------------------------
-- Area: Beaucedine_Glacier
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BEAUCEDINE_GLACIER] =
{
    text =
    {
        CONQUEST_BASE                  = 0,     -- Tallying conquest results...
        BEASTMEN_BANNER                = 81,    -- There is a beastmen's banner.
        ITEM_CANNOT_BE_OBTAINED        = 6567,  -- You cannot obtain the item. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6569,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6571,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6572,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6574,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6575,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                 = 6580,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY        = 6585,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6600,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7182,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7183,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 7184,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET         = 7238,  -- You can't fish here.
        CONQUEST                       = 7491,  -- You've earned conquest points!
        YOU_CANNOT_ENTER_DYNAMIS       = 7882,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7884,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7894,  -- There is an unusual arrangement of branches here.
        GARRISON_BASE                  = 8244,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM            = 8577,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8578,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8579,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8580,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8585,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN             = 8616,  -- The monster fades before your eyes, a look of disappointment on its face.
        REGIME_REGISTERED              = 10763, -- New training regime registered!
        VOIDWALKER_NO_MOB              = 11882, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR         = 11883, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT            = 11884, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB           = 11885, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1        = 11887, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2        = 11888, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI            = 11889, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI           = 11890, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL          = 12789, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        GARGANTUA_PH =
        {
            [17232078] = 17232079, -- 339 -0.472 -20
        },

        KIRATA_PH =
        {
            [17232042] = 17232044, -- 75.797 -0.335 -323.659
            [17232043] = 17232044, -- 69.336 -0.234 -276.561
        },

        NUE_PH =
        {
            [17231969] = 17231971, -- -342.830 -100.584 168.662
            [17231970] = 17231971, -- -322.000 -100.000 116.000
        },

        HUMBABA = 17232094,

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17232159, -- Gorehound
                17232158, -- Gorehound
                17232157, -- Gorehound
                17232156, -- Gorehound
                17232155, -- Gjenganger
                17232154, -- Gjenganger
                17232153, -- Gjenganger
                17232152, -- Gjenganger
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17232151, -- Erebus
                17232150, -- Feuerunke
            },

            [xi.keyItem.PURPLE_ABYSSITE] =
            {
                17232149, -- Lord Ruthven
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17232148, -- Yilbegan
            }
        }
    },

    npc =
    {
        CASKET_BASE     = 17232181,
        MIRROR_POND_J8  = 17232206,
        OVERSEER_BASE   = 17232217, -- Parledaire_RK in npc_list
    },
}

return zones[xi.zone.BEAUCEDINE_GLACIER]
