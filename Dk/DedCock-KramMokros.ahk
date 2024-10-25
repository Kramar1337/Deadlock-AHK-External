#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen
CommandLine := DllCall("GetCommandLine", "Str")
If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
	Try {
		If (A_IsCompiled) {
			Run *RunAs "%A_ScriptFullPath%" /restart
		} Else {
			Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
		}
	}
	ExitApp
}


IniFile := A_ScriptDir "\data\config.ini"
IniRead, key_jump, %iniFile%, Settings, key_jump, C
IniRead, key_crouch, %iniFile%, Settings, key_crouch, Ctrl
IniRead, key_activereload, %iniFile%, Settings, key_activereload, R

IniRead, PColor, %iniFile%, Settings, PColor, 0x7BF06B
IniRead, PColVn, %iniFile%, Settings, PColVn, 30
IniRead, AAcord, %iniFile%, Settings, AAcord, 1
IniRead, MouseX, %iniFile%, Settings, MouseX, 100
IniRead, MouseY, %iniFile%, Settings, MouseY, 100

IniRead, RunDedCockKramMokros, %iniFile%, Settings, RunDedCockKramMokros, 1
if !RunDedCockKramMokros
Exitapp

Hotkey, IfWinActive, ahk_exe project8.exe
Hotkey, *~$%key_jump%, JumpAction
Hotkey, *~$%key_crouch%, CrouchAction
Hotkey, *~$%key_activereload%, Activereload
Hotkey, IfWinActive
Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray, add, Macros, MetkaMenu3
Menu,Tray, Disable, Macros
Menu,Tray, Icon, Macros, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Edit Config, MetkaMenu3
Menu,Tray, Icon, Edit Config, imageres.dll, 247, 16
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16
return



Activereload:
Sleep 200
while (GetKeyState(key_activereload, "P"))
{
	if AAcord
	{
	MouseX := Round(A_ScreenWidth * (1280 / 2560))
	MouseY := Round(A_ScreenHeight * (780 / 1440))
	}
	PixelSearch,,, MouseX, MouseY, MouseX+1, MouseY+1, PColor, PColVn, Fast RGB
	if ErrorLevel = 0
    {
		SendInput {vk52}
		Sleep 50
    }
}
return



CrouchAction:
Sleep 1
while (GetKeyState(key_crouch, "P"))
{
	Sleep 1
	SendInput {vkA2 down} 	;Ctrl
	Sleep 10
	SendInput {vkA2 up} 	;Ctrl
}
return


JumpAction:
Sleep 1
SendInput {vkA0}   ; Shift
Sleep 350
SendInput {vk20}   ; Space
Sleep 1
SendInput {vkA2 down}
KeyWait %key_jump%
SendInput {vkA2 up}
return


;============================Функция: есть курсор мышки - 1, нет курсора - 0
FuncCursorVisible()
{
	StructSize1337 := A_PtrSize + 16
	VarSetCapacity(InfoStruct1337, StructSize1337)
	NumPut(StructSize1337, InfoStruct1337)
	DllCall("GetCursorInfo", UInt, &InfoStruct1337)
	Result1337 := NumGet(InfoStruct1337, 8)
	if (Result1337 <> 0)
		CursorVisible := 1
	Else
		CursorVisible := 0
	Return CursorVisible
}


MetkaMenu3:
Run, notepad.exe "%IniFile%"
return

*~$Home::
MetkaMenu2:
Reload
return

*~$End::
MetkaMenu1:
ExitApp
return