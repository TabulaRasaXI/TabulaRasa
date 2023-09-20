-----------------------------------
-- Area: Bhaflau_Thickets
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BHAFLAU_THICKETS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7057, -- You can't fish here.
        DIG_THROW_AWAY                = 7070, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7072, -- You dig and you dig, but find nothing.
        STAGING_GATE_CLOSER           = 7317, -- You must move closer.
        STAGING_GATE_INTERACT         = 7318, -- This gate guards an area under Imperial control.
        STAGING_GATE_MAMOOL           = 7320, -- Mamool Ja Staging Point.
        CANNOT_LEAVE                  = 7328, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7337, -- There is no response...
        HAND_OVER_TO_IMMORTAL         = 7550, -- You hand over the % to the Immortal.
        YOUR_IMPERIAL_STANDING        = 7551, -- Your Imperial Standing has increased!
        HARVESTING_IS_POSSIBLE_HERE   = 7569, -- Harvesting is possible here if you have <item>.
        CANNOT_ENTER                  = 7592, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7593, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7597, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7601, -- One or more party members are too far away from the entrance. Unable to enter area.
        SHED_LEAVES                   = 7662, -- The ground is strewn with shed leaves...
        BLOOD_STAINS                  = 7664, -- The ground is smeared with bloodstains...
        DRAWS_NEAR                    = 7689, -- Something draws near!
        HOMEPOINT_SET                 = 7700, -- Home point set!
    },
    mob =
    {
        MAHISHASURA_PH     =
        {
            [16990296] = 16990306, -- 215.000 -18.000 372.000
        },
        EMERGENT_ELM_PH    =
        {
            [16990374] = 16990376, -- 86.000 -35.000 621.000
        },
        NIS_PUK_PH         =
        {
            [16990383] = 16990403, -- -135 -18 -648
            [16990384] = 16990403, -- -104 -18 -636
            [16990385] = 16990403, -- -123 -16 -638
            [16990391] = 16990403, -- -106 -16 -613
            [16990392] = 16990403, -- -109 -15 -600
            [16990393] = 16990403, -- -128 -15 -602
            [16990394] = 16990403, -- -132 -16 -612
            [16990398] = 16990403, -- -119 -15 -651
        },
        HARVESTMAN         = 16990252,
        LIVIDROOT_AMOOSHAH = DYNAMIC_LOOKUP,
        DEA                = DYNAMIC_LOOKUP,
    },
    npc =
    {
        HARVESTING =
        {
            16990640,
            16990641,
            16990642,
            16990643,
            16990644,
            16990645,
        },
    },
}

return zones[xi.zone.BHAFLAU_THICKETS]
