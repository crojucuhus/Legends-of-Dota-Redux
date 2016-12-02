GameRules.damage_system = LoadKeyValues('scripts/kv/damage_system.kv')
DeepPrintTable(GameRules.damage_system)

function damageSystemDamageFilter(filterTable)
  local victim_index = filterTable['entindex_victim_const']
  local attacker_index = filterTable['entindex_attacker_const']
  local ability_index = filterTable['entindex_inflictor_const']
  
  if not victim_index or not attacker_index then
      return filterTable
  end
  
  local parent = EntIndexToHScript( victim_index )
  local caster = EntIndexToHScript( attacker_index )

  -- Apply only on hero
  if not parent:IsHero() then
    return filterTable
  end

  local hero_stats = GameRules.damage_system.heroes[parent:GetName()]
  if hero_stats == nil then
    return filterTable
  end
  
  -- Recalculate phys damage
  
  if not ability_index then
    return filterTable
  end
  
  local ability = EntIndexToHScript(ability_index)
  local ability_stat = GameRules.damage_system.abilities[ability:GetAbilityName()]
  
  if ability_stat == nil then
    return filterTable
  end  
  
  -- Recalculate spell damage
  local mult = 1
  for k,v in pairs(ability_stat) do
    mult = mult + (hero_stats[k] or 0)
  end
  
  if mult < 0 then
    parent:Heal(filterTable['damage'] * math.abs(mult), parent)
    filterTable['damage'] = 0
  else
    filterTable['damage'] = filterTable['damage'] * mult
  end

  --print(ability:GetAbilityName(), ': ', mult)
  return filterTable
end


