script_author = "Gorskin"
script_name = "[DFL_Editor]"

local memory = require "memory"
local inicfg = require "inicfg"
local directIni = "DFL_Editor.ini"
local ini = inicfg.load({
    settings = {
        givemedist = true,
        drawdist = "370",
        drawdistair = "1000",
        fog = "200",
        lod = "290",
    },
}, directIni)
inicfg.save(ini, directIni)

function save()
    inicfg.save(ini, directIni)
end

function main()
	repeat wait(15000) until isSampAvailable()
	if ini.settings.givemedist then
		sampAddChatMessage(script_name.." {FFFFFF}У вас активирован режим: {dc4747}/givemedist{FFFFFF}, изменяющий дальность прорисовки", 0x73b461)
	else
		sampAddChatMessage(script_name.." {FFFFFF}При малом FPS используйте: {dc4747}/givemedist{FFFFFF}, чтобы уменьшить дальность прорисовки", 0x73b461)
	end
    ChangeDist()
    sampRegisterChatCommand("givemedist", function()
       ini.settings.givemedist = not ini.settings.givemedist
        sampAddChatMessage(ini.settings.givemedist and script_name..' {FFFFFF}Малая прорисовка для слабых компьютеров {73b461}включена' or script_name..' {FFFFFF}Малая прорисовка для слабых компьютеров {dc4747}выключена', 0x73b461)
        save()
        ChangeDist()
    end)
    sampSetClientCommandDescription("givemedist", "Включение / выключение возможности менять прорисовку")
    sampRegisterChatCommand("dd", function(arg)
        local drawdist = arg:match("(%d+)")
        drawdist = tonumber(drawdist)
        if ini.settings.givemedist then
            if type(drawdist) ~= 'number' or drawdist > 3600 or drawdist < 35 then
                sampAddChatMessage(script_name.." {FFFFFF}Используйте: {dc4747}/dd [35-3600]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Текущий параметр: {dc4747}"..ini.settings.drawdist, 0x73b461)
            else
                ini.settings.drawdist = drawdist
                save()
                memory.setfloat(12044272, ini.settings.drawdist, false)
                sampAddChatMessage(script_name.." {FFFFFF}Установлена дальность прорисовки: {dc4747}"..ini.settings.drawdist, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}У вас выключена возможность менять прорисовку, включите её: {dc4747}/givemedist", 0x73b461)
        end
    end)
    sampSetClientCommandDescription("dd", "Изменить основную дальность прорисовки")
    sampRegisterChatCommand("ddair", function(arg)
        local drawdistair = arg:match("(%d+)")
        drawdistair = tonumber(drawdistair)
        if ini.settings.givemedist then
            if type(drawdistair) ~= 'number' or drawdistair > 3600 or drawdistair < 35 then
                sampAddChatMessage(script_name.." {FFFFFF}Используйте: {dc4747}/ddair [35-3600]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Текущий параметр: {dc4747}"..ini.settings.drawdistair, 0x73b461)
            else
                ini.settings.drawdistair = drawdistair
                save()
                memory.setfloat(12044272, ini.settings.drawdistair, false)
                sampAddChatMessage(script_name.." {FFFFFF}Дальность прорисовки в воздушном транспорте установлена на: {dc4747}"..ini.settings.drawdistair, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}У вас выключена возможность менять прорисовку, включите её: {dc4747}/givemedist", 0x73b461)
        end
    end)
    sampSetClientCommandDescription("ddair", "Изменить дальность прорисовки в воздушном транспорте")
    sampRegisterChatCommand("fdd", function(arg)
        local fogdist = arg:match("(%d+)")
        fogdist = tonumber(fogdist)
        if ini.settings.givemedist then
            if type(fogdist) ~= 'number' or fogdist > 1000 or fogdist < -1000 then
                sampAddChatMessage(script_name.." {FFFFFF}Используйте: {dc4747}/fdd [0-1000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Текущий параметр: {dc4747}"..ini.settings.fog, 0x73b461)
            else
                ini.settings.fog = fogdist
                save()
                memory.setfloat(13210352, ini.settings.fog, false)
                sampAddChatMessage(script_name.." {FFFFFF}Установлена дальность тумана: {dc4747}"..ini.settings.fog, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}У вас выключена возможность менять прорисовку, включите её: {dc4747}/givemedist", 0x73b461)
        end
    end)
    sampSetClientCommandDescription("fdd", "Изменить дальность тумана")
    sampRegisterChatCommand("ldist", function(arg)
        local lodd = arg:match("(%d+)")
        lodd = tonumber(lodd)
        if ini.settings.givemedist then
            if type(lodd) ~= 'number' or lodd > 1000 or lodd < 0 then
                sampAddChatMessage(script_name.." {FFFFFF}Используйте: {dc4747}/ldist [0-1000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Текущий параметр: {dc4747}"..ini.settings.lod, 0x73b461)
            else
                ini.settings.lod = lodd
                save()
                memory.setfloat(8753112, ini.settings.lod, false)
                sampAddChatMessage(script_name.." {FFFFFF}Установлена дальность лодов: {dc4747}"..ini.settings.lod, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}У вас выключена возможность менять прорисовку, включите её: {dc4747}/givemedist", 0x73b461)
        end
    end)
    sampSetClientCommandDescription("ldist", "Изменить дальность лодов")
    while true do
        wait(0)
        if ini.settings.givemedist then
            if isCharInAnyPlane(PLAYER_PED) or isCharInAnyHeli(PLAYER_PED) then --airveh dist
                if memory.getfloat(12044272, false) ~= ini.settings.drawdistair then
                    memory.setfloat(12044272, ini.settings.drawdistair, false)
                end
            else
                if memory.getfloat(12044272, false) ~= ini.settings.drawdist then
                    memory.setfloat(12044272, ini.settings.drawdist, false)
                end
            end

            --if memory.getfloat(13210352, false) >= memory.getfloat(12044272, false) then --fix bug dist
            --    memory.setfloat(13210352, ini.settings.drawdist - 1.0, false)
            --    ini.settings.fog = ini.settings.drawdist - 1.0
            --    save()
            --end
        end
    end
end

function ChangeDist()
    if ini.settings.givemedist then
        ---------------return original bytes-------
        memory.hex2bin("8B0DF0C4B700", 0x53EA93, 6)
        memory.hex2bin("DEC1D95E54", 0x55FCD9, 5)
        -----------------------------------------------------
        memory.write(5499541, 12044272, 4, false)-- вкл
        memory.write(8381985, 13213544, 4, false)-- вкл
		----------------------------------------------
		memory.setfloat(13210352, ini.settings.fog, false)
		memory.setfloat(12044272, ini.settings.drawdist, false)
		memory.setfloat(8753112, ini.settings.lod, false)
		
    else
        memory.write(5499541, 12043504, 4, false)-- выкл
        memory.write(8381985, 13210352, 4, false)-- выкл
    end
end