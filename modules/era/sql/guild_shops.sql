-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- --------------------------------------------------------

DROP TABLE IF EXISTS `guild_shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_shops` (
  `guildid` smallint(5) unsigned NOT NULL,
  `itemid` smallint(5) unsigned NOT NULL,
  `min_price` int(10) unsigned NOT NULL DEFAULT '0',
  `max_price` int(10) unsigned NOT NULL DEFAULT '0',
  `max_quantity` smallint(5) unsigned NOT NULL DEFAULT '0',
  `daily_increase` smallint(5) unsigned NOT NULL DEFAULT '0',
  `initial_quantity` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_shops`
--

LOCK TABLES `guild_shops` WRITE;
/*!40000 ALTER TABLE `guild_shops` DISABLE KEYS */;
INSERT INTO `guild_shops` VALUES

    -- Alchemy Guild
    -- Maymunah | Odoba (Bastok Mines)
    (5262, 621, 21, 40, 48, 0, 0), -- pot of crying mustard
    (5262, 622, 36, 51, 64, 24, 24), -- pinch of dried marjoram
    (5262, 636, 97, 369, 64, 24, 24), -- sprig of chamomile
    (5262, 637, 1870, 1870, 24, 0, 0), -- vial of slime oil
    (5262, 638, 138, 777, 64, 24, 24), -- sprig of sage
    (5262, 912, 192, 360, 64, 0, 0), -- beehive chip
    (5262, 914, 1125, 4320, 64, 24, 24), -- vial of mercury
    (5262, 920, 1084, 5899, 48, 24, 24), -- malboro vine
    (5262, 922, 300, 300, 24, 0, 0), -- bat wing
    (5262, 925, 1012, 4017, 24, 0, 0), -- giant stinger
    (5262, 928, 1004, 2513, 24, 0, 0), -- pinch of bomb ash
    (5262, 929, 1125, 6900, 24, 0, 0), -- jar of black ink
    (5262, 931, 19520, 19520, 12, 0, 0), -- cermet chunk
    (5262, 932, 1020, 1080, 12, 0, 0), -- loop of carbon fiber
    (5262, 933, 600, 3040, 36, 12, 12), -- loop of glass fiber
    (5262, 943, 246, 1305, 24, 0, 0), -- pinch of poison dust
    (5262, 947, 3449, 19532, 12, 0, 0), -- jar of firesand
    (5262, 951, 90, 95, 64, 24, 24), -- wijnruit
    (5262, 1108, 573, 765, 48, 24, 24), -- pinch of sulfur
    (5262, 1109, 930, 4563, 12, 0, 0), -- artificial lens
    (5262, 2131, 75, 242, 64, 24, 24), -- triturator
    (5262, 4112, 682, 728, 12, 0, 0), -- potions
    (5262, 4116, 3375, 7560, 12, 0, 0), -- hi-potion
    (5262, 4128, 3624, 17201, 12, 0, 0), -- ether
    (5262, 4148, 486, 1124, 12, 0, 0), -- antidote
    (5262, 4150, 1945, 9549, 12, 0, 0), -- flask of eye drops
    (5262, 4151, 880, 2944, 12, 0, 0), -- flask of echo drops
    (5262, 4154, 5250, 5250, 12, 0, 0), -- flask of holy water
    (5262, 4162, 675, 4725, 12, 0, 0), -- flask of silencing potion
    (5262, 4164, 1050, 3304, 12, 0, 0), -- pinch of prism powder
    (5262, 4165, 1870, 1870, 12, 0, 0), -- pot of silent oil
    (5262, 4166, 750, 4200, 12, 0, 0), -- flask of deodorizer
    (5262, 4171, 360, 2284, 12, 0, 0), -- flask of vitriol
    (5262, 4443, 114, 153, 48, 24, 24), -- cobalt jellyfish
    -- (5262, 18228, 114, 114, 64, 24, 24), -- battery (WoTG)
    (5262, 18232, 114, 114, 64, 24, 24), -- hydro pump
    (5262, 18236, 21, 21, 64, 24, 24), -- wind fan
    (5262, 16430, 13392, 93744, 20, 0, 10), -- acid claws
    (5262, 17605, 7725, 54075, 20, 0, 10), -- acid dagger
    (5262, 16501, 84716, 84716, 20, 0, 10), -- acid knife
    (5262, 937, 135, 945, 165, 0, 65), -- block of animal glue
    (5262, 16572, 5781, 5781, 20, 0, 10), -- bee spatha
    (5262, 913, 135, 945, 165, 0, 65), -- lump of beeswax
    (5262, 16454, 1904, 1904, 20, 0, 15), -- blind dagger
    (5262, 16471, 519, 3024, 20, 0, 10), -- blind knife
    (5262, 17343, 12, 84, 8910, 0, 3564), -- bronze bullet
    (5262, 17340, 392, 392, 8910, 0, 3564), -- bullet
    (5262, 4509, 9, 58, 375, 0, 150), -- flask of distilled water
    (5262, 17322, 63, 441, 8910, 0, 3564), -- fire arrow
    (5262, 16543, 5940, 41580, 20, 0, 3), -- fire sword
    (5262, 16564, 34875, 244125, 20, 0, 3), -- flame blade
    (5262, 16588, 4374, 30618, 20, 0, 3), -- flame claymore
    (5262, 16522, 25200, 55000, 20, 0, 3), -- flame degen
    (5262, 17313, 774, 5418, 8910, 0, 3564), -- grenade
    (5262, 16523, 25200, 55000, 20, 0, 3), -- holy degen
    (5262, 17041, 60178, 60178, 20, 0, 3), -- holy mace
    (5262, 16581, 33368, 167872, 20, 0, 3), -- holy sword
    (5262, 17323, 242, 242, 8910, 0, 3564), -- ice arrow
    (5262, 16709, 1569, 10983, 20, 0, 3), -- inferno axe
    (5262, 16594, 15696, 109872, 20, 0, 3), -- inferno sword
    (5262, 17324, 63, 441, 8910, 0, 3564), -- lightning arrow
    (5262, 16410, 9504, 66528, 20, 0, 5), -- poison baghnakhs
    (5262, 16458, 4980, 34860, 20, 0, 5), -- poison baselard
    (5262, 16387, 13471, 33886, 20, 0, 10), -- poison cesti
    (5262, 16417, 10800, 75600, 20, 0, 10), -- poison claws
    (5262, 16496, 4464, 31248, 20, 0, 10), -- poison dagger
    (5262, 16403, 108218, 108218, 20, 0, 3), -- poison katars
    (5262, 16472, 13020, 13020, 20, 0, 3), -- poison knife
    (5262, 4157, 800, 2240, 80, 0, 32), -- flask of poison potion
    (5262, 17315, 2970, 20790, 8910, 0, 3564), -- riot grenade
    (5262, 16429, 3711, 25977, 20, 0, 5), -- silence baghnakhs
    (5262, 16600, 300, 2100, 20, 0, 3), -- wax sword
    -- Wahraga | Gathweeda (Aht_Urhgan_Whitegate)
    (60425, 621, 21, 40, 64, 24, 24), -- pot of crying mustard
    (60425, 622, 36, 51, 64, 24, 24), -- pinch of dried marjoram
    (60425, 636, 97, 369, 64, 24, 24), -- sprig of chamomile
    (60425, 637, 1870, 1870, 24, 0, 0), -- vial of slime oil
    (60425, 638, 138, 777, 64, 24, 24), -- sprig of sage
    (60425, 912, 192, 360, 24, 0, 0), -- beehive chip
    (60425, 914, 1125, 4320, 64, 24, 24), -- vial of mercury
    (60425, 920, 1084, 5899, 48, 24, 24), -- malboro vine
    (60425, 922, 300, 300, 24, 0, 0), -- bat wing
    (60425, 925, 1012, 4017, 24, 0, 0), -- giant stinger
    (60425, 928, 1004, 2513, 24, 0, 0), -- pinch of bomb ash
    (60425, 929, 1875, 6900, 24, 0, 0), -- jar of black ink
    (60425, 931, 19520, 19520, 12, 0, 0), -- cermet chunk
    (60425, 932, 1020, 1080, 12, 0, 0), -- loop of carbon fiber
    (60425, 933, 600, 3040, 36, 12, 12), -- loop of glass fiber
    (60425, 943, 246, 1305, 24, 0, 0), -- pinch of poison dust
    (60425, 947, 3449, 19532, 12, 0, 0), -- jar of firesand
    (60425, 951, 90, 95, 64, 24, 24), -- wijnruit
    (60425, 1108, 573, 765, 48, 24, 24), -- pinch of sulfur
    (60425, 1109, 930, 4563, 12, 0, 0), -- artificial lens
    (60425, 2131, 75, 242, 64, 24, 24), -- triturator
    (60425, 4112, 682, 728, 12, 0, 0), -- potion
    (60425, 4116, 3375, 7560, 12, 0, 0), -- hi-potion
    (60425, 4128, 3624, 17201, 12, 0, 0), -- ether
    (60425, 4148, 486, 1124, 12, 0, 0), -- antidote
    (60425, 4150, 1945, 9549, 12, 0, 0), -- flask of eye drops
    (60425, 4151, 880, 2944, 12, 0, 0), -- flask of echo drops
    (60425, 4154, 5250, 5250, 12, 0, 0), -- flask of holy water
    (60425, 4162, 675, 4725, 12, 0, 0), -- flask of silencing potion
    (60425, 4164, 1050, 3304, 12, 0, 0), -- pinch of prism powder
    (60425, 4165, 1870, 1870, 12, 0, 0), -- pot of silent oil
    (60425, 4166, 750, 4200, 12, 0, 0), -- flask of deodorizer
    (60425, 4171, 360, 2284, 12, 0, 0), -- flask of vitriol
    (60425, 4443, 114, 153, 48, 24, 24), -- cobalt jellyfish
    -- (60425, 18228, 114, 114, 64, 24, 24), -- battery (WoTG)
    (60425, 18232, 114, 114, 64, 24, 24), -- hydro pump
    (60425, 18236, 21, 21, 64, 24, 24), -- wind fan
    (60425, 2316, 6, 7, 64, 64, 64), -- sheet of polyflan paper
    (60425, 2309, 963, 963, 12, 4, 4), -- bundle of homunculus nerves
    (60425, 2154, 11115, 12000, 1, 1, 1), -- orobon lure
    (60425, 16430, 13392, 93744, 20, 0, 10), -- acid claws
    (60425, 17605, 7725, 54075, 20, 0, 10), -- acid dagger
    (60425, 16501, 84716, 84716, 20, 0, 10), -- acid knife
    (60425, 937, 135, 945, 165, 0, 65), -- block of animal glue
    (60425, 16572, 5781, 5781, 20, 0, 10), -- bee spatha
    (60425, 913, 135, 945, 165, 0, 65), -- lump of beeswax
    (60425, 16454, 1904, 1904, 20, 0, 15), -- blind dagger
    (60425, 16471, 519, 3024, 20, 0, 10), -- blind knife
    (60425, 17343, 12, 84, 8910, 0, 3564), -- bronze bullet
    (60425, 17340, 392, 392, 8910, 0, 3564), -- bullet
    (60425, 4509, 9, 58, 375, 0, 150), -- flask of distilled water
    (60425, 17322, 63, 441, 8910, 0, 3564), -- fire arrow
    (60425, 16543, 5940, 41580, 20, 0, 3), -- fire sword
    (60425, 16564, 34875, 244125, 20, 0, 3), -- flame blade
    (60425, 16588, 4374, 30618, 20, 0, 3), -- flame claymore
    (60425, 16522, 25200, 55000, 20, 0, 3), -- flame degen
    (60425, 17313, 774, 5418, 8910, 0, 3564), -- grenade
    (60425, 16523, 25200, 55000, 20, 0, 3), -- holy degen
    (60425, 17041, 60178, 60178, 20, 0, 3), -- holy mace
    (60425, 16581, 33368, 167872, 20, 0, 3), -- holy sword
    (60425, 17323, 242, 242, 8910, 0, 3564), -- ice arrow
    (60425, 16709, 1569, 10983, 20, 0, 3), -- inferno axe
    (60425, 16594, 15696, 109872, 20, 0, 3), -- inferno sword
    (60425, 17324, 63, 441, 8910, 0, 3564), -- lightning arrow
    (60425, 16410, 9504, 66528, 20, 0, 5), -- poison baghnakhs
    (60425, 16458, 4980, 34860, 20, 0, 5), -- poison baselard
    (60425, 16387, 13471, 33886, 20, 0, 10), -- poison cesti
    (60425, 16417, 10800, 75600, 20, 0, 10), -- poison claws
    (60425, 16496, 4464, 31248, 20, 0, 10), -- poison dagger
    (60425, 16403, 108218, 108218, 20, 0, 3), -- poison katars
    (60425, 16472, 13020, 13020, 20, 0, 3), -- poison knife
    (60425, 16478, 19148, 19148, 20, 0, 5), -- poison kukri
    (60425, 4157, 800, 2240, 80, 0, 32), -- flask of poison potion
    (60425, 17315, 2970, 20790, 8910, 0, 3564), -- riot grenade
    (60425, 16429, 3711, 25977, 20, 0, 5), -- silence baghnakhs
    (60425, 16495, 9906, 9906, 20, 0, 10), -- silence dagger
    (60425, 17341, 392, 392, 2970, 0, 1188), -- silver bullet
    (60425, 16600, 300, 2100, 20, 0, 3), -- wax sword
    (60425, 2229, 3744, 3744, 80, 0, 100), -- vial of chimera blood
    (60425, 2171, 1231, 4250, 80, 0, 100), -- colibri beak
    (60425, 2175, 156, 1092, 80, 0, 100), -- chunk of flan meat
    (60425, 2301, 6, 6, 80, 0, 100), -- square of polyflan
    (60425, 2159, 111, 777, 80, 0, 100), -- qutrub bandage

    -- Bonecraft Guild
    -- Shih Tayuun | Retto-Marutto Windurst Woods
    (514, 864, 72, 288, 64, 24, 24), -- handful of fish scales
    (514, 880, 70, 349, 64, 24, 24), -- bone chip
    (514, 882, 150, 760, 64, 24, 24), -- sheep tooth
    (514, 888, 90, 90, 64, 24, 24), -- seashell
    (514, 881, 3355, 11398, 48, 24, 24), -- crab shell
    (514, 2130, 75, 75, 150, 50, 25), -- shagreen file
    (514, 12455, 5728, 32079, 4, 0, 0), -- beetle mask
    (514, 17319, 3, 6, 297, 0, 0), -- bone arrow
    (514, 17299, 2419, 2419, 198, 0, 99), -- astragalos
    (514, 16406, 14428, 35251, 20, 0, 10), -- baghnakhs
    (514, 17257, 19859, 39568, 20, 0, 7), -- bandits gun
    (514, 13323, 15408, 15408, 20, 0, 10), -- beetle earring
    (514, 13090, 7188, 8869, 20, 0, 10), -- beetle gorget
    (514, 12583, 12246, 49455, 20, 0, 15), -- beetle harness
    (514, 17612, 34440, 39606, 20, 0, 10), -- beetle knife
    (514, 12967, 18447, 27659, 20, 0, 15), -- beetle leggings
    (514, 12711, 10981, 10981, 20, 0, 15), -- beetle mittens
    (514, 13457, 2650, 2721, 20, 0, 10), -- beetle ring
    (514, 889, 298, 1495, 80, 0, 32), -- beetle shell
    (514, 884, 4850, 10732, 165, 0, 65), -- black tiger fang
    (514, 16642, 9050, 19053, 20, 0, 15), -- bone axe
    (514, 17026, 4032, 10590, 20, 0, 15), -- bone cudgel
    (514, 12505, 336, 1415, 20, 0, 20), -- bone hairpin
    (514, 12582, 30031, 30031, 20, 0, 20), -- bone harness
    (514, 17610, 22500, 53100, 20, 0, 15), -- bone knife
    (514, 12966, 14493, 14493, 20, 0, 20), -- bone leggings
    (514, 12454, 5633, 17995, 20, 0, 20), -- bone mask
    (514, 12710, 2937, 9008, 20, 0, 20), -- bone mittens
    (514, 16649, 4887, 5017, 20, 0, 15), -- bone pick
    (514, 17062, 21318, 21318, 20, 0, 15), -- bone rod
    (514, 12834, 22965, 22965, 20, 0, 20), -- bone subligar
    (514, 16407, 1521, 2859, 20, 0, 15), -- brass baghnakhs
    (514, 13091, 29568, 106260, 20, 0, 5), -- carapace gorget
    (514, 13712, 67567, 242550, 20, 0, 5), -- carapace harness
    (514, 13715, 57036, 57036, 20, 0, 5), -- carapace leggings
    (514, 13711, 29925, 29925, 20, 0, 5), -- carapace mask
    (514, 13713, 29452, 57960, 20, 0, 5), -- carapace mittens
    (514, 12837, 170016, 225456, 20, 0, 5), -- carapace subligar
    (514, 16405, 213, 519, 20, 0, 20), -- cat baghnakhs
    (514, 898, 163, 163, 375, 0, 150), -- chicken bone
    (514, 13076, 2862, 15569, 20, 0, 15), -- fang necklace
    (514, 893, 948, 1258, 80, 0, 32), -- giant femur
    (514, 17352, 51948, 51948, 20, 0, 10), -- horn
    (514, 12507, 15133, 33687, 20, 0, 10), -- horn hairpin
    (514, 13459, 7200, 21120, 20, 0, 5), -- horn ring
    (514, 895, 3060, 15560, 55, 0, 22), -- ram horn
    (514, 897, 1228, 7338, 80, 0, 32), -- scorpion claw
    (514, 13458, 14175, 15553, 20, 0, 3), -- scorpion ring
    (514, 896, 4089, 12166, 80, 0, 32), -- scorpion shell
    (514, 13313, 565, 641, 20, 0, 20), -- shell earring
    (514, 12506, 4500, 16350, 20, 0, 15), -- shell hairpin
    (514, 13442, 565, 807, 20, 0, 20), -- shell ring
    (514, 13324, 38565, 38565, 20, 0, 5), -- tortoise earring
    (514, 13981, 67439, 72204, 20, 0, 5), -- turtle bangles
    (514, 885, 25584, 74256, 30, 0, 12), -- turtle shell
    (514, 12414, 11377, 37771, 20, 0, 5), -- turtle shield

    -- Clothcraft Guild
    -- Tilala | Gibol (Selbina)
    (516, 816, 710, 3865, 48, 24, 24), -- spool of silk thread
    (516, 817, 58, 146, 64, 24, 24), -- spool of grass thread
    (516, 818, 312, 582, 64, 24, 24), -- spool of cotton thread
    (516, 819, 750, 750, 64, 24, 24), -- spool of linen thread
    (516, 820, 2700, 12528, 64, 24, 24), -- spool of wool thread
    (516, 822, 685, 3000, 64, 24, 24), -- spool of silver thread
    (516, 823, 18240, 95760, 64, 24, 24), -- spool of gold thread
    (516, 824, 240, 588, 64, 24, 24), -- square of grass cloth
    (516, 825, 480, 2432, 64, 24, 24), -- square of cotton cloth
    (516, 832, 675, 855, 64, 24, 24), -- clump of sheep wool
    (516, 833, 15, 90, 64, 24, 24), -- clump of moko grass
    (516, 835, 187, 430, 64, 24, 24), -- flax flower
    (516, 847, 14, 40, 375, 0, 150), -- bird feather
    (516, 839, 280, 624, 32, 12, 12), -- piece of crawler cocoon
    (516, 13075, 372, 2604, 20, 0, 10), -- feather collar
    (516, 842, 687, 4809, 55, 0, 22), -- giant bird feather
    (516, 826, 5970, 14400, 80, 0, 32), -- square of linen cloth
    (516, 821, 5940, 41580, 32, 0, 12), -- spool of rainbow thread
    (516, 834, 80, 200, 64, 24, 24), -- ball of saruta cotton
    (516, 829, 4725, 33075, 32, 0, 12), -- square of silk cloth
    (516, 2128, 75, 80, 375, 75, 150), -- spindle
    (516, 827, 21492, 52704, 55, 0, 22), -- square of wool cloth
    (516, 841, 28, 35, 375, 0, 150), -- yagudo feather
    -- Meriri | Kuzah_Hpirohpon (Windurst_Woods)
    (5152, 816, 710, 3856, 48, 24, 24), -- spool of silk thread
    (5152, 817, 58, 146, 64, 24, 24), -- spool of grass thread
    (5152, 818, 312, 582, 64, 24, 24), -- spool of cotton thread
    (5152, 819, 750, 750, 24, 0, 0), -- spool of linen thread
    (5152, 820, 2700, 12528, 48, 0, 0), -- spool of wool thread
    (5152, 822, 685, 3000, 48, 24, 24), -- spool of silver thread
    (5152, 824, 240, 588, 64, 24, 24), -- square of grass cloth
    (5152, 825, 480, 2432, 64, 24, 24), -- square of cotton cloth
    (5152, 833, 15, 90, 64, 24, 24), -- clump of moko grass
    (5152, 835, 187, 430, 64, 24, 24), -- flax flower
    (5152, 826, 5970, 14400, 64, 24, 24), -- square of linen cloth
    (5152, 832, 675, 855, 64, 24, 24), -- clump of sheep wool
    (5152, 834, 80, 200, 64, 24, 24), -- ball of saruta cotton
    (5152, 839, 280, 624, 32, 12, 12), -- piece of crawler cocoon
    (5152, 2128, 75, 80, 150, 50, 25), -- spindle
    (5152, 2145, 75, 80, 64, 24, 24), -- spool of zephyr thread
    (5152, 12856, 936, 936, 20, 0, 0), -- slops
    (5152, 847, 14, 40, 375, 0, 150), -- bird feather
    (5152, 13577, 15190, 42134, 20, 0, 10), -- black cape
    (5152, 12739, 37862, 172339, 20, 0, 5), -- black mitts
    (5152, 18865, 5175, 36225, 20, 0, 5), -- zonure
    (5152, 12609, 7767, 54369, 20, 0, 5), -- black tunic
    (5152, 12722, 29406, 29406, 20, 0, 5), -- bracers
    (5152, 12848, 4093, 5486, 20, 0, 5), -- brais
    (5152, 13583, 318, 1683, 20, 0, 20), -- cape
    (5152, 12610, 7866, 55062, 20, 0, 20), -- cloak
    (5152, 12849, 1800, 12600, 20, 0, 20), -- cotton brais
    (5152, 13584, 12386, 12386, 20, 0, 20), -- cotton cape
    (5152, 12593, 66992, 66992, 20, 0, 10), -- cotton doublet
    (5152, 12977, 2316, 16212, 20, 0, 10), -- cotton gaiters
    (5152, 12721, 1674, 11718, 20, 0, 10), -- cotton gloves
    (5152, 12498, 1800, 12600, 20, 0, 10), -- cotton headband
    (5152, 12465, 35315, 35135, 20, 0, 10), -- cotton headgear
    (5152, 12728, 246, 644, 20, 0, 10), -- cuffs
    (5152, 12592, 5325, 13066, 20, 0, 10), -- doublet
    (5152, 13075, 372, 2604, 20, 0, 10), -- feather collar
    (5152, 12976, 2538, 5188, 20, 0, 15), -- gaiters
    (5152, 12594, 11250, 78750, 20, 0, 15), -- gambison
    (5152, 842, 687, 4809, 55, 0, 22), -- giant bird feather
    (5152, 12720, 2787, 7391, 20, 0, 15), -- gloves
    (5152, 823, 18240, 95760, 165, 33, 65), -- spool of gold thread
    (5152, 12464, 1452, 5468, 20, 0, 20), -- headgear
    (5152, 13085, 972, 4838, 20, 0, 20), -- hemp gorget
    (5152, 12850, 7875, 55125, 20, 0, 20), -- hose
    (5152, 12729, 1569, 10983, 20, 0, 15), -- linen cuffs
    (5152, 13750, 87178, 87178, 20, 0, 10), -- linen doublet
    (5152, 12738, 3726, 26082, 20, 0, 15), -- linen mitts
    (5152, 12866, 8487, 59409, 20, 0, 15), -- linen slacks
    (5152, 12857, 336, 2352, 20, 0, 15), -- linen slops
    (5152, 830, 17616, 123312, 32, 0, 12), -- square of rainbow cloth
    (5152, 821, 5940, 41580, 32, 0, 12), -- spool of rainbow thread
    (5152, 12466, 23200, 39400, 20, 0, 10), -- red cap
    (5152, 13586, 94960, 94960, 20, 0, 10), -- red cape
    (5152, 12600, 424, 1046, 20, 0, 20), -- robe
    (5152, 13568, 5100, 5100, 20, 0, 10), -- scarlet ribbon
    (5152, 829, 4725, 33075, 32, 0, 12), -- square of silk cloth
    (5152, 12864, 4562, 4562, 20, 0, 10), -- slacks
    (5152, 12978, 21000, 147000, 20, 0, 20), -- socks
    (5152, 838, 9438, 34557, 55, 0, 22), -- spider web
    (5152, 12608, 1260, 8820, 20, 0, 20), -- tunic
    (5152, 828, 25520, 25520, 32, 0, 12), -- square of velvet cloth
    (5152, 12731, 36192, 36192, 20, 0, 20), -- velvet cuffs
    (5152, 12475, 12852, 89964, 20, 0, 20), -- velvet hat
    (5152, 12603, 19152, 134064, 20, 0, 20), -- velvet robe
    (5152, 12859, 15624, 109368, 20, 0, 20), -- velvet slops
    (5152, 13322, 1728, 12096, 20, 0, 20), -- wing earring
    (5152, 12723, 15480, 108360, 20, 0, 20), -- wool bracers
    (5152, 12467, 18720, 131040, 20, 0, 20), -- wool cap
    (5152, 827, 21492, 52704, 55, 0, 22), -- square of wool cloth
    (5152, 12730, 6579, 46053, 20, 0, 20), -- wool cuffs
    (5152, 12595, 28080, 196560, 20, 0, 20), -- wool gambison
    (5152, 12474, 7803, 54621, 20, 0, 20), -- wool hat
    (5152, 12851, 21600, 151200, 20, 0, 10), -- wool hose
    (5152, 12602, 11628, 81396, 20, 0, 10), -- wool robe
    (5152, 12858, 9486, 66402, 20, 0, 10), -- wool slops
    (5152, 12979, 14400, 100800, 20, 0, 10), -- wool socks
    (5152, 841, 28, 35, 375, 0, 150), -- yagudo feather
    -- Taten-Bilten (Al_Zahbi)
    (60430, 825, 480, 2432, 64, 24, 24), -- square of cotton cloth
    (60430, 818, 312, 582, 64, 24, 24), -- spool of cotton thread
    (60430, 839, 280, 624, 32, 12, 12), -- piece of crawler cocoon
    (60430, 835, 187, 430, 64, 24, 24), -- flax flower
    (60430, 824, 240, 588, 64, 24, 24), -- square of grass cloth
    (60430, 817, 58, 146, 64, 24, 24), -- spool of grass thread
    (60430, 2287, 14400, 17280, 24, 6, 12), -- spool of karakul thread
    (60430, 819, 750, 750, 64, 24, 24), -- spool of linen thread
    (60430, 833, 15, 90, 64, 24, 24), -- clump of moko grass
    (60430, 834, 80, 200, 64, 24, 24), -- ball of saruta cotton
    (60430, 832, 675, 855, 64, 24, 24), -- clump of sheep wool
    (60430, 822, 685, 3000, 64, 24, 24), -- spool of silver thread
    (60430, 2128, 75, 80, 128, 50, 25), -- spindle
    (60430, 2173, 748, 748, 64, 24, 24), -- wamoura cocoon
    (60430, 2145, 75, 80, 64, 24, 24), -- spool of zephyr thread
    (60430, 847, 14, 40, 375, 0, 150), -- bird feather
    (60430, 13577, 15190, 42134, 20, 0, 10), -- black cape
    (60430, 12739, 37862, 172339, 20, 0, 5), -- black mitts
    (60430, 18865, 5175, 36225, 20, 0, 5), -- zonure
    (60430, 12609, 7767, 54369, 20, 0, 5), -- black tunic
    (60430, 12722, 29406, 29406, 20, 0, 5), -- bracers
    (60430, 12848, 4093, 5486, 20, 0, 5), -- brais
    (60430, 13583, 318, 1683, 20, 0, 20), -- cape
    (60430, 12610, 7866, 55062, 20, 0, 20), -- cloak
    (60430, 12849, 1800, 12600, 20, 0, 20), -- cotton brais
    (60430, 13584, 12386, 12386, 20, 0, 20), -- cotton cape
    (60430, 12593, 66992, 66992, 20, 0, 10), -- cotton doublet
    (60430, 12977, 2316, 16212, 20, 0, 10), -- cotton gaiters
    (60430, 12721, 1674, 11718, 20, 0, 10), -- cotton gloves
    (60430, 12498, 1800, 12600, 20, 0, 10), -- cotton headband
    (60430, 12465, 35315, 35135, 20, 0, 10), -- cotton headgear
    (60430, 12728, 246, 644, 20, 0, 10), -- cuffs
    (60430, 12592, 5325, 13066, 20, 0, 10), -- doublet
    (60430, 13075, 372, 2604, 20, 0, 10), -- feather collar
    (60430, 12499, 14160, 78080, 20, 0, 5), -- flax headband
    (60430, 12976, 2538, 5188, 20, 0, 15), -- gaiters
    (60430, 12594, 11250, 78750, 20, 0, 15), -- gambison
    (60430, 842, 687, 4809, 55, 0, 22), -- giant bird feather
    (60430, 12720, 2787, 7391, 20, 0, 15), -- gloves
    (60430, 823, 18240, 95760, 165, 33, 65), -- spool of gold thread
    (60430, 12464, 1452, 5468, 20, 0, 20), -- headgear
    (60430, 13085, 972, 4838, 20, 0, 20), -- hemp gorget
    (60430, 12850, 7875, 55125, 20, 0, 20), -- hose
    (60430, 826, 5970, 14400, 80, 0, 32), -- square of linen cloth
    (60430, 12729, 1569, 10983, 20, 0, 15), -- linen cuffs
    (60430, 13750, 87178, 87178, 20, 0, 10), -- linen doublet
    (60430, 12738, 3726, 26082, 20, 0, 15), -- linen mitts
    (60430, 12601, 14684, 14684, 20, 0, 15), -- linen robe
    (60430, 12866, 8487, 59409, 20, 0, 15), -- linen slacks
    (60430, 12857, 336, 2352, 20, 0, 15), -- linen slops
    (60430, 12736, 1290, 3196, 20, 0, 15), -- mitts
    (60430, 821, 5940, 41580, 32, 0, 12), -- spool of rainbow thread
    (60430, 12466, 23200, 39400, 20, 0, 10), -- red cap
    (60430, 13586, 94960, 94960, 20, 0, 10), -- red cape
    (60430, 12600, 424, 1046, 20, 0, 20), -- robe
    (60430, 13568, 5100, 5100, 20, 0, 10), -- scarlet ribbon
    (60430, 829, 4725, 33075, 32, 0, 12), -- square of silk cloth
    (60430, 816, 710, 3865, 48, 24, 24), -- spool of silk thread
    (60430, 12864, 4562, 4562, 20, 0, 10), -- slacks
    (60430, 12856, 372, 936, 20, 0, 20), -- slops
    (60430, 12978, 21000, 147000, 20, 0, 20), -- socks
    (60430, 838, 9438, 34557, 55, 0, 22), -- spider web
    (60430, 12608, 1260, 8820, 20, 0, 20), -- tunic
    (60430, 828, 25520, 25520, 32, 0, 12), -- square of velvet cloth
    (60430, 12731, 36192, 36192, 20, 0, 20), -- velvet cuffs
    (60430, 12475, 12852, 89964, 20, 0, 20), -- velvet hat
    (60430, 12603, 19152, 134064, 20, 0, 20), -- velvet robe
    (60430, 12859, 15624, 109368, 20, 0, 20), -- velvet slops
    (60430, 13322, 1728, 12096, 20, 0, 20), -- wing earring
    (60430, 12723, 15480, 108360, 20, 0, 20), -- wool bracers
    (60430, 12467, 18720, 131040, 20, 0, 20), -- wool cap
    (60430, 827, 21492, 52704, 55, 0, 22), -- square of wool cloth
    (60430, 12730, 6579, 46053, 20, 0, 20), -- wool cuffs
    (60430, 12595, 28080, 196560, 20, 0, 20), -- wool gambison
    (60430, 12474, 7803, 54621, 20, 0, 20), -- wool hat
    (60430, 12851, 21600, 151200, 20, 0, 10), -- wool hose
    (60430, 12602, 11628, 81396, 20, 0, 10), -- wool robe
    (60430, 12858, 9486, 66402, 20, 0, 10), -- wool slops
    (60430, 12979, 14400, 100800, 20, 0, 10), -- wool socks
    (60430, 820, 2700, 12528, 165, 0, 65), -- spool of wool thread
    (60430, 841, 28, 35, 375, 0, 150), -- yagudo feather
    (60430, 2149, 687, 4809, 375, 0, 150), -- apkallu feather
    (60430, 2150, 687, 4809, 375, 0, 150), -- colibri feather
    (60430, 2288, 8235, 57645, 375, 0, 150), -- square of karakul cloth
    (60430, 2148, 687, 4809, 375, 0, 150), -- puk wing
    (60430, 2289, 4890, 34230, 375, 0, 150), -- square of wamoura cloth

    -- Cooking Guild
    -- Chomo_Jinjahl | Kopopo (Windurst_Waters)
    (530, 4571, 75, 460, 64, 24, 24), -- clump of beaugreens
    (530, 4491, 158, 760, 64, 24, 24), -- watermelon
    (530, 4468, 148, 384, 64, 24, 24), -- bunch of pamamas
    (530, 4412, 287, 1235, 64, 24, 24), -- thundermelon
    (530, 4390, 78, 195, 64, 24, 24), -- mithran tomato
    (530, 4389, 60, 157, 64, 24, 24), -- san dorian carrot
    (530, 4380, 165, 924, 64, 24, 24), -- smoked salmon
    (530, 4378, 57, 264, 64, 24, 24), -- jug of selbina milk
    (530, 4367, 36, 238, 64, 24, 24), -- clump of batagreens
    (530, 4366, 18, 43, 64, 24, 24), -- la theine cabbage
    (530, 4363, 39, 220, 64, 24, 24), -- faerie apple
    (530, 2112, 530, 540, 64, 24, 24), -- stick of vanilla
    (530, 2111, 525, 530, 64, 24, 24), -- saucer of soy stock
    (530, 2110, 457, 530, 64, 24, 24), -- jar of fish stock
    (530, 1840, 1500, 2800, 64, 24, 24), -- bag of semolina
    (530, 1590, 536, 680, 64, 24, 24), -- sprig of holy basil
    (530, 1555, 1061, 1188, 64, 24, 24), -- onz of coriander
    (530, 1554, 431, 438, 64, 24, 24), -- onz of turmeric
    (530, 629, 36, 182, 64, 24, 24), -- ear of millioncorn
    (530, 628, 195, 572, 64, 24, 24), -- stick of cinnamon
    (530, 625, 66, 334, 64, 24, 24), -- bottle of apple vinegar
    (530, 622, 36, 220, 64, 24, 24), -- pinch of dried marjoram
    (530, 621, 21, 40, 64, 24, 24), -- pot of crying mustard
    (530, 620, 45, 276, 84, 36, 36), -- box of tarutaru rice
    (530, 618, 21, 50, 64, 24, 24), -- pod of blue peas
    (530, 616, 60, 368, 64, 24, 24), -- piece of pie dough
    (530, 614, 60, 631, 64, 24, 24), -- bulb of mhaura garlic
    (530, 612, 45, 194, 64, 24, 24), -- bunch of kazham peppers
    (530, 611, 30, 60, 64, 24, 24), -- bag of rye flour
    (530, 610, 52, 252, 64, 24, 24), -- bag of san dorian flour
    (530, 4510, 27, 189, 255, 0, 100), -- acorn cookie
    (530, 4423, 225, 876, 55, 0, 22), -- bottle of apple juice
    (530, 4413, 225, 876, 165, 0, 65), -- apple pie
    (530, 4406, 638, 2200, 165, 0, 65), -- baked apple
    (530, 4436, 240, 1600, 165, 0, 65), -- baked popoto
    (530, 4360, 114, 160, 255, 0, 100), -- bastore sardine
    (530, 4572, 1360, 7260, 55, 0, 22), -- serving of beaugreen saute
    (530, 4570, 48, 188, 255, 48, 100), -- bird egg
    (530, 4364, 90, 576, 255, 0, 100), -- loaf of black bread
    (530, 4399, 2700, 2700, 165, 0, 65), -- bluetail
    (530, 4456, 1856, 10980, 165, 0, 65), -- boiled crab
    (530, 4391, 41, 274, 165, 0, 65), -- bretzel
    (530, 4397, 12, 12, 165, 0, 65), -- cinna-cookie
    (530, 4435, 3520, 3968, 165, 0, 65), -- slice of cockatrice meat
    (530, 4472, 147, 198, 255, 0, 100), -- crayfish
    (530, 1475, 741, 5187, 255, 0, 100), -- onz of curry powder
    (530, 4359, 424, 1017, 255, 0, 100), -- slice of dhalmel meat
    (530, 4438, 2736, 7084, 55, 0, 22), -- dhalmel steak
    (530, 4457, 4800, 13920, 165, 0, 65), -- eel kabob
    (530, 4417, 3960, 16236, 165, 0, 65), -- bowl of egg soup
    (530, 4398, 2127, 3256, 165, 0, 65), -- fish mithkabob
    (530, 4382, 158, 160, 165, 0, 65), -- frost turnip
    (530, 1111, 450, 2760, 255, 0, 100), -- block of gelatin
    (530, 4372, 93, 236, 255, 0, 100), -- slice of giant sheep meat
    (530, 4394, 9, 55, 255, 0, 100), -- ginger cookie
    (530, 4383, 3906, 5760, 165, 0, 65), -- gold lobster
    (530, 4441, 720, 4650, 165, 0, 65), -- bottle of grape juice
    (530, 4371, 266, 853, 55, 0, 22), -- slice of grilled hare
    (530, 4409, 72, 371, 165, 0, 65), -- hard-boiled egg
    (530, 4358, 139, 136, 255, 0, 100), -- slice of hare meat
    (530, 4370, 240, 590, 255, 0, 100), -- pot of honey
    (530, 631, 200, 200, 255, 0, 100), -- bag of horo flour
    (530, 4556, 10644, 10644, 55, 0, 22), -- serving of icecap rolanberry
    (530, 4499, 77, 320, 165, 0, 65), -- loaf of iron bread
    (530, 4432, 115, 261, 255, 48, 100), -- kazham pineapple
    (530, 4362, 300, 300, 255, 0, 100), -- lizard egg
    (530, 627, 200, 200, 255, 0, 100), -- pot of maple sugar
    (530, 4376, 90, 364, 255, 0, 100), -- strip of meat jerky
    (530, 4381, 1382, 3872, 165, 0, 65), -- meat mithkabob
    (530, 4424, 1573, 3872, 55, 0, 22), -- bottle of melon juice
    (530, 4401, 45, 315, 165, 0, 65), -- moat carp
    (530, 4419, 34720, 34720, 165, 0, 65), -- bowl of mushroom soup
    (530, 4459, 8568, 8568, 165, 0, 65), -- nebimonite bake
    (530, 4482, 1408, 1984, 255, 0, 100), -- nosteau herring
    (530, 4422, 150, 888, 55, 0, 22), -- bottle of orange juice
    (530, 4563, 15360, 15360, 15, 0, 6), -- pamama tart
    (530, 4416, 2716, 6944, 165, 0, 65), -- bowl of pea soup
    (530, 4455, 968, 984, 165, 0, 65), -- bowl of pebble soup
    (530, 4490, 955, 2284, 165, 0, 65), -- pickled herring
    (530, 4442, 300, 1600, 55, 0, 22), -- bottle of pineapple juice
    (530, 619, 36, 40, 255, 48, 100), -- popoto
    (530, 4492, 1182, 2845, 55, 0, 22), -- bowl of puls
    (530, 4444, 44, 117, 165, 0, 65), -- rarab tail
    (530, 4537, 1040, 1768, 165, 0, 65), -- roast carp
    (530, 4410, 670, 1706, 165, 0, 65), -- roast mushroom
    (530, 4437, 1288, 3024, 55, 0, 22), -- slice of roast mutton
    (530, 4538, 1628, 4232, 165, 0, 65), -- roast pipira
    (530, 4404, 918, 918, 165, 0, 65), -- roast trout
    (530, 4415, 124, 620, 165, 0, 65), -- ear of roasted corn
    (530, 936, 25, 73, 255, 48, 65), -- chunk of rock salt
    (530, 4365, 585, 590, 255, 0, 100), -- rolanberry
    (530, 4355, 1946, 4973, 165, 0, 65), -- salmon sub sandwich
    (530, 4431, 63, 367, 255, 48, 100), -- bunch of san dorian grapes
    (530, 4392, 58, 152, 255, 48, 100), -- saruta orange
    (530, 615, 45, 292, 255, 0, 100), -- stick of selbina butter
    (530, 4354, 117, 819, 255, 0, 100), -- shining trout
    (530, 4483, 937, 1289, 165, 0, 65), -- tiger cod
    (530, 4425, 559, 1446, 55, 0, 22), -- bottle of tomato juice
    (530, 4408, 105, 560, 165, 0, 65), -- tortilla
    (530, 4489, 1950, 1950, 255, 0, 100), -- bowl of vegetable gruel
    (530, 4560, 2861, 2861, 55, 0, 22), -- bowl of vegetable soup
    (530, 4356, 210, 992, 165, 0, 65), -- loaf of white bread
    (530, 4387, 1794, 1950, 255, 0, 100), -- wild onion
    (530, 4555, 3701, 3701, 255, 0, 100), -- windurst salad
    (530, 4445, 114, 114, 165, 0, 65), -- yagudo cherry

    -- Fishing Guild
    -- Babubu (Port_Windurst)
    (517, 4443, 28, 134, 64, 24, 24), -- cobalt jellyfish
    (517, 4472, 30, 65, 64, 24, 24), -- crayfish
    (517, 16992, 52, 294, 124, 48, 48), -- slice of bluetail
    (517, 16993, 52, 52, 124, 48, 48), -- peeled crayfish
    (517, 16994, 52, 52, 124, 0, 0), -- slice of moat carp
    (517, 16996, 52, 52, 124, 48, 48), -- ball of sardine paste
    (517, 16997, 52, 52, 124, 48, 48), -- ball of crayfish paste
    (517, 16998, 38, 38, 124, 48, 48), -- ball of insect paste
    (517, 16999, 52, 52, 124, 48, 48), -- ball of trout paste
    (517, 17000, 52, 52, 124, 48, 48), -- meatball
    (517, 17380, 25740, 25740, 20, 0, 0), -- mithran fishing rod
    (517, 17382, 9657, 9657, 20, 5, 5), -- single hook fishing rod
    (517, 17383, 1980, 1980, 30, 10, 10), -- clothespole
    (517, 17387, 4077, 4077, 20, 0, 0), -- tarutaru fishing rod
    (517, 17388, 934, 934, 30, 0, 0), -- fastwater fishing rod
    (517, 17389, 332, 332, 30, 0, 0), -- bamboo fishing rod
    (517, 17390, 145, 145, 30, 0, 0), -- yew fishing rod
    (517, 17391, 44, 44, 30, 10, 20), -- willow fishing rod
    (517, 17392, 213, 213, 124, 0, 0), -- slice of sardine
    (517, 17393, 213, 213, 124, 0, 0), -- slice of cod
    (517, 17394, 220, 220, 124, 0, 0), -- peeled lobster
    (517, 17395, 8, 9, 400, 100, 200), -- lugworm
    (517, 17396, 3, 8, 400, 100, 200), -- little worm
    (517, 17399, 2394, 2394, 20, 6, 12), -- sabiki rig
    (517, 17404, 540, 540, 20, 6, 12), -- worm lure
    (517, 17405, 540, 540, 20, 6, 12), -- fly lure
    (517, 17407, 270, 270, 20, 6, 12), -- minnow
    -- Graegham (Selbina)
    (518, 4384, 5250, 13790, 48, 0, 0), -- black sole
    (518, 4385, 261, 261, 48, 0, 0), -- zafmlug bass
    (518, 4399, 2520, 2520, 48, 0, 0), -- bluetail
    (518, 4426, 195, 296, 48, 0, 0), -- tricolored carp
    (518, 4451, 3400, 16000, 48, 0, 0), -- silver shark
    (518, 4461, 4050, 6048, 48, 0, 0), -- bastore bream
    (518, 4479, 1350, 1350, 48, 0, 0), -- bhefhel marlin
    (518, 4483, 520, 1248, 48, 0, 0), -- tiger cod
    (518, 4485, 900, 1200, 48, 0, 0), -- noble lady
    (518, 4500, 24, 76, 64, 0, 0), -- greedie
    (518, 17382, 9657, 9657, 20, 5, 5), -- single hook fishing rod
    (518, 17383, 1980, 1980, 30, 10, 10), -- clothespole
    (518, 17387, 4077, 4077, 20, 5, 10), -- tarutaru fishing rod
    (518, 17388, 934, 934, 30, 10, 10), -- fastwater fishing rod
    (518, 17399, 2394, 2394, 20, 6, 12), -- sabiki rig
    -- Mep_Nhapopoluko (Bibiki_Bay)
    (519, 624, 24, 39, 64, 24, 24), -- clump of pamtam kelp
    (519, 4314, 300, 300, 64, 24, 24), -- bibikibo
    (519, 4317, 120, 237, 64, 24, 24), -- trilobite
    (519, 4318, 3375, 3375, 64, 24, 24), -- bibiki urchin
    (519, 4385, 115, 115, 64, 24, 24), -- zafmlug bass
    (519, 4399, 1350, 1350, 64, 24, 24), -- bluetail
    (519, 4443, 9, 32, 64, 24, 24), -- cobalt jellyfish
    (519, 4484, 2100, 2100, 64, 24, 24), -- shall shell
    (519, 4485, 2100, 2800, 64, 24, 24), -- noble lady
    (519, 17382, 7081, 8369, 20, 5, 5), -- single hook fishing rod
    (519, 17388, 766, 906, 30, 10, 20), -- fastwater fishing rod
    -- Rajmonda (Ship_bound_for_Selbina | Ship_bound_for_Selbina_Pirates)
    (520, 624, 47, 158, 64, 0, 0), -- clump of pamtam kelp
    (520, 4385, 235, 737, 64, 0, 0), -- zafmlug bass
    (520, 4399, 1350, 1350, 48, 0, 0), -- bluetail
    (520, 4451, 3000, 18080, 48, 0, 0), -- silver shark
    (520, 4483, 509, 509, 64, 0, 0), -- tiger cod
    (520, 17387, 4077, 4077, 20, 5, 10), -- tarutaru fishing rod
    (520, 17395, 8, 9, 400, 100, 200), -- lugworm
    (520, 17399, 2394, 2394, 20, 5, 15), -- sabiki rig
    (520, 17400, 691, 691, 20, 6, 12), -- sinking minnow
    (520, 17407, 270, 270, 20, 6, 12), -- minnow
    -- Lokhong (Ship_bound_for_Mhaura | Ship_bound_for_Mhaura_Pirates)
    (521, 624, 47, 158, 64, 0, 0), -- clump of pamtam kelp
    (521, 4385, 235, 737, 64, 0, 0), -- zafmlug bass
    (521, 4399, 1350, 1350, 48, 0, 0), -- bluetail
    (521, 4451, 3000, 18080, 48, 0, 0), -- silver shark
    (521, 4483, 509, 509, 64, 0, 0), -- tiger cod
    (521, 17387, 4077, 4077, 20, 5, 10), -- tarutaru fishing rod
    (521, 17395, 8, 9, 400, 100, 200), -- lugworm
    (521, 17399, 2394, 2394, 20, 5, 15), -- sabiki rig
    (521, 17400, 691, 691, 20, 6, 12), -- sinking minnow
    (521, 17407, 270, 270, 20, 6, 12), -- minnow
    -- Cehn_Teyohngo (Open_sea_route_to_Al_Zahbi)
    (522, 4403, 336, 336, 64, 0, 0), -- yellow globe
    (522, 4480, 282, 600, 48, 0, 0), -- gugru tuna
    (522, 4485, 900, 1200, 24, 0, 0), -- noble lady
    (522, 17387, 4077, 4077, 20, 5, 10), -- tarutaru fishing rod
    (522, 17395, 8, 9, 400, 100, 200), -- lugworm
    (522, 17399, 2394, 2394, 20, 5, 15), -- sabiki rig
    (522, 17400, 691, 691, 20, 6, 12), -- sinking minnow
    (522, 17407, 270, 270, 20, 6, 12), -- minnow
    -- Pashi_Maccaleh (Open_sea_route_to_Mhaura)
    (523, 4403, 336, 336, 64, 0, 0), -- yellow globe
    (523, 4480, 282, 600, 48, 0, 0), -- gugru tuna
    (523, 4485, 900, 1200, 24, 0, 0), -- noble lady
    (523, 17387, 4077, 4077, 20, 5, 10), -- tarutaru fishing rod
    (523, 17395, 8, 9, 400, 100, 200), -- lugworm
    (523, 17399, 2394, 2394, 20, 5, 15), -- sabiki rig
    (523, 17400, 691, 691, 20, 6, 12), -- sinking minnow
    (523, 17407, 270, 270, 20, 6, 12), -- minnow
    -- Jidwahn (Silver_Sea_route_to_Nashmau)
    (524, 2177, 36, 224, 500, 200, 200), -- ice card
    (524, 2180, 36, 224, 500, 200, 200), -- thunder card
    (524, 2182, 36, 224, 500, 200, 200), -- light card
    (524, 2183, 36, 224, 500, 200, 200), -- dark card
    (524, 5449, 92, 136, 64, 0, 0), -- hamsi
    (524, 5450, 282, 600, 48, 0, 0), -- lakerda
    (524, 17387, 4077, 4077, 20, 5, 10), -- tarutaru fishing rod
    (524, 17395, 8, 9, 400, 100, 200), -- lugworm
    (524, 17399, 2394, 2394, 20, 6, 12), -- sabiki rig
    (524, 17400, 691, 691, 20, 6, 12), -- sinking minnow
    (524, 17407, 270, 270, 20, 6, 12), -- minnow
    -- Yahliq (Silver_Sea_route_to_Al_Zahbi)
    (525, 2177, 36, 224, 500, 200, 200), -- ice card
    (525, 2180, 36, 224, 500, 200, 200), -- thunder card
    (525, 2182, 36, 224, 500, 200, 200), -- light card
    (525, 2183, 36, 224, 500, 200, 200), -- dark card
    (525, 5449, 92, 136, 64, 0, 0), -- hamsi
    (525, 5450, 282, 600, 48, 0, 0), -- lakerda
    (525, 17387, 4077, 4077, 20, 5, 10), -- tarutaru fishing rod
    (525, 17395, 8, 9, 400, 100, 200), -- lugworm
    (525, 17399, 2394, 2394, 20, 6, 12), -- sabiki rig
    (525, 17400, 691, 691, 20, 6, 12), -- sinking minnow
    (525, 17407, 270, 270, 20, 6, 12), -- minnow
    -- Wahnid (Aht_Urhgan_Whitegate)
    (60426, 5449, 92, 136, 64, 0, 0), -- hamsi
    (60426, 5447, 21, 128, 64, 24, 24), -- denizanasi
    (60426, 5453, 4560, 5952, 48, 0, 0), -- istakoz
    (60426, 5454, 5130, 25920, 48, 0, 0), -- mercanbaligi
    (60426, 4472, 30, 65, 64, 24, 24), -- crayfish
    (60426, 16992, 52, 294, 198, 48, 64), -- slice of bluetail
    (60426, 16993, 52, 52, 124, 48, 64), -- peeled crayfish
    (60426, 16994, 52, 52, 124, 48, 64), -- slice of moat carp
    (60426, 16996, 52, 52, 124, 48, 64), -- ball of sardine paste
    (60426, 16997, 52, 52, 124, 48, 64), -- ball of crayfish paste
    (60426, 16998, 38, 38, 124, 48, 48), -- ball of insect paste
    (60426, 16999, 52, 52, 124, 48, 48), -- ball of trout paste
    (60426, 17000, 52, 52, 124, 48, 48), -- meatball
    (60426, 17380, 25740, 25740, 20, 5, 5), -- mithran fishing rod
    (60426, 17382, 9657, 9657, 20, 5, 5), -- single hook fishing rod
    (60426, 17383, 1980, 1980, 30, 10, 10), -- clothespole
    (60426, 17387, 4077, 4077, 20, 5, 10), -- tarutaru fishing rod
    (60426, 17388, 934, 934, 30, 10, 10), -- fastwater fishing rod
    (60426, 17389, 332, 332, 30, 10, 15), -- bamboo fishing rod
    (60426, 17390, 145, 145, 30, 10, 15), -- yew fishing rod
    (60426, 17391, 44, 44, 30, 10, 20), -- willow fishing rod
    (60426, 17392, 213, 213, 124, 48, 48), -- slice of sardine
    (60426, 17393, 213, 213, 124, 48, 48), -- slice of cod
    (60426, 17394, 220, 220, 124, 48, 18), -- peeled lobster
    (60426, 17395, 8, 9, 400, 100, 200), -- lugworm
    (60426, 17396, 3, 8, 400, 100, 200), -- little worm
    (60426, 17399, 2394, 2394, 20, 6, 12), -- sabiki rig
    (60426, 17404, 540, 540, 20, 6, 12), -- worm lure
    (60426, 17405, 540, 540, 20, 6, 12), -- fly lure
    (60426, 17407, 270, 270, 20, 6, 12), -- minnow

    -- Goldsmithing Guild
    -- Celestina | Yabby_Tanmikey (Mhaura)
    (528, 640, 9, 18, 128, 64, 64), -- chunk of copper ore
    (528, 642, 595, 620, 24, 0, 0), -- chunk of zinc ore
    (528, 644, 1500, 9800, 24, 0, 0), -- chunk of mythril ore
    (528, 650, 952, 4179, 12, 0, 0), -- brass ingot
    (528, 736, 315, 1260, 24, 12, 12), -- chunk of silver ore
    (528, 737, 1890, 13230, 12, 0, 0), -- chunk of gold ore
    (528, 769, 1288, 6440, 48, 16, 32), -- red rock
    (528, 770, 1288, 6440, 48, 16, 32), -- blue rock
    (528, 771, 1288, 6440, 48, 16, 32), -- yellow rock
    (528, 772, 1288, 6440, 48, 16, 32), -- green rock
    (528, 773, 1288, 6440, 48, 16, 32), -- translucent rock
    (528, 774, 1288, 6440, 48, 16, 32), -- purple rock
    (528, 775, 1288, 6440, 48, 16, 32), -- black rock
    (528, 776, 1288, 6440, 48, 16, 32), -- white rock
    (528, 2143, 75, 75, 48, 12, 12), -- mandrel
    (528, 2144, 75, 242, 48, 12, 12), -- workshop anvil
    (528, 673, 520, 1131, 255, 0, 100), -- handful of brass scales
    (528, 661, 1171, 1171, 255, 0, 100), -- brass sheet
    (528, 648, 571, 571, 55, 0, 22), -- copper ingot
    (528, 745, 9450, 66150, 55, 0, 22), -- gold ingot
    (528, 752, 9291, 65037, 20, 0, 15), -- gold sheet
    (528, 681, 10500, 55440, 30, 0, 12), -- mythril chain
    (528, 653, 19900, 36400, 55, 0, 22), -- mythril ingot
    (528, 663, 20240, 45600, 80, 0, 32), -- mythril sheet
    (528, 762, 20925, 146475, 55, 0, 22), -- platinum chain
    (528, 746, 17550, 37550, 80, 0, 32), -- platinum ingot
    (528, 738, 8032, 15245, 30, 0, 12), -- chunk of platinum ore
    (528, 754, 16875, 46875, 80, 0, 32), -- platinum sheet
    (528, 760, 68640, 74880, 55, 0, 22), -- silver chain
    (528, 744, 8820, 10416, 80, 0, 32), -- silver ingot
    -- Visala | Teerth (Bastok_Markets)
    (5272, 640, 9, 18, 128, 64, 64), -- chunk of copper ore
    (5272, 642, 595, 620, 24, 12, 12), -- chunk of zinc ore
    (5272, 644, 1500, 9800, 24, 12, 12), -- chunk of mythril ore
    (5272, 650, 952, 4179, 12, 0, 0), -- brass ingot
    (5272, 736, 315, 1260, 24, 12, 12), -- chunk of silver ore
    (5272, 737, 1890, 13230, 12, 0, 0), -- chunk of gold ore
    (5272, 769, 1288, 6440, 48, 16, 32), -- red rock
    (5272, 770, 1288, 6440, 48, 16, 32), -- blue rock
    (5272, 771, 1288, 6440, 48, 16, 32), -- yellow rock
    (5272, 772, 1288, 6440, 48, 16, 32), -- green rock
    (5272, 773, 1288, 6440, 48, 16, 32), -- translucent rock
    (5272, 774, 1288, 6440, 48, 16, 32), -- purple rock
    (5272, 775, 1288, 6440, 48, 16, 32), -- black rock
    (5272, 776, 1288, 6440, 48, 16, 32), -- white rock
    (5272, 2143, 75, 242, 48, 12, 12), -- mandrel
    (5272, 2144, 75, 75, 48, 12, 12), -- workshop anvil
    (5272, 1588, 20400, 20400, 255, 255, 255), -- slab of tufa
    (5272, 814, 1396, 2794, 80, 0, 32), -- amber stone
    (5272, 13335, 1186, 1238, 20, 0, 20), -- amber earring
    (5272, 13473, 1875, 2400, 20, 0, 15), -- amber ring
    (5272, 800, 1396, 2794, 80, 0, 32), -- amethyst
    (5272, 13333, 1186, 1238, 20, 0, 20), -- amethyst earring
    (5272, 13471, 1875, 2400, 20, 0, 15), -- amethyst ring
    (5272, 811, 9000, 15000, 15, 0, 6), -- ametrine
    (5272, 13340, 13440, 13440, 20, 0, 10), -- ametrine earring
    (5272, 813, 48336, 284544, 15, 0, 3), -- angelstone
    (5272, 791, 23400, 46608, 15, 0, 3), -- aquamarine
    (5272, 13320, 13440, 13440, 20, 0, 10), -- black earring
    (5272, 13338, 13440, 13440, 15, 0, 3), -- blood earring
    (5272, 16641, 2870, 13845, 20, 0, 10), -- brass axe
    (5272, 16407, 2399, 13554, 20, 0, 10), -- brass baghnakhs
    (5272, 12449, 1503, 4300, 20, 0, 15), -- brass cap
    (5272, 12817, 11520, 11520, 20, 0, 15), -- brass cuisses
    (5272, 16449, 4054, 4054, 20, 0, 10), -- brass dagger
    (5272, 12689, 7728, 7728, 20, 0, 20), -- brass finger gauntlets
    (5272, 12945, 6864, 6864, 20, 0, 15), -- brass greaves
    (5272, 12497, 1029, 1029, 20, 0, 15), -- brass hairpin
    (5272, 17043, 3102, 3102, 20, 0, 10), -- brass hammer
    (5272, 12577, 15000, 15000, 20, 0, 10), -- brass harness
    (5272, 16391, 2700, 13989, 20, 0, 10), -- brass knuckles
    (5272, 12961, 2380, 3720, 20, 0, 15), -- brass leggings
    (5272, 12433, 9600, 9600, 20, 0, 15), -- brass mask
    (5272, 12705, 2511, 2511, 20, 0, 15), -- brass mittens
    (5272, 13465, 536, 536, 20, 0, 20), -- brass ring
    (5272, 17081, 3229, 3229, 20, 0, 10), -- brass rod
    (5272, 12561, 7000, 15000, 20, 0, 20), -- brass scale mail
    (5272, 673, 520, 1131, 255, 0, 100), -- handful of brass scales
    (5272, 12833, 1500, 1500, 20, 0, 15), -- brass subligar
    (5272, 16531, 3522, 24654, 20, 0, 10), -- brass xiphos
    (5272, 16769, 5424, 5424, 20, 0, 10), -- brass zaghnal
    (5272, 13209, 4590, 32130, 20, 0, 10), -- chain belt
    (5272, 13083, 3645, 25515, 20, 0, 10), -- chain choker
    (5272, 13082, 11260, 11260, 20, 0, 10), -- chain gorget
    (5272, 801, 23400, 49608, 15, 0, 3), -- chrysoberyl
    (5272, 12472, 200, 200, 20, 0, 20), -- circlet
    (5272, 13332, 1186, 1238, 20, 0, 20), -- clear earring
    (5272, 13470, 1875, 2400, 20, 0, 15), -- clear ring
    (5272, 809, 1396, 1396, 80, 0, 65), -- clear topaz
    (5272, 12496, 117, 234, 20, 0, 20), -- copper hairpin
    (5272, 648, 571, 571, 55, 0, 22), -- copper ingot
    (5272, 13454, 114, 114, 20, 0, 20), -- copper ring
    (5272, 812, 48336, 284544, 15, 0, 3), -- deathstone
    (5272, 787, 48336, 284544, 15, 0, 3), -- diamond
    (5272, 785, 48336, 284544, 15, 0, 3), -- emerald
    (5272, 810, 23400, 49608, 15, 0, 3), -- fluorite
    (5272, 790, 9000, 15000, 15, 0, 6), -- garnet
    (5272, 13983, 17415, 121905, 20, 0, 10), -- gold bangles
    (5272, 761, 15525, 108675, 55, 0, 22), -- gold chain
    (5272, 13315, 7875, 55125, 20, 0, 10), -- gold earring
    (5272, 745, 9450, 66150, 55, 0, 22), -- gold ingot
    (5272, 13445, 7875, 55125, 20, 0, 15), -- gold ring
    (5272, 752, 9291, 65037, 20, 0, 15), -- gold sheet
    (5272, 808, 9000, 15000, 15, 0, 6), -- goshenite
    (5272, 13339, 13000, 20000, 20, 0, 10), -- goshenite earring
    (5272, 784, 42432, 136032, 15, 0, 3), -- jadeite
    (5272, 795, 1396, 1434, 80, 0, 32), -- lapis lazuli
    (5272, 13334, 2812, 2812, 20, 0, 20), -- lapis lazuli earring
    (5272, 13472, 3350, 3350, 20, 0, 15), -- lapis lazuli ring
    (5272, 796, 1396, 1434, 80, 0, 32), -- light opal
    (5272, 802, 42432, 136032, 15, 0, 3), -- moonstone
    (5272, 681, 10500, 55440, 30, 6, 12), -- mythril chain
    (5272, 13328, 3375, 23625, 20, 0, 10), -- mythril earring
    (5272, 653, 19900, 36400, 55, 0, 22), -- mythril ingot
    (5272, 13446, 3375, 23625, 20, 0, 10), -- mythril ring
    (5272, 663, 20240, 45600, 80, 0, 32), -- mythril sheet
    (5272, 799, 1396, 1434, 80, 0, 32), -- onyx
    (5272, 13336, 2812, 2812, 20, 0, 15), -- onyx earring
    (5272, 13474, 3350, 3350, 20, 0, 15), -- onyx ring
    (5272, 13337, 2812, 2812, 20, 0, 15), -- opal earring
    (5272, 797, 42432, 136032, 15, 0, 6), -- painite
    (5272, 13317, 12800, 12800, 20, 0, 10), -- pearl earring
    (5272, 788, 56160, 56160, 15, 0, 6), -- peridot
    (5272, 13319, 12800, 12800, 20, 0, 10), -- peridot earring
    (5272, 762, 20925, 146475, 55, 0, 22), -- platinum chain
    (5272, 13316, 25650, 179550, 20, 0, 10), -- platinum earring
    (5272, 746, 17550, 37550, 80, 0, 32), -- platinum ingot
    (5272, 738, 8032, 15245, 30, 0, 12), -- chunk of platinum ore
    (5272, 13447, 27900, 60700, 20, 0, 15), -- platinum ring
    (5272, 754, 16875, 46875, 80, 0, 32), -- platinum sheet
    (5272, 12473, 1863, 13041, 20, 0, 10), -- poets circlet
    (5272, 786, 143488, 265088, 15, 0, 3), -- ruby
    (5272, 16551, 3631, 15487, 20, 0, 10), -- sapara
    (5272, 794, 143488, 265088, 15, 0, 3), -- sapphire
    (5272, 807, 1396, 1434, 80, 0, 32), -- sardonyx
    (5272, 13331, 2812, 2812, 20, 0, 10), -- sardonyx earring
    (5272, 13444, 3350, 3350, 20, 0, 15), -- sardonyx ring
    (5272, 13979, 20088, 20088, 20, 0, 10), -- silver bangles
    (5272, 760, 68640, 74880, 55, 0, 22), -- silver chain
    (5272, 12495, 4398, 4398, 20, 0, 10), -- silver hairpin
    (5272, 744, 8820, 10416, 80, 0, 32), -- silver ingot
    (5272, 12425, 12825, 89775, 20, 0, 20), -- silver mask
    (5272, 12681, 10575, 74025, 20, 0, 20), -- silver mittens
    (5272, 13456, 5850, 5850, 20, 0, 20), -- silver ring
    (5272, 815, 56160, 56160, 15, 0, 6), -- sphene
    (5272, 804, 143488, 265088, 15, 0, 3), -- spinel
    (5272, 803, 42432, 163032, 15, 0, 3), -- sunstone
    (5272, 789, 143488, 260088, 15, 0, 3), -- topaz
    (5272, 806, 1396, 1434, 80, 0, 32), -- tourmaline
    (5272, 13330, 2812, 2812, 20, 0, 10), -- tourmaline earring
    (5272, 13468, 3350, 3350, 20, 0, 15), -- tourmaline ring
    (5272, 798, 56160, 56160, 165, 0, 65), -- turquoise
    (5272, 805, 42432, 136032, 15, 0, 3), -- zircon
    -- Bornahn (Al_Zahbi)
    (60429, 640, 9, 18, 128, 64, 64), -- chunk of copper ore
    (60429, 642, 595, 620, 24, 0, 0), -- chunk of zinc ore
    (60429, 644, 1500, 9800, 24, 12, 12), -- chunk of mythril ore
    (60429, 650, 952, 4179, 12, 0, 0), -- brass ingot
    (60429, 736, 315, 1260, 24, 12, 12), -- chunk of silver ore
    (60429, 737, 1890, 13230, 12, 0, 0), -- chunk of gold ore
    (60429, 769, 1288, 6440, 48, 16, 32), -- red rock
    (60429, 770, 1288, 6440, 48, 16, 32), -- blue rock
    (60429, 771, 1288, 6440, 48, 16, 32), -- yellow rock
    (60429, 772, 1288, 6440, 48, 16, 32), -- green rock
    (60429, 773, 1288, 6440, 48, 16, 32), -- translucent rock
    (60429, 774, 1288, 6440, 48, 16, 32), -- purple rock
    (60429, 775, 1288, 6440, 48, 16, 32), -- black rock
    (60429, 776, 1288, 6440, 48, 16, 32), -- white rock
    (60429, 2143, 75, 242, 48, 12, 12), -- mandrel
    (60429, 2144, 75, 242, 48, 12, 12), -- workshop anvil
    (60429, 814, 1396, 2794, 80, 0, 32), -- amber stone
    (60429, 13335, 1186, 1238, 20, 0, 20), -- amber earring
    (60429, 13473, 1875, 2400, 20, 0, 15), -- amber ring
    (60429, 800, 1396, 2794, 80, 0, 32), -- amethyst
    (60429, 13333, 1186, 1238, 20, 0, 20), -- amethyst earring
    (60429, 13471, 1875, 2400, 20, 0, 15), -- amethyst ring
    (60429, 811, 9000, 15000, 15, 0, 6), -- ametrine
    (60429, 13340, 13440, 13440, 20, 0, 10), -- ametrine earring
    (60429, 813, 48336, 284544, 15, 0, 3), -- angelstone
    (60429, 791, 23400, 46608, 15, 0, 3), -- aquamarine
    (60429, 13320, 13440, 13440, 20, 0, 10), -- black earring
    (60429, 13338, 13440, 13440, 15, 0, 3), -- blood earring
    (60429, 16641, 2870, 13845, 20, 0, 10), -- brass axe
    (60429, 16407, 2399, 13554, 20, 0, 10), -- brass baghnakhs
    (60429, 12449, 1503, 4300, 20, 0, 15), -- brass cap
    (60429, 12817, 11520, 11520, 20, 0, 15), -- brass cuisses
    (60429, 16449, 4054, 4054, 20, 0, 10), -- brass dagger
    (60429, 12689, 7728, 7728, 20, 0, 20), -- brass finger gauntlets
    (60429, 12945, 6864, 6864, 20, 0, 15), -- brass greaves
    (60429, 12497, 1029, 1029, 20, 0, 15), -- brass hairpin
    (60429, 17043, 3102, 3102, 20, 0, 10), -- brass hammer
    (60429, 12577, 15000, 15000, 20, 0, 10), -- brass harness
    (60429, 16391, 2700, 13989, 20, 0, 10), -- brass knuckles
    (60429, 12961, 2380, 3720, 20, 0, 15), -- brass leggings
    (60429, 12433, 9600, 9600, 20, 0, 15), -- brass mask
    (60429, 12705, 2511, 2511, 20, 0, 15), -- brass mittens
    (60429, 13465, 536, 536, 20, 0, 20), -- brass ring
    (60429, 17081, 3229, 3229, 20, 0, 10), -- brass rod
    (60429, 12561, 7000, 15000, 20, 0, 20), -- brass scale mail
    (60429, 673, 520, 1131, 255, 0, 100), -- handful of brass scales
    (60429, 661, 1171, 1171, 255, 0, 100), -- brass sheet
    (60429, 12833, 1500, 1500, 20, 0, 15), -- brass subligar
    (60429, 16531, 3522, 24654, 20, 0, 10), -- brass xiphos
    (60429, 16769, 5424, 5424, 20, 0, 10), -- brass zaghnal
    (60429, 13209, 4590, 32130, 20, 0, 10), -- chain belt
    (60429, 13083, 3645, 25515, 20, 0, 10), -- chain choker
    (60429, 13082, 11260, 11260, 20, 0, 10), -- chain gorget
    (60429, 801, 23400, 49608, 15, 0, 3), -- chrysoberyl
    (60429, 12472, 200, 200, 20, 0, 20), -- circlet
    (60429, 13332, 1186, 1238, 20, 0, 20), -- clear earring
    (60429, 13470, 1875, 2400, 20, 0, 15), -- clear ring
    (60429, 809, 1396, 1396, 80, 0, 65), -- clear topaz
    (60429, 12496, 117, 234, 20, 0, 20), -- copper hairpin
    (60429, 648, 571, 571, 55, 0, 22), -- copper ingot
    (60429, 13454, 114, 114, 20, 0, 20), -- copper ring
    (60429, 812, 48336, 284544, 15, 0, 3), -- deathstone
    (60429, 787, 48336, 284544, 15, 0, 3), -- diamond
    (60429, 785, 48336, 284544, 15, 0, 3), -- emerald
    (60429, 810, 23400, 49608, 15, 0, 3), -- fluorite
    (60429, 790, 9000, 15000, 15, 0, 6), -- garnet
    (60429, 13983, 17415, 121905, 20, 0, 10), -- gold bangles
    (60429, 761, 15525, 108675, 55, 0, 22), -- gold chain
    (60429, 13315, 7875, 55125, 20, 0, 10), -- gold earring
    (60429, 745, 9450, 66150, 55, 0, 22), -- gold ingot
    (60429, 13445, 7875, 55125, 20, 0, 15), -- gold ring
    (60429, 752, 9291, 65037, 20, 0, 15), -- gold sheet
    (60429, 808, 9000, 15000, 15, 0, 6), -- goshenite
    (60429, 13339, 13000, 20000, 20, 0, 10), -- goshenite earring
    (60429, 784, 42432, 136032, 15, 0, 3), -- jadeite
    (60429, 795, 1396, 1434, 80, 0, 32), -- lapis lazuli
    (60429, 13334, 2812, 2812, 20, 0, 20), -- lapis lazuli earring
    (60429, 13472, 3350, 3350, 20, 0, 15), -- lapis lazuli ring
    (60429, 796, 1396, 1434, 80, 0, 32), -- light opal
    (60429, 802, 42432, 136032, 15, 0, 3), -- moonstone
    (60429, 681, 10500, 55440, 30, 6, 12), -- mythril chain
    (60429, 13328, 3375, 23625, 20, 0, 10), -- mythril earring
    (60429, 653, 19900, 36400, 55, 0, 22), -- mythril ingot
    (60429, 13446, 3375, 23625, 20, 0, 10), -- mythril ring
    (60429, 663, 20240, 45600, 80, 0, 32), -- mythril sheet
    (60429, 799, 1396, 1434, 80, 0, 32), -- onyx
    (60429, 13336, 2812, 2812, 20, 0, 15), -- onyx earring
    (60429, 13474, 3350, 3350, 20, 0, 15), -- onyx ring
    (60429, 13337, 2812, 2812, 20, 0, 15), -- opal earring
    (60429, 797, 42432, 136032, 15, 0, 6), -- painite
    (60429, 13317, 12800, 12800, 20, 0, 10), -- pearl earring
    (60429, 788, 56160, 56160, 15, 0, 6), -- peridot
    (60429, 13319, 12800, 12800, 20, 0, 10), -- peridot earring
    (60429, 762, 20925, 146475, 55, 0, 22), -- platinum chain
    (60429, 13316, 25650, 179550, 20, 0, 10), -- platinum earring
    (60429, 746, 17550, 37550, 80, 0, 32), -- platinum ingot
    (60429, 738, 8032, 15245, 30, 0, 12), -- chunk of platinum ore
    (60429, 13447, 27900, 60700, 20, 0, 15), -- platinum ring
    (60429, 754, 16875, 46875, 80, 0, 32), -- platinum sheet
    (60429, 12473, 1863, 13041, 20, 0, 10), -- poets circlet
    (60429, 786, 143488, 265088, 15, 0, 3), -- ruby
    (60429, 16551, 3631, 15487, 20, 0, 10), -- sapara
    (60429, 794, 143488, 265088, 15, 0, 3), -- sapphire
    (60429, 807, 1396, 1434, 80, 0, 32), -- sardonyx
    (60429, 13331, 2812, 2812, 20, 0, 10), -- sardonyx earring
    (60429, 13444, 3350, 3350, 20, 0, 15), -- sardonyx ring
    (60429, 13979, 20088, 20088, 20, 0, 10), -- silver bangles
    (60429, 806, 1396, 1434, 80, 0, 32), -- tourmaline
    (60429, 13330, 2812, 2812, 20, 0, 10), -- tourmaline earring
    (60429, 13456, 5850, 5850, 20, 0, 20), -- silver ring
    (60429, 815, 56160, 56160, 15, 0, 6), -- sphene
    (60429, 13342, 12250, 12250, 20, 0, 10), -- sphene earring
    (60429, 804, 143488, 265088, 15, 0, 3), -- spinel
    (60429, 803, 42432, 163032, 15, 0, 3), -- sunstone
    (60429, 789, 143488, 260088, 15, 0, 3), -- topaz
    (60429, 13468, 3350, 3350, 20, 0, 15), -- tourmaline ring
    (60429, 798, 56160, 56160, 165, 0, 65), -- turquoise
    (60429, 805, 42432, 136032, 15, 0, 3), -- zircon

    -- Leathercraft Guild
    -- Kueh_Igunahmori | Cletae (Southern_San_dOria)
    (529, 505, 135, 349, 24, 8, 24), -- sheepskin
    (529, 695, 120, 184, 64, 24, 24), -- willow log
    (529, 853, 2155, 13680, 24, 8, 24), -- raptor skin
    (529, 854, 2650, 3304, 24, 8, 24), -- cockatrice skin
    (529, 856, 45, 276, 24, 8, 24), -- rabbit hide
    (529, 858, 483, 1419, 48, 24, 24), -- wolf hide
    (529, 859, 937, 3250, 48, 24, 24), -- ram skin
    (529, 861, 1312, 1653, 48, 24, 24), -- black tiger hide
    (529, 863, 2700, 16560, 48, 24, 24), -- coeurl hide
    (529, 1116, 44505, 44505, 12, 0, 0), -- manticore hide
    (529, 2129, 75, 75, 150, 50, 25), -- tanning vat
    (529, 4509, 9, 23, 200, 50, 50), -- flask of distilled water
    (529, 13192, 837, 1224, 64, 0, 0), -- leather belt
    (529, 13203, 2277, 5980, 20, 0, 10), -- barbarians belt
    (529, 13703, 286944, 286944, 20, 0, 10), -- brigandine armor
    (529, 16385, 625, 625, 20, 0, 10), -- cesti
    (529, 506, 33796, 33796, 165, 0, 65), -- square of coeurl leather
    (529, 12443, 22713, 22713, 20, 0, 10), -- cuir bandana
    (529, 12571, 32340, 37514, 20, 0, 5), -- cuir bouilli
    (529, 12699, 44789, 65249, 20, 0, 5), -- cuir gloves
    (529, 12955, 40414, 41039, 20, 0, 5), -- cuir highboots
    (529, 12827, 32592, 66192, 20, 0, 5), -- cuir trousers
    (529, 857, 1940, 4280, 255, 0, 100), -- dhalmel hide
    (529, 848, 2912, 4636, 80, 0, 32), -- square of dhalmel leather
    (529, 13588, 2484, 2980, 20, 0, 10), -- dhalmel mantle
    (529, 16388, 11970, 41496, 20, 0, 5), -- himantes
    (529, 12440, 330, 2024, 20, 0, 15), -- leather bandana
    (529, 12696, 342, 1612, 20, 0, 15), -- leather gloves
    (529, 13081, 211, 1003, 20, 0, 15), -- leather gorget
    (529, 12952, 661, 1545, 20, 0, 15), -- leather highboots
    (529, 13469, 1106, 1450, 20, 0, 15), -- leather ring
    (529, 12294, 25920, 45968, 10, 0, 5), -- leather shield
    (529, 12825, 589, 9615, 20, 0, 15), -- lizard trousers
    (529, 12568, 1102, 3279, 20, 0, 15), -- leather vest
    (529, 13193, 4590, 12420, 20, 0, 15), -- lizard belt
    (529, 16386, 945, 3780, 20, 0, 15), -- lizard cesti
    (529, 12697, 2700, 17136, 20, 0, 15), -- lizard gloves
    (529, 12441, 4136, 4136, 20, 0, 15), -- lizard helm
    (529, 12569, 13514, 33476, 20, 0, 15), -- lizard jerkin
    (529, 12953, 5578, 26542, 20, 0, 15), -- lizard ledelsens
    (529, 13592, 2533, 12337, 20, 0, 15), -- lizard mantle
    (529, 852, 630, 1586, 255, 0, 100), -- lizard skin
    (529, 13195, 2277, 5980, 20, 0, 10), -- magic belt
    (529, 1117, 8385, 51428, 30, 0, 12), -- square of manticore leather
    (529, 12995, 52120, 52120, 20, 0, 5), -- moccasins
    (529, 917, 947, 2039, 255, 0, 100), -- sheet of parchment
    (529, 13594, 132, 246, 20, 10, 15), -- rabbit mantle
    (529, 851, 2718, 14785, 80, 0, 32), -- square of ram leather
    (529, 13570, 10800, 10800, 20, 0, 10), -- ram mantle
    (529, 12700, 29700, 82362, 20, 0, 5), -- raptor gloves
    (529, 12444, 9200, 10000, 20, 0, 5), -- raptor helm
    (529, 12572, 44460, 130416, 20, 0, 5), -- raptor jerkin
    (529, 13593, 24000, 37120, 20, 0, 5), -- raptor mantle
    (529, 12828, 61204, 80215, 20, 0, 5), -- raptor trousers
    (529, 12993, 3366, 7001, 20, 0, 15), -- sandals
    (529, 850, 390, 390, 80, 0, 32), -- square of sheep leather
    (529, 832, 1575, 4320, 80, 20, 40), -- clump of sheep wool
    (529, 12992, 435, 495, 20, 0, 15), -- solea
    (529, 12442, 8000, 9000, 20, 0, 10), -- studded bandana
    (529, 12945, 20556, 20556, 20, 0, 10), -- brass greaves
    (529, 12698, 23580, 23580, 20, 0, 10), -- studded gloves
    (529, 12826, 32002, 36232, 20, 0, 10), -- studded trousers
    (529, 12570, 44232, 44916, 20, 0, 10), -- studded vest
    (529, 855, 3087, 3087, 30, 0, 12), -- square of black tiger leather
    (529, 13200, 13860, 80572, 20, 0, 10), -- waistbelt
    (529, 13089, 6384, 39155, 20, 0, 15), -- wolf gorget
    (529, 13571, 7282, 27074, 20, 0, 10), -- wolf mantle

    -- Smithing Guild
    -- Doggomehr | Lucretia (Northern_San_dOria)
    (531, 640, 9, 15, 124, 48, 24), -- chunk of copper ore
    (531, 641, 30, 66, 124, 48, 24), -- chunk of tin ore
    (531, 643, 675, 981, 124, 48, 24), -- chunk of iron ore
    (531, 644, 2000, 10000, 64, 0, 0), -- chunk of mythril ore
    (531, 2143, 75, 75, 124, 48, 100), -- mandrel
    (531, 2144, 75, 75, 124, 48, 100), -- workshop anvil
    (531, 16455, 3591, 25137, 20, 0, 15), -- baselard
    (531, 16545, 15048, 105336, 20, 0, 15), -- broadsword
    (531, 16448, 240, 761, 20, 0, 15), -- bronze dagger
    (531, 649, 240, 761, 165, 0, 65), -- bronze ingot
    (531, 17034, 313, 917, 20, 0, 15), -- bronze mace
    (531, 17059, 448, 448, 20, 0, 15), -- bronze rod
    (531, 672, 81, 106, 165, 33, 65), -- handful of bronze scales
    (531, 660, 74, 138, 165, 33, 65), -- bronze sheet
    (531, 16535, 509, 1056, 20, 0, 20), -- bronze sword
    (531, 16768, 643, 677, 20, 0, 20), -- bronze zaghnal
    (531, 12808, 9450, 66150, 20, 0, 20), -- chain hose
    (531, 12680, 10744, 10744, 20, 0, 20), -- chain mittens
    (531, 16411, 8208, 57456, 20, 0, 20), -- claws
    (531, 16583, 5358, 5358, 20, 0, 20), -- claymore
    (531, 16450, 1827, 12789, 20, 0, 10), -- dagger
    (531, 682, 14961, 104727, 80, 0, 32), -- darksteel chain
    (531, 16413, 19440, 136080, 20, 0, 10), -- darksteel claws
    (531, 664, 12825, 89775, 30, 0, 12), -- darksteel sheet
    (531, 16538, 44886, 314202, 20, 0, 10), -- darksteel sword
    (531, 12432, 2610, 7076, 20, 0, 20), -- faceguard
    (531, 16524, 9576, 67032, 20, 0, 10), -- fleuret
    (531, 16532, 36503, 36503, 20, 0, 10), -- gladius
    (531, 16590, 30411, 212877, 20, 0, 15), -- greatsword
    (531, 12936, 5805, 40635, 20, 0, 15), -- greaves
    (531, 16576, 22356, 156492, 20, 0, 15), -- hunting sword
    (531, 680, 4725, 11592, 80, 0, 32), -- iron chain
    (531, 14243, 27945, 27945, 20, 0, 5), -- iron cuisses
    (531, 14001, 42476, 88529, 20, 0, 10), -- iron finger gauntlets
    (531, 14118, 10206, 71442, 20, 0, 10), -- iron greaves
    (531, 651, 2700, 2916, 165, 0, 65), -- iron ingot
    (531, 12424, 7695, 26676, 20, 0, 15), -- iron mask
    (531, 1155, 2275, 2275, 165, 0, 65), -- handful of iron sand
    (531, 13783, 81084, 81084, 20, 0, 10), -- iron scale mail
    (531, 674, 4945, 30744, 80, 0, 32), -- handful of iron scales
    (531, 16536, 5940, 41580, 20, 0, 10), -- iron sword
    (531, 13871, 27216, 47355, 20, 0, 10), -- iron visor
    (531, 16399, 8712, 60984, 20, 0, 10), -- katars
    (531, 12306, 14165, 54378, 20, 0, 10), -- kite shield
    (531, 16567, 34875, 104625, 20, 0, 10), -- knights sword
    (531, 16460, 7776, 38880, 20, 0, 10), -- kris
    (531, 16566, 6912, 34560, 20, 0, 10), -- longsword
    (531, 17035, 3636, 18180, 20, 0, 10), -- mace
    (531, 16412, 49699, 49699, 20, 0, 10), -- mythril claws
    (531, 16584, 23625, 118125, 20, 0, 10), -- mythril claymore
    (531, 16451, 6438, 32190, 20, 0, 10), -- mythril dagger
    (531, 653, 19900, 36400, 55, 0, 22), -- mythril ingot
    (531, 17036, 10152, 50760, 20, 0, 10), -- mythril mace
    (531, 16651, 66555, 168606, 20, 0, 5), -- mythril pick
    (531, 17061, 3519, 17595, 20, 0, 10), -- mythril rod
    (531, 16775, 31050, 77625, 20, 0, 10), -- mythril scythe
    (531, 663, 20240, 45600, 80, 0, 32), -- mythril sheet
    (531, 16537, 25800, 32680, 20, 0, 10), -- mythril sword
    (531, 17060, 12199, 12199, 80, 0, 32), -- rod
    (531, 12816, 2810, 8735, 80, 0, 32), -- scale cuisses
    (531, 12688, 1666, 5664, 20, 0, 15), -- scale finger gauntlets
    (531, 12560, 10882, 10882, 20, 0, 15), -- scale mail
    (531, 16774, 7947, 39735, 20, 0, 15), -- scythe
    (531, 16565, 1395, 8853, 20, 0, 15), -- spatha
    (531, 14245, 52785, 166096, 20, 0, 5), -- steel cuisses
    (531, 14120, 38311, 38311, 20, 0, 5), -- steel greaves
    (531, 652, 25620, 25620, 80, 0, 32), -- steel ingot
    (531, 13785, 146819, 146819, 20, 0, 5), -- steel scale mail
    (531, 676, 13720, 13720, 80, 0, 32), -- handful of steel scales
    (531, 666, 14868, 39984, 165, 0, 65), -- steel sheet
    (531, 13873, 36960, 36960, 20, 0, 5), -- steel visor
    (531, 657, 4500, 22500, 20, 0, 15), -- lump of tama-hagane
    (531, 16589, 10723, 49576, 20, 0, 10), -- two-handed sword
    (531, 16650, 18270, 36987, 20, 0, 10), -- war pick
    (531, 16530, 1323, 1323, 20, 0, 15), -- xiphos
    -- Mololo | Kamilah (Mhaura)
    (532, 640, 9, 15, 124, 48, 24), -- chunk of copper ore
    (532, 641, 30, 66, 124, 48, 24), -- chunk of tin ore
    (532, 643, 675, 981, 124, 48, 24), -- chunk of iron ore
    (532, 660, 74, 138, 48, 24, 24), -- bronze sheet
    (532, 672, 81, 106, 48, 24, 24), -- handful of bronze scales
    (532, 649, 240, 761, 165, 0, 65), -- bronze ingot
    (532, 651, 2700, 2916, 165, 0, 65), -- iron ingot
    (532, 1155, 2275, 2275, 165, 0, 65), -- handful of iron sand
    (532, 674, 4945, 30744, 80, 0, 32), -- handful of iron scales
    (532, 662, 4050, 9898, 165, 33, 65), -- iron sheet
    (532, 2143, 75, 75, 255, 48, 100), -- mandrel
    (532, 2144, 75, 75, 255, 48, 100), -- workshop anvil
    -- Vicious_Eye | Amulya (Metalworks)
    (5332, 640, 9, 15, 124, 48, 24), -- chunk of copper ore
    (5332, 641, 30, 66, 124, 48, 24), -- chunk of tin ore
    (5332, 643, 675, 981, 124, 48, 24), -- chunk of iron ore
    (5332, 2143, 75, 242, 164, 48, 50), -- mandrel
    (5332, 2144, 75, 75, 164, 48, 50), -- workshop anvil
    (5332, 16455, 3591, 25137, 20, 0, 15), -- baselard
    (5332, 16545, 15048, 105336, 20, 0, 15), -- broadsword
    (5332, 16448, 240, 761, 20, 0, 15), -- bronze dagger
    (5332, 649, 240, 761, 165, 0, 65), -- bronze ingot
    (5332, 17034, 313, 917, 20, 0, 15), -- bronze mace
    (5332, 17059, 448, 448, 20, 0, 15), -- bronze rod
    (5332, 672, 81, 106, 165, 33, 65), -- handful of bronze scales
    (5332, 660, 74, 138, 165, 33, 65), -- bronze sheet
    (5332, 16535, 509, 1056, 20, 0, 20), -- bronze sword
    (5332, 16768, 643, 677, 20, 0, 20), -- bronze zaghnal
    (5332, 12808, 9450, 66150, 20, 0, 20), -- chain hose
    (5332, 12680, 10744, 10744, 20, 0, 20), -- chain mittens
    (5332, 16411, 8208, 57456, 20, 0, 20), -- claws
    (5332, 16583, 5358, 5358, 20, 0, 20), -- claymore
    (5332, 16450, 1827, 12789, 20, 0, 10), -- dagger
    (5332, 682, 14961, 104727, 80, 0, 32), -- darksteel chain
    (5332, 16413, 19440, 136080, 20, 0, 10), -- darksteel claws
    (5332, 664, 12825, 89775, 30, 0, 12), -- darksteel sheet
    (5332, 16538, 44886, 314202, 20, 0, 10), -- darksteel sword
    (5332, 12432, 2610, 7076, 20, 0, 20), -- faceguard
    (5332, 16524, 9576, 67032, 20, 0, 10), -- fleuret
    (5332, 16532, 36503, 36503, 20, 0, 10), -- gladius
    (5332, 16590, 30411, 212877, 20, 0, 15), -- greatsword
    (5332, 12936, 5805, 40635, 20, 0, 15), -- greaves
    (5332, 16576, 22356, 156492, 20, 0, 15), -- hunting sword
    (5332, 14243, 27945, 27945, 20, 0, 5), -- iron cuisses
    (5332, 14001, 42476, 88529, 20, 0, 10), -- iron finger gauntlets
    (5332, 14118, 10206, 71442, 20, 0, 10), -- iron greaves
    (5332, 651, 2700, 2916, 165, 0, 65), -- iron ingot
    (5332, 12424, 7695, 26676, 20, 0, 15), -- iron mask
    (5332, 1155, 2275, 2275, 165, 0, 65), -- handful of iron sand
    (5332, 13783, 81084, 81084, 20, 0, 10), -- iron scale mail
    (5332, 674, 4945, 30744, 80, 0, 32), -- handful of iron scales
    (5332, 662, 4050, 9898, 165, 33, 65), -- iron sheet
    (5332, 16536, 5940, 41580, 20, 0, 10), -- iron sword
    (5332, 13871, 27216, 47355, 20, 0, 10), -- iron visor
    (5332, 16399, 8712, 60984, 20, 0, 10), -- katars
    (5332, 12306, 14165, 54378, 20, 0, 10), -- kite shield
    (5332, 16567, 34875, 104625, 20, 0, 10), -- knights sword
    (5332, 16460, 7776, 38880, 20, 0, 10), -- kris
    (5332, 16566, 6912, 34560, 20, 0, 10), -- longsword
    (5332, 17035, 3636, 18180, 20, 0, 10), -- mace
    (5332, 16412, 49699, 49699, 20, 0, 10), -- mythril claws
    (5332, 16584, 23625, 118125, 20, 0, 10), -- mythril claymore
    (5332, 16451, 6438, 32190, 20, 0, 10), -- mythril dagger
    (5332, 653, 19900, 36400, 55, 0, 22), -- mythril ingot
    (5332, 17036, 10152, 50760, 20, 0, 10), -- mythril mace
    (5332, 644, 2000, 10000, 165, 0, 65), -- chunk of mythril ore
    (5332, 16651, 66555, 168606, 20, 0, 5), -- mythril pick
    (5332, 17061, 3519, 17595, 20, 0, 10), -- mythril rod
    (5332, 16775, 31050, 77625, 20, 0, 10), -- mythril scythe
    (5332, 663, 20240, 45600, 80, 0, 32), -- mythril sheet
    (5332, 16537, 25800, 32680, 20, 0, 10), -- mythril sword
    (5332, 17060, 12199, 12199, 80, 0, 32), -- rod
    (5332, 12816, 2810, 8735, 80, 0, 32), -- scale cuisses
    (5332, 12688, 1666, 5664, 20, 0, 15), -- scale finger gauntlets
    (5332, 12944, 1519, 5294, 20, 0, 15), -- scale greaves
    (5332, 12560, 10882, 10882, 20, 0, 15), -- scale mail
    (5332, 16774, 7947, 39735, 20, 0, 15), -- scythe
    (5332, 16565, 1395, 8853, 20, 0, 15), -- spatha
    (5332, 14245, 52785, 166096, 20, 0, 5), -- steel cuisses
    (5332, 14003, 79745, 84198, 20, 0, 5), -- steel finger gauntlets
    (5332, 14120, 38311, 38311, 20, 0, 5), -- steel greaves
    (5332, 652, 25620, 25620, 80, 0, 32), -- steel ingot
    (5332, 13785, 146819, 146819, 20, 0, 5), -- steel scale mail
    (5332, 676, 13720, 13720, 80, 0, 32), -- handful of steel scales
    (5332, 666, 14868, 39984, 165, 0, 65), -- steel sheet
    (5332, 13873, 36960, 36960, 20, 0, 5), -- steel visor
    (5332, 657, 4500, 22500, 20, 0, 15), -- lump of tama-hagane
    (5332, 16589, 10723, 49576, 20, 0, 10), -- two-handed sword
    (5332, 16650, 18270, 36987, 20, 0, 10), -- war pick
    (5332, 16530, 1323, 1323, 20, 0, 15), -- xiphos
    (5332, 16770, 16803, 24703, 20, 0, 15), -- zaghnal
    -- Ndego (Al_Zahbi)
    (60427, 640, 9, 15, 124, 48, 24), -- chunk of copper ore
    (60427, 641, 30, 66, 124, 48, 24), -- chunk of tin ore
    (60427, 643, 675, 981, 124, 48, 24), -- chunk of iron ore
    (60427, 660, 74, 138, 48, 24, 24), -- bronze sheet
    (60427, 672, 81, 106, 48, 24, 24), -- handful of bronze scales
    (60427, 16455, 3591, 25137, 20, 0, 15), -- baselard
    (60427, 16545, 15048, 105336, 20, 0, 15), -- broadsword
    (60427, 16448, 240, 761, 20, 0, 15), -- bronze dagger
    (60427, 649, 240, 761, 165, 33, 65), -- bronze ingot
    (60427, 17034, 313, 917, 20, 0, 15), -- bronze mace
    (60427, 17059, 448, 448, 20, 0, 15), -- bronze rod
    (60427, 16535, 509, 1056, 20, 0, 20), -- bronze sword
    (60427, 16768, 643, 677, 20, 0, 20), -- bronze zaghnal
    (60427, 12808, 9450, 66150, 20, 0, 20), -- chain hose
    (60427, 12680, 10744, 10744, 20, 0, 20), -- chain mittens
    (60427, 16411, 8208, 57456, 20, 0, 20), -- claws
    (60427, 16583, 5358, 5358, 20, 0, 20), -- claymore
    (60427, 16450, 1827, 12789, 20, 0, 10), -- dagger
    (60427, 682, 14961, 104727, 80, 0, 32), -- darksteel chain
    (60427, 16413, 19440, 136080, 20, 0, 10), -- darksteel claws
    (60427, 664, 12825, 89775, 30, 0, 12), -- darksteel sheet
    (60427, 16538, 44886, 314202, 20, 0, 10), -- darksteel sword
    (60427, 12432, 2610, 7076, 20, 0, 20), -- faceguard
    (60427, 16524, 9576, 67032, 20, 0, 10), -- fleuret
    (60427, 16532, 36503, 36503, 20, 0, 10), -- gladius
    (60427, 16590, 30411, 212877, 20, 0, 15), -- greatsword
    (60427, 12936, 5805, 40635, 20, 0, 15), -- greaves
    (60427, 16576, 22356, 156492, 20, 0, 15), -- hunting sword
    (60427, 680, 4725, 11592, 80, 0, 32), -- iron chain
    (60427, 14243, 27945, 27945, 20, 0, 5), -- iron cuisses
    (60427, 14001, 42476, 88529, 20, 0, 10), -- iron finger gauntlets
    (60427, 14118, 10206, 71442, 20, 0, 10), -- iron greaves
    (60427, 651, 2700, 2916, 165, 0, 65), -- iron ingot
    (60427, 12424, 7695, 26676, 20, 0, 15), -- iron mask
    (60427, 1155, 2275, 2275, 165, 0, 65), -- handful of iron sand
    (60427, 13783, 81084, 81084, 20, 0, 10), -- iron scale mail
    (60427, 674, 4945, 30744, 80, 0, 32), -- handful of iron scales
    (60427, 16536, 5940, 41580, 20, 0, 10), -- iron sword
    (60427, 13871, 27216, 47355, 20, 0, 10), -- iron visor
    (60427, 16399, 8712, 60984, 20, 0, 10), -- katars
    (60427, 12306, 14165, 54378, 20, 0, 10), -- kite shield
    (60427, 16567, 34875, 104625, 20, 0, 10), -- knights sword
    (60427, 16460, 7776, 38880, 20, 0, 10), -- kris
    (60427, 16566, 6912, 34560, 20, 0, 10), -- longsword
    (60427, 17035, 3636, 18180, 20, 0, 10), -- mace
    (60427, 2143, 75, 75, 255, 48, 100), -- mandrel
    (60427, 16412, 49699, 49699, 20, 0, 10), -- mythril claws
    (60427, 16584, 23625, 118125, 20, 0, 10), -- mythril claymore
    (60427, 16451, 6438, 32190, 20, 0, 10), -- mythril dagger
    (60427, 653, 19900, 36400, 55, 0, 22), -- mythril ingot
    (60427, 17036, 10152, 50760, 20, 0, 10), -- mythril mace
    (60427, 644, 2000, 10000, 165, 0, 65), -- chunk of mythril ore
    (60427, 16651, 66555, 168606, 20, 0, 5), -- mythril pick
    (60427, 17061, 3519, 17595, 20, 0, 10), -- mythril rod
    (60427, 663, 20240, 45600, 80, 0, 32), -- mythril sheet
    (60427, 16537, 25800, 32680, 20, 0, 10), -- mythril sword
    (60427, 17060, 12199, 12199, 80, 0, 32), -- rod
    (60427, 12816, 2810, 8735, 80, 0, 32), -- scale cuisses
    (60427, 12688, 1666, 5664, 20, 0, 15), -- scale finger gauntlets
    (60427, 12944, 1519, 5294, 20, 0, 15), -- scale greaves
    (60427, 12560, 10882, 10882, 20, 0, 15), -- scale mail
    (60427, 16774, 7947, 39735, 20, 0, 15), -- scythe
    (60427, 16565, 1395, 8853, 20, 0, 15), -- spatha
    (60427, 14245, 52785, 166096, 20, 0, 5), -- steel cuisses
    (60427, 14003, 79745, 84198, 20, 0, 5), -- steel finger gauntlets
    (60427, 14120, 38311, 38311, 20, 0, 5), -- steel greaves
    (60427, 652, 25620, 25620, 80, 0, 32), -- steel ingot
    (60427, 13785, 146819, 146819, 20, 0, 5), -- steel scale mail
    (60427, 676, 13720, 13720, 80, 0, 32), -- handful of steel scales
    (60427, 666, 14868, 39984, 165, 0, 65), -- steel sheet
    (60427, 13873, 36960, 36960, 20, 0, 5), -- steel visor
    (60427, 657, 4500, 22500, 20, 0, 15), -- lump of tama-hagane
    (60427, 16589, 10723, 49576, 20, 0, 10), -- two-handed sword
    (60427, 16650, 18270, 36987, 20, 5, 10), -- war pick
    (60427, 16530, 1323, 1323, 20, 0, 15), -- xiphos
    (60427, 16770, 16803, 24703, 20, 0, 15), -- zaghnal

    -- Woodworking Guild
    -- Beugungel (Carpenters_Landing)
    (534, 688, 12, 30, 36, 12, 12), -- arrowwood log
    (534, 693, 640, 1622, 36, 12, 12), -- walnut log
    (534, 695, 120, 184, 36, 12, 12), -- willow log
    (534, 696, 330, 686, 36, 12, 12), -- yew log
    (534, 698, 93, 182, 36, 12, 12), -- ash log
    (534, 1021, 312, 500, 64, 24, 24), -- hatchet
    (534, 1657, 75, 255, 64, 64, 64), -- spool of bundling twine
    -- Cauzeriste | Chaupire (Northern_San_dOria)
    (5132, 688, 15, 28, 24, 12, 24), -- arrowwood log
    (5132, 689, 27, 59, 24, 12, 24), -- lauan log
    (5132, 690, 1723, 10938, 24, 12, 24), -- elm log
    (5132, 691, 45, 276, 24, 12, 24), -- maple log
    (5132, 693, 640, 3586, 24, 12, 24), -- walnut log
    (5132, 694, 2119, 2811, 24, 12, 24), -- chestnut log
    (5132, 695, 120, 132, 24, 12, 24), -- willow log
    (5132, 696, 330, 699, 24, 12, 24), -- yew log
    (5132, 697, 528, 930, 24, 12, 24), -- holly log
    (5132, 698, 72, 122, 24, 12, 24), -- ash log
    (5132, 699, 4740, 24016, 24, 12, 24), -- oak log
    (5132, 700, 9075, 19844, 24, 12, 24), -- mahogany log
    (5132, 701, 6615, 37044, 24, 12, 24), -- rosewood log
    (5132, 702, 9600, 23040, 24, 12, 24), -- ebony log
    (5132, 704, 96, 230, 24, 12, 24), -- bamboo stick
    (5132, 705, 7, 18, 12, 4, 12), -- piece of arrowwood lumber
    (5132, 706, 27, 151, 12, 4, 12), -- piece of lauan lumber
    (5132, 707, 1723, 9651, 12, 4, 12), -- piece of elm lumber
    (5132, 708, 45, 276, 12, 4, 12), -- piece of maple lumber
    (5132, 710, 2119, 6104, 12, 4, 12), -- piece of chestnut lumber
    (5132, 712, 120, 256, 12, 4, 12), -- piece of willow lumber
    (5132, 713, 330, 836, 12, 4, 12), -- piece of yew lumber
    (5132, 714, 607, 2559, 12, 4, 12), -- piece of holly lumber
    (5132, 715, 72, 441, 12, 4, 12), -- piece of ash lumber
    (5132, 716, 4740, 23257, 12, 4, 12), -- piece of oak lumber
    (5132, 1657, 75, 242, 64, 64, 64), -- spool of bundling twine
    -- Dehbi_Moshal (Al_Zahbi)
    (60428, 688, 12, 30, 24, 12, 12), -- arrowwood log
    (60428, 689, 27, 59, 24, 12, 12), -- lauan log
    (60428, 690, 1401, 10295, 24, 12, 12), -- elm log
    (60428, 691, 45, 192, 24, 12, 12), -- maple log
    (60428, 693, 640, 3925, 24, 12, 12), -- walnut log
    (60428, 694, 2119, 4182, 24, 12, 12), -- chestnut log
    (60428, 695, 120, 184, 24, 12, 12), -- willow log
    (60428, 696, 330, 686, 24, 12, 12), -- yew log
    (60428, 697, 528, 930, 24, 12, 12), -- holly log
    (60428, 698, 72, 86, 24, 12, 12), -- ash log
    (60428, 699, 4740, 24016, 24, 12, 12), -- oak log
    (60428, 700, 9075, 19844, 24, 12, 12), -- mahogany log
    (60428, 701, 6615, 18345, 24, 12, 12), -- rosewood log
    (60428, 702, 9600, 45568, 24, 12, 12), -- ebony log
    (60428, 704, 96, 248, 24, 12, 12), -- bamboo stick
    (60428, 705, 7, 18, 12, 4, 12), -- piece of arrowwood lumber
    (60428, 706, 27, 165, 12, 4, 12), -- piece of lauan lumber
    (60428, 708, 45, 276, 12, 4, 12), -- piece of maple lumber
    (60428, 710, 2119, 6104, 12, 4, 12), -- piece of chestnut lumber
    (60428, 712, 120, 256, 12, 4, 12), -- piece of willow lumber
    (60428, 713, 330, 1672, 12, 4, 12), -- piece of yew lumber
    (60428, 714, 607, 2559, 12, 4, 12), -- piece of holly lumber
    (60428, 715, 72, 215, 12, 4, 12), -- piece of ash lumber
    (60428, 716, 4740, 26544, 12, 4, 12), -- piece of oak lumber

    -- Tenshodo Guild
    -- Amalasanda   60432
    (60432, 704, 96, 149, 48, 12, 24), -- bamboo stick
    (60432, 626, 190, 938, 48, 12, 24), -- black pepper
    (60432, 1555, 1061, 1500, 64, 24, 24), -- onz of coriander
    (60432, 5164, 1945, 2854, 64, 24, 24), -- Ground Wasabi
    (60432, 1590, 536, 700, 64, 24, 24), -- sprig of holy basil
    (60432, 1652, 150, 160, 64, 24, 24), -- bottle of rice vinegar
    (60432, 5237, 369, 500, 64, 24, 24), -- bundle of shirataki
    (60432, 1471, 316, 416, 120, 24, 24), -- sticky rice
    (60432, 1554, 431, 512, 64, 24, 24), -- onz of turmeric
    (60432, 1415, 55147, 55147, 165, 33, 65), -- pot of urushi

    -- Akamafula (Lower_Jeuno)
    (60417, 16896, 517, 592, 20, 10, 20), -- kunai
    (60417, 16900, 1404, 1608, 20, 7, 15), -- wakizashi
    (60417, 16960, 3121, 3575, 20, 5, 10), -- uchigatana
    (60417, 16974, 224510, 697840, 20, 0, 0), -- dotanuki
    (60417, 16975, 11583, 13266, 20, 5, 10), -- kanesada
    (60417, 16966, 1836, 2103, 20, 10, 20), -- tachi
    (60417, 16982, 4752, 38670, 20, 0, 0), -- nodachi
    (60417, 16987, 12253, 14033, 20, 5, 10), -- okanehira
    (60417, 17265, 25372, 62175, 20, 5, 10), -- tanegashima
    (60417, 17301, 43, 150, 297, 99, 99), -- shuriken
    (60417, 12456, 552, 858, 20, 10, 20), -- hachimaki
    (60417, 12457, 3272, 5079, 20, 7, 15), -- cotton hachimaki
    (60417, 12458, 8972, 13927, 20, 5, 10), -- soil hachimaki
    (60417, 13111, 20061, 29942, 20, 5, 10), -- nodowa
    (60417, 12584, 833, 1294, 20, 10, 20), -- kenpogi
    (60417, 12585, 4931, 7654, 20, 7, 15), -- cotton dogi
    (60417, 12586, 13266, 14850, 20, 5, 10), -- soil gi
    (60417, 12712, 458, 712, 20, 10, 20), -- tekko
    (60417, 12713, 2528, 3924, 20, 7, 15), -- cotton tekko
    (60417, 12714, 2713, 8316, 20, 5, 10), -- soil tekko
    (60417, 12840, 666, 1034, 20, 10, 20), -- sitabaki
    (60417, 12841, 3951, 8847, 20, 7, 15), -- cotton sitabaki
    (60417, 12842, 2713, 8316, 20, 5, 10), -- soil sitabaki
    (60417, 12968, 424, 660, 20, 10, 20), -- kyahan
    (60417, 12969, 2528, 11925, 20, 7, 15), -- cotton kyahan
    (60417, 12970, 11071, 12393, 20, 5, 10), -- soil kyahan
    (60417, 17302, 347, 347, 2970, 594, 1188), -- juji shuriken
    (60417, 17285, 101745, 101745, 20, 1, 5), -- moonring blade
    (60417, 13088, 43890, 52440, 20, 1, 3), -- darksteel nodowa
    -- Jabbar (Port_Bastok)
    (60419, 704, 96, 149, 48, 24, 24), -- bamboo stick
    (60419, 657, 4690, 10500, 12, 0, 0), -- lump of tama-hagane
    (60419, 4928, 1561, 1747, 30, 6, 12), -- scroll of katon ichi
    (60419, 4934, 1561, 1747, 30, 6, 12), -- scroll of huton ichi
    (60419, 4937, 1561, 1747, 30, 6, 12), -- scroll of doton ichi
    (60419, 4943, 1561, 1747, 30, 6, 12), -- scroll of suiton ichi
    (60419, 4878, 37800, 41370, 7, 0, 0), -- scroll of absorb-int
    (60419, 4879, 14070, 15750, 7, 0, 0), -- scroll of absorb-mnd
    (60419, 4880, 14070, 15750, 7, 0, 0), -- scroll of absorb-chr
    (60419, 1554, 431, 512, 64, 24, 24), -- onz of turmeric
    (60419, 1555, 1061, 1259, 64, 24, 24), -- onz of coriander
    (60419, 1590, 536, 700, 64, 24, 24), -- sprig of holy basil
    (60419, 1475, 579, 1188, 64, 24, 24), -- onz of curry powder
    (60419, 4876, 14070, 15750, 7, 0, 0), -- scroll of absorb-vit
    (60419, 4877, 39270, 41370, 7, 0, 0), -- scroll of absorb-agi
    (60419, 1164, 30, 65, 2970, 0, 0), -- tsurara
    (60419, 4874, 4000, 4500, 7, 0, 0), -- scroll of absorb-str
    (60419, 5164, 1945, 2854, 64, 24, 24), -- jar of ground wasabi
    (60419, 1652, 150, 160, 64, 24, 24), -- bottle of rice vinegar
    (60419, 5236, 194, 224, 64, 24, 24), -- clump of shungiku
    (60419, 4875, 4000, 4500, 7, 0, 0), -- scroll of absorb-dex
    -- Silver_Owl (Port_Bastok)
    (60420, 16896, 517, 592, 20, 10, 20), -- kunai
    (60420, 16919, 2728, 17167, 20, 7, 15), -- shinobi-gatana
    (60420, 16975, 11583, 13266, 20, 5, 10), -- kanesada
    (60420, 16988, 14676, 16808, 20, 7, 15), -- kotetsu
    (60420, 12456, 552, 858, 20, 10, 20), -- hachimaki
    (60420, 12457, 3272, 5079, 20, 7, 15), -- cotton hachimaki
    (60420, 13111, 20061, 29942, 20, 5, 10), -- nodowa
    (60420, 13088, 43890, 52440, 20, 0, 0), -- darksteel nodowa
    (60420, 12584, 833, 1294, 20, 10, 20), -- kenpogi
    (60420, 12585, 4931, 7654, 20, 7, 15), -- cotton dogi
    (60420, 12712, 458, 712, 20, 10, 20), -- tekko
    (60420, 12713, 2528, 3924, 20, 7, 15), -- cotton tekko
    (60420, 12840, 666, 1034, 20, 10, 20), -- sitabaki
    (60420, 12968, 424, 660, 20, 10, 20), -- kyahan
    (60420, 12969, 2528, 11925, 20, 7, 15), -- cotton kyahan
    (60420, 16405, 104, 225, 20, 0, 0), -- cat baghnakhs
    (60420, 17314, 7333, 7446, 15, 0, 0), -- quake grenade
    (60420, 16966, 1836, 2103, 20, 7, 15), -- tachi
    (60420, 12841, 3951, 8847, 20, 10, 20), -- cotton sitabaki
    -- Achika (Norg)
    (60421, 12456, 552, 858, 20, 10, 20), -- hachimaki
    (60421, 12457, 3272, 5079, 20, 7, 15), -- cotton hachimaki
    (60421, 12458, 10044, 13927, 20, 5, 10), -- soil hachimaki
    (60421, 13111, 20061, 29942, 20, 5, 10), -- nodowa
    (60421, 12584, 833, 1294, 20, 10, 20), -- kenpogi
    (60421, 12585, 4931, 7654, 20, 7, 15), -- cotton dogi
    (60421, 12586, 13266, 14850, 20, 5, 10), -- soil gi
    (60421, 12712, 458, 712, 20, 10, 20), -- tekko
    (60421, 12713, 2528, 3924, 20, 7, 15), -- cotton tekko
    (60421, 12714, 6316, 8316, 20, 5, 10), -- soil tekko
    (60421, 12840, 666, 1034, 20, 10, 20), -- sitabaki
    (60421, 12841, 3951, 8847, 20, 7, 15), -- cotton sitabaki
    (60421, 12842, 2713, 8316, 20, 5, 10), -- soil sitabaki
    (60421, 12968, 424, 660, 20, 10, 20), -- kyahan
    (60421, 12969, 2830, 11925, 20, 7, 15), -- cotton kyahan
    (60421, 12970, 11071, 12393, 20, 5, 10), -- soil kyahan
    -- Chiyo (Norg)
    (60422, 4928, 1561, 1747, 30, 6, 12), -- scroll of katon ichi
    (60422, 4931, 1561, 1747, 30, 6, 12), -- scroll of hyoton ichi
    (60422, 4934, 1561, 1747, 30, 6, 12), -- scroll of huton ichi
    (60422, 4937, 1561, 1747, 30, 6, 12), -- scroll of doton ichi
    (60422, 4940, 1561, 1747, 30, 6, 12), -- scroll of raiton ichi
    (60422, 4943, 1561, 1747, 30, 6, 12), -- scroll of suiton ichi
    (60422, 4879, 14070, 15750, 7, 1, 2), -- scroll of absorb-mnd
    (60422, 4880, 14070, 15750, 7, 1, 2), -- scroll of absorb-chr
    -- Jirokichi (Norg)
    (60423, 16406, 14428, 35251, 20, 0, 0), -- baghnakhs
    (60423, 16411, 11746, 46986, 20, 0, 0), -- claws
    (60423, 16419, 76419, 168396, 20, 0, 0), -- patas
    (60423, 16896, 517, 592, 20, 10, 20), -- kunai
    (60423, 16917, 4226, 4226, 20, 7, 15), -- suzume
    (60423, 16900, 1404, 1608, 20, 7, 15), -- wakizashi
    (60423, 16919, 2728, 17167, 20, 7, 15), -- shinobi-gatana
    (60423, 16960, 3121, 3575, 20, 7, 15), -- uchigatana
    (60423, 16975, 11583, 13266, 20, 5, 10), -- kanesada
    (60423, 16966, 1836, 2103, 20, 10, 20), -- tachi
    (60423, 16982, 4752, 38670, 20, 5, 10), -- nodachi
    (60423, 16987, 12253, 14033, 20, 5, 10), -- okanehira
    (60423, 16988, 14676, 16808, 20, 0, 0), -- kotetsu
    (60423, 17802, 189945, 464059, 20, 0, 0), -- kiku-ichimonji
    (60423, 16871, 183516, 404395, 20, 0, 0), -- kamayari
    (60423, 17259, 72144, 158976, 20, 0, 0), -- pirates gun
    (60423, 17301, 43, 150, 297, 99, 99), -- shuriken
    (60423, 17302, 347, 347, 297, 0, 0), -- juji shuriken
    (60423, 17303, 7333, 7446, 297, 0, 0), -- manji shuriken
    (60423, 17285, 101745, 101745, 20, 0, 0), -- moonring blade
    (60423, 17314, 7333, 7446, 15, 0, 0), -- quake grenade
    (60423, 17320, 7, 18, 297, 0, 0), -- iron arrow
    (60423, 17322, 128, 330, 297, 0, 0), -- fire arrow
    (60423, 17340, 58, 174, 297, 0, 0), -- bullet
    -- Vuliaie (Norg)
    (60424, 704, 96, 149, 48, 24, 24), -- bamboo stick
    (60424, 915, 2700, 16120, 165, 33, 165), -- jar of toad oil
    (60424, 1134, 810, 2095, 255, 48, 100), -- sheet of bast parchment
    (60424, 1155, 436, 645, 165, 33, 165), -- handful of iron sand
    (60424, 657, 4690, 21000, 165, 33, 65), -- lump of tama-hagane
    (60424, 1472, 369, 369, 255, 48, 100), -- gardenia seed
    (60424, 1554, 431, 512, 255, 48, 100), -- onz of turmeric
    (60424, 1555, 1061, 1259, 255, 48, 100), -- onz of coriander
    (60424, 1590, 536, 700, 255, 48, 100), -- sprig of holy basil
    (60424, 1475, 579, 1188, 255, 48, 100), -- onz of curry powder
    (60424, 5164, 1945, 2854, 255, 48, 100), -- jar of ground wasabi
    (60424, 1652, 233, 250, 255, 48, 100), -- bottle of rice vinegar
    (60424, 5235, 1284, 1350, 255, 48, 100), -- head of napa
    (60424, 1415, 55147, 55147, 165, 33, 65), -- pot of urushi
    -- Tsutsuroon (Nashmau)
    (60431, 16896, 517, 592, 20, 10, 20), -- kunai
    (60431, 16917, 4226, 4226, 20, 7, 15), -- suzume
    (60431, 16900, 1404, 1608, 20, 7, 15), -- wakizashi
    (60431, 16919, 2728, 17167, 20, 7, 15), -- shinobi-gatana
    (60431, 16960, 3121, 3575, 20, 5, 10), -- uchigatana
    (60431, 16975, 11583, 13266, 20, 5, 10), -- kanesada
    (60431, 16966, 1836, 2103, 20, 10, 20), -- tachi
    (60431, 16982, 4752, 38670, 20, 0, 10), -- nodachi
    (60431, 17301, 43, 150, 2970, 594, 1188), -- shuriken
    (60431, 17302, 347, 347, 2970, 594, 1188), -- juji shuriken
    (60431, 17340, 58, 174, 8910, 0, 3564), -- bullet
    (60431, 12456, 552, 858, 20, 10, 20), -- hachimaki
    (60431, 12457, 3272, 5079, 20, 7, 15), -- cotton hachimaki
    (60431, 12458, 8972, 13927, 20, 5, 10), -- soil hachimaki
    (60431, 12584, 833, 1294, 20, 10, 20), -- kenpogi
    (60431, 12585, 4931, 7654, 20, 7, 15), -- cotton dogi
    (60431, 12586, 13266, 14850, 20, 5, 10), -- soil gi
    (60431, 12712, 458, 712, 20, 10, 20), -- tekko
    (60431, 12713, 2528, 3924, 20, 7, 15), -- cotton tekko
    (60431, 12714, 2713, 8316, 20, 5, 10), -- soil tekko
    (60431, 12840, 666, 1034, 20, 10, 20), -- sitabaki
    (60431, 12841, 3951, 8847, 20, 7, 15), -- cotton sitabaki
    (60431, 12842, 2713, 8316, 20, 5, 10), -- soil sitabaki
    (60431, 12968, 424, 660, 20, 10, 20), -- kyahan
    (60431, 12969, 2528, 11925, 20, 7, 15), -- cotton kyahan
    (60431, 12970, 11070, 12393, 20, 5, 10), -- soil kyahan
    (60431, 704, 108, 149, 48, 24, 24), -- bamboo stick
    (60431, 915, 6048, 16120, 165, 33, 165), -- jar of toad oil
    (60431, 1134, 993, 2095, 255, 48, 100), -- sheet of bast parchment
    (60431, 1155, 436, 645, 165, 33, 165), -- handful of iron sand
    (60431, 657, 4690, 21000, 165, 33, 65), -- lump of tama-hagane
    (60431, 1415, 55147, 55147, 165, 33, 65), -- pot of urushi
    (60431, 1472, 369, 369, 255, 48, 100), -- gardenia seed
    (60431, 1554, 431, 512, 255, 48, 100), -- onz of turmeric
    (60431, 1555, 1061, 1259, 255, 48, 100), -- onz of coriander
    (60431, 1590, 536, 700, 255, 48, 100), -- sprig of holy basil
    (60431, 1475, 579, 1188, 255, 48, 100), -- onz of curry powder
    (60431, 5164, 1945, 2854, 255, 48, 100), -- jar of ground wasabi
    (60431, 1652, 233, 250, 255, 48, 100), -- bottle of rice vinegar
    (60431, 5235, 1284, 1350, 255, 48, 100), -- head of napa
    (60431, 17304, 57960, 57960, 2970, 594, 1188), -- fuma shuriken
    (60431, 17285, 101745, 101745, 2970, 594, 1188), -- moonring blade
    (60431, 17322, 116, 187, 2970, 594, 1188), -- fire arrow
    (60431, 1161, 94, 174, 2970, 594, 1188), -- uchitake
    (60431, 1164, 65, 120, 2970, 594, 1188), -- tsurara
    (60431, 1167, 94, 174, 2970, 594, 1188), -- kawahori-ogi
    (60431, 1170, 94, 174, 2970, 594, 1188), -- makibishi
    (60431, 1173, 94, 174, 2970, 594, 1188), -- hiraishin
    (60431, 1176, 94, 174, 2970, 594, 1188), -- mizu-deppo

    -- Chip Vendor
    (60418, 474, 21000, 21000, 255, 255, 255), -- red chip
    (60418, 475, 21000, 21000, 255, 255, 255), -- blue chip
    (60418, 476, 21000, 21000, 255, 255, 255), -- yellow chip
    (60418, 477, 21000, 21000, 255, 255, 255), -- green chip
    (60418, 478, 21000, 21000, 255, 255, 255), -- clear chip
    (60418, 479, 21000, 21000, 255, 255, 255), -- purple chip
    (60418, 480, 21000, 21000, 255, 255, 255), -- white chip
    (60418, 481, 21000, 21000, 255, 255, 255); -- black chip

    UNLOCK TABLES;