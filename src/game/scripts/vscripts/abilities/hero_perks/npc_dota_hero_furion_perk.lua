--------------------------------------------------------------------------------------------------------
--
--		Hero: Nature's Prophet
--		Perk: Reduces the cooldown of all Teleportation abilities by 50%. 
--
--------------------------------------------------------------------------------------------------------
LinkLuaModifier( "modifier_npc_dota_hero_furion_perk", "abilities/hero_perks/npc_dota_hero_furion_perk.lua" ,LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------------------------------
if npc_dota_hero_furion_perk == nil then npc_dota_hero_furion_perk = class({}) end
--------------------------------------------------------------------------------------------------------
--		Modifier: modifier_npc_dota_hero_furion_perk				
--------------------------------------------------------------------------------------------------------
if modifier_npc_dota_hero_furion_perk == nil then modifier_npc_dota_hero_furion_perk = class({}) end
--------------------------------------------------------------------------------------------------------
function modifier_npc_dota_hero_furion_perk:IsPassive()
	return true
end
--------------------------------------------------------------------------------------------------------
function modifier_npc_dota_hero_furion_perk:IsHidden()
	return true
end
--------------------------------------------------------------------------------------------------------
-- Add additional functions
--------------------------------------------------------------------------------------------------------
function modifier_npc_dota_hero_furion_perk:DeclareFunctions()
  local funcs = {
    MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
  }
  return funcs
end

function modifier_npc_dota_hero_furion_perk:OnAbilityFullyCast(keys)
  if IsServer() then
    local hero = self:GetCaster()
    local target = keys.target
    local ability = keys.ability

    if hero == keys.unit and ability and ability:HasAbilityFlag("teleport") then
      ability:EndCooldown()
      ability:StartCooldown(ability:GetCooldown(ability:GetLevel()-1)*0.5)
    end
  end
end
