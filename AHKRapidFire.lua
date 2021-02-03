-- For menu & data
AHKRapidFire = {}
AHKRapidFire.name = "AHKRapidFire"
AHKRapidFire.savedVars = {}

local ptk = LibPixelControl
local ms_time = GetGameTimeMilliseconds()
local function dmsg(txt)
	d((GetGameTimeMilliseconds() - ms_time) .. ") " .. txt)
	ms_time = GetGameTimeMilliseconds()
end
local function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			s = s .. '['..k..'] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end
local function LogValues(eventName, args)
	local sep = ";"
	local ms_log_time = GetGameTimeMilliseconds()
	local strArgs = tostring(ms_log_time)..sep..eventName
	for _,value in pairs(args) do strArgs = strArgs..sep..tostring(value) end
	AHKRapidFire.savedVars.log[AHKRapidFire.savedVars.logIdx] = strArgs
	AHKRapidFire.savedVars.logIdx = AHKRapidFire.savedVars.logIdx + 1
end
local keepfiring = false
local function LClick() dmsg("Mouse Click") ptk.SetIndOnFor(ptk.VM_BTN_LEFT, 20) end
local function Press1() dmsg("Press 1") ptk.SetIndOnFor(ptk.VK_1, 20) end
local function BarSwap() dmsg("Press backquote") ptk.SetIndOnFor(ptk.VK_BACK_QUOTE, 20) end


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
	-- 1 Light Attack
	-- 2 Heavy Attack
	-- 3-8 Action Slots: 1-5 then Ultimate
	-- 9-16 Quick Slots: straight down then counter clockwise
	local barNum, isLocked = GetActiveWeaponPairInfo()
	AHKRapidFire.savedVars["availableActions"] = AHKRapidFire.availableActions
	for i=1,16 do
		local slotName = GetSlotName(i)
		if slotName ~= nil then
			local action = AHKRapidFire.availableActions[slotName] or {}
			action.name = slotName
			action.idx = i
			action.isPossible = true
			action.priority = 1
			action.barAvailable = {[1] = false, [2] = false}
			action.barAvailable[barNum] = true
			if i==1 then
				action.delayLightAttackFor = 1000
				action.delayBarActionFor = 100
				action.delayUltimateFor = 100
				action.delayQuickSlotFor = 100
			else
				action.delayLightAttackFor = 100
				action.delayBarActionFor = 1000
				action.delayUltimateFor = 100
				action.delayQuickSlotFor = 100
			end

			local remain, duration, global, globalSlotType = GetSlotCooldownInfo(i) -- Returns: number remain, number duration, boolean global, number ActionBarSlotType globalSlotType
				--ActionBarSlotType:ACTION_TYPE_ABILITY, ACTION_TYPE_COLLECTIBLE, ACTION_TYPE_EMOTE, ACTION_TYPE_ITEM, ACTION_TYPE_NOTHING, ACTION_TYPE_QUEST_ITEM, ACTION_TYPE_QUICK_CHAT
			action.cooldownDuration = duration
			action.abilityCostAmt, action.abilityCostType = GetSlotAbilityCost(i) -- Returns: number abilityCost, number mechanicType

			if GetUnitPower("Player", action.abilityCostType) < action.abilityCostAmt then action.isPossible = false end
			action.locked = IsSlotLocked(i) -- Returns: boolean locked -- Presumably Grayed out for some reason
			if action.locked then action.isPossible = false end

			AHKRapidFire.availableActions[slotName] = action
		end
	end

	--local abilityCost, mechanicType = GetSlotAbilityCost(i) -- Returns: number abilityCost, number mechanicType
	--local locked = IsSlotLocked(i) -- Returns: boolean locked -- Presumably Grayed out for some reason
	----is HasRangeFailure a thing? is it feasible to use SelectSlotItem in combat?
	--local canPayAbilityCost = (GetUnitPower("Player", mechanicType) >= abilityCost) -- mechanicTypes:POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA, POWERTYPE_ULTIMATE
	--SetCurrentQuickslot(number actionSlotIndex)
