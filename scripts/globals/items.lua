-----------------------------------
-- Items
-- Item table by ID (used by quests)
-----------------------------------
xi = xi or {}

xi.items =
{
    IMPERIAL_STANDARD               = 129,
    TABLEWARE_SET                   = 132,
    TEA_SET                         = 133,
    SAN_DORIAN_FLAG                 = 181,
    BASTOKAN_FLAG                   = 182,
    WINDURSTIAN_FLAG                = 183,
    COPY_OF_ANCIENT_BLOOD           = 206,
    HUME_M_MANNEQUIN                = 256,
    HUME_F_MANNEQUIN                = 257,
    ELVAAN_M_MANNEQUIN              = 258,
    ELVAAN_F_MANNEQUIN              = 259,
    TARUTARU_M_MANNEQUIN            = 260,
    TARUTARU_F_MANNEQUIN            = 261,
    MITHRA_MANNEQUIN                = 262,
    GALKA_MANNEQUIN                 = 263,
    PRISHE_STATUE                   = 277,
    NANAA_MIHGO_STATUE              = 286,
    CANTEEN_OF_DRACHENFALL_WATER    = 492,
    BRASS_CANTEEN                   = 493,
    QUADAV_AUGURY_SHELL             = 494,
    QUADAV_CHARM                    = 495,
    PINCH_OF_VALKURM_SUNSAND        = 503,
    RHINOSTERY_CANTEEN              = 504,
    SHEEPSKIN                       = 505,
    LANOLIN_CUBE                    = 531,
    MAGICMART_FLYER                 = 532,
    CLUMP_OF_GAUSEBIT_WILDGRASS     = 534,
    DAMSELFLY_WORM                  = 537,
    MAGICKED_SKULL                  = 538,
    CRAB_APRON                      = 539,
    BLOODY_ROBE                     = 540,
    CUP_OF_DHALMEL_SALIVA           = 541,
    WILD_RABBIT_TAIL                = 542,
    STARFALL_TEAR                   = 546,
    TOMB_GUARDS_WATERSKIN           = 547,
    DELKFUTT_KEY                    = 549,
    LOCK_OF_HIWONS_HAIR             = 552,
    DANGRUF_STONE                   = 553,
    DIVINATION_SPHERE               = 556,
    AHRIMAN_LENS                    = 557,
    TARUT_CARD_THE_FOOL             = 558,
    TARUT_CARD_DEATH                = 559,
    PINCH_OF_ZERUHN_SOOT            = 560,
    TARUT_CARD_THE_KING             = 561,
    TARUT_CARD_THE_HERMIT           = 562,
    GLOCOLITE                       = 563,
    SKIN_OF_WELL_WATER              = 567,
    CLAY_TABLET                     = 570,
    LUMP_OF_SELBINA_CLAY            = 571,
    SIRENS_TEAR                     = 576,
    EAGLE_BUTTON                    = 578,
    GILT_GLASSES                    = 579,
    SUPPLIES_ORDER                  = 592,
    PARCEL_FOR_THE_MAGIC_SHOP       = 593,
    CHUNK_OF_MINE_GRAVEL            = 597,
    SHARP_STONE                     = 598,
    ONZ_OF_MYTHRIL_SAND             = 599,
    DOSE_OF_OINTMENT                = 600,
    OINTMENT_CASE                   = 601,
    BLESSED_WATERSKIN               = 602,
    SKIN_OF_CHEVAL_RIVER_WATER      = 603,
    PICKAXE                         = 605,
    QUADAV_FETICH_HEAD              = 606,
    QUADAV_FETICH_TORSO             = 607,
    QUADAV_FETICH_ARMS              = 608,
    QUADAV_FETICH_LEGS              = 609,
    FADED_CRYSTAL                   = 613,
    STICK_OF_SELBINA_BUTTER         = 615,
    CLUMP_OF_PAMTAM_KELP            = 624,
    CHAMOMILE                       = 636,
    VIAL_OF_SLIME_OIL               = 637,
    CHUNK_OF_TIN_ORE                = 641,
    CHUNK_OF_ZINC_ORE               = 642,
    CHUNK_OF_DARKSTEEL_ORE          = 645,
    CHUNK_OF_ADAMAN_ORE             = 646,
    STEEL_INGOT                     = 652,
    MYTHRIL_INGOT                   = 653,
    DARKSTEEL_INGOT                 = 654,
    ADAMAN_INGOT                    = 655,
    BRASS_SHEET                     = 661,
    MYTHRIL_SHEET                   = 663,
    PETRIFIED_LOG                   = 703,
    ROSEWOOD_LUMBER                 = 718,
    CHUNK_OF_GOLD_ORE               = 737,
    CHUNK_OF_PLATINUM_ORE           = 738,
    GOLD_INGOT                      = 745,
    ORICHALCUM_INGOT                = 747,
    GOLD_BEASTCOIN                  = 748,
    MYTHRIL_BEASTCOIN               = 749,
    SILVER_BEASTCOIN                = 750,
    RED_ROCK                        = 769,
    BLUE_ROCK                       = 770,
    YELLOW_ROCK                     = 771,
    GREEN_ROCK                      = 772,
    TRANSLUCENT_ROCK                = 773,
    PURPLE_ROCK                     = 774,
    BLACK_ROCK                      = 775,
    WHITE_ROCK                      = 776,
    LINEN_CLOTH                     = 826,
    PERIDOT                         = 788,
    PAINITE                         = 797,
    TURQUOISE                       = 798,
    GOSHENITE                       = 808,
    DEATHSTONE                      = 812,
    ANGELSTONE                      = 813,
    GOLD_THREAD                     = 823,
    SQUARE_OF_LINEN_CLOTH           = 826,
    SQUARE_OF_WOOL_CLOTH            = 827,
    SQUARE_OF_VELVET_CLOTH          = 828,
    SQUARE_OF_SILK_CLOTH            = 829,
    SQUARE_OF_RAINBOW_CLOTH         = 830,
    BALL_OF_SARUTA_COTTON           = 834,
    FLAX_FLOWER                     = 835,
    INSECT_WING                     = 846,
    SQUARE_OF_DHALMEL_LEATHER       = 848,
    SQUARE_OF_RAM_LEATHER           = 851,
    LIZARD_SKIN                     = 852,
    SQUARE_OF_BLACK_TIGER_LEATHER   = 855,
    TIGER_HIDE                      = 861,
    HANDFUL_OF_PUGIL_SCALES         = 868,
    SQUARE_OF_KARAKUL_LEATHER       = 879,
    BONE_CHIP                       = 880,
    BAT_FANG                        = 891,
    BEEHIVE_CHIP                    = 912,
    SHEET_OF_PARCHMENT              = 917,
    MALBORO_VINE                    = 920,
    LIZARD_TAIL                     = 926,
    JAR_OF_BLACK_INK                = 929,
    CERMET_CHUNK                    = 931,
    CHUNK_OF_ROCK_SALT              = 936,
    PAPAKA_GRASS                    = 938,
    HECTEYES_EYE                    = 939,
    RED_ROSE                        = 941,
    CARNATION                       = 948,
    RAIN_LILY                       = 949,
    TAHRONGI_CACTUS                 = 950,
    LILAC                           = 956,
    AMARYLLIS                       = 957,
    MARGUERITE                      = 958,
    DAHLIA                          = 959,
    SICKLE                          = 1020,
    HATCHET                         = 1021,
    SET_OF_THIEFS_TOOLS             = 1022,
    LIVING_KEY                      = 1023,
    DAVOI_COFFER_KEY                = 1042,
    BEADEAUX_COFFER_KEY             = 1043,
    OZTROJA_COFFER_KEY              = 1044,
    UGGALEPIH_COFFER_KEY            = 1049,
    RANCOR_DEN_COFFER_KEY           = 1050,
    QUICKSAND_COFFER_KEY            = 1054,
    GROTTO_COFFER_KEY               = 1059,
    PIECE_OF_ANCIENT_PAPYRUS        = 1088,
    CLUMP_OF_EXORAY_MOLD            = 1089,
    CHUNK_OF_BOMB_COAL              = 1090,
    LUMP_OF_CHANDELIER_COAL         = 1091,
    REGAL_DIE                       = 1092,
    SULFUR                          = 1108,
    ORCISH_MAIL_SCALES              = 1112,
    SKELETON_KEY                    = 1115,
    CASABLANCA                      = 1120,
    BEASTMENS_SEAL                  = 1126,
    KINDREDS_SEAL                   = 1127,
    MOON_ORB                        = 1130,
    STAR_ORB                        = 1131,
    NORG_SHELL                      = 1135,
    UNLIT_LANTERN                   = 1138,
    RANCOR_FLAME                    = 1139,
    FLAME_OF_CRIMSON_RANCOR         = 1140,
    FLAME_OF_BLUE_RANCOR            = 1141,
    CURSED_KEY                      = 1143,
    SHOALWEED                       = 1148,
    STAR_SPINEL                     = 1149,
    LUMP_OF_ORIENTAL_STEEL          = 1151,
    LUMP_OF_BOMB_STEEL              = 1152,
    SACRED_BRANCH                   = 1153,
    WYVERN_EGG                      = 1159,
    FRAG_ROCK                       = 1160,
    TSURARA                         = 1164,
    BANISHING_CHARM                 = 1166,
    SACK_OF_FISH_BAIT               = 1168,
    CLOTHO_ORB                      = 1175,
    COMET_ORB                       = 1177,
    LACHESIS_ORB                    = 1178,
    ATROPOS_ORB                     = 1180,
    CLUMP_OF_GOOBBUE_HUMUS          = 1181,
    OFFERING_TO_UGGALEPIH           = 1183,
    UGGALEPIH_WHISTLE               = 1184,
    ANTICAN_TAG                     = 1190,
    SAHAGIN_KEY                     = 1197,
    SACRED_SPRIG                    = 1198,
    TONBERRY_RATTLE                 = 1266,
    SWEET_WILLIAM                   = 1410,
    PHALAENOPSIS                    = 1411,
    OLIVE_FLOWER                    = 1412,
    CATTLEYA                        = 1413,
    GEM_OF_THE_EAST                 = 1418,
    SPRINGSTONE                     = 1419,
    GEM_OF_THE_SOUTH                = 1420,
    SUMMERSTONE                     = 1421,
    GEM_OF_THE_WEST                 = 1422,
    AUTUMNSTONE                     = 1423,
    GEM_OF_THE_NORTH                = 1424,
    WINTERSTONE                     = 1425,
    WARRIORS_TESTIMONY              = 1426,
    MONKS_TESTIMONY                 = 1427,
    WHITE_MAGES_TESTIMONY           = 1428,
    BLACK_MAGES_TESTIMONY           = 1429,
    RED_MAGES_TESTIMONY             = 1430,
    THIEFS_TESTIMONY                = 1431,
    PALADINS_TESTIMONY              = 1432,
    DARK_KNIGHTS_TESTIMONY          = 1433,
    BEASTMASTERS_TESTIMONY          = 1434,
    BARDS_TESTIMONY                 = 1435,
    RANGERS_TESTIMONY               = 1436,
    SAMURAIS_TESTIMONY              = 1437,
    NINJAS_TESTIMONY                = 1438,
    DRAGOONS_TESTIMONY              = 1439,
    SUMMONERS_TESTIMONY             = 1440,
    LUNGO_NANGO_JADESHELL           = 1450,
    RIMILALA_STRIPESHELL            = 1451,
    MONTIONT_SILVERPIECE            = 1453,
    RANPERRE_GOLDPIECE              = 1454,
    ONE_HUNDRED_BYNE_BILL           = 1456,
    TEN_THOUSAND_BYNE_BILL          = 1457,
    GARDENIA_SEED                   = 1472,
    JADE_CRYPTEX                    = 1532,
    SILVER_ENGRAVING                = 1533,
    THIRTEEN_KNOT_QUIPU             = 1535,
    SQUARE_OF_GRIFFON_LEATHER       = 1459,
    CLOUDY_ORB                      = 1551,
    SKY_ORB                         = 1552,
    THEMIS_ORB                      = 1553,
    MYSTIC_FRAGMENT                 = 1571,
    ORNATE_FRAGMENT                 = 1572,
    HOLY_FRAGMENT                   = 1573,
    INTRICATE_FRAGMENT              = 1574,
    RUNAEIC_FRAGMENT                = 1575,
    SERAPHIC_FRAGMENT               = 1576,
    TENEBROUS_FRAGMENT              = 1577,
    STELLAR_FRAGMENT                = 1578,
    DEMONIAC_FRAGMENT               = 1579,
    DIVINE_FRAGMENT                 = 1580,
    HEAVENLY_FRAGMENT               = 1581,
    CELESTIAL_FRAGMENT              = 1582,
    SNARLED_FRAGMENT                = 1583,
    MYSTERIAL_FRAGMENT              = 1584,
    ETHEREAL_FRAGMENT               = 1585,
    SHARD_OF_NECROPSYCHE            = 1589,
    HOLY_BASIL                      = 1590,
    MANNEQUIN_HEAD                  = 1601,
    MANNEQUIN_BODY                  = 1602,
    MANNEQUIN_HANDS                 = 1603,
    MANNEQUIN_LEGS                  = 1604,
    MANNEQUIN_FEET                  = 1605,
    RHODONITE                       = 1634,
    PAKTONG_INGOT                   = 1635,
    SQUARE_OF_MOBLINWEAVE           = 1636,
    SQUARE_OF_BUGARD_LEATHER        = 1637,
    SEALION_CREST_KEY               = 1658,
    CORAL_CREST_KEY                 = 1659,
    CATHEDRAL_TAPESTRY              = 1662,
    INGOT_OF_ROYAL_TREASURY_GOLD    = 1682,
    PIECE_OF_ATTOHWA_GINSENG        = 1683,
    SOILED_LETTER                   = 1686,
    HIPPOGRYPH_TAILFEATHER          = 1690,
    CARMINE_CHIP                    = 1692,
    CYAN_CHIP                       = 1693,
    GRAY_CHIP                       = 1694,
    NYUMOMO_DOLL                    = 1706,
    MOLYBDENUM_INGOT                = 1711,
    SNOW_LILY                       = 1725,
    EGRET_FISHING_ROD               = 1726,
    SHAKUDO_INGOT                   = 1738,
    SQUARE_OF_BALLON_CLOTH          = 1739,
    IOLITE                          = 1740,
    HIGH_QUALITY_EFT_SKIN           = 1741,
    FREE_CHOCOPASS                  = 1789,
    SUPERNAL_FRAGMENT               = 1822,
    YAGUDO_HEADDRESS_CUTTING        = 1867,
    SQUARE_OF_LM_BUFFALO_LEATHER    = 2007,
    SQUARE_OF_WOLF_FELT             = 2010,
    MERROW_SCALE                    = 2146,
    TROLL_PAULDRON                  = 2160,
    IMP_WING                        = 2163,
    WAMOURA_COCOON                  = 2173,
    FLAN_MEAT                       = 2175,
    IMPERIAL_BRONZE_PIECE           = 2184,
    IMPERIAL_SILVER_PIECE           = 2185,
    IMPERIAL_MYTHRIL_PIECE          = 2186,
    IMPERIAL_GOLD_PIECE             = 2187,
    UNAPPRAISED_SWORD               = 2190,
    UNAPPRAISED_DAGGER              = 2191,
    UNAPPRAISED_POLEARM             = 2192,
    UNAPPRAISED_AXE                 = 2193,
    UNAPPRAISED_BOW                 = 2194,
    UNAPPRAISED_GLOVES              = 2195,
    UNAPPRAISED_FOOTWEAR            = 2196,
    LIGHTNING_BAND                  = 2217,
    LAMIAN_FANG_KEY                 = 2219,
    HALVUNG_SHAKUDO_KEY             = 2221,
    HALVUNG_BRONZE_KEY              = 2222,
    HALVUNG_BRASS_KEY               = 2223,
    UNAPPRAISED_HEADPIECE           = 2276,
    UNAPPRAISED_EARRING             = 2277,
    UNAPPRAISED_RING                = 2278,
    UNAPPRAISED_CAPE                = 2279,
    UNAPPRAISED_SASH                = 2280,
    UNAPPRAISED_SHIELD              = 2281,
    UNAPPRAISED_NECKLACE            = 2282,
    UNAPPRAISED_INGOT               = 2283,
    UNAPPRAISED_POTION              = 2284,
    UNAPPRAISED_CLOTH               = 2285,
    UNAPPRAISED_BOX                 = 2286,
    SQUARE_OF_KARAKUL_CLOTH         = 2288,
    SQUARE_OF_WAMOURA_CLOTH         = 2289,
    CHUNK_OF_IMPERIAL_CERMET        = 2290,
    VIAL_OF_JODYS_ACID              = 2307,
    CHOCOBO_EGG                     = 2317,
    BLUE_MAGES_TESTIMONY            = 2331,
    CORSAIRS_TESTIMONY              = 2332,
    PUPPETMASTERS_TESTIMONY         = 2333,
    POROGGO_HAT                     = 2334,
    SOULFLAYER_STAFF                = 2336,
    RUBBER_CAP                      = 2465,
    RUBBER_HARNESS                  = 2466,
    RUBBER_GLOVES                   = 2467,
    RUBBER_CHAUSSES                 = 2468,
    RUBBER_SOLES                    = 2469,
    NETHEREYE_CHAIN                 = 2470,
    NETHERFIELD_CHAIN               = 2471,
    NETHERSPIRIT_CHAIN              = 2472,
    NETHERCANT_CHAIN                = 2473,
    NETHERPACT_CHAIN                = 2474,
    SOUL_PLATE                      = 2477,
    FORBIDDEN_KEY                   = 2490,
    BLACK_PUPPET_TURBAN             = 2501,
    WHITE_PUPPET_TURBAN             = 2502,
    HEAVY_QUADAV_CHESTPLATE         = 2504,
    HEAVY_QUADAV_BACKPLATE          = 2505,
    LADYBUG_WING                    = 2506,
    LYCOPODIUM_FLOWER               = 2507,
    VELLUM                          = 2550,
    SQUARE_OF_SMILODON_LEATHER      = 2529,
    SQUARE_OF_LYNX_LEATHER          = 2530,
    ELECTRUM_INGOT                  = 2536,
    SQUARE_OF_CILICE                = 2537,
    SQUARE_OF_PEISTE_LEATHER        = 2538,
    ASPHODEL                        = 2554,
    DANCERS_TESTIMONY               = 2556,
    SCHOLARS_TESTIMONY              = 2557,
    BLOCK_OF_YAGUDO_GLUE            = 2558,
    BALRAHNS_EYEPATCH               = 2571,
    SQUARE_OF_OIL_SOAKED_CLOTH      = 2704,
    SQUARE_OF_FOULARD               = 2705,
    CERNUNNOS_BULB                  = 2728,
    OXBLOOD_ORB                     = 2743,
    ANGEL_SKIN_ORB                  = 2744,
    ORCISH_PLATE_ARMOR              = 2757,
    QUADAV_BACKSCALE                = 2758,
    YAGUDO_CAULK                    = 2759,
    KINDREDS_CREST                  = 2955,
    HIGH_KINDREDS_CREST             = 2956,
    SACRED_KINDREDS_CREST           = 2957,
    WATER_LILY                      = 2960,
    INCRESCENT_SHADE                = 3295,
    DECRESCENT_SHADE                = 3296,
    PHOBOS_ORB                      = 3351,
    DEIMOS_ORB                      = 3352,
    ZELOS_ORB                       = 3454,
    BIA_ORB                         = 3455,
    SEASONING_STONE                 = 3541,
    FOSSILIZED_BONE                 = 3542,
    FOSSILIZED_FANG                 = 3543,
    VALKYRIES_TEAR                  = 3856,
    VALKYRIES_WING                  = 3867,
    VALKYRIES_SOUL                  = 3868,
    VELKK_NECKLACE                  = 3928,
    VELKK_MASK                      = 3929,
    TWITHERYM_WING                  = 3930,
    UMBRIL_OOZE                     = 3935,
    MICROCOSMIC_ORB                 = 4062,
    MACROCOSMIC_ORB                 = 4063,
    BOWL_OF_GOBLIN_STEW_880         = 4094,
    FIRE_CRYSTAL                    = 4096,
    ICE_CRYSTAL                     = 4097,
    EARTH_CRYSTAL                   = 4099,
    WATER_CRYSTAL                   = 4101,
    DARK_CRYSTAL                    = 4103,
    HI_POTION_I                     = 4117,
    HI_POTION_II                    = 4118,
    HI_POTION_III                   = 4119,
    REMEDY                          = 4155,
    FLASK_OF_SLEEPING_POTION        = 4161,
    RERAISER                        = 4172,
    SCROLL_OF_INSTANT_WARP          = 4181,
    CATHOLICON                      = 4206,
    MANA_POWDER                     = 4255,
    CANTEEN_OF_GIDDEUS_WATER        = 4351,
    CRAWLER_EGG                     = 4357,
    SLICE_OF_HARE_MEAT              = 4358,
    DHALMEL_MEAT                    = 4359,
    BASTORE_SARDINE                 = 4360,
    LIZARD_EGG                      = 4362,
    ROLANBERRY                      = 4365,
    CLUMP_OF_BATAGREENS             = 4367,
    POT_OF_HONEY                    = 4370,
    SLICE_OF_GRILLED_HARE           = 4371,
    SLICE_OF_GIANT_SHEEP_MEAT       = 4372,
    STRIP_OF_MEAT_JERKY             = 4376,
    SLICE_OF_COEURL_MEAT            = 4377,
    FROST_TURNIP                    = 4382,
    WILD_ONION                      = 4387,
    EGGPLANT                        = 4388,
    LAND_CRAB_MEAT                  = 4400,
    TORTILLA                        = 4408,
    HARD_BOILED_EGG                 = 4409,
    BAKED_POPOTO                    = 4436,
    COBALT_JELLYFISH                = 4443,
    RARAB_TAIL                      = 4444,
    SCREAM_FUNGUS                   = 4447,
    PUFFBALL                        = 4448,
    CRESCENT_FISH                   = 4473,
    THREE_EYED_FISH                 = 4478,
    CUP_OF_WINDURSTIAN_TEA          = 4493,
    CHUNK_OF_GOBLIN_CHOCOLATE       = 4495,
    CRYSTAL_BASS                    = 4528,
    BUNCH_OF_GYSAHL_GREENS          = 4545,
    BOWL_OF_QUADAV_STEW             = 4569,
    BIRD_EGG                        = 4570,
    SCROLL_OF_CURE_II               = 4610,
    SCROLL_OF_CURE_V                = 4613,
    SCROLL_OF_REGEN                 = 4716,
    SCROLL_OF_FIRE                  = 4752,
    SCROLL_OF_STONE_IV              = 4770,
    SCROLL_OF_BLAZE_SPIKES          = 4857,
    SCROLL_OF_RETRACE               = 4873,
    SCROLL_OF_ABSORB_INT            = 4878,
    SCROLL_OF_HOJO_ICHI             = 4952,
    SCROLL_OF_FOE_SIRVENTE          = 5076,
    SCROLL_OF_ADVENTURERS_DIRGE     = 5077,
    ISTAVRIT                        = 5136,
    PITCHER_OF_HOMEMADE_HERBAL_TEA  = 5221,
    BOWL_OF_HOMEMADE_STEW           = 5222,
    CONE_OF_HOMEMADE_GELATO         = 5223,
    HOMEMADE_RICE_BALL              = 5224,
    CHUNK_OF_HOMEMADE_CHEESE        = 5225,
    HOMEMADE_STEAK                  = 5226,
    PLATE_OF_HOMEMADE_SALAD         = 5227,
    LOAF_OF_HOMEMADE_BREAD          = 5228,
    PLATE_OF_HOMEMADE_RISOTTO       = 5229,
    MISTMELT                        = 5265,
    HEALING_POWDER                  = 5322,
    QIQIRN_MINE                     = 5331,
    KABURA_QUIVER                   = 5332,
    CAGE_OF_AZOUPH_FIREFLIES        = 5343,
    CAGE_OF_BHAFLAU_FIREFLIES       = 5344,
    CAGE_OF_ZHAYOLM_FIREFLIES       = 5345,
    CAGE_OF_DVUCCA_FIREFLIES        = 5346,
    CAGE_OF_REEF_FIREFLIES          = 5347,
    UNDERSEA_RUINS_FIREFLIES        = 5348,
    CAGE_OF_CUTTER_FIREFLIES        = 5349,
    BULLET_POUCH                    = 5363,
    SMOLDERING_LAMP                 = 5413,
    GLOWING_LAMP                    = 5414,
    DUSTY_ELIXIR                    = 5433,
    VICARS_DRINK                    = 5439,
    ISTAKOZ                         = 5453,
    MERCANBALIGI                    = 5454,
    AHTAPOT                         = 5455,
    ISTIRIDYE                       = 5456,
    BASTORE_SWEEPER                 = 5473,
    CORSAIR_DIE                     = 5493,
    POT_OF_WHITE_HONEY              = 5562,
    CUP_OF_CHAI                     = 5570,
    IRMIK_HELVASI                   = 5572,
    BOWL_OF_SUTLAC                  = 5577,
    CUP_OF_IMPERIAL_COFFEE          = 5592,
    BOWL_OF_NASHMAU_STEW            = 5595,
    PEPPERONI                       = 5660,
    WALNUT                          = 5661,
    DRAGON_FRUIT                    = 5662,
    LYNX_MEAT                       = 5667,
    HOMEMADE_SALISBURY_STEAK        = 5705,
    DISH_OF_HOMEMADE_CARBONARA      = 5706,
    HOMEMADE_OMELETTE               = 5707,
    LUCID_POTION_I                  = 5824,
    LUCID_POTION_II                 = 5825,
    LUCID_ETHER_I                   = 5827,
    LUCID_ETHER_II                  = 5828,
    LUCID_ELIXIR_I                  = 5830,
    HEALING_SALVE_I                 = 5835,
    CLEAR_SALVE_I                   = 5837,
    CLEAR_SALVE_II                  = 5838,
    STALWARTS_TONIC                 = 5839,
    ASCETICS_TONIC                  = 5841,
    CHAMPIONS_TONIC                 = 5843,
    PRIMEVAL_BREW                   = 5853,
    PETRIFY_SCREEN                  = 5876,
    TERROR_SCREEN                   = 5877,
    AMNESIA_SCREEN                  = 5878,
    DOOM_SCREEN                     = 5879,
    POISON_SCREEN                   = 5880,
    OLDE_RARAB_TAIL                 = 5911,
    PLATE_OF_INDI_POISON            = 6074,
    SHADOW_THRONE                   = 6410,
    PORXIE_QUIVER                   = 6414,
    SEKI_SHURIKEN_POUCH             = 6415,
    DIVINE_QUIVER                   = 6417,
    BERYLLIUM_QUIVER                = 6418,
    RAETIC_QUIVER                   = 6419,
    VOLUSPA_QUIVER                  = 6420,
    DIVINE_BOLT_QUIVER              = 6427,
    BERYLLIUM_BOLT_QUIVER           = 6428,
    VOLUSPA_BOLT_QUIVER             = 6429,
    DIVINE_BULLET_POUCH             = 6437,
    VOLUSPA_BULLET_POUCH            = 6438,
    DATE_SHURIKEN_POUCH             = 6449,
    HARLEQUIN_HEAD                  = 8193,
    VALOREDGE_HEAD                  = 8194,
    SHARPSHOT_HEAD                  = 8195,
    STORMWAKER_HEAD                 = 8196,
    SOULSOOTHER_HEAD                = 8197,
    SPIRITREAVER_HEAD               = 8198,
    HARLEQUIN_FRAME                 = 8224,
    VALOREDGE_FRAME                 = 8225,
    SHARPSHOT_FRAME                 = 8226,
    STORMWAKER_FRAME                = 8227,
    COPPER_AMAN_VOUCHER             = 8711,
    MOBLIN_OIL                      = 8801,
    CLUMP_OF_BEE_POLLEN             = 9082,
    MANDRAGORA_DEWDROP              = 9083,
    CIPHER_OF_RAINEMARDS_ALTER_EGO  = 10119,
    CIPHER_OF_SEMIHS_ALTER_EGO      = 10157,
    CIPHER_OF_HALVERS_ALTER_EGO     = 10158,
    CIPHER_OF_LIONS_ALTER_EGO_II    = 10159,
    CIPHER_OF_ZEIDS_ALTER_EGO_II    = 10160,
    CIPHER_OF_TENZENS_ALTER_EGO_II  = 10167,
    BENEDIGHT_COAT                  = 11309,
    PERLE_SOLLERETS                 = 11413,
    AURORE_GAITERS                  = 11414,
    TEAL_PIGACHES                   = 11415,
    PERLE_SALADE                    = 11503,
    AURORE_BERET                    = 11504,
    TEAL_CHAPEAU                    = 11505,
    NEXUS_CAPE                      = 11538,
    RAVAGERS_MASK                   = 12008,
    TANTRA_CROWN                    = 12009,
    ORISON_CAP                      = 12010,
    GOETIA_PETASOS                  = 12011,
    ESTOQUEURS_CHAPPEL              = 12012,
    RAIDERS_BONNET                  = 12013,
    CREED_ARMET                     = 12014,
    BALE_BURGEONET                  = 12015,
    FERINE_CABASSET                 = 12016,
    AOIDOS_CALOT                    = 12017,
    SYLVAN_GAPETTE                  = 12018,
    UNKAI_KABUTO                    = 12019,
    IGA_ZUKIN                       = 12020,
    LANCERS_MEZAIL                  = 12021,
    CALLERS_HORN                    = 12022,
    MAVI_KAVUK                      = 12023,
    NAVARCHS_TRICORNE               = 12024,
    CIRQUE_CAPPELLO                 = 12025,
    CHARIS_TIARA                    = 12026,
    SAVANTS_BONNET                  = 12027,
    UNKAI_DOMARU                    = 12039,
    IGA_NINGI                       = 12040,
    LANCERS_PLACKART                = 12041,
    CALLERS_DOUBLET                 = 12042,
    MAVI_MINTAN                     = 12043,
    NAVARCHS_FRAC                   = 12044,
    CIRQUE_FARSETTO                 = 12045,
    CHARIS_CASAQUE                  = 12046,
    SAVANTS_GOWN                    = 12047,
    RAVAGERS_MUFFLERS               = 12048,
    TANTRA_GLOVES                   = 12049,
    ORISON_MITTS                    = 12050,
    GOETIA_GLOVES                   = 12051,
    ESTOQUEURS_GANTHEROTS           = 12052,
    RAIDERS_ARMLETS                 = 12053,
    CREED_GAUNTLETS                 = 12054,
    BALE_GAUNTLETS                  = 12055,
    FERINE_MANOPLAS                 = 12056,
    AOIDOS_MANCHETTES               = 12057,
    SYLVAN_GLOVELETTES              = 12058,
    UNKAI_KOTE                      = 12059,
    IGA_TEKKO                       = 12060,
    LANCERS_VAMBRACES               = 12061,
    CALLERS_BRACERS                 = 12062,
    MAVI_BAZUBANDS                  = 12063,
    NAVARCHS_GANTS                  = 12064,
    CIRQUE_GUANTI                   = 12065,
    CHARIS_BANGLES                  = 12066,
    SAVANTS_BRACERS                 = 12067,
    PARANA_SHIELD                   = 12298,
    WOOL_HAT                        = 12474,
    ROGUES_BONNET                   = 12514,
    BLUE_RIBBON                     = 12521,
    LEATHER_VEST                    = 12568,
    BRONZE_HARNESS                  = 12576,
    KENPOGI                         = 12584,
    POWER_GI                        = 12590,
    ROBE                            = 12600,
    TUNIC                           = 12608,
    LEATHER_GLOVES                  = 12696,
    LIZARD_GLOVES                   = 12697,
    PERLE_MOUFLES                   = 12745,
    AURORE_GLOVES                   = 12746,
    TEAL_CUFFS                      = 12747,
    BRONZE_SUBLIGAR                 = 12832,
    GORGET_1                        = 13065,
    FEATHER_COLLAR                  = 13075,
    LEATHER_GORGET                  = 13081,
    CHAIN_CHOKER                    = 13083,
    JUSTICE_BADGE                   = 13093,
    FLOWER_NECKLACE                 = 13094,
    TIGER_STOLE                     = 13119,
    BEAST_COLLAR                    = 13121,
    SPECTACLES                      = 13128,
    ASHURA_NECKLACE                 = 13134,
    PROMISE_BADGE                   = 13135,
    STAR_NECKLACE                   = 13136,
    JAGD_GORGET                     = 13165,
    WILLPOWER_TORQUE                = 13174,
    WING_PENDANT                    = 13183,
    HEKO_OBI                        = 13204,
    BEETLE_RING                     = 13457,
    BRASS_RING                      = 13465,
    PURPLE_RIBBON                   = 13569,
    RAPTOR_MANTLE                   = 13593,
    ENHANCING_MANTLE                = 13624,
    HI_POTION_TANK                  = 13688,
    HI_ETHER_TANK                   = 13689,
    PERLE_HAUBERK                   = 13759,
    AURORE_DOUBLET                  = 13760,
    TEAL_SAIO                       = 13778,
    MYOCHIN_KABUTO                  = 13868,
    BRIDAL_CORSAGE                  = 13933,
    ROGUES_POULAINES                = 14094,
    MYOCHIN_SUNE_ATE                = 14100,
    WEDDING_BOOTS                   = 14126,
    PERLE_BRAYETTES                 = 14210,
    WEDDING_HOSE                    = 14251,
    WEDDING_DRESS                   = 14386,
    AMIR_KORAZIN                    = 14525,
    YIGIT_GOMLEK                    = 14527,
    PAHLUWAN_KHAZAGAND              = 14530,
    DANCERS_CASAQUE                 = 14579,
    AURORE_BRAIS                    = 14257,
    TEAL_SLOPS                      = 14258,
    DUCAL_GUARDS_RING               = 14657,
    CUNNING_EARRING                 = 14760,
    AMIR_KOLLUKS                    = 14933,
    YIGIT_GAGES                     = 14935,
    STORM_GAGES                     = 14937,
    PAHLUWAN_DASTANAS               = 14940,
    TRAINEE_GLOVES                  = 15008,
    ANCILE                          = 15069,
    AEGIS                           = 15070,
    MAATS_CAP                       = 15194,
    YAGUDO_HEADGEAR                 = 15202,
    TSOO_HAJAS_HEADGEAR             = 15216,
    STORM_CAPE                      = 15489,
    MIRACULOUS_CAPE                 = 15490,
    BULLSEYE_CAPE                   = 15491,
    INTENSIFYING_CAPE               = 15492,
    BUSHIDO_CAPE                    = 15493,
    INVIGORATING_CAPE               = 15494,
    STORM_MUFFLER                   = 15519,
    STORM_TORQUE                    = 15520,
    ENLIGHTENED_CHAIN               = 15522,
    CHIVALROUS_CHAIN                = 15523,
    FORTIFIED_CHAIN                 = 15524,
    GRANDIOSE_CHAIN                 = 15525,
    TEMPERED_CHAIN                  = 15521,
    CHOCOBO_WHISTLE                 = 15533,
    AMIR_DIRS                       = 15604,
    YIGIT_SERAWEELS                 = 15606,
    PAHLUWAN_SERAWEELS              = 15609,
    CORSAIRS_BOTTES                 = 15685,
    AMIR_BOOTS                      = 15688,
    YIGIT_CRACKOWS                  = 15690,
    PAHLUWAN_CRACKOWS               = 15695,
    OLDUUM_RING                     = 15769,
    UNFETTERED_RING                 = 15775,
    EBULLIENT_RING                  = 15776,
    HALE_RING                       = 15777,
    UNYIELDING_RING                 = 15778,
    GARRULOUS_RING                  = 15779,
    IOTA_RING                       = 15799,
    OMEGA_RING                      = 15800,
    BALRAHNS_RING                   = 15807,
    ULTHALAMS_RING                  = 15808,
    JALZAHNS_RING                   = 15809,
    MATRIMONY_RING                  = 15847,
    MATRIMONY_BAND                  = 15848,
    POTENT_BELT                     = 15884,
    SPECTRAL_BELT                   = 15885,
    PRECISE_BELT                    = 15886,
    RESOLUTE_BELT                   = 15887,
    HURLING_BELT                    = 15888,
    BUCCANEERS_BELT                 = 15911,
    STOIC_EARRING                   = 15970,
    ANTIVENOM_EARRING               = 15971,
    INSOMNIA_EARRING                = 15972,
    VISION_EARRING                  = 15973,
    VELOCITY_EARRING                = 15974,
    DELTA_RING                      = 15990,
    RAISING_EARRING                 = 16003,
    AMIR_PUGGAREE                   = 16062,
    YIGIT_TURBAN                    = 16064,
    PAHLUWAN_QALANSUWA              = 16069,
    UTILIS_SHIELD                   = 16191,
    ASLAN_CAPE                      = 16228,
    GLEEMANS_CAPE                   = 16229,
    RITTER_GORGET                   = 16267,
    KUBIRA_BEAD_NECKLACE            = 16268,
    MORGANAS_CHOKER                 = 16269,
    CHANOIXS_GORGET                 = 16270,
    BENEDIGHT_HOSE                  = 16364,
    LYNX_BAGHNAKHS                  = 16409,
    PATAS                           = 16419,
    RUSTY_DAGGER                    = 16447,
    YATAGHAN                        = 16485,
    MINSTRELS_DAGGER                = 16487,
    ASPIR_KNIFE                     = 16509,
    BRONZE_SWORD                    = 16535,
    MYTHRIL_PICK                    = 16651,
    ORCISH_AXE                      = 16656,
    DOOM_TABAR                      = 16660,
    LIGHT_AXE                       = 16667,
    MYTHRIL_PICK_HQ                 = 16670,
    AXE_OF_TRIALS                   = 16735,
    MARAUDERS_KNIFE                 = 16764,
    SCYTHE_OF_TRIALS                = 16793,
    SPEAR_OF_TRIALS                 = 16892,
    SWORD_OF_TRIALS                 = 16952,
    YUKITSUGU                       = 16971,
    BOUNCER_CLUB                    = 17029,
    POWER_BOW                       = 17161,
    HEAVY_CROSSBOW                  = 17220,
    CHAKRAM                         = 17284,
    QUAKE_GRENADE                   = 17314,
    ICE_ARROW                       = 17323,
    WILLOW_FISHING_ROD              = 17391,
    SHRIMP_LURE                     = 17402,
    CURSE_WAND                      = 17437,
    CLUB_OF_TRIALS                  = 17456,
    GRAPNEL                         = 17474,
    KNUCKLES_OF_TRIALS              = 17507,
    POLE_OF_TRIALS                  = 17527,
    DAGGER_OF_TRIALS                = 17616,
    BUCCANEERS_KNIFE                = 17622,
    BARTHOLOMEWS_KNIFE              = 17623,
    SAPARA_OF_TRIALS                = 17654,
    STORM_TULWAR                    = 17715,
    KODACHI_OF_TRIALS               = 17773,
    MUMEITO                         = 17809,
    MAGOROKU                        = 17812,
    TACHI_OF_TRIALS                 = 17815,
    STORM_FIFE                      = 17851,
    ANIMATOR_P1                     = 17857,
    TURBO_ANIMATOR                  = 17858,
    ANIMATOR                        = 17859,
    JUG_OF_HUMUS                    = 17868,
    PICK_OF_TRIALS                  = 17933,
    STORM_TABAR                     = 17951,
    KHANJAR                         = 18025,
    STORM_ZAGHNAL                   = 18065,
    IMPERIAL_NEZA                   = 18113,
    BOW_OF_TRIALS                   = 18144,
    GUN_OF_TRIALS                   = 18146,
    SPARTAN_BULLET                  = 18160,
    BIBIKI_SEASHELL                 = 18257,
    CAESTUS                         = 18263,
    SPHARAI                         = 18264,
    BATARDEAU                       = 18269,
    MANDAU                          = 18270,
    CALIBURN                        = 18275,
    EXCALIBUR                       = 18276,
    VALHALLA                        = 18281,
    RAGNAROK                        = 18282,
    OGRE_KILLER                     = 18287,
    GUTTLER                         = 18288,
    ABADDON_KILLER                  = 18293,
    BRAVURA                         = 18294,
    GAE_ASSAIL                      = 18299,
    GUNGNIR                         = 18300,
    BEC_DE_FAUCON                   = 18305,
    APOCALYPSE                      = 18306,
    YOSHIMITSU                      = 18311,
    KIKOKU                          = 18312,
    TOTSUKANOTSURUGI                = 18317,
    AMANOMURAKUMO                   = 18318,
    GULLINTANI                      = 18323,
    MJOLLNIR                        = 18324,
    THYRUS                          = 18329,
    CLAUSTRUM                       = 18330,
    FERDINAND                       = 18335,
    ANNIHILATOR                     = 18336,
    MILLENNIUM_HORN                 = 18341,
    GJALLARHORN                     = 18342,
    FUTATOKOROTO                    = 18347,
    YOICHINOYUMI                    = 18348,
    PAHLUWAN_PATAS                  = 18365,
    DOOMBRINGER                     = 18388,
    YIGIT_BULAWA                    = 18408,
    SAYOSAMONJI                     = 18417,
    HOTARUMARU                      = 18435,
    IMPERIAL_BHUJ                   = 18485,
    PYF_HARP                        = 18573,
    IMPERIAL_POLE                   = 18583,
    IMPERIAL_KAMAN                  = 18685,
    IMPERIAL_GUN                    = 18686,
    TRUMP_GUN                       = 18702,
    SOULTRAPPER                     = 18721,
    BLANK_SOUL_PLATE                = 18722,
    SOULTRAPPER_2000                = 18724,
    BLANK_HIGH_SPEED_SOUL_PLATE     = 18725,
    TRAINEE_HAMMER                  = 18855,
    TRAINEE_KNIFE                   = 19101,
    SMART_GRENADE                   = 19202,
    WAR_HOOP                        = 19203,
    SOWILO_CLAYMORE                 = 20781,
    BERYLLIUM_ARROW                 = 21295,
    CHRONO_BULLET                   = 21296,
    CHRONO_ARROW                    = 21297,
    ARTEMIS_ARROW                   = 21298,
    YOICHIS_ARROW                   = 21299,
    DIVINE_ARROW                    = 21300,
    PORXIE_ARROW                    = 21301,
    RAETIC_ARROW                    = 21310,
    QUELLING_BOLT                   = 21311,
    DIVINE_BOLT                     = 21312,
    DEVASTATING_BULLET              = 21325,
    LIVING_BULLET                   = 21326,
    ERADICATING_BULLET              = 21327,
    DIVINE_BULLET                   = 21328,
    SEKI_SHURIKEN                   = 21391,
    MATRE_BELL                      = 21460,
    BERYLLIUM_BOLT                  = 22285,
    VOLUSPA_ARROW                   = 22289,
    VOLUSPA_BOLT                    = 22290,
    VOLUSPA_BULLET                  = 22291,
    DATE_SHURIKEN                   = 22292,
    PIEUJE_UNITY_SHIRT              = 25734,
    AYAME_UNITY_SHIRT               = 25735,
    IVINCIBLE_SHIELD_UNITY_SHIRT    = 25736,
    APURURU_UNITY_SHIRT             = 25737,
    MAAT_UNITY_SHIRT                = 25738,
    ALDO_UNITY_SHIRT                = 25739,
    JAKOH_WAHCONDALO_UNITY_SHIRT    = 25740,
    NAJA_SALAHEEM_UNITY_SHIRT       = 25741,
    FLAVIRIA_UNITY_SHIRT            = 25742,
    YORAN_ORAN_UNITY_SHIRT          = 25743,
    SYLVIE_UNITY_SHIRT              = 25744,
}
