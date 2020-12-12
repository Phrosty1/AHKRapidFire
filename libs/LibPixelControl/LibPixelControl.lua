--lib = lib or {} -- tmpbri
lib = {} -- tmpbri

function lib:Init()
	d("Init1")
	lib.msg = "Init1"
	if not lib.content then
		d("Init2")
		lib.msg = "Init2"
	end
end

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

function lib.new(cnstColor, cnstX, cnstY)
	d("new".." cnstColor:"..tostring(cnstColor).." cnstX:"..tostring(cnstX).." cnstY:"..tostring(cnstY))
	local result = {
		cnstColor = cnstColor,
		cnstX = cnstX,
		cnstY = cnstY,
		msg = function(txt)
			d("msg:"..tostring(txt)) 
		end,
		msg2 = lib.dispmsg
	}
	result.ColorDataWindow = WINDOW_MANAGER:CreateTopLevelWindow("LibPixelControl")
	result.ColorDataWindow:SetDimensions(10,10)
	result.ColorDataLine1 = CreateControl(nil, ColorDataWindow, CT_LINE)
	result.ColorDataLine1:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, cnstX+0, cnstY)
	result.ColorDataLine1:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, cnstX+1, cnstY)
	result.ColorDataLine1:SetColor(GetColorFromHex(cnstColor))
	result.ColorDataLine2 = CreateControl(nil, ColorDataWindow, CT_LINE)
	result.ColorDataLine2:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, cnstX+1, cnstY)
	result.ColorDataLine2:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, cnstX+2, cnstY)
	result.ColorDataLine2:SetColor((0/255),(0/255),(0/255))
	result.ColorDataLine3 = CreateControl(nil, ColorDataWindow, CT_LINE)
	result.ColorDataLine3:SetAnchor(TOPLEFT, ColorDataWindow, TOPLEFT, cnstX+2, cnstY)
	result.ColorDataLine3:SetAnchor(TOPRIGHT, ColorDataWindow, TOPLEFT, cnstX+3, cnstY)
	result.ColorDataLine3:SetColor((0/255),(0/255),(0/255))
	return result
end

function lib.dispmsg(txt)
	txt = txt or "blank"
	d("Findme:"..tostring(txt))
end

LibPixelControl = lib