end
--function AHKRapidFire.GetTopAction()
--	local tSortActions = {}
--	for action in pairs(AHKRapidFire.availableActions) do
--		if action.isPossible then
--			table.insert(tSortActions, action)
--		end
--	end
--	table.sort(tSortActions, function(a,b) return a.priority > b.priority end)
--	return tSortActions[1]
--end
function strInfo(idx)
	--local remain, duration, global, globalSlotType = GetSlotCooldownInfo(1) -- Returns: number remain, number duration, boolean global, number ActionBarSlotType globalSlotType
	local obj = GetSlotType(idx)
	if obj then return tostring(obj)
	else return " "
	end
	return tostring(obj)
end
function AHKRapidFire.GetSlotCSVInfo()
	local remain, duration, global, globalSlotType = GetSlotCooldownInfo(1) -- Returns: number remain, number duration, boolean global, number ActionBarSlotType globalSlotType
	local str = tostring(remain)
	for i=2,16 do
		remain, duration, global, globalSlotType = GetSlotCooldownInfo(i) -- Returns: number remain, number duration, boolean global, number ActionBarSlotType globalSlotType
		str = str..", "..tostring(remain)
	end
	return str
end
function AHKRapidFire.GetSlotCSVLock()
	local str = strInfo(1)
	for i=2,16 do
		str = str..", "..strInfo(i)
	end
	return str
end

local msLightUsed = 0
local isLightReady = true
function AHKRapidFire:OpenFire()
	keepfiring = true
	if false then
		BarSwap()
		EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_WEAPON_PAIR_LOCK_CHANGED, function(_, isLocked)
				if not isLocked then -- At least means that bar can be flipped again
					BarSwap()
				end
			end)
	end

	if false then
		LClick()
		EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_ABILITY_USED, function(_, slotIdx)
				if slotIdx == 1 then
					isLightReady = true
					msLightUsed = GetGameTimeMilliseconds()
					Press1()
				end
			end)
		EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_UPDATE_COOLDOWNS, function()
				if isLightReady and GetGameTimeMilliseconds() >= msLightUsed + 600 then
					isLightReady = false
					LClick()
					d({HasRequirementFailure(1),HasTargetFailure(1),HasWeaponSlotFailure(1),IsSlotLocked(1)})

				end
			end)

	end

	if false then
		EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_ABILITY_USED, function(_, slotIdx)
				dmsg("EVENT_ACTION_SLOT_ABILITY_USED "..tostring(slotIdx))
			end)
		--500 too short
		--600 too short
		--650 a little too short
		--680 a little too short
		--690 skips every 10th ish
		--700 works. 7600dps
		--1000 works. 5000dps
		EVENT_MANAGER:RegisterForUpdate("presslots", 700, LClick)
		LClick()
	end

	if true then
		EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_ABILITY_USED, function(_, slotIdx)
				dmsg("EVENT_ACTION_SLOT_ABILITY_USED "..tostring(slotIdx))
			end)
		EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_UPDATE_COOLDOWNS, function()
				dmsg("EVENT_ACTION_UPDATE_COOLDOWNS "..AHKRapidFire.GetSlotCSVInfo())
			end)

		--1000 works
		EVENT_MANAGER:RegisterForUpdate("presslots", 900, function()
				zo_callLater(LClick, 0)
				zo_callLater(Press1, 50)
			end)
		zo_callLater(LClick, 0)
		zo_callLater(Press1, 50)
	end


	--zo_callLater(function()
	--		BarSwap()
	--	end, 500)
	--EVENT_MANAGER:RegisterForUpdate("presslots", 1000, function()
	--		LClick()
	--	end)

end
function AHKRapidFire:CeaseFire()
	keepfiring = false
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_WEAPON_PAIR_LOCK_CHANGED)
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_ABILITY_USED)
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_ACTION_UPDATE_COOLDOWNS)
	EVENT_MANAGER:UnregisterForUpdate("presslots")
	d("CeaseFire ------------------------------")
