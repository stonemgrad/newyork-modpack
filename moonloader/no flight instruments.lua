script_author("sunlight")

local memory = require "memory"

function main()
	-- enable this-blip
	memory.setuint8(0x588550, 0xEB, true)
	-- disable arrow
	memory.setuint32(0x58A4FE + 0x1, 0x0, true)
	-- disable green rect
	memory.setuint32(0x586A71 + 0x1, 0x0, true)
end