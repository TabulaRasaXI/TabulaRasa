DELETE FROM mob_spawn_points 
WHERE mobname in 
(
    'Flume_Toad',
    'Poroggo_Excavator'
);

UPDATE mobg_groups
SET respawntime = 960
WHERE name in
(
    'Specter_blm',
    'Specter_rng',
    'Specter_thf',
    'Specter_war'
)