end
function AHKRapidFire:OpenFireOld()
	AHKRapidFire.PopulateActions()
	keepfiring = true
	dmsg("OpenFire ------------------------------")
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_ABILITY_USED, AHKRapidFire.OnSlotAbilityUsed) -- EVENT_ACTION_SLOT_ABILITY_USED (number eventCode, number actionSlotIndex)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_UPDATE_COOLDOWNS, AHKRapidFire.OnActionUpdateCooldowns) -- EVENT_ACTION_UPDATE_COOLDOWNS (number eventCode)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_STATE_UPDATED, AHKRapidFire.OnSlotStateUpdated) -- EVENT_ACTION_SLOT_STATE_UPDATED (number eventCode, number actionSlotIndex)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_COMBAT_EVENT, AHKRapidFire.OnCombatEvent) -- EVENT_COMBAT_EVENT (number eventCode, number ActionResult result, boolean isError, string abilityName, number abilityGraphic, number ActionSlotType abilityActionSlotType, string sourceName, number CombatUnitType sourceType, string targetName, number CombatUnitType targetType, number hitValue, number CombatMechanicType powerType, number DamageType damageType, boolean log, number sourceUnitId, number targetUnitId, number abilityId, number overflow)
	--EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_EFFECT_CHANGED, AHKRapidFire.OnEffectChanged) -- EVENT_EFFECT_CHANGED (number eventCode, MsgEffectResult changeType, number effectSlot, string effectName, string unitTag, number beginTime, number endTime, number stackCount, string iconName, string buffType, BuffEffectType effectType, AbilityType abilityType, StatusEffectType statusEffectType, string unitName, number unitId, number abilityId, CombatUnitType sourceType)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_WEAPON_PAIR_LOCK_CHANGED, AHKRapidFire.OnWeaponPairLockChanged) -- EVENT_WEAPON_PAIR_LOCK_CHANGED (number eventCode, boolean locked)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_UPDATED, AHKRapidFire.OnActionSlotUpdated) -- EVENT_ACTION_SLOT_UPDATED (number eventCode, number actionSlotIndex)
	--zo_callLater(function() dmsg("Mouse Click") ptk.SetIndOnFor(ptk.VM_BTN_LEFT, 30) end, 0)
	--dmsg("Press 1") ptk.SetIndOnFor(ptk.VK_1, 30)
	--zo_callLater(function() dmsg("Mouse Click") ptk.SetIndOnFor(ptk.VM_BTN_LEFT, 30) end, 400)
	
	dmsg("Mouse Click") d(AHKRapidFire.GetSlotCSVLock()) ptk.SetIndOnFor(ptk.VM_BTN_LEFT, 30)
	zo_callLater(function() dmsg("Press 1") d(AHKRapidFire.GetSlotCSVLock()) ptk.SetIndOnFor(ptk.VK_1, 30) end, 400)
end
function AHKRapidFire:CeaseFireOld()
	keepfiring = false
	d("CeaseFire ------------------------------")
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_ABILITY_USED)
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_ACTION_UPDATE_COOLDOWNS)
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_STATE_UPDATED)
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_EFFECT_CHANGED)
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_WEAPON_PAIR_LOCK_CHANGED)
	EVENT_MANAGER:UnregisterForEvent(AHKRapidFire.name, EVENT_ACTION_SLOT_UPDATED)
end
function AHKRapidFire.GetTopAction()
	local tSortActions = {}
	for action in pairs(AHKRapidFire.availableActions) do
		action.isPossible = true
		if GetUnitPower("Player", action.abilityCostType) < action.abilityCostAmt then action.isPossible = false end
		action.locked = IsSlotLocked(i) -- Returns: boolean locked -- Presumably Grayed out for some reason
		if action.locked then action.isPossible = false end
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
	d(AHKRapidFire.GetSlotCSVLock())
	local slotName = GetSlotName(actionSlotIndex)
	if slotName ~= nil then
		local usedAction = AHKRapidFire.availableActions[slotName]
		if usedAction ~= nil then
			local msNow = GetGameTimeMilliseconds()
			--dmsg(dump(AHKRapidFire.availableActions))
			for action in pairs(AHKRapidFire.availableActions) do
				if action.idx == nil then
					d(dump(action))
					--action.holdUntil = math.max(action.holdUntil, msNow + usedAction.delayLightAttackFor)
				elseif action.idx == 1 then
					action.holdUntil = math.max(action.holdUntil, msNow + usedAction.delayLightAttackFor)
				elseif action.idx >= 3 and action.idx <= 7 then
					action.holdUntil = math.max(action.holdUntil, msNow + usedAction.delayBarActionFor)
				elseif action.idx == 8 then
					action.holdUntil = math.max(action.holdUntil, msNow + usedAction.delayUltimateFor)
				elseif action.idx >= 9 and action.idx <= 16 then
					action.holdUntil = math.max(action.holdUntil, msNow + usedAction.delayQuickSlotFor)
				end
			end
		end
	end
