-- For menu & data
AHKRapidFire = {}
AHKRapidFire.savedVars = {}
AHKRapidFire.globalSavedVars = {}
AHKRapidFire.name = "AHKRapidFire"

--AHKRapidFire.pixelControl = LibPixelControl.new("010203", 0, 7)
local pixelControl = LibPixelControl.new("010203", 0, 7)

local ms_time = GetGameTimeMilliseconds()
local function dmsg(txt)
	d((GetGameTimeMilliseconds() - ms_time) .. ") " .. txt)
	ms_time = GetGameTimeMilliseconds()
end

function AHKRapidFire:OpenFire()
	d("OpenFire")
	--local tmp = PixelsToKeys:new(cnstColor, cnstX, cnstY)
	--PixelsToKeys:example()
	--local tmp = pixelControl -- LibPixelControl.new("010203", 0, 7)
	--d("tmp.cnstY:"..tostring(tmp.cnstY))
	--tmp.SetIndOn(10)
	--tmp.SetPixelColors()
	--tmp.msg("YY1")
	--tmp.msg2("YY2")
	pixelControl.SetIndOn(3)
end
function AHKRapidFire:CeaseFire()
	d("CeaseFire")
	pixelControl.SetIndOff(3)
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
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)
