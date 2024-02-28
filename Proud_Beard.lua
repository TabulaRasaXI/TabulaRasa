-----------------------------------
-- Area: Bastok Mines
--  NPC: Proud Beard
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12631, 276,    --Hume Tunic
        12632, 276,    --Hume Vest
        12754, 165,    --Hume M Gloves
        12760, 165,    --Hume F Gloves
        12883, 239,    --Hume Slacks
        12884, 239,    --Hume Pants
        13005, 165,    --Hume M Boots
        13010, 165,    --Hume F Boots
        12637, 276,    --Galkan Surcoat
        12758, 165,    --Galkan Bracers
        12888, 239,    --Galkan Braguette
        13009, 165,     --Galkan Sandals
	15297,	1000,	      --RABBIT_BELT
15298,	1000,	      --WORM_BELT
15299,	1000,	      --MANDRAGORA_BELT
15919,	1000,	      --DROVERS_BELT
15929,	1000,	      --GOBLIN_BELT
15921,	1000,	      --DETONATOR_BELT
18871,	1000,	      --KITTY_ROD
16273,	1000,	      --CHOCOBO_PULLUS_TORQUE
18166,	1000,	      --HAPPY_EGG
18167,	1000,	      --FORTUNE_EGG
18256,	1000,	      --ORPHIC_EGG
13216,	1000,	      --GOLD_MOOGLE_BELT
13217,	1000,	      --SILVER_MOOGLE_BELT
13218,	1000,	      --BRONZE_MOOGLE_BELT
15455,	1000,	      --RED_SASH
15456,	1000,	      --DASH_SASH
181,	1000,	      --SAN_DORIAN_FLAG
182,	1000,	      --BASTOKAN_FLAG
183,	1000,	      --WINDURSTIAN_FLAG
184,	1000,	      --JEUNOAN_FLAG
129,	1000,	      --IMPERIAL_STANDARD
365,	1000,	      --POELE_CLASSIQUE
366,	1000,	      --KANONENOFEN
367,	1000,	      --POT_TOPPER
15860,	1000,	      --GYOKUTO_OBI
272,	1000,	      --ARK_ANGEL_HM_STATUE
273,	1000,	      --ARK_ANGEL_EV_STATUE
274,	1000,	      --ARK_ANGEL_TT_STATUE
275,	1000,	      --ARK_ANGEL_MR_STATUE
276,	1000,	      --ARK_ANGEL_GK_STATUE
11853,	1000,	      --NOVENNIAL_COAT
11956,	1000,	      --NOVENNIAL_HOSE
11854,	1000,	      --NOVENNIAL_DRESS
11957,	1000,	      --NOVENNIAL_THIGH_BOOTS
11811,	1000,	      --DESTRIER_BERET
11812,	1000,	      --CHARITY_CAP
11861,	1000,	      --HIKOGAMI_YUKATA
11862,	1000,	      --HIMEGAMI_YUKATA
3676,	1000,	      --CELESTIAL_GLOBE
18879,	1000,	      --ROUNSEY_WAND
3647,	1000,	      --SPOOK_A_SWIRL
3648,	1000,	      --CHOCOLATE_GRUMPKIN
3649,	1000,	      --HARVEST_HORROR
3677,	1000,	      --SPINET
18880,	1000,	      --MAESTROS_BATON
18863,	1000,	      --DREAM_BELL
15178,	1000,	      --DREAM_HAT
14519,	1000,	      --DREAM_ROBE
10382,	1000,	      --DREAM_MITTENS
11965,	1000,	      --DREAM_TROUSERS
11967,	1000,	      --DREAM_PANTS
15752,	1000,	      --DREAM_BOOTS
10875,	1000,	      --SNOWMAN_CAP
3619,	1000,	      --COURONNE_DES_ETOILES
3620,	1000,	      --SILBERKRANZ
3621,	1000,	      --LEAFBERRY_WREATH
3650,	1000,	      --PRINSEGGSTARTA
3652,	1000,	      --MEMORIAL_CAKE
10430,	1000,	      --DECENNIAL_CROWN
10251,	1000,	      --DECENNIAL_COAT
10593,	1000,	      --DECENNIAL_TIGHTS
10431,	1000,	      --DECENNIAL_TIARA
10252,	1000,	      --DECENNIAL_DRESS
10594,	1000,	      --DECENNIAL_HOSE
10429,	1000,	      --MOOGLE_MASQUE
10250,	1000,	      --MOOGLE_SUIT
17031,	1000,	      --SHELL_SCEPTER
17032,	1000,	      --GOBBIE_GAVEL
10807,	1000,	      --MANDRAGUARD
18881,	1000,	      --MELOMANE_MALLET
10256,	1000,	      --MARINE_GILET
10330,	1000,	      --MARINE_BOXERS
10257,	1000,	      --MARINE_TOP
10331,	1000,	      --MARINE_SHORTS
10258,	1000,	      --WOODSY_GILET
10332,	1000,	      --WOODSY_BOXERS
10259,	1000,	      --WOODSY_TOP
10333,	1000,	      --WOODSY_SHORTS
10260,	1000,	      --CREEK_MAILLOT
10334,	1000,	      --CREEK_BOXERS
10261,	1000,	      --CREEK_TOP
10335,	1000,	      --CREEK_SHORTS
10262,	1000,	      --RIVER_TOP
10336,	1000,	      --RIVER_SHORTS
10263,	1000,	      --DUNE_GILET
10337,	1000,	      --DUNE_BOXERS
10446,	1000,	      --AHRIMAN_CAP
10447,	1000,	      --PYRACMON_CAP
426,	1000,	      --ORCHESTRION
10808,	1000,	      --JANUS_GUARD
3654,	1000,	      --TENDER_BOUQUET
265,	1000,	      --ADAMANTOISE_STATUE
266,	1000,	      --BEHEMOTH_STATUE
267,	1000,	      --FAFNIR_STATUE
269,	1000,	      --SHADOW_LORD_STATUE
270,	1000,	      --ODIN_STATUE
271,	1000,	      --ALEXANDER_STATUE
18464,	1000,	      --ARK_TACHI
18545,	1000,	      --ARK_TABAR
18563,	1000,	      --ARK_SCYTHE
18912,	1000,	      --ARK_SABER
18913,	1000,	      --ARK_SWORD
10293,	1000,	      --CHOCOBO_SHIRT
10809,	1000,	      --MOOGLE_GUARD
10811,	1000,	      --CHOCOBO_SHIELD
27803,	1000,	      --RUSTIC_MAILLOT
28086,	1000,	      --RUSTIC_TRUNKS
27804,	1000,	      --SHOAL_MAILLOT
28087,	1000,	      --SHOAL_TRUNKS
27765,	1000,	      --CHOCOBO_MASQUE
27911,	1000,	      --CHOCOBO_SUIT
27759,	1000,	      --KORRIGAN_BERET
28661,	1000,	      --GLINTING_SHIELD
286,	1000,	      --NANAA_MIHGO_STATUE
27757,	1000,	      --BOMB_MASQUE
287,	1000,	      --NANAA_MIHGO_STATUE_II
27899,	1000,	      --ALLIANCE_SHIRT
28185,	1000,	      --ALLIANCE_PANTS
28324,	1000,	      --ALLIANCE_BOOTS
28655,	1000,	      --SLIME_SHIELD
27756,	1000,	      --SLIME_CAP
28511,	1000,	      --SLIME_EARRING
21118,	1000,	      --GREEN_SPRIGGAN_CLUB
27902,	1000,	      --GREEN_SPRIGGAN_COAT
100,	1000,	      --OKADOMATSU
21117,	1000,	      --HAGOITA
87,	1000,	      --KADOMATSU
20953,	1000,	      --ESCRITORIO
21280,	1000,	      --DECAZOOM_MK_XI
28652,	1000,	      --HATCHLING_SHIELD
28650,	1000,	      --SHE_SLIME_SHIELD
27726,	1000,	      --SHE_SLIME_HAT
28509,	1000,	      --SHE_SLIME_EARRING
28651,	1000,	      --METAL_SLIME_SHIELD
27727,	1000,	      --METAL_SLIME_HAT
28510,	1000,	      --METAL_SLIME_EARRING
27872,	1000,	      --PURPLE_SPRIGGAN_COAT
21113,	1000,	      --PURPLE_SPRIGGAN_CLUB
27873,	1000,	      --RED_SPRIGGAN_COAT
21114,	1000,	      --RED_SPRIGGAN_CLUB
20532,	1000,	      --WORM_FEELERS
27717,	1000,	      --WORM_MASQUE
27715,	1000,	      --GOBLIN_MASQUE
27866,	1000,	      --GOBLIN_SUIT
27716,	1000,	      --GREEN_MOOGLE_MASQUE
27867,	1000,	      --GREEN_MOOGLE_SUIT
278,	1000,	      --CARDIAN_STATUE
281,	1000,	      --ATOMOS_STATUE
284,	1000,	      --GOOBBUE_STATUE
3680,	1000,	      --COPY_OF_JUDGMENT_DAY
3681,	1000,	      --ALZADAAL_TABLE
27859,	1000,	      --KENGYU_HAPPI
28149,	1000,	      --KENGYU_HANMOMOHIKI
27860,	1000,	      --SHOKUJO_HAPPI
28150,	1000,	      --SHOKUJO_HANMOMOHIKI
21107,	1000,	      --KYUKA_UCHIWA
27625,	1000,	      --MORBOL_SHIELD
27626,	1000,	      --CASSIES_SHIELD
26693,	1000,	      --MORBOL_CAP
26694,	1000,	      --CASSIES_CAP
26707,	1000,	      --FLAN_MASQUE
27631,	1000,	      --CAIT_SITH_GUARD
26705,	1000,	      --MANDRAGORA_MASQUE
27854,	1000,	      --MANDRAGORA_SUIT
26703,	1000,	      --LYCOPODIUM_MASQUE
3682,	1000,	      --SPROUTLING_BOARD
3683,	1000,	      --FORESTDWELLER_BOARD
3684,	1000,	      --PRINCESS_BOARD
3685,	1000,	      --EMPRESS_BOARD
3686,	1000,	      --DUELIST_BOARD
3687,	1000,	      --CRYSTAL_BOARD
3688,	1000,	      --DANCER_BOARD
3689,	1000,	      --WIZARDESS_BOARD
3690,	1000,	      --FIGHTER_BOARD
3691,	1000,	      --GUARDIAN_BOARD
3692,	1000,	      --STOIC_BOARD
3693,	1000,	      --LAMB_CARVING
3694,	1000,	      --POLISHED_LAMB_CARVING
3695,	1000,	      --CAIT_SITH_CARVING
21097,	1000,	      --LEAFKIN_BOPPER
26717,	1000,	      --CAIT_SITH_CAP
26728,	1000,	      --FROSTY_CAP
26719,	1000,	      --SHEEP_CAP
26889,	1000,	      --HEART_APRON
21095,	1000,	      --HEARTBEATER
26738,	1000,	      --LEAFKIN_CAP
26729,	1000,	      --COROLLA
26730,	1000,	      --CELESTE_CAP
26788,	1000,	      --RABBIT_CAP
26946,	1000,	      --PUPILS_SHIRT
27281,	1000,	      --PUPILS_TROUSERS
27455,	1000,	      --PUPILS_SHOES
26789,	1000,	      --SHOBUHOUOU_KABUTO
3698,	1000,	      --CHERRY_TREE
20713,	1000,	      --EXCALIPOOR
20714,	1000,	      --EXCALIPOOR_II
26798,	1000,	      --BEHEMOTH_MASQUE
26954,	1000,	      --BEHEMOTH_SUIT
3706,	1000,	      --VANACLOCK
26956,	1000,	      --POROGGO_COAT
3705,	1000,	      --FAR_EAST_HEARTH
26964,	1000,	      --PUPILS_CAMISA
26965,	1000,	      --TA_MOKO
27291,	1000,	      --SWIMMING_TOGS
26967,	1000,	      --COSSIE_TOP
27293,	1000,	      --COSSIE_BOTTOM
21153,	1000,	      --MALICE_MASHER
21086,	1000,	      --HEARTSTOPPER
25606,	1000,	      --AGENT_HOOD
26974,	1000,	      --AGENT_COAT
27111,	1000,	      --AGENT_CUFFS
27296,	1000,	      --AGENT_PANTS
27467,	1000,	      --AGENT_BOOTS
25607,	1000,	      --STARLET_FLOWER
26975,	1000,	      --STARLET_JABOT
27112,	1000,	      --STARLET_GLOVES
27297,	1000,	      --STARLET_SKIRT
27468,	1000,	      --STARLET_BOOTS
3670,	1000,	      --NET_AND_LURE
3672,	1000,	      --CARPENTERS_KIT
3661,	1000,	      --STONE_HEARTH
3595,	1000,	      --GEMSCOPE
3665,	1000,	      --SPINNING_WHEEL
3668,	1000,	      --HIDE_STRETCHER
3663,	1000,	      --SET_OF_BONECRAFTING_TOOLS
3674,	1000,	      --ALEMBIC
3667,	1000,	      --BRASS_CROCK
191,	1000,	      --FISHING_HOLE_MAP
28,	1000,	      --DRAWING_DESK
151,	1000,	      --STACK_OF_FOOLS_GOLD
198,	1000,	      --GILT_TAPESTRY
202,	1000,	      --GOLDEN_FLEECE
142,	1000,	      --DROGAROGAS_FANG
134,	1000,	      --COPY_OF_EMERALDA
137,	1000,	      --CORDON_BLEU_COOKING_SET
25632,	1000,	      --CARBIE_CAP
25604,	1000,	      --BUFFALO_CAP
25713,	1000,	      --TRACK_SHIRT
27325,	1000,	      --TRACK_PANTS
3651,	1000,	      --HARVEST_PASTRY
25711,	1000,	      --BOTULUS_SUIT
25657,	1000,	      --WYRMKING_MASQUE
25756,	1000,	      --WYRMKING_SUIT
25909,	1000,	      --MORBOL_SUBLIGAR
25639,	1000,	      --KORRIGAN_MASQUE
25715,	1000,	      --KORRIGAN_SUIT
25638,	1000,	      --PACHYPODIUM_MASQUE
3707,	1000,	      --MURREY_GRISAILLE
3708,	1000,	      --MOSS_GREEN_GRISAILLE
21074,	1000,	      --KUPO_ROD
26406,	1000,	      --KUPO_SHIELD
25645,	1000,	      --KUPO_MASQUE
25726,	1000,	      --KUPO_SUIT
25648,	1000,	      --CURMUDGEONS_HELMET
25649,	1000,	      --GAZERS_HELMET
25650,	1000,	      --RETCHING_HELMET
25758,	1000,	      --RHAPSODY_SHIRT
25672,	1000,	      --SNOLL_MASQUE
282,	1000,	      --YOVRA_REPLICA
279,	1000,	      --SHADOW_LORD_STATUE_II
280,	1000,	      --SHADOW_LORD_STATUE_III
268,	1000,	      --NOMAD_MOOGLE_STATUE
25670,	1000,	      --RARAB_CAP
26520,	1000,	      --AKITU_SHIRT
25652,	1000,	      --CRAB_CAP
25653,	1000,	      --HALITUS_HELM
22017,	1000,	      --SEIKA_UCHIWA
25586,	1000,	      --KAKAI_CAP
10384,	1000,	      --CUMULUS_MASQUE
22019,	1000,	      --JINGLY_ROD
25722,	1000,	      --JUBILEE_SHIRT
25585,	1000,	      --BLACK_CHOCOBO_CAP
25776,	1000,	      --BLACK_CHOCOBO_SUIT
25677,	1000,	      --ARTHROS_CAP
25675,	1000,	      --WHITE_RARAB_CAP
20668,	1000,	      --FIRETONGUE
22069,	1000,	      --HAPY_STAFF
25755,	1000,	      --CRUSTACEAN_SHIRT
3722,	1000,	      --LION_STATUE
21608,	1000,	      --ONION_SWORD_II
3713,	1000,	      --POT_OF_WARDS
3714,	1000,	      --POT_OF_WHITE_CLEMATIS
3715,	1000,	      --POT_OF_PINK_CLEMATIS
3717,	1000,	      --BIRCH_TREE
3727,	1000,	      --MUMOR_STATUE
3728,	1000,	      --ULLEGORE_STATUE
20577,	1000,	      --CHICKEN_KNIFE_II
3726,	1000,	      --APHMAU_STATUE
20666,	1000,	      --BLIZZARD_BRAND
21741,	1000,	      --DEMONIC_AXE
21609,	1000,	      --SAVE_THE_QUEEN_II
3723,	1000,	      --LILISETTE_STATUE
26410,	1000,	      --DIAMOND_BUCKLER
25850,	1000,	      --PRETTY_PINK_SUBLIGAR
21509,	1000,	      --PREMIUM_MOGTI
3725,	1000,	      --CORNELIA_STATUE
3720,	1000,	      --ARCIELA_STATUE
21658,	1000,	      --BRAVE_BLADE_II
26524,	1000,	      --GIL_NABBER_SHIRT
20665,	1000,	      --KAMLANAUTS_SWORD
26412,	1000,	      --KAMLANAUTS_SHIELD
21965,	1000,	      --ZANMATO
21967,	1000,	      --MELON_SLICER
25774,	1000,	      --FANCY_GILET
25838,	1000,	      --FANCY_TRUNKS
25775,	1000,	      --FANCY_TOP
25839,	1000,	      --FANCY_SHORTS
3724,	1000,	      --UKA_STATUE
3721,	1000,	      --IROHA_STATUE
21682,	1000,	      --LAMENT
22072,	1000,	      --LAMIA_STAFF
21820,	1000,	      --LOST_SICKLE
23731,	1000,	      --ROYAL_CHOCOBO_BERET
26517,	1000,	      --SHADOW_LORD_SHIRT
23730,	1000,	      --KARAKUL_CAP
20573,	1000,	      --AERN_DAGGER
20674,	1000,	      --AERN_SWORD
21742,	1000,	      --AERN_AXE
21860,	1000,	      --AERN_SPEAR
22065,	1000,	      --AERN_STAFF
22039,	1000,	      --FLORAL_HAGOITA
22124,	1000,	      --ARTEMISS_BOW
3719,	1000,	      --PRISHE_STATUE_II
3738,	1000,	      --EASTERN_UMBRELLA
26518,	1000,	      --JODY_SHIRT
27623,	1000,	      --JODY_SHIELD
21867,	1000,	      --SHA_WUJINGS_LANCE
22283,	1000,	      --MARVELOUS_CHEER
26516,	1000,	      --CITRULLUS_SHIRT
20933,	1000,	      --HOTENGEKI
20578,	1000,	      --WIND_KNIFE
3739,	1000,	      --AUTUMN_TREE
20569,	1000,	      --ESIKUVA
20570,	1000,	      --NORGISH_DAGGER
22288,	1000,	      --MANDRAGORA_POUCH
26352,	1000,	      --MOOGLE_SACOCHE
23737,	1000,	      --BYAKKO_MASQUE
22282,	1000,	      --GRUDGE
3740,	1000,	      --MODEL_SYNERGY_FURNACE
26545,	1000,	      --MITHKABOB_SHIRT
21977,	1000,	      --MUTSUNOKAMI
3742,	1000,	      --PAINTING_OF_A_MERCENARY
26519,	1000,	      --MANDRAGORA_SHIRT
26514,	1000,	      --POROGGO_FLEECE
3743,	1000,	      --MOOGLE_BED
21636,	1000,	      --NIHILITY
23753,	1000,	      --SANDOGASA
54,	1000,	      --CHOCOBO_COMMODE
25910,	1000,	      --CAIT_SITH_SUBLIGAR
20571,	1000,	      --INFILTRATOR
23790,	1000,	      --ADENIUM_MASQUE
23791,	1000,	      --ADENIUM_SUIT
26489,	1000,	      --TROTH
22153,	1000,	      --SILVER_GUN
20574,	1000,	      --AERN_DAGGER_II
20675,	1000,	      --AERN_SWORD_II
21743,	1000,	      --AERN_AXE_II
21861,	1000,	      --AERN_SPEAR_II
22066,	1000,	      --AERN_STAFF_II
3748,	1000,	      --LEAFKIN_BED
21638,	1000,	      --EXTINCTION
23800,	1000,	      --CANCRINE_APRON
3749,	1000,	      --CHEMISTRY_SET
3750,	1000,	      --QIQIRN_SACK
22045,	1000,	      --FELINE_HAGOITA
3751,	1000,	      --BESIGILED_TABLE
    }

    player:showText(npc, ID.text.PROUDBEARD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
