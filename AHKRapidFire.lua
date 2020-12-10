-- For menu & data
AHKRapidFire = {}
AHKRapidFire.savedVars = {}
AHKRapidFire.globalSavedVars = {}

local ADDON_NAME = "AHKRapidFire"
AHKRapidFire.name = "AHKRapidFire"
AHKRapidFire.watchList = {}

local PixY = 7
local programID = 1
local queueID = 0
local KEY_NONE = 0
local KEY_E = 1
local KEY_X = 2

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
	-- if (keycode == nil) then keycode = 0 d(5) else keycode = tonumber(keycode) end
	keycode = nvl(keycode, 0)
	if (queueID == nil or queueID > 255) then queueID = 0 end
	queueID = queueID + 1
	ColorDataLine1:SetColor((programID/255),(programID/255),(programID/255))
	dmsg("SetPixelKey: "..tostring(programID)..","..tostring(queueID)..","..tostring(keycode))
	ColorDataLine2:SetColor((programID/255),(queueID/255),(keycode/255))
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

function AHKRapidFire:Initialize()
	SLASH_COMMANDS["/rf"] = DelayedPixel
	SLASH_COMMANDS["/rfx"] = DelayedPixelX10

	ColorDataWindow = WINDOW_MANAGER:CreateTopLevelWindow("AHKRapidFire")
	ColorDataWindow:SetDimensions(10,10)

	ColorDataLine1 = CreateControl(nil, ColorDataWindow, CT_LINE)
	ColorDataLine1:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 0, PixY)
	ColorDataLine1:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 1, PixY)
	ColorDataLine1:SetColor((programID/255),(programID/255),(programID/255))
	-- PixelGetColor, curColor1, 0, PixY

	ColorDataLine2 = CreateControl(nil, ColorDataWindow, CT_LINE)
	ColorDataLine2:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 1, PixY)
	ColorDataLine2:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 2, PixY)
	ColorDataLine2:SetColor((programID/255),(queueID/255),(KEY_NONE/255))
	-- PixelGetColor, curColor2, 1, PixY

	--ColorDataLine3 = CreateControl(nil, ColorDataWindow, CT_LINE)
	--ColorDataLine3:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 2, 6)
	--ColorDataLine3:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 3, 6)
	--ColorDataLine3:SetColor((0/255),(0/255),(0/255))
	---- PixelGetColor, curColor3, 2, 6
end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKRapidFire.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == AHKRapidFire.name then AHKRapidFire:Initialize() end
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)
