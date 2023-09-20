﻿/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "attack.h"
#include "ai/ai_container.h"
#include "attackround.h"
#include "entities/battleentity.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "status_effect_container.h"
#include "utils/puppetutils.h"

#include <cmath>

/************************************************************************
 *                                                                      *
 *  Constructor.                                                            *
 *                                                                      *
 ************************************************************************/
CAttack::CAttack(CBattleEntity* attacker, CBattleEntity* defender, PHYSICAL_ATTACK_TYPE type, PHYSICAL_ATTACK_DIRECTION direction, CAttackRound* attackRound)
: m_attacker(attacker)
, m_victim(defender)
, m_attackRound(attackRound)
, m_attackType(type)
, m_attackDirection(direction)
{
}

/************************************************************************
 *                                                                      *
 *  Returns the attack direction.                                       *
 *                                                                      *
 ************************************************************************/
PHYSICAL_ATTACK_DIRECTION CAttack::GetAttackDirection()
{
    return m_attackDirection;
}

/************************************************************************
 *                                                                      *
 *  Returns the attack type.                                                *
 *                                                                      *
 ************************************************************************/
PHYSICAL_ATTACK_TYPE CAttack::GetAttackType()
{
    return m_attackType;
}

/************************************************************************
 *                                                                      *
 *  Sets the attack type.                                               *
 *                                                                      *
 ************************************************************************/
void CAttack::SetAttackType(PHYSICAL_ATTACK_TYPE type)
{
    m_attackType = type;
}

/************************************************************************
 *                                                                      *
 *  Returns the isCritical flag.                                            *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsCritical() const
{
    return m_isCritical;
}

/************************************************************************
 *                                                                      *
 *  Sets the critical flag.                                             *
 *                                                                      *
 ************************************************************************/
void CAttack::SetCritical(bool value, uint16 slot, bool isGuarded)
{
    m_isCritical = value;

    if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        m_damageRatio = battleutils::GetRangedDamageRatio(m_attacker, m_victim, m_isCritical, 0);
    }
    else
    {
        float attBonus = 1.f;
        if (m_attackType == PHYSICAL_ATTACK_TYPE::KICK)
        {
            if (CStatusEffect* footworkEffect = m_attacker->StatusEffectContainer->GetStatusEffect(EFFECT_FOOTWORK))
            {
                attBonus = 1.0 + footworkEffect->GetSubPower() / 256.f; // Mod is out of 256
            }
        }

        m_damageRatio = battleutils::GetDamageRatio(m_attacker, m_victim, m_isCritical, attBonus, slot, 0, isGuarded);
    }
}

/************************************************************************
 *                                                                      *
 *  Sets the guarded flag.                                              *
 *                                                                      *
 ************************************************************************/
void CAttack::SetGuarded(bool isGuarded)
{
    m_isGuarded = isGuarded;
}

/************************************************************************
 *                                                                      *
 *  Gets the guarded flag.                                              *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsGuarded()
{
    m_isGuarded = attackutils::IsGuarded(m_attacker, m_victim);
    if (m_isGuarded)
    {
        if (m_damageRatio > 1.0f)
        {
            m_damageRatio -= 1.0f;
        }
        else
        {
            m_damageRatio = 0;
        }
    }
    return m_isGuarded;
}

/************************************************************************
 *                                                                      *
 *  Gets the evaded flag.                                               *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsEvaded() const
{
    return m_isEvaded;
}

/************************************************************************
 *                                                                      *
 *  Sets the evaded flag.                                               *
 *                                                                      *
 ************************************************************************/
void CAttack::SetEvaded(bool value)
{
    m_isEvaded = value;
}

/************************************************************************
 *                                                                      *
 *  Gets the blocked flag.                                              *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsBlocked() const
{
    return m_isBlocked;
}

/************************************************************************
 *                                                                      *
 *  Gets the Parried flag if set, else calculates a new one and returns.*
 *                                                                      *
 ************************************************************************/
bool CAttack::IsParried()
{
    if (m_isParried.has_value())
    {
        return m_isParried.value();
    }

    if (m_attackType != PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        m_isParried.emplace(attackutils::IsParried(m_attacker, m_victim));
    }
    return m_isParried.value_or(false);
}

