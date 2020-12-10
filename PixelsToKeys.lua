local PixY = 5
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
local function replace_char(str, pos, r) return str:sub(1, tonumber(pos)-1) .. r .. str:sub(tonumber(pos)+1) end
function GetIntFromBin(bin)
	bin = string.reverse(bin)
	local sum = 0
	for i = 1, string.len(bin) do
		num = string.sub(bin, i,i) == "1" and 1 or 0
		sum = sum + num * math.pow(2, i-1)
	end
	return sum
end
local function SetKeyOn(keyidx)
	binkeys = replace_char(binkeys, keyidx, "1")
	PixelsToKeys.ColorDataLine2:SetColor((GetIntFromBin(string.sub(binkeys, 1, 8))/255),(GetIntFromBin(string.sub(binkeys, 9, 16))/255),(GetIntFromBin(string.sub(binkeys, 17, 24))/255))
end
local function SetKeyOff(keyidx)
	binkeys = replace_char(binkeys, keyidx, "0")
	PixelsToKeys.ColorDataLine2:SetColor((GetIntFromBin(string.sub(binkeys, 1, 8))/255),(GetIntFromBin(string.sub(binkeys, 9, 16))/255),(GetIntFromBin(string.sub(binkeys, 17, 24))/255))
end
local function SetMouseCmdOn(mouseCmdIdx)
	binmouse = replace_char(binmouse, mouseCmdIdx, "1")
	PixelsToKeys.ColorDataLine3:SetColor((GetIntFromBin(string.sub(binmouse, 1, 8))/255),(GetIntFromBin(string.sub(binmouse, 9, 16))/255),(GetIntFromBin(string.sub(binmouse, 17, 24))/255))
end
local function SetMouseCmdOff(mouseCmdIdx)
	binmouse = replace_char(binmouse, mouseCmdIdx, "0")
	PixelsToKeys.ColorDataLine3:SetColor((GetIntFromBin(string.sub(binmouse, 1, 8))/255),(GetIntFromBin(string.sub(binmouse, 9, 16))/255),(GetIntFromBin(string.sub(binmouse, 17, 24))/255))
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

function PixelsToKeys:Initialize()
	SLASH_COMMANDS["/pd"] = PixelDemo

	ColorDataWindow = WINDOW_MANAGER:CreateTopLevelWindow("PixelsToKeys")
	ColorDataWindow:SetDimensions(10,10)
	   
	PixelsToKeys.ColorDataLine1 = CreateControl(nil, ColorDataWindow, CT_LINE)
	PixelsToKeys.ColorDataLine1:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 0, PixY)
	PixelsToKeys.ColorDataLine1:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 1, PixY)
	PixelsToKeys.ColorDataLine1:SetColor((01/255),(02/255),(03/255))

	PixelsToKeys.ColorDataLine2 = CreateControl(nil, ColorDataWindow, CT_LINE)
	PixelsToKeys.ColorDataLine2:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 1, PixY)
	PixelsToKeys.ColorDataLine2:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 2, PixY)
	PixelsToKeys.ColorDataLine2:SetColor((0/255),(0/255),(0/255))

	PixelsToKeys.ColorDataLine3 = CreateControl(nil, ColorDataWindow, CT_LINE)
	PixelsToKeys.ColorDataLine3:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, 2, PixY)
	PixelsToKeys.ColorDataLine3:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, 3, PixY)
	PixelsToKeys.ColorDataLine3:SetColor((0/255),(0/255),(0/255))
end

