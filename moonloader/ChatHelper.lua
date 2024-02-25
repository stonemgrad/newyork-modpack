script_name("ChatHelper")
script_description("/chathelper - on/off and config.")
script_version("1.0")
script_version_number(1)
script_author("{FF5F5F}teekyuu and DarkPixel")
script_dependencies("SAMPFUNCS, SAMP")

local ffi = require("ffi")
ffi.cdef[[
	short GetKeyState(int nVirtKey);
	bool GetKeyboardLayoutNameA(char* pwszKLID);
	int GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);
]]
local BuffSize = 32
local KeyboardLayoutName = ffi.new("char[?]", BuffSize)
local LocalInfo = ffi.new("char[?]", BuffSize)

chathelper = true
FontName = "Font Awesome 5 Free Solid"
FontSize = 11.5
FontFlag = 13
--[[
FontName - Имя шрифта
FontSize - Размер шрифта
FontFlag - Флаг шрифта
Флаги текста (объединяются путем сложения)
0	Текст без особенностей
1	Жирный текст
2	Наклонный текст
3   Наклонный и жирный текст
4	Обводка текста
8	Тень текста
16	Подчеркнутый текст
32	Зачеркнутый текст
]]

function main()
  while not isSampAvailable() do
    wait(1000)
  end
  sampRegisterChatCommand("chathelper", cmd)
  font = renderCreateFont(--[[string]] FontName, --[[int]] FontSize, --[[int]] FontFlag)
  func()
end

function func()
  repeat
    wait(0)
    chat = sampIsChatInputActive()
    if chat == true and chathelper == true then
      in1 = sampGetInputInfoPtr()
      in1 = getStructElement(in1, 0x8, 4)
      in2 = getStructElement(--[[int]] in1, --[[int]] 0x8, --[[int]] 4)
      in3 = getStructElement(--[[int]] in1, --[[int]] 0xC, --[[int]] 4)
      fib = in3 + 42
      fib2 = in2 + 0
      _, pID = sampGetPlayerIdByCharHandle(playerPed)
      name = sampGetPlayerNickname(--[[int]] pID)
	  color = sampGetPlayerColor(--[[int]] pID)
	  capsState = ffi.C.GetKeyState(20)
	  numState = ffi.C.GetKeyState(144)
	  success = ffi.C.GetKeyboardLayoutNameA(KeyboardLayoutName)
	  errorCode = ffi.C.GetLocaleInfoA(tonumber(ffi.string(KeyboardLayoutName), 16), 0x00000002, LocalInfo, BuffSize)
	  localName = ffi.string(LocalInfo)
      --text = string.format("Ваш ID: {41303a}%d {ffffff}| Ваш Ник: {41303a}%s", pID, score, ping, name)
	  text = string.format(
		"{ffffff}[%s]{ffffff} > {%0.6x}{aac3e4}%s{ffffff}{aac3e4}(%d) {ffffff}| Num: %s | Caps: %s | {e89360}%s{ffffff}",
		os.date("%H:%M:%S"), bit.band(color,0xffffff), name, pID, getStrByState(numState), getStrByState(capsState), localName
	  )
      renderFontDrawText(--[[int]] font, --[[string]] text, --[[int]] fib2, --[[int]] fib, --[[int]] -1)
      end
  until false
end

function getStrByState(keyState)
	if keyState == 0 then
		return "{bb3d5a}OFF{ffffff}"
	end
	return "{45974c}ON{ffffff}"
end

function getStrByPing(ping)
	if ping < 100 then
		return string.format("{45974c}%d{ffffff}", ping)
	elseif ping < 150 then
		return string.format("{becfc5}%d{ffffff}", ping)
	end
	return string.format("{BF0000}%d{ffffff}", ping)
end

function cmd()
  if chathelper == true then
    chathelper = false
    sampfuncsLog("* ChatHelper выключен!")
  else
    chathelper = true
    sampfuncsLog("* ChatHelper включен!")
  end
end
