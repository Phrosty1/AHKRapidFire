-- For menu & data
AHKFishing = {}
AHKFishing.savedVars = {}
AHKFishing.globalSavedVars = {}

local ADDON_NAME = "AHKFishing"
AHKFishing.name = "AHKFishing"
AHKFishing.watchList = {}

local PixY = 5
local programID = 1
local queueID = 0
local binkeys = "00000000000000000000000000000000"
local KEY_W = 1
local KEY_S = 2
local KEY_A = 3
local KEY_D = 4
local KEY_E = 5
local KEY_X = 6
local binmouse = "00000000000000000000000000000000"
local MOUSE_BTN_L = 1
local MOUSE_BTN_R = 2
local MOUSE_UP = 3
local MOUSE_DOWN = 4
local MOUSE_LEFT = 5
local MOUSE_RIGHT = 6


local ms_time = GetGameTimeMilliseconds()
local function dmsg(txt)
	d((GetGameTimeMilliseconds() - ms_time) .. ") " .. txt)
	ms_time = GetGameTimeMilliseconds()
end
local function isEmpty(s) return s == nil or s == '' end
local function nvl(n, v) if n == nil or n == '' then return v else return n end end

local function subrange(t, first, last)
	local sub = {}
	for i=first,last do
		sub[#sub + 1] = t[i]
	end
	return sub
end

function GetIntFromBin(bin) -- local bin = "10010011001100011001011110001100000110110101100"
	bin = string.reverse(bin)
	local sum = 0
	for i = 1, string.len(bin) do
		num = string.sub(bin, i,i) == "1" and 1 or 0
		sum = sum + num * math.pow(2, i-1)
	end
	return sum
end

function GetColorFromHex(hex, alpha)
	local r, g, b = hex:match("(%w%w)(%w%w)(%w%w)")
	r = (tonumber(r, 16) or 0) / 255
	g = (tonumber(g, 16) or 0) / 255
	b = (tonumber(b, 16) or 0) / 255
	return r, g, b, alpha or 1
end

function GetRGBFromKeystates(arrKS)
	tmp = (arrKS[1] .. arrKS[2])
	r = (tonumber((arrKS[1] .. arrKS[2]), 16) or 0) / 255
	g = (tonumber((arrKS[3] .. arrKS[4]), 16) or 0) / 255
	b = (tonumber((arrKS[5] .. arrKS[6]), 16) or 0) / 255
	return r, g, b
end

local function SetPixelKey(keycode)
	if (queueID == nil or queueID > 255) then queueID = 0 end
	queueID = queueID + 1
	AHKFishing.ColorDataLine1:SetColor((programID/255),(programID/255),(programID/255))
	AHKFishing.ColorDataLine2:SetColor((programID/255),(queueID/255),(keycode/255))
	dmsg("SetPixelKey: "..tostring(programID)..","..tostring(queueID)..","..tostring(keycode))
end

local function DelayedPixel(key)
	zo_callLater(function() SetPixelKey(key) end, 500)
end

local function DelayedPixelX10(key)
	for i = 1, 10, 1 do
		zo_callLater(function() SetPixelKey(key) end, 500 * i)
	end
end

local function replace_char(str, pos, r)
	-- return str:sub(1, pos-1) .. r .. str:sub(pos+1)
	return str:sub(1, tonumber(pos)-1) .. r .. str:sub(tonumber(pos)+1)
end

local function SetKeyOn(keyidx)
	binkeys = replace_char(binkeys, keyidx, "1")
	AHKFishing.ColorDataLine1:SetColor((01/255),(02/255),(03/255))
	AHKFishing.ColorDataLine2:SetColor((GetIntFromBin(string.sub(binkeys, 1, 8))/255),(GetIntFromBin(string.sub(binkeys, 9, 16))/255),(GetIntFromBin(string.sub(binkeys, 17, 24))/255))
	AHKFishing.ColorDataLine3:SetColor((GetIntFromBin(string.sub(binmouse, 1, 8))/255),(GetIntFromBin(string.sub(binmouse, 9, 16))/255),(GetIntFromBin(string.sub(binmouse, 17, 24))/255))
end
local function SetKeyOff(keyidx)
	binkeys = replace_char(binkeys, keyidx, "0")
	AHKFishing.ColorDataLine1:SetColor((01/255),(02/255),(03/255))
	AHKFishing.ColorDataLine2:SetColor((GetIntFromBin(string.sub(binkeys, 1, 8))/255),(GetIntFromBin(string.sub(binkeys, 9, 16))/255),(GetIntFromBin(string.sub(binkeys, 17, 24))/255))
	AHKFishing.ColorDataLine3:SetColor((GetIntFromBin(string.sub(binmouse, 1, 8))/255),(GetIntFromBin(string.sub(binmouse, 9, 16))/255),(GetIntFromBin(string.sub(binmouse, 17, 24))/255))
end
local function SetMouseCmdOn(mouseCmdIdx)
	binmouse = replace_char(binmouse, mouseCmdIdx, "1")
	AHKFishing.ColorDataLine1:SetColor((01/255),(02/255),(03/255))
	AHKFishing.ColorDataLine2:SetColor((GetIntFromBin(string.sub(binkeys, 1, 8))/255),(GetIntFromBin(string.sub(binkeys, 9, 16))/255),(GetIntFromBin(string.sub(binkeys, 17, 24))/255))
	AHKFishing.ColorDataLine3:SetColor((GetIntFromBin(string.sub(binmouse, 1, 8))/255),(GetIntFromBin(string.sub(binmouse, 9, 16))/255),(GetIntFromBin(string.sub(binmouse, 17, 24))/255))
end
local function SetMouseCmdOff(mouseCmdIdx)
	binmouse = replace_char(binmouse, mouseCmdIdx, "0")
	AHKFishing.ColorDataLine1:SetColor((01/255),(02/255),(03/255))
	AHKFishing.ColorDataLine2:SetColor((GetIntFromBin(string.sub(binkeys, 1, 8))/255),(GetIntFromBin(string.sub(binkeys, 9, 16))/255),(GetIntFromBin(string.sub(binkeys, 17, 24))/255))
	AHKFishing.ColorDataLine3:SetColor((GetIntFromBin(string.sub(binmouse, 1, 8))/255),(GetIntFromBin(string.sub(binmouse, 9, 16))/255),(GetIntFromBin(string.sub(binmouse, 17, 24))/255))
end


local function DoKeyPress(keyidx)
	SetKeyOn(keyidx)
	zo_callLater(function() SetKeyOff(keyidx) end, 100)
	dmsg("Pressing keyidx "..tostring(keyidx))
end

local function DoMouseMove(mouseCmdIdx)
	SetMouseCmdOn(mouseCmdIdx)
	zo_callLater(function() SetMouseCmdOff(mouseCmdIdx) end, 100)
	dmsg("Setting mouseCmdIdx "..tostring(mouseCmdIdx))
end
--local function DelayedPixelB(keyidx)
--	keyidx = nvl(keyidx, KEY_W)
--	for i = 1, 5, 1 do
--		zo_callLater(function() DoKeyPress(keyidx) end, (500 * i))
--	end
--end
local function DelayedPixelB(mouseCmdIdx)
	mouseCmdIdx = nvl(mouseCmdIdx, MOUSE_LEFT)
	for i = 1, 15, 1 do
		zo_callLater(function() DoMouseMove(mouseCmdIdx) end, (500 * i))
	end
end
local function PixelDemo(mouseCmdIdx)
	t=1000
	zo_callLater(function() SetKeyOn(KEY_A) end, t) t=t+500
	zo_callLater(function() SetKeyOff(KEY_A) end, t)
	t=t+500
	zo_callLater(function() SetKeyOn(KEY_D) end, t) t=t+500
	zo_callLater(function() SetKeyOff(KEY_D) end, t)
	t=t+500
	zo_callLater(function() SetKeyOn(KEY_W) end, t) t=t+500
	zo_callLater(function() SetKeyOff(KEY_W) end, t)
	t=t+500
	zo_callLater(function() SetKeyOn(KEY_S) end, t) t=t+500
	zo_callLater(function() SetKeyOff(KEY_S) end, t)
	t=t+500
	zo_callLater(function() SetMouseCmdOn(MOUSE_LEFT) end, t) t=t+500
	zo_callLater(function() SetMouseCmdOff(MOUSE_LEFT) end, t)
	t=t+500
	zo_callLater(function() SetMouseCmdOn(MOUSE_RIGHT) end, t) t=t+500
	zo_callLater(function() SetMouseCmdOff(MOUSE_RIGHT) end, t)
	t=t+500
	zo_callLater(function() SetMouseCmdOn(MOUSE_UP) end, t) t=t+500
	zo_callLater(function() SetMouseCmdOff(MOUSE_UP) end, t)
	t=t+500
	zo_callLater(function() SetMouseCmdOn(MOUSE_DOWN) end, t) t=t+500
	zo_callLater(function() SetMouseCmdOff(MOUSE_DOWN) end, t)
	t=t+500
	zo_callLater(function() SetMouseCmdOn(MOUSE_BTN_R) end, t) t=t+500
	zo_callLater(function() SetMouseCmdOff(MOUSE_BTN_R) end, t)
	t=t+500
	zo_callLater(function() SetMouseCmdOn(MOUSE_BTN_L) end, t) t=t+50
	zo_callLater(function() SetMouseCmdOff(MOUSE_BTN_L) end, t)
end


local function IsItemFish(bagId, slotIndex)
	if bagId ~= BAG_BACKPACK then
		return false
	end
	local itemType = GetItemType(bagId, slotIndex)
	if ITEMTYPE_FISH == itemType then
		local usable, onlyFromActionSlot = IsItemUsable(bagId, slotIndex)
		local canInteractWithItem = CanInteractWithItem(bagId, slotIndex)
		return usable and not onlyFromActionSlot and canInteractWithItem
	end
	return false
end

local useItem = IsProtectedFunction("UseItem") and function(...)
		return CallSecureProtected("UseItem", ...)
	end or function(...)
		UseItem(...)
		return true
	end

-- EVENT_INVENTORY_SINGLE_SLOT_UPDATE (number eventCode, Bag bagId, number slotId, boolean isNewItem, ItemUISoundCategory itemSoundCategory, number inventoryUpdateReason, number stackCountChange)
function OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
	if (GetItemType(bagId,slotId) == ITEMTYPE_LURE 
		and isNewItem == false 
		and stackCountChange == -1 
		and itemSoundCategory == 39) 
	then
		--SetPixelKey(KEY_E)
		--zo_callLater(function() SetPixelKey(KEY_E) end, 500)
		DoKeyPress(KEY_E)
		zo_callLater(function() DoKeyPress(KEY_E) end, 500)
	end
	--if (IsItemFish(bagId,slotId)) then
	--	useItem(bagId,slotId)
	--end
end

function StealthState(code)
	local tmp = {
		[STEALTH_STATE_DETECTED] = "STEALTH_STATE_DETECTED",
		[STEALTH_STATE_HIDDEN] = "STEALTH_STATE_HIDDEN",
		[STEALTH_STATE_HIDDEN_ALMOST_DETECTED] = "STEALTH_STATE_HIDDEN_ALMOST_DETECTED",
		[STEALTH_STATE_HIDING] = "STEALTH_STATE_HIDING",
		[STEALTH_STATE_NONE] = "STEALTH_STATE_NONE",
		[STEALTH_STATE_STEALTH] = "STEALTH_STATE_STEALTH",
		[STEALTH_STATE_STEALTH_ALMOST_DETECTED] = "STEALTH_STATE_STEALTH_ALMOST_DETECTED"}
	return tmp[code]
end

local bladeIsReady = false
-- EVENT_SYNERGY_ABILITY_CHANGED (number eventCode)
function OnSynergyAbilityChanged(eventCode) -- eventCode=131174
	local synergyName, iconFilename = GetSynergyInfo()
	if (synergyName == "Blade of Woe") then
		local isStealthed = GetUnitStealthState("player")
		--if (synergyName == "Blade of Woe" and isStealthed ~= STEALTH_STATE_HIDDEN) then
		--	bladeIsReady = true
		--end
		dmsg("OnSynergyAbilityChanged: "..tostring(eventCode).." synergyName:"..tostring(synergyName))
		d("- isStealthed: "..tostring(StealthState(isStealthed)))
		d("- bladeIsReady:"..tostring(bladeIsReady))
		if (synergyName == "Blade of Woe" and (isStealthed == STEALTH_STATE_HIDDEN or isStealthed == STEALTH_STATE_HIDDEN_ALMOST_DETECTED)) then
			DoKeyPress(KEY_X)
		end
	end
end
-- EVENT_STEALTH_STATE_CHANGED (number eventCode, string unitTag, StealthState stealthState)
function OnStealthStateChanged(eventCode, unitTag, stealthState)
	local isStealthed = GetUnitStealthState("player")
	--if (isStealthed == STEALTH_STATE_HIDDEN) then
	--	if (stealthState == STEALTH_STATE_HIDDEN and bladeIsReady == true) then
	--		bladeIsReady = false
	--		DoKeyPress(KEY_X)
	--	end
	--end
	dmsg("OnStealthStateChanged: "..tostring(eventCode).." unitTag:"..tostring(unitTag).." stealthState:"..tostring(stealthState).." bladeIsReady:"..tostring(bladeIsReady))
	d("- stealthState: "..tostring(StealthState(stealthState)))
	d("- isStealthed: "..tostring(StealthState(isStealthed)))
end

-- EVENT_COMBAT_EVENT (number eventCode, number ActionResult result, boolean isError, string abilityName, number abilityGraphic, number ActionSlotType abilityActionSlotType, string sourceName, number CombatUnitType sourceType, string targetName, number CombatUnitType targetType, number hitValue, number CombatMechanicType powerType, number DamageType damageType, boolean log, number sourceUnitId, number targetUnitId, number abilityId, number overflow)
function OnCombatEvent(eventCode, abilityId)
	dmsg("OnCombatEvent: "..tostring(eventCode)
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

function AHKFishing:Initialize()
	EVENT_MANAGER:RegisterForEvent(AHKFishing.name, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, OnInventorySingleSlotUpdate)
	EVENT_MANAGER:RegisterForEvent(AHKFishing.name, EVENT_SYNERGY_ABILITY_CHANGED, OnSynergyAbilityChanged)
	EVENT_MANAGER:RegisterForEvent(AHKFishing.name, EVENT_STEALTH_STATE_CHANGED, OnStealthStateChanged)
	SLASH_COMMANDS["/px"] = DelayedPixel
	SLASH_COMMANDS["/pt"] = DelayedPixelX10
	SLASH_COMMANDS["/pb"] = DelayedPixelB
	SLASH_COMMANDS["/pd"] = PixelDemo

	ColorDataWindow = WINDOW_MANAGER:CreateTopLevelWindow("AHKFishing")
	ColorDataWindow:SetDimensions(10,10)
	   
	AHKFishing.ColorDataLine1 = CreateControl(nil, ColorDataWindow, CT_LINE)
	AHKFishing.ColorDataLine1:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 0, PixY)
	AHKFishing.ColorDataLine1:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 1, PixY)
	AHKFishing.ColorDataLine1:SetColor((programID/255),(programID/255),(programID/255))

	AHKFishing.ColorDataLine2 = CreateControl(nil, ColorDataWindow, CT_LINE)
	AHKFishing.ColorDataLine2:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 1, PixY)
	AHKFishing.ColorDataLine2:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 2, PixY)
	AHKFishing.ColorDataLine2:SetColor((0/255),(0/255),(0/255))

	AHKFishing.ColorDataLine3 = CreateControl(nil, ColorDataWindow, CT_LINE)
	AHKFishing.ColorDataLine3:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 2, PixY)
	AHKFishing.ColorDataLine3:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 3, PixY)
	AHKFishing.ColorDataLine3:SetColor((0/255),(0/255),(0/255))

	--EVENT_MANAGER:RegisterForEvent(AHKFishing.name, EVENT_COMBAT_EVENT, OnCombatEvent)
end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKFishing.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == AHKFishing.name then AHKFishing:Initialize() end
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKFishing.name, EVENT_ADD_ON_LOADED, AHKFishing.OnAddOnLoaded)
