-- For menu & data
AHKRapidFire = {}
AHKRapidFire.savedVars = {}
AHKRapidFire.globalSavedVars = {}
AHKRapidFire.name = "AHKRapidFire"

local PixelsToKeys

local ms_time = GetGameTimeMilliseconds()
local function dmsg(txt)
	d((GetGameTimeMilliseconds() - ms_time) .. ") " .. txt)
	ms_time = GetGameTimeMilliseconds()
end

function AHKRapidFire.OpenFire()
	d("OpenFire")
	local tmp = PixelsToKeys:new() -- (cnstColor, cnstX, cnstY)
end
function AHKRapidFire.CeaseFire()
	d("CeaseFire")
end

function AHKRapidFire:Initialize()
	--SLASH_COMMANDS["/pd"] = AHKRapidFire.PTK.PixelDemo
	--AHKRapidFire.PTK = PixelsToKeys:new("010203", 0, 6) -- (cnstColor, cnstX, cnstY)

end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function AHKRapidFire.OnAddOnLoaded(event, addonName) -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == AHKRapidFire.name then AHKRapidFire:Initialize() end
	ZO_CreateStringId("SI_BINDING_NAME_RF_FIRING", "Rapid Firing")
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(AHKRapidFire.name, EVENT_ADD_ON_LOADED, AHKRapidFire.OnAddOnLoaded)
