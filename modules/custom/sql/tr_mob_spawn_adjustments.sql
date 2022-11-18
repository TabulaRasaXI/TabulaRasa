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
)