bool CAttack::IsAnticipated() const
{
    return m_anticipated;
}

/************************************************************************
 *                                                                      *
 *  Returns the isFirstSwing flag.                                      *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsFirstSwing() const
{
    return m_isFirstSwing;
}

/************************************************************************
 *                                                                      *
 *  Sets this swing as the first.                                       *
 *                                                                      *
 ************************************************************************/
void CAttack::SetAsFirstSwing(bool isFirst)
{
    m_isFirstSwing = isFirst;
}

/************************************************************************
 *                                                                      *
 *  Gets the damage ratio.                                              *
 *                                                                      *
 ************************************************************************/
float CAttack::GetDamageRatio() const
{
    return m_damageRatio;
}

/************************************************************************
 *                                                                      *
 *  Sets the attack type.                                               *
 *                                                                      *
 ************************************************************************/
uint8 CAttack::GetWeaponSlot()
{
    if (m_attackRound->IsH2H())
    {
        return SLOT_MAIN;
    }
    if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        return SLOT_AMMO;
    }
    return m_attackDirection == RIGHTATTACK ? SLOT_MAIN : SLOT_SUB;
}

/************************************************************************
 *                                                                      *
 *  Returns the animation ID.                                           *
 *                                                                      *
 ************************************************************************/
uint16 CAttack::GetAnimationID()
{
    AttackAnimation animation;

    // Try normal kick attacks (without footwork)
    if (this->m_attackType == PHYSICAL_ATTACK_TYPE::KICK)
    {
        animation = this->m_attackDirection == RIGHTATTACK ? AttackAnimation::RIGHTKICK : AttackAnimation::LEFTKICK;
    }

    else if (this->m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        animation = AttackAnimation::THROW;
    }

    // Normal attack
    else
    {
        animation = this->m_attackDirection == RIGHTATTACK ? AttackAnimation::RIGHTATTACK : AttackAnimation::LEFTATTACK;
    }

    return (uint16)animation;
}

/************************************************************************
 *                                                                      *
 *  Returns the hitrate for this swing.                                 *
 *                                                                      *
 ************************************************************************/
uint8 CAttack::GetHitRate()
{
    if (m_attackType == PHYSICAL_ATTACK_TYPE::KICK)
    {
        m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 2);
    }
    else if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        m_hitRate = battleutils::GetRangedHitRate(m_attacker, m_victim, false, 100);
    }
    else if (m_attackDirection == RIGHTATTACK)
    {
        if (m_attackType == PHYSICAL_ATTACK_TYPE::ZANSHIN)
        {
            m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 0, (uint8)35);
        }
        else
        {
            m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 0);
        }

        // Deciding this here because SA/TA wears on attack, before the 2nd+ hits go off.
        if (m_hitRate == 100)
        {
            m_attackRound->SetSATA(true);
        }
    }
    else if (m_attackDirection == LEFTATTACK)
    {
        if (m_attackType == PHYSICAL_ATTACK_TYPE::ZANSHIN)
        {
            m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 1, (uint8)35);
        }
        else
        {
            m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 1);
        }
    }
    return m_hitRate;
}

/************************************************************************
 *                                                                      *
 *  Returns the damage for this swing.                                  *
 *                                                                      *
 ************************************************************************/
int32 CAttack::GetDamage() const
{
    return m_damage;
}

/************************************************************************
 *                                                                      *
 *  Sets the damage for this swing.                                     *
 *                                                                      *
 ************************************************************************/
void CAttack::SetDamage(int32 value)
{
    m_damage = value;
}

bool CAttack::CheckAnticipated()
{
    auto value = (ANTICIPATE_RESULT)attackutils::TryAnticipate(m_victim, m_attacker, m_attackType);

    switch (value)
    {
        case ANTICIPATE_RESULT::FAIL:
            return false;
        case ANTICIPATE_RESULT::CRITICALCOUNTER:
            m_isCritical  = true;
            m_isCountered = true;
            return true;
        case ANTICIPATE_RESULT::COUNTER:
            m_isCountered = true;
            return true;
        case ANTICIPATE_RESULT::ANTICIPATE:
            m_anticipated = true;
            return true;
    }

    return false;
}

