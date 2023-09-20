-----------------------------------
-- MAP SERVER SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with game administration and configuring the map executable
-----------------------------------

xi          = xi or {}
xi.settings = xi.settings or {}

xi.settings.map =
{
    -- --------------------------------
    -- Packet settings
    -- --------------------------------

    MAX_TIME_LASTUPDATE = 60,

    -- --------------------------------
    -- SQL settings
    -- --------------------------------

    -- Used by serverutils::PersistServerVar() for the maximum attempts to retry verification
    -- of a written Server Variable.
    SETVAR_RETRY_MAX = 3,

    -- --------------------------------
    -- Game settings
    -- --------------------------------

    -- PacketGuard will block and report any packets that aren't in the allow-list for a
    -- player's current state.
    PACKETGUARD_ENABLED = true,

    -- Minimal number of 0x3A packets which uses for detect lightluggage (set 0 for disable)
    LIGHTLUGGAGE_BLOCK = 4,

    --  AH fee structure, defaults are retail.
    AH_BASE_FEE_SINGLE = 1,
    AH_BASE_FEE_STACKS = 4,
    AH_TAX_RATE_SINGLE = 1.0,
    AH_TAX_RATE_STACKS = 0.5,
    AH_MAX_FEE         = 10000,

    -- Max open listings per player, 0 = no limit. (Default 7)
    -- Note = Settings over 7 may need client-side plugin to work under all circumstances.
    -- If this is the case, consider using the ah_pagination module
    AH_LIST_LIMIT = 7,

    -- Misc EXP related settings
    EXP_RATE                = 1.0,
    EXP_LOSS_RATE           = 1.0,
    EXP_PARTY_GAP_PENALTIES = true,

    -- Capacity Point Settings
    CAPACITY_RATE = 1.0,

    -- Determines Vana'diel time epoch (886/1/1 Firesday)
    -- current timestamp - vanadiel_time_epoch = vana'diel time
    -- 0 defaults to SE epoch 1009810800 (JP midnight 1/1/2002)
    -- safe range is 1 - current timestamp
    VANADIEL_TIME_EPOCH = 0,

    -- For old fame calculation use .25
    FAME_MULTIPLIER = 0.25,

    -- Percentage of experience normally lost to keep upon death. 0 means full loss, where 1 means no loss.
    EXP_RETAIN = 0,

    -- Minimum level at which experience points can be lost
    EXP_LOSS_LEVEL = 4,

    -- Minimum level at which regional influence is lost in conquest when a player dies
    -- Level 5 and below don't lose influence: http://wiki.ffo.jp/html/498.html
    MINIMUM_LEVEL_CONQUEST_INFUENCE_LOSS = 6,

    -- Enable/disable Level Sync
    LEVEL_SYNC_ENABLE = true,

    -- Disables ability to equip higher level gear when level cap/sync effect is on player.
    DISABLE_GEAR_SCALING = false,

    -- Weaponskill point base (before skillchain) for breaking latent - whole numbers only. retail is 1.
    WS_POINTS_BASE = 1,

    -- Weaponskill points per skillchain element - whole numbers only, retail is 1
    -- (tier 3 sc's have 4 elements, plus 1 for the ws itself, giving 5 points to the closer).
    WS_POINTS_SKILLCHAIN = 1,

    -- Enable/disable jobs other than BST and RNG having widescan
    ALL_JOBS_WIDESCAN = true,

    -- Modifier to apply to player speed. 0 is the retail accurate default. Negative numbers will reduce it.
    SPEED_MOD = -10,

    -- Modifier to apply to mount speed. 0 is the retail accurate default. Negative numbers will reduce it.
    -- Note retail treats the mounted speed as double what it actually is.
    MOUNT_SPEED_MOD = 0,

    -- Modifier to apply to agro'd monster speed. 0 is the retail accurate default. Negative numbers will reduce it.
    MOB_SPEED_MOD = -10,

    -- Allows you to manipulate the constant multiplier in the skill-up rate formulas, having a potent effect on skill-up rates.
    SKILLUP_CHANCE_MULTIPLIER = 1.0,
    CRAFT_CHANCE_MULTIPLIER   = 1.0,

    -- Multiplier for skillup amounts. Using anything above 1 will break the 0.5 cap, the cap will become 0.9 (For maximum, set to 5)
    SKILLUP_AMOUNT_MULTIPLIER = 1,
    CRAFT_AMOUNT_MULTIPLIER   = 1,

    -- Gardening Factors. DO NOT change defaults without verifiable proof that your change IS how retail does it. Myths need to be optional.
    GARDEN_DAY_MATTERS       = false,
    GARDEN_MOONPHASE_MATTERS = false,
    GARDEN_POT_MATTERS       = false,
    GARDEN_MH_AURA_MATTERS   = false,

    -- Use current retail skill up rates and margins (Retail = High Skill-Up rate; Skill-Up when at or under 10 levels above synth recipe level.)
    CRAFT_MODERN_SYSTEM = false,

    -- Craft level limit from witch specialization points beging to count. (Retail = 700; Level 75 era:600)
    CRAFT_COMMON_CAP = 600,

    -- Amount of points allowed in crafts over the level defined above. Points are shared across all crafting skills. (Retail = 400; All skills can go to max = 3200)
    CRAFT_SPECIALIZATION_POINTS = 400,

    -- Enables fishing. 0 = Disbaled. 1 = Enable. ENABLE AT YOUR OWN RISK.
    FISHING_ENABLE = false,

    -- Multipler for fishing skill-up chance. Default = 1.0, very hard.
    FISHING_SKILL_MULTIPLIER = 1.0,

    -- Enable/disable skill-ups from bloodpacts
    SKILLUP_BLOODPACT = true,

    -- Adjust rate of TP gain for mobs, pets (includes charmed pets), fellows, trusts and players.
    -- Acts as a multiplier, so default is 1.
    MOB_TP_MULTIPLIER    = 1.0,
    PET_TP_MULTIPLIER    = 1.0,
    PLAYER_TP_MULTIPLIER = 1.0,
    TRUST_TP_MULTIPLIER  = 1.0,
    FELLOW_TP_MULTIPLIER = 1.0,

    -- Adjust max HP pool for NMs, regular mobs, players, and trusts/fellows. Acts as a multiplier, so default is 1.
    NM_HP_MULTIPLIER        = 1.0,
    MOB_HP_MULTIPLIER       = 1.0,
    PLAYER_HP_MULTIPLIER    = 1.0,
    ALTER_EGO_HP_MULTIPLIER = 1.0,

    -- Adjust max MP pool for NMs, regular mobs, players, and trusts/fellows. Acts as a multiplier, so default is 1.
    NM_MP_MULTIPLIER        = 1.0,
    MOB_MP_MULTIPLIER       = 1.0,
    PLAYER_MP_MULTIPLIER    = 1.0,
    ALTER_EGO_MP_MULTIPLIER = 1.0,

    -- Sets the fraction of MP a subjob provides to the main job. Retail is half and this acts as a divisor so default is 2
    SJ_MP_DIVISOR = 2.0,

    -- Modify ratio of subjob-to-mainjob
    -- 0            = no subjobs
    -- 1            = 1/2   (default, 75/37, 99/49)
    -- 2            = 2/3   (75/50, 99/66)
    -- 3            = equal (75/75, 99/99)
    SUBJOB_RATIO = 1,

    -- Also adjust monsters subjob in ratio adjustments? 1 = true / 0 = false
    INCLUDE_MOB_SJ = false,

    -- Adjust base stats (str/vit/etc.) for NMs, regular mobs, players, and trusts/fellows. Acts as a multiplier, so default is 1.
    NM_STAT_MULTIPLIER        = 1.0,
    MOB_STAT_MULTIPLIER       = 1.0,
    PLAYER_STAT_MULTIPLIER    = 1.0,
    ALTER_EGO_STAT_MULTIPLIER = 1.0,

    -- Adjust skill caps for trusts/fellows. Acts as a multiplier, so default is 1.
    ALTER_EGO_SKILL_MULTIPLIER = 1.0,

    -- Adjust the recast time for abilities. Acts as a multiplier, so default is 1
    ABILITY_RECAST_MULTIPLIER = 1.0,

    -- Enable/disable shared blood pact timer
    BLOOD_PACT_SHARED_TIMER = false,

    -- Adjust mob drop rate. Acts as a multiplier, so default is 1.
    DROP_RATE_MULTIPLIER = 1.0,

    -- Multiplier for gil naturally dropped by mobs. Does not apply to the bonus gil from all_mobs_gil_bonus. Default is 1.0.
    MOB_GIL_MULTIPLIER = 1.0,

    -- All mobs drop this much extra gil per mob LV even if they normally drop zero.
    ALL_MOBS_GIL_BONUS = 0,

    -- Maximum total bonus gil that can be dropped. Default 9999 gil.
    MAX_GIL_BONUS = 9999,

    --  Allow mobs to walk back home instead of despawning
    MOB_NO_DESPAWN = true,

    -- Adds extra time to mob despawn in seconds. Base time is 25s, so a setting of 5 here would be a total of 30 seconds.
    MOB_ADDITIONAL_TIME_TO_DEAGGRO = 0,

    -- Allows parry, block, and guard to skill up regardless of the action occuring.
    -- This did not happen in previous eras
    PARRY_OLD_SKILLUP_STYLE = true,
    BLOCK_OLD_SKILLUP_STYLE = true,
    GUARD_OLD_SKILLUP_STYLE = true,

    -- Globally adjusts ALL battlefield level caps by this many levels.
    BATTLE_CAP_TWEAK = 0,

    -- Enable/disable level cap of mission battlefields stored in database.
    LV_CAP_MISSION_BCNM = 1,

    -- Max allowed merits points players can hold
    --  10 classic
    --  30 abyssea
    MAX_MERIT_POINTS = 10,

    -- Minimum time between uses of yell command (in seconds).
    YELL_COOLDOWN = 30,

    -- Prevent players from sending tells to hidden GMs. You will still receive them from other GMs.
    BLOCK_TELL_TO_HIDDEN_GM = false,

    -- Command Audit [logging] commands with lower permission than this will not be logged.
    -- Zero for no logging at all. Commands given to non GMs are not logged.
    AUDIT_GM_CMD = false,

    -- Todo = other logging including anti-cheat messages

    -- Chat Audit[logging] settings
    AUDIT_CHAT      = false,
    AUDIT_SAY       = false,
    AUDIT_SHOUT     = false,
    AUDIT_TELL      = false,
    AUDIT_YELL      = false,
    AUDIT_LINKSHELL = false,
    AUDIT_UNITY     = false,
    AUDIT_PARTY     = false,

    -- Seconds between healing ticks. Default is 10
    HEALING_TICK_DELAY = 10,

    -- Set to 1 to enable server side anti-cheating measurements
    ANTICHEAT_ENABLED = true,

    -- Set to 1 to completely disable auto-jailing offenders
    ANTICHEAT_JAIL_DISABLE = false,

    -- Gobbie Mystery Box settings
    DAILY_TALLY_AMOUNT = 10,
    DAILY_TALLY_LIMIT  = 50000,

    -- Paralysis Settings
    ITEM_PARALYSIS_LOSS              = true, -- Allow items to be put on recast or deleted when used during a paralysis tick.
    ITEM_PARALYSIS_SCROLL_PROTECTION = false, -- Stops scrolls from being deleted if a paralysis tick occurs.

    -- Enable/disable keeping jug pets through zoning
    KEEP_JUGPET_THROUGH_ZONING = false,
}
