-----------------------------------
-- Area: Tahrongi_Canyon
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.TAHRONGI_CANYON] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6565,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6571,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6572,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6574,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6585,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6600,  -- I'm ready. I suppose.
        CRUOR_TOTAL                   = 7169,  -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS           = 7182,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7183,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7184,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7204,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7241,  -- You can't fish here.
        DIG_THROW_AWAY                = 7254,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7256,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7322,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        ALREADY_OBTAINED_TELE         = 7341,  -- You already possess the gate crystal for this telepoint.
        TELEPOINT_DISAPPEARED         = 7342,  -- The telepoint has disappeared...
        SIGN_1                        = 7416,  -- North: Meriphataud Mountains Northeast: Crag of Mea South: East Sarutabaruta
        SIGN_3                        = 7417,  -- North: Meriphataud Mountains East: Crag of Mea South: East Sarutabaruta
        SIGN_5                        = 7418,  -- North: Meriphataud Mountains East: Buburimu Peninsula South: East Sarutabaruta
        SIGN_7                        = 7419,  -- East: Buburimu Peninsula West: East Sarutabaruta
        BUD_BREAKS_OFF                = 7420,  -- The bud breaks off. You obtain <item>.
        POISONOUS_LOOKING_BUDS        = 7421,  -- The flowers have poisonous-looking buds.
        CANT_TAKE_ANY_MORE            = 7422,  -- You can't take any more.
        MINING_IS_POSSIBLE_HERE       = 7443,  -- Mining is possible here if you have <item>.
        TELEPOINT_HAS_BEEN_SHATTERED  = 7528,  -- The telepoint has been shattered into a thousand pieces...
        SPROUT_LOOKS_WITHERED         = 7571,  -- There is something sprouting from the ground here. It looks a little withered.
        REPULSIVE_CREATURE_EMERGES    = 7572,  -- A repulsive creature emerges from the ground!
        SPROUT_DOES_NOT_NEED_WATER    = 7573,  -- The sprout does not need any more water now.
        NOTHING_HAPPENS               = 7574,  -- Nothing happens.
        SPROUT_LOOKING_BETTER         = 7575,  -- The sprout is looking better.
        PLAYER_OBTAINS_ITEM           = 7580,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7581,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7582,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7583,  -- You already possess that temporary item.
        NO_COMBINATION                = 7588,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7619,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7650,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9840,  -- New training regime registered!
        VOIDWALKER_NO_MOB             = 11013, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11014, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11015, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11016, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11018, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11019, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11020, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11021, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                  = 11948, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11950, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11957, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        SERPOPARD_ISHTAR_PH =
        {
            [17256560] = 17256563, -- -9.176 -8.191 -64.347 (south)
            [17256686] = 17256690, -- 22.360 23.757 281.584 (north)
        },

        HERBAGE_HUNTER_PH =
        {
            [17256835] = 17256836, -- -119.301, 24.087, 448.636
        },

        HABROK            = 17256493,
        YARA_MA_YHA_WHO   = 17256900,

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17256918, -- Prickly Sheep
                17256917, -- Prickly Sheep
                17256916, -- Prickly Sheep
                17256915, -- Prickly Sheep
                17256914,  -- Void Hare
                17256913,  -- Void Hare
                17256912,  -- Void Hare
                17256911,  -- Void Hare
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17256910, -- Chesma
                17256909, -- Tammuz
            },

            [xi.keyItem.GREY_ABYSSITE] =
            {
                17256908, -- Dawon
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17256907, -- Yilbegan
            }
        }
    },

    npc =
    {
        SIGNPOST_OFFSET = 17257033,

        EXCAVATION =
        {
            17257055,
            17257056,
            17257057,
            17257058,
            17257059,
            17257060,
        },
    },
}

return zones[xi.zone.TAHRONGI_CANYON]