bool CAttack::IsCountered() const
{
    return m_isCountered;
}

bool CAttack::CheckCounter()
{
    if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        return false;
    }

    if (m_victim->StatusEffectContainer->HasPreventActionEffect(true))
    {
        return false;
    }

    if (!m_victim->PAI->IsEngaged())
    {
        m_isCountered = false;
        return m_isCountered;
    }

    uint8 meritCounter = 0;
    if (m_victim->objtype == TYPE_PC && charutils::hasTrait((CCharEntity*)m_victim, TRAIT_COUNTER))
    {
        if (m_victim->GetMJob() == JOB_MNK || m_victim->GetMJob() == JOB_PUP)
        {
            meritCounter = ((CCharEntity*)m_victim)->PMeritPoints->GetMeritValue(MERIT_COUNTER_RATE, (CCharEntity*)m_victim);
        }
    }

    // counter check (rate AND your hit rate makes it land, else its just a regular hit)
    // having seigan active gives chance to counter at 25% of the zanshin proc rate
    uint16 seiganChance = 0;
    if (m_victim->objtype == TYPE_PC && m_victim->StatusEffectContainer->HasStatusEffect(EFFECT_SEIGAN))
    {
        seiganChance = m_victim->getMod(Mod::ZANSHIN) + ((CCharEntity*)m_victim)->PMeritPoints->GetMeritValue(MERIT_ZASHIN_ATTACK_RATE, (CCharEntity*)m_victim);
        seiganChance = std::clamp<uint16>(seiganChance, 0, 100);
        seiganChance /= 4;
    }
    // clang-format off
    if (((xirand::GetRandomNumber(100) < std::clamp<uint16>(m_victim->getMod(Mod::COUNTER) + meritCounter, 0, 100)) ||
        (xirand::GetRandomNumber(100) < std::clamp<uint16>(seiganChance, 0, 80))) &&
            (facing(m_victim->loc.p, m_attacker->loc.p, 64) && (xirand::GetRandomNumber(100) < battleutils::GetHitRate(m_victim, m_attacker))))
    // clang-format on
    {
        m_isCountered = true;
        m_isCritical  = (xirand::GetRandomNumber(100) < battleutils::GetCritHitRate(m_victim, m_attacker, false));
    }
    else if (m_victim->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_COUNTER))
    { // Perfect Counter only counters hits that normal counter misses, always critical, can counter 1-3 times before wearing
        m_isCountered = true;
        m_isCritical  = true;

        // TODO: Implement VIT-based formula for Perfect Counter wearing off, and add JP bonus
        m_victim->StatusEffectContainer->DelStatusEffect(EFFECT_PERFECT_COUNTER);
    }
    return m_isCountered;
}

bool CAttack::IsCovered() const
{
    return m_isCovered;
}

bool CAttack::CheckCover()
{
    CBattleEntity* PCoverAbilityUser = m_attackRound->GetCoverAbilityUserEntity();
    if (PCoverAbilityUser != nullptr && PCoverAbilityUser->isAlive())
    {
        m_isCovered = true;
        m_victim    = PCoverAbilityUser;
    }
    else
    {
        m_isCovered = false;
    }

    return m_isCovered;
}

/************************************************************************
 *                                                                      *
 *  Processes the damage for this swing.                                    *
 *                                                                      *
 ************************************************************************/
