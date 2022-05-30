-----------------------------------
-- Area: Ceizak Battlegrounds (261)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.CEIZAK_BATTLEGROUNDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED              = 6390, -- Obtained: <item>.
        GIL_OBTAINED               = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS        = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        EXPENDED_KINETIC_UNITS     = 7603, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS         = 7604, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT = 7605, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC     = 7606, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED  = 7607, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME   = 7608, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER     = 7609, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        HOMEPOINT_SET              = 7791, -- Home point set!
        UNCANNY_SENSATION          = 8033, -- You are assaulted by an uncanny sensation.
        ENERGIES_COURSE            = 8034, -- The arcane energies begin to course within your veins.
        MYSTICAL_WARMTH            = 8035, -- You feel a mystical warmth welling up inside you!
    },
    mob =
    {
    },
    npc =
    {
    },
    reive =
    {
        -- Bounding Chapuli (I-8)
        [1] =
        {
            mob =
            {
                17846627,
                17846628,
                17846629,
                17846630,
            },
            -- Knotted Vines
            obstacles =
            {
                17846624,
                17846625,
                17846626,
            },
            collision =
            {
                17846760,
                17846761,
            },
        },
    },
}

return zones[xi.zone.CEIZAK_BATTLEGROUNDS]
