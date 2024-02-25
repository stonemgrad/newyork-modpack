-- Author Seven_Memz

local memory = require "memory"

function main()
    local oldProtect = memory.unprotect(0x53C136, 5) -- CGame::Process (CCoronas::DoSunAndMoon)
    memory.hex2bin("E865041C00", 0x53C136, 5) -- Write original game bytes
    memory.protect(0x53C136, 5, oldProtect)
end