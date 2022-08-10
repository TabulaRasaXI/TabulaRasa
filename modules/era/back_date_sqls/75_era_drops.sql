-- ---------------------------------------------------------------------------
--  Notes: Changes drop rates or removes drops that are out of Era.
-- ---------------------------------------------------------------------------

UPDATE mob_droplist SET itemRate = 0 WHERE itemId in (4994,	-- Remove Mage's Ballad as a drop, quested only at 75 cap
													  2759, -- Block Of Yagudo Caulk
													  2758, -- Quadav Backscale
													  2757, -- Orcish Armor Plate
													  9082 -- Clump Of Bee Pollen
													  )
