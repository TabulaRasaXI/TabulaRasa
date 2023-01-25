DELETE FROM `mob_skill_lists` where skill_list_id = 1066;
INSERT INTO `mob_skill_lists` (`skill_list_name`,`skill_list_id`,`mob_skill_id`) VALUES
    ('TRUST_Rahal',1066,34),
    ('TRUST_Rahal',1066,41),
    ('TRUST_Rahal',1066,42);

DELETE FROM `mob_spell_lists` where spell_list_id = 310 and spell_id in (129,134);




