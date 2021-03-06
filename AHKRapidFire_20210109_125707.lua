-- For menu & data
AHKRapidFire = {}
AHKRapidFire.name = "AHKRapidFire"

local ptk = LibPixelControl
local ms_time = GetGameTimeMilliseconds()
local function dmsg(txt)
	d((GetGameTimeMilliseconds() - ms_time) .. ") " .. txt)
	ms_time = GetGameTimeMilliseconds()
end

function AHKRapidFire:PixelDemo()
	--d("ptk.VK_A:"..tostring(ptk.VK_A))
	t=1000
	zo_callLater(function() ptk.SetIndOn(ptk.VK_A) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VK_A) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VK_D) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VK_D) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VK_W) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VK_W) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VK_S) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VK_S) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VM_MOVE_LEFT) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VM_MOVE_LEFT) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VM_MOVE_RIGHT) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VM_MOVE_RIGHT) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VM_MOVE_UP) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VM_MOVE_UP) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VM_MOVE_DOWN) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VM_MOVE_DOWN) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VM_BTN_RIGHT) end, t) t=t+500
	zo_callLater(function() ptk.SetIndOff(ptk.VM_BTN_RIGHT) end, t)
	t=t+500
	zo_callLater(function() ptk.SetIndOn(ptk.VM_BTN_LEFT) end, t) t=t+50
	zo_callLater(function() ptk.SetIndOff(ptk.VM_BTN_LEFT) end, t)
end

local keepfiring = false
local cntUsed = 0
local cntCooldowns = 0
local repeatkey = ptk.VK_1
local function checkFire()
	if keepfiring then -- and cntUsed >= 1 and cntCooldowns >= 2 then
		dmsg("Pressing "..repeatkey) ptk.SetIndOnFor(repeatkey, 50)
	end
end

function AHKRapidFire:OpenFire()
	dmsg("OpenFire ------------------------------")
	keepfiring = true
	cntUsed = 0
	cntCooldowns = 0
	--zo_callLater(function() dmsg("Mouse Click") ptk.SetIndOnFor(ptk.VM_BTN_LEFT, 50) end, 0)
	--zo_callLater(function() dmsg("Pressing 1") ptk.SetIndOnFor(ptk.VK_1, 50) end, 50)
	---- needs 500 before can press 2
	--t=0
	--zo_callLater(function() dmsg("Mouse Click") ptk.SetIndOnFor(ptk.VM_BTN_LEFT, 50) end, t)
	--t=t+200
	--zo_callLater(function() dmsg("Pressing `") ptk.SetIndOnFor(ptk.VK_BACK_QUOTE, 50) end, t)
	--t=t+200
	--zo_callLater(function() dmsg("Mouse Click") ptk.SetIndOnFor(ptk.VM_BTN_LEFT, 50) end, t)
	--t=t+200
	--zo_callLater(function() dmsg("Pressing `") ptk.SetIndOnFor(ptk.VK_BACK_QUOTE, 50) end, t)
	--t=t+200
	--zo_callLater(function() dmsg("Pressing 2") ptk.SetIndOnFor(ptk.VK_2, 50) end, t)
	----zo_callLater(function() dmsg("Pressing 1") ptk.SetIndOnFor(ptk.VK_1, 50) end, 200)
	dmsg("Pressing "..repeatkey) ptk.SetIndOnFor(repeatkey, 50)
	--zo_callLater(function() dmsg("Pressing `") ptk.SetIndOnFor(ptk.VK_BACK_QUOTE, 50) end, 100)
end
function AHKRapidFire:CeaseFire()
	keepfiring = false
	d("CeaseFire ------------------------------")
	--ptk.SetIndOff(ptk.VK_A)
	--AHKRapidFire:PixelDemo()
	--ptk.SetIndOnFor(ptk.VK_E, 50)
end

-- EVENT_COMBAT_EVENT (number eventCode, number ActionResult result, boolean isError, string abilityName, number abilityGraphic, number ActionSlotType abilityActionSlotType, string sourceName, number CombatUnitType sourceType, string targetName, number CombatUnitType targetType, number hitValue, number CombatMechanicType powerType, number DamageType damageType, boolean log, number sourceUnitId, number targetUnitId, number abilityId, number overflow)
function AHKRapidFire.OnCombatEvent(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)
	--[39089] = {62775, 2240, nil, nil}, --Elemental Susceptibility --> Major Breach
	-- 61743 ??
	--d(tostring(GetAbilityDescription(abilityId)))
	if isError then
	d("OnCombatEvent: "..tostring(eventCode)
		.." result:"..tostring(result)
		.." isError:"..tostring(isError)
		.." abilityName:"..tostring(abilityName)
		.." abilityActionSlotType:"..tostring(abilityActionSlotType)
		.." sourceName:"..tostring(sourceName)
		.." sourceType:"..tostring(sourceType)
		.." targetName:"..tostring(targetName)
		.." targetType:"..tostring(targetType)
		.." hitValue:"..tostring(hitValue)
		.." powerType:"..tostring(powerType)
		.." damageType:"..tostring(damageType)
		.." sourceUnitId:"..tostring(sourceUnitId)
		.." targetUnitId:"..tostring(targetUnitId)
		.." abilityId:"..tostring(abilityId)
		.." overflow:"..tostring(overflow))
	end
