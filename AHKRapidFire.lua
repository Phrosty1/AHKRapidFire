-- For menu & data
AHKRapidFire = {}
AHKRapidFire.savedVars = {}
AHKRapidFire.globalSavedVars = {}
AHKRapidFire.name = "AHKRapidFire"

local ms_time = GetGameTimeMilliseconds()
local function dmsg(txt)
	d((GetGameTimeMilliseconds() - ms_time) .. ") " .. txt)
	ms_time = GetGameTimeMilliseconds()
end

local ptk = LibPixelControl.new("010203", 0, 7)

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

function AHKRapidFire:OpenFire()
	d("OpenFire")
	ptk.SetIndOn(ptk.VK_A)
end
function AHKRapidFire:CeaseFire()
	d("CeaseFire")
	ptk.SetIndOff(ptk.VK_A)
	AHKRapidFire:PixelDemo()
end

---- EVENT_COMBAT_EVENT (number eventCode, number ActionResult result, boolean isError, string abilityName, number abilityGraphic, number ActionSlotType abilityActionSlotType, string sourceName, number CombatUnitType sourceType, string targetName, number CombatUnitType targetType, number hitValue, number CombatMechanicType powerType, number DamageType damageType, boolean log, number sourceUnitId, number targetUnitId, number abilityId, number overflow)
--function OnCombatEvent(eventCode, abilityId)
--	dmsg("OnCombatEvent: "..tostring(eventCode)
--		.." result:"..tostring(result)
--		.." isError:"..tostring(isError)
--		.." abilityName:"..tostring(abilityName)
--		.." abilityActionSlotType:"..tostring(abilityActionSlotType)
--		.." sourceName:"..tostring(sourceName)
--		.." sourceType:"..tostring(sourceType)
--		.." targetName:"..tostring(targetName)
--		.." targetType:"..tostring(targetType)
--		.." hitValue:"..tostring(hitValue)
--		.." powerType:"..tostring(powerType)
--		.." damageType:"..tostring(damageType)
--		.." sourceUnitId:"..tostring(sourceUnitId)
--		.." targetUnitId:"..tostring(targetUnitId)
--		.." abilityId:"..tostring(abilityId)
--		.." overflow:"..tostring(overflow))
--end

--function AHKRapidFire:PressPickUntilDone()
--	ptk.SetIndOn(ptk.VM_BTN_LEFT)
--	EVENT_MANAGER:RegisterForUpdate("AHKRapidFireLockpicker", 100, CheckLockPickStatus)
--end
--function AHKRapidFire:MoveAndPickNext()
--	dmsg("MoveAndPickNext")
--	if IsChamberSolved(1) ~= true then
--		ptk.SetIndOn(ptk.VM_MOVE_10_LEFT)
--		zo_callLater(function()
--						ptk.SetIndOff(ptk.VM_MOVE_10_LEFT)
--						AHKRapidFire:PressPickUntilDone()
--					end, 80)
--	end
--end
--function AHKRapidFire:EndLockpicking()
--	d("EndLockpicking")
--	EVENT_MANAGER:UnregisterForUpdate("AHKRapidFireLockpicker")
--	ptk.SetIndOff(ptk.VM_BTN_LEFT) -- stop pressing
--end
--function AHKRapidFire:BeginLockpicking()
--	d("BeginLockpicking")
--	ptk.SetIndOn(ptk.VM_MOVE_10_RIGHT)
--	zo_callLater(function()
--						ptk.SetIndOff(ptk.VM_MOVE_10_RIGHT)
--						AHKRapidFire:PressPickUntilDone()
--					end, 500)
--end

function AHKRapidFire:BeginLockpicking()
	d("BeginLockpicking")
	ptk.SetIndOn(ptk.VM_BTN_LEFT)
	--EVENT_MANAGER:RegisterForUpdate("AHKRapidFireLockpicker", 100, CheckLockPickStatus)
end
function AHKRapidFire:EndLockpicking()
	d("EndLockpicking")
	--EVENT_MANAGER:UnregisterForUpdate("AHKRapidFireLockpicker")
	ptk.SetIndOff(ptk.VM_BTN_LEFT) -- stop pressing
	ptk.SetIndOff(ptk.VM_MOVE_10_RIGHT) -- stop pressing
end
local function CheckLockPickStatus()
	dmsg("Stress:"..tostring(GetSettingChamberStress()).." Chambers:"..tostring(IsChamberSolved(1))..":"..tostring(IsChamberSolved(2))..":"..tostring(IsChamberSolved(3))..":"..tostring(IsChamberSolved(4))..":"..tostring(IsChamberSolved(5)))
	--d("Stress:"..tostring(GetSettingChamberStress()).." State:"..tostring(GetChamberState(1))..":"..tostring(GetChamberState(2))..":"..tostring(GetChamberState(3))..":"..tostring(GetChamberState(4))..":"..tostring(GetChamberState(5)))
	state1, prog1 = GetChamberState(1)
	state2, prog2 = GetChamberState(2)
	state3, prog3 = GetChamberState(3)
	state4, prog4 = GetChamberState(4)
	state5, prog5 = GetChamberState(5)
	d("Stress:"..tostring(GetSettingChamberStress()).." State"
		..":"..tostring(state1)..","..tostring(prog1)
		..":"..tostring(state2)..","..tostring(prog2)
		..":"..tostring(state3)..","..tostring(prog3)
		..":"..tostring(state4)..","..tostring(prog4)
		..":"..tostring(state5)..","..tostring(prog5))

	if IsIndOn(ptk.VM_BTN_LEFT) then
		if GetSettingChamberStress() > 0 then
			ptk.SetIndOff(ptk.VM_BTN_LEFT) -- stop pressing
			ptk.SetIndOn(ptk.VM_MOVE_10_RIGHT) -- start moving
			zo_callLater(CheckLockPickStatus, 80)
		elseif (prog1 > 0 or prog2 > 0 or prog3 > 0 or prog4 > 0 or prog5 > 0) then -- keep holding
			zo_callLater(CheckLockPickStatus, 100)
		end
	elseif IsIndOn(ptk.VM_MOVE_10_RIGHT) then
		ptk.SetIndOff(ptk.VM_MOVE_10_RIGHT) -- stop moving
		ptk.SetIndOn(ptk.VM_BTN_LEFT) -- start pressing
		zo_callLater(CheckLockPickStatus, 100)
	end
end


-- local item = PotMaker.Ingredient:new {name = zo_strformat(SI_TOOLTIP_ITEM_NAME, reagent), icon = TEXTURE_REAGENTUNKNOWN, traits = addTraits(newTraits), iconTraits = {}, pack = {}}

function AHKRapidFire:Initialize()
	--SLASH_COMMANDS["/pd"] = AHKRapidFire.PTK.PixelDemo
	--AHKRapidFire.PTK = PixelsToKeys:new("010203", 0, 6) -- (cnstColor, cnstX, cnstY)
	d("FindmeInitText") -- does not show. wait until player active
	ZO_CreateStringId("SI_BINDING_NAME_RF_FIRING", "Rapid Firing")
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_BEGIN_LOCKPICK, AHKRapidFire.BeginLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_FAILED, AHKRapidFire.EndLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_SUCCESS, AHKRapidFire.EndLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_BROKE, AHKRapidFire.EndLockpicking)
end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKRapidFire.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == AHKRapidFire.name then AHKRapidFire:Initialize() end
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)
