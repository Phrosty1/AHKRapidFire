--lib = lib or {} -- tmpbri
lib = {} -- tmpbri

--function lib.newworks(cnstColor, cnstX, cnstY)
--	d("new".." cnstColor:"..tostring(cnstColor).." cnstX:"..tostring(cnstX).." cnstY:"..tostring(cnstY))
--	local result = {
--		cnstColor = cnstColor,
--		cnstX = cnstX,
--		cnstY = cnstY,
--		msg = function(txt) d("msg:"..tostring(txt)) end,
--		msg2 = lib.dispmsg
--	}
--	return result
--end
--function lib.dispmsg(txt) d("Findme:"..tostring(txt)) end

local function GetColorFromHex(hex, alpha)
	local r, g, b = hex:match("(%w%w)(%w%w)(%w%w)")
	r = (tonumber(r, 16) or 0) / 255
	g = (tonumber(g, 16) or 0) / 255
	b = (tonumber(b, 16) or 0) / 255
	return r, g, b, alpha or 1
end
local function GetRGBFromKeystates(arrKS)
	r = (tonumber((arrKS[1] .. arrKS[2]), 16) or 0) / 255
	g = (tonumber((arrKS[3] .. arrKS[4]), 16) or 0) / 255
	b = (tonumber((arrKS[5] .. arrKS[6]), 16) or 0) / 255
	return r, g, b
end
local function GetIntFromBin(bin)
	bin = string.reverse(bin)
	local sum = 0
	for i = 1, string.len(bin) do
		num = string.sub(bin, i,i) == "1" and 1 or 0
		sum = sum + num * math.pow(2, i-1)
	end
	return sum
end
local function Subrange(t, first, last)
	local sub = {}
	for i=first,last do sub[#sub + 1] = t[i] end
	return sub
end
local function GetIntFromBool(bools)
	local sum = 0
	for i=0,7 do sum = sum + bools[8-i] * math.pow(2, i) end
	return sum
end
local function GetRGBFromBoolRange(bools)
	r = (GetIntFromBool(Subrange(bools,1,8)) or 0) / 255
	g = (GetIntFromBool(Subrange(bools,9,16)) or 0) / 255
	b = (GetIntFromBool(Subrange(bools,17,24)) or 0) / 255
	return r, g, b
end

function lib.new(cnstColor, cnstX, cnstY)
	d("new".." cnstColor:"..tostring(cnstColor).." cnstX:"..tostring(cnstX).." cnstY:"..tostring(cnstY))
	local colorDataWindow = WINDOW_MANAGER:CreateTopLevelWindow("LibPixelControl")
	colorDataWindow:SetDimensions(10,10)
	local colorDataLine1 = CreateControl(nil, colorDataWindow, CT_LINE)
	colorDataLine1:SetAnchor(TOPLEFT, colorDataWindow, TOPLEFT, cnstX+0, cnstY)
	colorDataLine1:SetAnchor(TOPRIGHT, colorDataWindow, TOPLEFT, cnstX+1, cnstY)
	colorDataLine1:SetColor(GetColorFromHex(cnstColor))
	local colorDataLine2 = CreateControl(nil, colorDataWindow, CT_LINE)
	colorDataLine2:SetAnchor(TOPLEFT, colorDataWindow, TOPLEFT, cnstX+1, cnstY)
	colorDataLine2:SetAnchor(TOPRIGHT, colorDataWindow, TOPLEFT, cnstX+2, cnstY)
	colorDataLine2:SetColor((0/255),(0/255),(0/255))
	local colorDataLine3 = CreateControl(nil, colorDataWindow, CT_LINE)
	colorDataLine3:SetAnchor(TOPLEFT, colorDataWindow, TOPLEFT, cnstX+2, cnstY)
	colorDataLine3:SetAnchor(TOPRIGHT, colorDataWindow, TOPLEFT, cnstX+3, cnstY)
	colorDataLine3:SetColor((0/255),(0/255),(0/255))
	local bools = {}
	for i=1,48 do bools[i] = 0 end

	local result = {
		cnstColor = cnstColor,
		cnstX = cnstX,
		cnstY = cnstY,
		bools = bools,
		SetPixelColors = function()
			d("SetPixelColors")
			colorDataLine2:SetColor(GetRGBFromBoolRange(Subrange(bools,1,24)))
			colorDataLine3:SetColor(GetRGBFromBoolRange(Subrange(bools,25,48)))
		end,
		SetIndOn = function(idx)
			bools[idx] = 1
			colorDataLine2:SetColor(GetRGBFromBoolRange(Subrange(bools,1,24)))
			colorDataLine3:SetColor(GetRGBFromBoolRange(Subrange(bools,25,48)))
		end,
		SetIndOff = function(idx) bools[idx] = 0 SetPixelColors() end,
		colorDataLine1 = colorDataLine1,
		colorDataLine2 = colorDataLine2,
		colorDataLine3 = colorDataLine3,
		msg2 = lib.dispmsg
	}

	return result
end

function lib:dispmsg(txt)
	txt = txt or "blank"
	d("dispmsg:"..tostring(txt).." cnstY:"..tostring(self.cnstY)) 
end

LibPixelControl = lib
