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


local function CheckLockPickStatus()
	dmsg("Stress:"..tostring(GetSettingChamberStress()).." Chambers:"..tostring(IsChamberSolved(1))..":"..tostring(IsChamberSolved(2))..":"..tostring(IsChamberSolved(3))..":"..tostring(IsChamberSolved(4))..":"..tostring(IsChamberSolved(5)))
	if GetSettingChamberStress() > 0 then
		ptk.SetIndOff(ptk.VM_BTN_LEFT) -- stop pressing
		EVENT_MANAGER:UnregisterForUpdate("AHKRapidFireLockpicker")
		zo_callLater(function()
						if IsChamberSolved(1) ~= true then
							AHKRapidFire:MoveAndPickNext()
						end
					end, 50)

		
	end
end
function AHKRapidFire:PressPickUntilDone()
	ptk.SetIndOn(ptk.VM_BTN_LEFT)
	EVENT_MANAGER:RegisterForUpdate("AHKRapidFireLockpicker", 100, CheckLockPickStatus)
end
function AHKRapidFire:MoveAndPickNext()
	dmsg("MoveAndPickNext")
	if IsChamberSolved(1) ~= true then
		ptk.SetIndOn(ptk.VM_MOVE_10_LEFT)
		zo_callLater(function()
						ptk.SetIndOff(ptk.VM_MOVE_10_LEFT)
						AHKRapidFire:PressPickUntilDone()
					end, 80)
	end
end
function AHKRapidFire:EndLockpicking()
	EVENT_MANAGER:UnregisterForUpdate("AHKRapidFireLockpicker")
	ptk.SetIndOff(ptk.VM_BTN_LEFT) -- stop pressing
end
-- EVENT_BEGIN_LOCKPICK (number eventCode)
function AHKRapidFire:BeginLockpicking()
	d("Lockpicking")
	
	ptk.SetIndOn(ptk.VM_MOVE_10_RIGHT)
	zo_callLater(function()
						ptk.SetIndOff(ptk.VM_MOVE_10_RIGHT)
						AHKRapidFire:PressPickUntilDone()
					end, 500)

	--local chamberStress = GetSettingChamberStress()
	--local chamberSolved = IsChamberSolved(1)
	--d("chamberStress:"..tostring(chamberStress))
	--d("chamberSolved:"..tostring(chamberSolved))
end

-- local item = PotMaker.Ingredient:new {name = zo_strformat(SI_TOOLTIP_ITEM_NAME, reagent), icon = TEXTURE_REAGENTUNKNOWN, traits = addTraits(newTraits), iconTraits = {}, pack = {}}

function AHKRapidFire:Initialize()
	--SLASH_COMMANDS["/pd"] = AHKRapidFire.PTK.PixelDemo
	--AHKRapidFire.PTK = PixelsToKeys:new("010203", 0, 6) -- (cnstColor, cnstX, cnstY)
	d("FindmeInitText") -- does not show. wait until player active
end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKRapidFire.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == AHKRapidFire.name then AHKRapidFire:Initialize() end
	ZO_CreateStringId("SI_BINDING_NAME_RF_FIRING", "Rapid Firing")
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_BEGIN_LOCKPICK, AHKRapidFire.BeginLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_FAILED, AHKRapidFire.EndLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_SUCCESS, AHKRapidFire.EndLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_BROKE, AHKRapidFire.EndLockpicking)
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)
