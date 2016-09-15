--------------------------------------------------------------------------------------------------------
--
--		Hero: Legion Commander
--		Perk: When this hero casts Duel, it will gain spell immunity for the duration of the duel.
--
--------------------------------------------------------------------------------------------------------
LinkLuaModifier( "modifier_npc_dota_hero_legion_commander_perk", "scripts/vscripts/../abilities/hero_perks/npc_dota_hero_legion_commander_perk.lua" ,LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------------------------------
if npc_dota_hero_legion_commander_perk == nil then npc_dota_hero_legion_commander_perk = class({}) end
--------------------------------------------------------------------------------------------------------
--		Modifier: modifier_npc_dota_hero_legion_commander_perk				
--------------------------------------------------------------------------------------------------------
if modifier_npc_dota_hero_legion_commander_perk == nil then modifier_npc_dota_hero_legion_commander_perk = class({}) end
--------------------------------------------------------------------------------------------------------
function modifier_npc_dota_hero_legion_commander_perk:IsPassive()
	return true
end
--------------------------------------------------------------------------------------------------------
function modifier_npc_dota_hero_legion_commander_perk:IsHidden()
	return true
end
--------------------------------------------------------------------------------------------------------
-- Add additional functions
--------------------------------------------------------------------------------------------------------
function modifier_npc_dota_hero_legion_commander_perk:DeclareFunctions()
  local funcs = {
    MODIFIER_EVENT_ON_ABILITY_START,
  }
  return funcs
end

function modifier_npc_dota_hero_legion_commander_perk:OnAbilityStart(keys)
  if IsServer() then
    local hero = self:GetCaster()
    local target = keys.target
    local ability = keys.ability


    if ability:GetName() == "legion_commander_duel" then
      hero:AddNewModifier(hero,ability,"modifier_black_king_bar_immune",{duration = ability:GetLevelSpecialValueFor("duration",ability:GetLevel()-1)})
    end
  end
end