end

-- EVENT_EFFECT_CHANGED (number eventCode, MsgEffectResult changeType, number effectSlot, string effectName, string unitTag, number beginTime, number endTime, number stackCount, string iconName, string buffType, BuffEffectType effectType, AbilityType abilityType, StatusEffectType statusEffectType, string unitName, number unitId, number abilityId, CombatUnitType sourceType)
function AHKRapidFire.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, sourceType)
	dmsg("OnEffectChanged: "..tostring(eventCode)
		.." changeType:"..tostring(changeType)
		.." effectSlot:"..tostring(effectSlot)
		.." effectName:"..tostring(effectName)
		.." unitTag:"..tostring(unitTag)
		.." beginTime:"..tostring(beginTime)
		.." endTime:"..tostring(endTime)
		.." stackCount:"..tostring(stackCount)
		.." iconName:"..tostring(iconName)
		.." buffType:"..tostring(buffType)
		.." effectType:"..tostring(effectType)
		.." abilityType:"..tostring(abilityType)
		.." statusEffectType:"..tostring(statusEffectType)
		.." unitName:"..tostring(unitName)
		.." unitId:"..tostring(unitId)
		.." abilityId:"..tostring(abilityId)
		.." sourceType:"..tostring(sourceType))
end

AHKRapidFire.availableActions = {}
function AHKRapidFire.PopulateActions()
	local retval = {}
	-- 1 Light Attack
	-- 2 Heavy Attack
	-- 3-8 Action Slots: 1-5 then Ultimate
	-- 9-16 Quick Slots: straight down then counter clockwise
	local barNum, isLocked = GetActiveWeaponPairInfo()
	for i=1,16 do
		local slotName = getSlotName(i)
		if slotName ~= nil then
			local action = AHKRapidFire.availableActions[slotName] or {}
			action.name = slotName
			action.idx = i
			action.isPossible = true
			action.priority = 1
			action.barAvailable = {[1] = false, [2] = false}
			action.barAvailable[barNum] = true

			local remain, duration, global, globalSlotType = GetSlotCooldownInfo(i) -- Returns: number remain, number duration, boolean global, number ActionBarSlotType globalSlotType
				--ActionBarSlotType:ACTION_TYPE_ABILITY, ACTION_TYPE_COLLECTIBLE, ACTION_TYPE_EMOTE, ACTION_TYPE_ITEM, ACTION_TYPE_NOTHING, ACTION_TYPE_QUEST_ITEM, ACTION_TYPE_QUICK_CHAT
			action.cooldownRemaining = remain
			action.slotType = globalSlotType
			action.abilityCostAmt, action.abilityCostType = GetSlotAbilityCost(i) -- Returns: number abilityCost, number mechanicType

			if GetUnitPower("Player", action.abilityCostType) < action.abilityCostAmt then action.isPossible = false end
			action.locked = IsSlotLocked(i) -- Returns: boolean locked -- Presumably Grayed out for some reason
			if action.locked then action.isPossible = false end

		end
	end

	--local abilityCost, mechanicType = GetSlotAbilityCost(i) -- Returns: number abilityCost, number mechanicType
	--local locked = IsSlotLocked(i) -- Returns: boolean locked -- Presumably Grayed out for some reason
	----is HasRangeFailure a thing? is it feasible to use SelectSlotItem in combat?
	--local canPayAbilityCost = (GetUnitPower("Player", mechanicType) >= abilityCost) -- mechanicTypes:POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA, POWERTYPE_ULTIMATE
	--SetCurrentQuickslot(number actionSlotIndex)
end
function AHKRapidFire.GetTopAction()
	local tSortActions = {}
	for action in pairs(AHKRapidFire.availableActions) do
		if action.isPossible then
			table.insert(tSortActions, action)
		end
	end
	table.sort(tSortActions, function(a,b) return a.priority > b.priority end)
	return tSortActions[1]
end

function AHKRapidFire.OnSlotAbilityUsed(eventCode, actionSlotIndex) -- EVENT_ACTION_SLOT_ABILITY_USED (number eventCode, number actionSlotIndex)
	dmsg("OnSlotAbilityUsed: "..tostring(eventCode)
		.." actionSlotIndex:"..tostring(actionSlotIndex))
	cntUsed=cntUsed+1
	checkFire()
end

