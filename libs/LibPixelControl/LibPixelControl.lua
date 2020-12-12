lib = lib or {}

function lib:Init()
	d("Init1")
	lib.msg = "Init1"
	if not lib.content then
		d("Init2")
		lib.msg = "Init2"

	end
end

function lib:Findme()
	d("Findme")
	d("msg:"..tostring(lib.msg))
end

LibPixelControl = lib