end
function AHKRapidFire.OnActionUpdateCooldowns(eventCode) -- EVENT_ACTION_UPDATE_COOLDOWNS (number eventCode)
	dmsg("OnActionUpdateCooldowns: "..tostring(eventCode))
	d(AHKRapidFire.GetSlotCSVLock())
end
function AHKRapidFire.OnSlotStateUpdated(eventCode, actionSlotIndex) -- EVENT_ACTION_SLOT_STATE_UPDATED (number eventCode, number actionSlotIndex)
	--if actionSlotIndex == 1 or actionSlotIndex == 4 then
		remain, duration, global, globalSlotType = GetSlotCooldownInfo(actionSlotIndex)
		dmsg("UpdState"--"OnSlotStateUpdated: "..tostring(eventCode)
			.." idx:"..tostring(actionSlotIndex)
			.." rem:"..tostring(remain)
			.." dur:"..tostring(duration)
			.." gbl:"..tostring(global)
			.." typ:"..tostring(globalSlotType)
			.." lock:"..tostring(IsSlotLocked(actionSlotIndex))
			.." name:"..tostring(GetSlotName(actionSlotIndex))
			)
	--end
end
function AHKRapidFire.OnWeaponPairLockChanged(eventCode, locked) -- EVENT_WEAPON_PAIR_LOCK_CHANGED (number eventCode, boolean locked)
	dmsg("OnWeaponPairLockChanged: "..tostring(eventCode)
		.." locked:"..tostring(locked))
	d(AHKRapidFire.GetSlotCSVInfo())
end
function AHKRapidFire.OnActionSlotUpdated(eventCode, actionSlotIndex) -- EVENT_ACTION_SLOT_UPDATED (number eventCode, number actionSlotIndex)
	--if actionSlotIndex == 1 or actionSlotIndex == 4 then
		dmsg("OnActionSlotUpdated: "..tostring(eventCode)
			.." idx:"..tostring(actionSlotIndex)
			.." name:"..tostring(GetSlotName(actionSlotIndex))
			)
	--end
end
function AHKRapidFire:Initialize()
	AHKRapidFire.savedVars = ZO_SavedVars:NewAccountWide("AHKRapidFireSavedVariables", 1, nil, {})
	--UseItem(number Bag bagId, number slotIndex)
	--SLASH_COMMANDS["/pd"] = AHKRapidFire.PTK.PixelDemo
	--d("FindmeInitText") -- would not show. wait until player active
	ZO_CreateStringId("SI_BINDING_NAME_RF_FIRING", "Rapid Firing")
	if AHKRapidFire.savedVars.log == nil or AHKRapidFire.savedVars.logIdx == nil or true then
		AHKRapidFire.savedVars.log = {}
		AHKRapidFire.savedVars.logIdx = 1
	end


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

	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name.."LOG", EVENT_ACTION_SLOT_ABILITY_USED, function(...) LogValues("EVENT_ACTION_SLOT_ABILITY_USED", {...}) end)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name.."LOG", EVENT_ACTION_UPDATE_COOLDOWNS, function(...) LogValues("EVENT_ACTION_UPDATE_COOLDOWNS", {...}) end)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name.."LOG", EVENT_ACTION_SLOT_STATE_UPDATED, function(...) LogValues("EVENT_ACTION_SLOT_STATE_UPDATED", {...}) end)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name.."LOG", EVENT_EFFECT_CHANGED, function(...) LogValues("EVENT_EFFECT_CHANGED", {...}) end)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name.."LOG", EVENT_WEAPON_PAIR_LOCK_CHANGED, function(...) LogValues("EVENT_WEAPON_PAIR_LOCK_CHANGED", {...}) end)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name.."LOG", EVENT_ACTION_SLOT_UPDATED, function(...) LogValues("EVENT_ACTION_SLOT_UPDATED", {...}) end)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name.."LOG", EVENT_COMBAT_EVENT, function(...) LogValues("EVENT_COMBAT_EVENT", {...}) end)

	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name.."LOG", EVENT_HOTBAR_SLOT_CHANGE_REQUESTED, function(...) LogValues("EVENT_HOTBAR_SLOT_CHANGE_REQUESTED", {...}) end)


end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKRapidFire.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == AHKRapidFire.name then AHKRapidFire:Initialize() end
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)