function AHKRapidFire.OnActionUpdateCooldowns(eventCode) -- EVENT_ACTION_UPDATE_COOLDOWNS (number eventCode)
	dmsg("OnActionUpdateCooldowns: "..tostring(eventCode))
	-- 16 is last quick slot
	--for i=1,9 do
	--	local remain, duration, global, globalSlotType = GetSlotCooldownInfo(i) -- Returns: number remain, number duration, boolean global, number ActionBarSlotType globalSlotType
	--	local abilityCost, mechanicType = GetSlotAbilityCost(i) -- Returns: number abilityCost, number mechanicType
	--	d("("..tostring(i)..")"
	--		.." rem:"..tostring(remain)
	--		.." dur:"..tostring(duration)
	--		.." gbl:"..tostring(global)
	--		.." typ:"..tostring(globalSlotType)
	--		.." cost:"..tostring(abilityCost)
	--		.." mtyp:"..tostring(mechanicType)
	--		.." name:"..tostring(GetSlotName(i))
	--		)
	--end
end


function AHKRapidFire.OnSlotStateUpdated(eventCode, actionSlotIndex) -- EVENT_ACTION_SLOT_STATE_UPDATED (number eventCode, number actionSlotIndex)
	if actionSlotIndex == 1 or actionSlotIndex == 4 then
		remain, duration, global, globalSlotType = GetSlotCooldownInfo(actionSlotIndex)
		dmsg("OnSlotStateUpdated: "..tostring(eventCode)
			.." idx:"..tostring(actionSlotIndex)
			--.." rem:"..tostring(remain)
			--.." dur:"..tostring(duration)
			--.." gbl:"..tostring(global)
			--.." typ:"..tostring(globalSlotType)
			.." lock:"..tostring(IsSlotLocked(actionSlotIndex))
			.." name:"..tostring(GetSlotName(actionSlotIndex))
			)
	end
end
function AHKRapidFire.OnWeaponPairLockChanged(eventCode, locked) -- EVENT_WEAPON_PAIR_LOCK_CHANGED (number eventCode, boolean locked)
	dmsg("OnWeaponPairLockChanged: "..tostring(eventCode)
		.." locked:"..tostring(locked))
end
function AHKRapidFire.OnActionSlotUpdated(eventCode, actionSlotIndex) -- EVENT_ACTION_SLOT_UPDATED (number eventCode, number actionSlotIndex)
	if actionSlotIndex == 1 or actionSlotIndex == 4 then
		dmsg("OnActionSlotUpdated: "..tostring(eventCode)
			.." idx:"..tostring(actionSlotIndex)
			.." name:"..tostring(GetSlotName(actionSlotIndex))
			)
	end
end
function AHKRapidFire:Initialize()
	--UseItem(number Bag bagId, number slotIndex)
	--SLASH_COMMANDS["/pd"] = AHKRapidFire.PTK.PixelDemo
	--d("FindmeInitText") -- would not show. wait until player active
	ZO_CreateStringId("SI_BINDING_NAME_RF_FIRING", "Rapid Firing")

	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_ABILITY_USED, AHKRapidFire.OnSlotAbilityUsed)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_UPDATE_COOLDOWNS, AHKRapidFire.OnActionUpdateCooldowns)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_STATE_UPDATED, AHKRapidFire.OnSlotStateUpdated)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_COMBAT_EVENT, AHKRapidFire.OnCombatEvent)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_EFFECT_CHANGED, AHKRapidFire.OnEffectChanged)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_WEAPON_PAIR_LOCK_CHANGED, AHKRapidFire.OnWeaponPairLockChanged) -- EVENT_WEAPON_PAIR_LOCK_CHANGED (number eventCode, boolean locked)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_UPDATED, AHKRapidFire.OnActionSlotUpdated) -- EVENT_ACTION_SLOT_UPDATED (number eventCode, number actionSlotIndex)

	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_GAME_CAMERA_UI_MODE_CHANGED, OnEventUiModeChanged)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_PLAYER_COMBAT_STATE, OnEventCombatStateChanged)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_MOUNTED_STATE_CHANGED, OnEventMountedStateChanged)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_EFFECT_CHANGED, OnEventEffectChanged) -- local function OnEventEffectChanged(e, change, slot, auraName, unitTag, start, finish, stack, icon, buffType, effectType, abilityType, statusType, unitName, unitId, abilityId, sourceType) end
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_POWER_UPDATE, OnEventPowerUpdate)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_GROUP_SUPPORT_RANGE_UPDATE, OnEventGroupSupportRangeUpdate)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_DISPLAY_ACTIVE_COMBAT_TIP, OnEventCombatTipDisplay)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_REMOVE_ACTIVE_COMBAT_TIP, OnEventCombatTipRemove)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_PLAYER_STUNNED_STATE_CHANGED, OnEventStunStateChanged)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_COMBAT_EVENT, OnEventCombatEvent)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_RETICLE_TARGET_CHANGED, OnEventReticleChanged)

--EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_ABILITY_USED)
end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKRapidFire.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    --if addonName == AHKRapidFire.name then AHKRapidFire:Initialize() end
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)