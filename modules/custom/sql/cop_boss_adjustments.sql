UPDATE mob_groups SET
    minLevel = minLevel - 2,
    maxLevel = maxLevel - 2
    where name in
        (
            -- Bearclaw Binnacle
            'Snoll_Tzar',

            -- Boneyard Gully
            'Shikaree_X',
            'Shikaree_Y',
            'Shikaree_Z',

            -- Mine Shaft #2716
            'Bugbby',

            -- Monarch Linn
            'Ouryu',

            -- Phomuina Aqueducts
            'Minotaur',

            -- Promyvion-Vahzl
            'Ponderer',
            'Propagator',
            'Solicitor',

            -- Sacrarium

            -- Sealion's Den
            'Omega',
            'Tenzen',
            'Ultima',

            -- Spire of Dem
            'Progenerator',

            -- Spire of Holla
            'Wreaker',

            -- Spire of Mea
            'Delver',

            -- Spire of Vahzl
            'Agonizer',
            'Cumulator',
            'Procreator'

        )
		AND minLevel > 0