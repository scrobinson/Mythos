function Shield(keys)
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target
	local absorb = ability:GetLevelSpecialValueFor( "damage_absorbed", ability:GetLevel() - 1 )
	
	-- for x,y in pairs(target) do
	-- 	--print(x,"|",y)
	-- end
	caster.shieldHealth = absorb
end

function Absorb(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local absorb = caster.shieldHealth
	local damage = keys.attack_damage
	if absorb - damage > 0 and target.GetHealth() then
		caster.shieldHealth = absorb - damage
	else
		caster:RemoveModifierByName("stone_shield")
	end
end

function Explode(keys)
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target
	local radius = ability:GetLevelSpecialValueFor( "radius", ability:GetLevel() - 1 )
	local damage = ability:GetLevelSpecialValueFor( "damage_dealt", ability:GetLevel() - 1 )
	-- for x,y in pairs(keys) do
	-- 	print(x,"|",y)
	-- end
	local nearbyUnits = FindUnitsInRadius(caster:GetTeam(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_CREEP, 0, 0, false)
	local count = table.getn(nearbyUnits)

	for x=1, count do
		local damageTable = {
				victim = nearbyUnits[x],
				attacker = target,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			 
			ApplyDamage(damageTable)
	end
end