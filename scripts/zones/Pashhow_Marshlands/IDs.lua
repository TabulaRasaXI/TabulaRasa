-----------------------------------
-- Area: Pashhow_Marshlands
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PASHHOW_MARSHLANDS] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6412,  -- Obtained: <item>.
        GIL_OBTAINED             = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6415,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6416,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6426,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6441,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7023,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7024,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7025,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7079,  -- Tallying conquest results...
        BEASTMEN_BANNER          = 7160,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET   = 7238,  -- You can't fish here.
        DIG_THROW_AWAY           = 7251,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7253,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET       = 7319,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        CONQUEST                 = 7927,  -- You've earned conquest points!
        GARRISON_BASE            = 8306,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM      = 8476,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8477,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8478,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8479,  -- You already possess that temporary item.
        NO_COMBINATION           = 8484,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN       = 8515,  -- The monster fades before your eyes, a look of disappointment on its face.
        REGIME_REGISTERED        = 10725, -- New training regime registered!
        VOIDWALKER_NO_MOB        = 11844, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 11845, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 11846, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB     = 11847, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1  = 11849, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2  = 11850, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI      = 11851, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 11852, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL    = 12836, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        NI_ZHO_BLADEBENDER_PH =
        {
            [17223740] = 17223797, -- -429.953 24.5 -305.450
            [17223789] = 17223797, -- 11.309 23.904 -337.923
        },

        JOLLY_GREEN_PH =
        {
            [17223888] = 17223889, -- 184.993 24.499 -41.790
        },

        BLOODPOOL_VORAX_PH =
        {
            [17224014] = 17224019, -- -351.884 24.014 513.531
        },

        BOWHO_WARMONGER = 17224104,

        VOIDWALKER  =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17224184, -- Globster
                17224183, -- Globster
                17224182, -- Globster
                17224181, -- Globster
                17224180, -- Ground Guzzler
                17224179, -- Ground Guzzler
                17224178, -- Ground Guzzler
                17224177, -- Ground Guzzler
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17224176, -- Lamprey Lord
                17224175, -- Shoggoth
            },

            [xi.keyItem.ORANGE_ABYSSITE] =
            {
                17224168, -- Blobdingnag
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17224167, -- Yilbegan
            }
        }
    },

    pet =
    {
        [17224168] = -- Blobdingnag
        {
            17224174,-- Septic Boils
            17224173,-- Septic Boils
            17224172,-- Septic Boils
            17224171,-- Septic Boils
            17224170,-- Septic Boils
            17224169,-- Septic Boils
        },
    },

    npc =
    {
        CASKET_BASE   = 17224275,
        OVERSEER_BASE = 17224326, -- Mesachedeau_RK in npc_list
    },
}

return zones[xi.zone.PASHHOW_MARSHLANDS]
