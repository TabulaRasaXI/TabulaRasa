-----------------------------------
-- Area: Buburimu_Peninsula
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BUBURIMU_PENINSULA] =
{
    text =
    {
        NOTHING_HAPPENS                = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED        = 6419,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6425,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6426,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6428,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6429,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET          = 6454,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7036,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7037,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 7038,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                  = 7092,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7173,  -- There is a beastmen's banner.
        FIVEOFSPADES_DIALOG            = 7251,  -- GiMmefIvE! FiVe isA cArdIanOF WiN-DuRst! FIvEiS OnpA-tRol!
        FISHING_MESSAGE_OFFSET         = 7257,  -- You can't fish here.
        DIG_THROW_AWAY                 = 7270,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                   = 7272,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET             = 7338,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        SONG_RUNES_DEFAULT             = 7377,  -- An old momument. A melancholy song of two separated lovers is written upon it.
        SONG_RUNES_REQUIRE             = 7391,  -- If only you had <item>, you could jot down the lyrics.
        SONG_RUNES_WRITING             = 7392,  -- You write down the lyrics on the <item>.
        SIGN_1                         = 7399,  -- West: Tahrongi Canyon Southeast: Mhaura
        SIGN_2                         = 7400,  -- West: Tahrongi Canyon South: Mhaura
        SIGN_3                         = 7401,  -- West: Tahrongi Canyon Southwest: Mhaura
        SIGN_4                         = 7402,  -- West: Mhaura and Tahrongi Canyon
        SIGN_5                         = 7403,  -- West: Mhaura Northwest: Tahrongi Canyon
        LOGGING_IS_POSSIBLE_HERE       = 7404,  -- Logging is possible here if you have <item>.
        CONQUEST                       = 7420,  -- You've earned conquest points!
        GARRISON_BASE                  = 7801,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        YOU_CANNOT_ENTER_DYNAMIS       = 7907,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7909,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 8031,  -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        PLAYER_OBTAINS_ITEM            = 8119,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8120,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8121,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8122,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8127,  -- You were unable to enter a combination.
        REGIME_REGISTERED              = 10305, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12326, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BACKOO        = 17260613,
        HELLDIVER_PH  =
        {
            [17260886] = 17260907, -- 439.685 -0.200 -271.203
            [17260906] = 17260907, -- 509.641 0.151 -267.664
            [17260905] = 17260907, -- 503.268 -0.981 -211.204
            [17260868] = 17260907, -- 395.297 -0.037 -149.776
            [17260887] = 17260907, -- 445.199 -0.323 -306.818
        },
        BUBURIMBOO_PH =
        {
            [17261000] = 17261003, -- 443.429 19.500 135.322
            [17261002] = 17261003, -- 442.901 19.500 109.075
            [17261001] = 17261003, -- 443.004 19.500 96.000
            [17260999] = 17261003, -- 444.224 19.499 76.000
        },
    },
    npc =
    {
        CASKET_BASE     = 17261113,
        OVERSEER_BASE   = 17261150, -- Bonbavour_RK in npc_list
        SIGNPOST_OFFSET = 17261165,
        LOGGING =
        {
            17261175,
            17261176,
            17261177,
            17261178,
            17261179,
            17261180,
        },
    },
}

return zones[xi.zone.BUBURIMU_PENINSULA]
