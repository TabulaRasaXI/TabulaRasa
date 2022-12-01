UPDATE `mob_groups`
SET spawntype = 128
WHERE name in
(
    'Flume_Toad',
    'Poroggo_Excavator'
);

UPDATE `mob_groups`
SET respawntime = 960
WHERE name in
(
    'Specter_blm',
    'Specter_rng',
    'Specter_thf',
    'Specter_war'
);

UPDATE `mob_groups`
SET minLevel = 59, maxLevel = 62, content_tag = NULL
WHERE name = 'Kaboom';

UPDATE `mob_groups`
SET minLevel = 51, maxLevel = 55, content_tag = NULL
WHERE name IN
(
    'Fortalice_Bats',
    'Donjon_Bat'
);

UPDATE `mob_groups`
SET minLevel = 56, maxLevel = 58, content_tag = NULL
WHERE name = 'Warden_Beetle';