void CAttack::ProcessDamage(bool isCritical, bool isGuarded, bool isKick)
{
    // Sneak attack.
    if (m_attacker->GetMJob() == JOB_THF && m_isFirstSwing && m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK_ATTACK) &&
        (behind(m_attacker->loc.p, m_victim->loc.p, 64) || m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE) ||
         m_victim->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBT)))
    {
        m_trickAttackDamage += m_attacker->DEX() * (1 + m_attacker->getMod(Mod::SNEAK_ATK_DEX) / 100);
    }

    // Trick attack.
    if (m_attacker->GetMJob() == JOB_THF && m_isFirstSwing && m_attackRound->GetTAEntity() != nullptr)
    {
        m_trickAttackDamage += m_attacker->AGI() * (1 + m_attacker->getMod(Mod::TRICK_ATK_AGI) / 100);
    }

    SLOTTYPE slot = (SLOTTYPE)GetWeaponSlot();

    if (m_attackRound->IsH2H())
    {
        m_baseDamage       = 0;
        m_naturalH2hDamage = (int32)(m_attacker->GetSkill(SKILL_HAND_TO_HAND) * 0.11f) + 3;
        m_baseDamage       = isKick ? m_attacker->getMod(Mod::KICK_DMG) : m_attacker->GetMainWeaponDmg();

        if (m_attacker->objtype == TYPE_MOB)
        {
            // mobdamage = (floor((level + 2 + fstr) * .9) / 2) * pdif
            int8 mobH2HDamage = m_attacker->GetMLevel() + 2;
            m_damage          = (uint32)((std::floor((mobH2HDamage + battleutils::GetFSTR(m_attacker, m_victim, slot)) * 0.9f) / 2) * battleutils::GetDamageRatio(m_attacker, m_attacker->GetBattleTarget(), isCritical, 1, slot, 0, isGuarded));
        }
        else
        {
            m_damage = (uint32)(((m_baseDamage + m_naturalH2hDamage + m_trickAttackDamage + battleutils::GetFSTR(m_attacker, m_victim, slot)) * battleutils::GetDamageRatio(m_attacker, m_attacker->GetBattleTarget(), isCritical, 1, slot, 0, isGuarded)));
        }
    }
    else if (slot == SLOT_MAIN)
    {
        m_damage = (uint32)(((m_attacker->GetMainWeaponDmg() + m_trickAttackDamage + battleutils::GetFSTR(m_attacker, m_victim, slot)) * battleutils::GetDamageRatio(m_attacker, m_attacker->GetBattleTarget(), isCritical, 1, slot, 0, isGuarded)));
    }
    else if (slot == SLOT_SUB)
    {
        m_damage = (uint32)(((m_attacker->GetSubWeaponDmg() + m_trickAttackDamage + battleutils::GetFSTR(m_attacker, m_victim, slot)) * battleutils::GetDamageRatio(m_attacker, m_attacker->GetBattleTarget(), isCritical, 1, slot, 0, isGuarded)));
    }
    else if (slot == SLOT_AMMO || slot == SLOT_RANGED)
    {
        m_damage = (uint32)((m_attacker->GetRangedWeaponDmg() + battleutils::GetFSTR(m_attacker, m_victim, slot)) * battleutils::GetRangedDamageRatio(m_attacker, m_attacker->GetBattleTarget(), isCritical, 0));
    }

    // Apply "Double Attack" damage and "Triple Attack" damage mods
    if (m_attackType == PHYSICAL_ATTACK_TYPE::DOUBLE && m_attacker->objtype == TYPE_PC)
    {
        m_damage = (int32)(m_damage * ((100.0f + m_attacker->getMod(Mod::DOUBLE_ATTACK_DMG)) / 100.0f));
    }
    else if (m_attackType == PHYSICAL_ATTACK_TYPE::TRIPLE && m_attacker->objtype == TYPE_PC)
    {
        m_damage = (int32)(m_damage * ((100.0f + m_attacker->getMod(Mod::TRIPLE_ATTACK_DMG)) / 100.0f));
    }

    // Soul eater.
    if (m_attacker->objtype == TYPE_PC)
    {
        m_damage = battleutils::doSoulEaterEffect((CCharEntity*)m_attacker, m_damage);
    }

    // Consume mana
    if (m_attacker->objtype == TYPE_PC)
    {
        m_damage = battleutils::doConsumeManaEffect((CCharEntity*)m_attacker, m_damage);
    }

    // Set attack type to Samba if the attack type is normal.  Don't overwrite other types.  Used for Samba double damage.
    if (m_attackType == PHYSICAL_ATTACK_TYPE::NORMAL && (m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_SAMBA) ||
                                                         m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_SAMBA) || m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_SAMBA)))
    {
        SetAttackType(PHYSICAL_ATTACK_TYPE::SAMBA);
    }

    if (m_attacker->objtype == TYPE_PET && m_attacker->GetBattleTarget() != nullptr && m_attacker->GetBattleTarget()->getMod(Mod::PET_DMG_TAKEN_PHYSICAL) != 0)
    {
        m_damage *= m_attacker->GetBattleTarget()->getMod(Mod::PET_DMG_TAKEN_PHYSICAL) / 100;
    }

    // Get damage multipliers.
    m_damage =
        attackutils::CheckForDamageMultiplier((CCharEntity*)m_attacker, dynamic_cast<CItemWeapon*>(m_attacker->m_Weapons[slot]), m_damage, m_attackType, slot);

    // Apply Sneak Attack Augment Mod
    if (m_attacker->getMod(Mod::AUGMENTS_SA) > 0 && m_trickAttackDamage > 0 && m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK_ATTACK))
    {
        m_damage += (int32)(m_damage * ((100 + (m_attacker->getMod(Mod::AUGMENTS_SA))) / 100.0f));
    }

    // Apply Trick Attack Augment Mod
    if (m_attacker->getMod(Mod::AUGMENTS_TA) > 0 && m_trickAttackDamage > 0 && m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK))
    {
        m_damage += (int32)(m_damage * ((100 + (m_attacker->getMod(Mod::AUGMENTS_TA))) / 100.0f));
    }

    // Try skill up.
    if (m_damage > 0)
    {
        if (m_attacker->objtype == TYPE_PC)
        {
            if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
            {
                charutils::TrySkillUP((CCharEntity*)m_attacker, SKILLTYPE::SKILL_THROWING, m_victim->GetMLevel());
            }
            else if (auto* weapon = dynamic_cast<CItemWeapon*>(m_attacker->m_Weapons[slot]))
            {
                charutils::TrySkillUP((CCharEntity*)m_attacker, (SKILLTYPE)weapon->getSkillType(), m_victim->GetMLevel());
            }
        }
        else if (m_attacker->objtype == TYPE_PET && m_attacker->PMaster && m_attacker->PMaster->objtype == TYPE_PC &&
                 static_cast<CPetEntity*>(m_attacker)->getPetType() == PET_TYPE::AUTOMATON)
        {
            puppetutils::TrySkillUP((CAutomatonEntity*)m_attacker, SKILL_AUTOMATON_MELEE, m_victim->GetMLevel());
        }
    }
    m_isBlocked = attackutils::IsBlocked(m_attacker, m_victim);

    // Apply Restraint Weaponskill Damage Modifier
    // Effect power tracks the total bonus
    // Effect sub power tracks remainder left over from whole percentage flooring
    if (m_isFirstSwing && m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_RESTRAINT))
    {
        CStatusEffect* effect = m_attacker->StatusEffectContainer->GetStatusEffect(EFFECT_RESTRAINT);

        if (effect->GetPower() < 30)
        {
            uint8 jpBonus = 0;

            if (m_attacker->objtype == TYPE_PC)
            {
                jpBonus = static_cast<CCharEntity*>(m_attacker)->PJobPoints->GetJobPointValue(JP_RESTRAINT_EFFECT) * 2;
            }

            // Convert weapon delay and divide
            // Pull remainder of previous hit's value from Effect sub Power
            float boostPerRound = ((m_attacker->GetWeaponDelay(false) / 1000.0f) * 60.0f) / 385.0f;
            float remainder     = effect->GetSubPower() / 100.0f;

            // Calculate bonuses from Enhances Restraint, Job Point upgrades, and remainder from previous hit
            boostPerRound = (boostPerRound * (1 + m_attacker->getMod(Mod::ENHANCES_RESTRAINT) / 100.0f) * (1 + jpBonus / 100.0f)) + remainder;

            // Calculate new remainder and multiply by 100 so significant digits aren't lost
            // Floor Boost per Round
            remainder     = (1 - (std::ceil(boostPerRound) - boostPerRound)) * 100;
            boostPerRound = std::floor(boostPerRound);

            // Cap total power to +30% WSD
            if (effect->GetPower() + boostPerRound > 30)
            {
                boostPerRound = 30 - effect->GetPower();
            }

            effect->SetPower(effect->GetPower() + boostPerRound);
            effect->SetSubPower(remainder);
            m_attacker->addModifier(Mod::ALL_WSDMG_FIRST_HIT, boostPerRound);
        }
    }
}
