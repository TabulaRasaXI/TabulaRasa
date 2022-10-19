UPDATE `mob_skills` 
SET primary_sc = 0,
    secondary_sc = 0,
    tertiary_sc = 0
WHERE
    mob_skill_id IN (836,846,855,864,873,876,882,891)
