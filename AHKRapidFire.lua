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

local function LocOpenFire()
	d("GetVal:"..tostring(ptk.GetVal()))
	d("SetVal:"..tostring(ptk.SetVal(2)))
	d("GetVal:"..tostring(ptk.GetVal()))
	d("SetVal:"..tostring(ptk:SelfSetVal(3)))
	d("GetVal:"..tostring(ptk:SelfGetVal()))
	d("GetVal:"..tostring(LibPixelControl.GetVal()))

	d("VK_BRACELEFT:"..tostring(LibPixelControl)) -- 
	d("VK_BRACELEFT:"..tostring(ptk)) -- 
	d("VK_BRACELEFT:"..tostring(LibPixelControl.VK_BRACELEFT)) -- 
	d("VK_BRACELEFT:"..tostring(ptk.VK_BRACELEFT)) -- 
end

function AHKRapidFire:OpenFire()
	d("OpenFire")
	--ptk.SetIndOn(ptk.VK_A)
	--d("newlib.pxval:"..tostring(newlib.pxval))
	--d("newlib.GetColorValFromBoolVals:"..tostring(newlib.GetColorValFromBoolVals(1,2,3,4,5,6,7,8))) -- nil
	--d("newlib.GetColorValFromBoolVals:"..tostring(GetColorValFromBoolVals(1,2,3,4,5,6,7,8))) -- nil when declared with local, works otherwise
	--d("GetConstValue:"..tostring(GetConstValue())) -- 
	--d("GetSelfValue:"..tostring(GetSelfValue())) -- 

	--d("VK_BRACELEFT:"..tostring(LibPixelControl.VK_BRACELEFT)) -- 
	--d("VK_BRACELEFT:"..tostring(self.ptk.VK_BRACELEFT)) -- 
	LocOpenFire()
end
function AHKRapidFire:CeaseFire()
	d("CeaseFire")
	--ptk.SetIndOff(ptk.VK_A)
	--AHKRapidFire:PixelDemo()
	ptk.SetIndOnFor(ptk.VK_E, 100)
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

function AHKRapidFire:Initialize()
	--SLASH_COMMANDS["/pd"] = AHKRapidFire.PTK.PixelDemo
	--d("FindmeInitText") -- would not show. wait until player active
	ZO_CreateStringId("SI_BINDING_NAME_RF_FIRING", "Rapid Firing")
end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKRapidFire.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == AHKRapidFire.name then AHKRapidFire:Initialize() end
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)
