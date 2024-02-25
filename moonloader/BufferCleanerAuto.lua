script_author("Azller")
local memory = require 'memory'

function main()
	repeat wait(0) until isSampAvailable()
	wait(2000)
	while true do wait(5000)
		if memory.read(0x8E4CB4, 4, true) > 1400000000 then
			cleanStreamMemoryBuffer()
		end
	end
end


function cleanStreamMemoryBuffer()
local huy = callFunction(0x53C500, 2, 2, true, true)
local huy1 = callFunction(0x53C810, 1, 1, true)
local huy2 = callFunction(0x40CF80, 0, 0)
local huy3 = callFunction(0x4090A0, 0, 0)
local huy4 = callFunction(0x5A18B0, 0, 0)
local huy5 = callFunction(0x707770, 0, 0)
local huy6 = callFunction(0x40CFD0, 0, 0)
local huy7 = callFunction(0x40D7C0, 1, 1, false)
local pX, pY, pZ = getCharCoordinates(PLAYER_PED)
requestCollision(pX, pY)
loadScene(pX, pY, pZ)
end
