-- For menu & data
AHKRapidFire = {}
AHKRapidFire.name = "AHKRapidFire"

local ms_time = GetGameTimeMilliseconds()
local function dmsg(txt)
	d((GetGameTimeMilliseconds() - ms_time) .. ") " .. txt)
	ms_time = GetGameTimeMilliseconds()
end

local ptk = LibPixelControl
local testval = 5

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



function AHKRapidFire:BeginLockpicking()
	dmsg("BeginLockpicking")
	ptk.SetIndOn(ptk.VM_MOVE_10_LEFT)
	zo_callLater(function() AHKRapidFire:CheckLockPickStatus() end, 500)
end
function AHKRapidFire:CheckLockPickStatus()
	d("Stress:"..tostring(GetSettingChamberStress()).." Chambers:"..tostring(IsChamberSolved(1))..":"..tostring(IsChamberSolved(2))..":"..tostring(IsChamberSolved(3))..":"..tostring(IsChamberSolved(4))..":"..tostring(IsChamberSolved(5)))
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
	local repeatrate = 75
	if ptk.IsIndOn(ptk.VM_MOVE_10_LEFT) then
		ptk.SetIndOff(ptk.VM_MOVE_10_LEFT) -- stop moving
		ptk.SetIndOn(ptk.VM_BTN_LEFT) -- start pressing
		ptk.SetIndOn(ptk.VM_MOVE_10_RIGHT) -- start moving
		zo_callLater(function() AHKRapidFire:CheckLockPickStatus() end, repeatrate)
	elseif ptk.IsIndOn(ptk.VM_BTN_LEFT) then
		if GetSettingChamberStress() > 0 then
			ptk.SetIndOff(ptk.VM_BTN_LEFT) -- stop pressing
			zo_callLater(function() AHKRapidFire:CheckLockPickStatus() end, repeatrate)
		elseif (prog1 > 0 or prog2 > 0 or prog3 > 0 or prog4 > 0 or prog5 > 0) then -- keep holding
			zo_callLater(function() AHKRapidFire:CheckLockPickStatus() end, repeatrate)
		end
	elseif ptk.IsIndOn(ptk.VM_MOVE_10_RIGHT) then
		ptk.SetIndOn(ptk.VM_BTN_LEFT) -- start pressing
		zo_callLater(function() AHKRapidFire:CheckLockPickStatus() end, repeatrate)
	end
end
function AHKRapidFire:EndLockpicking()
	dmsg("EndLockpicking")
	--EVENT_MANAGER:UnregisterForUpdate("AHKRapidFireLockpicker")
	ptk.SetIndOff(ptk.VM_MOVE_10_LEFT) -- stop pressing
	ptk.SetIndOff(ptk.VM_MOVE_10_RIGHT) -- stop pressing
	ptk.SetIndOff(ptk.VM_BTN_LEFT) -- stop pressing
end


-- EVENT_INVENTORY_SINGLE_SLOT_UPDATE (number eventCode, Bag bagId, number slotId, boolean isNewItem, ItemUISoundCategory itemSoundCategory, number inventoryUpdateReason, number stackCountChange)
function AHKRapidFire.OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
	if (GetItemType(bagId,slotId) == ITEMTYPE_LURE 
		and isNewItem == false 
		and stackCountChange == -1 
		and itemSoundCategory == 39) 
	then
		dmsg("Lure used, pressing E")
		--SetPixelKey(KEY_E)
		--zo_callLater(function() SetPixelKey(KEY_E) end, 500)
		ptk.SetIndOnFor(ptk.VK_E, 100)
		zo_callLater(function() ptk.SetIndOnFor(ptk.VK_E, 100) end, 500)
	end
	--if (IsItemFish(bagId,slotId)) then
	--	useItem(bagId,slotId)
	--end
end

function AHKRapidFire:Initialize()
	--SLASH_COMMANDS["/pd"] = AHKRapidFire.PTK.PixelDemo
	--AHKRapidFire.PTK = PixelsToKeys:new("010203", 0, 6) -- (cnstColor, cnstX, cnstY)
	d("FindmeInitText") -- does not show. wait until player active
	ZO_CreateStringId("SI_BINDING_NAME_RF_FIRING", "Rapid Firing")
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_BEGIN_LOCKPICK, AHKRapidFire.BeginLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_FAILED, AHKRapidFire.EndLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_SUCCESS, AHKRapidFire.EndLockpicking)
	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_LOCKPICK_BROKE, AHKRapidFire.EndLockpicking)

	EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, AHKRapidFire.OnInventorySingleSlotUpdate)
end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKRapidFire.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == AHKRapidFire.name then AHKRapidFire:Initialize() end
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)
