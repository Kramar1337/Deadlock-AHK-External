#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
SetBatchLines, -1

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
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

IniFile := A_ScriptDir "\data\config.ini"
IniRead, key_SpeedBoost, %iniFile%, Settings, key_SpeedBoost, XButton1
IniRead, RunDedCockKramSpuudBest, %iniFile%, Settings, RunDedCockKramSpuudBest, 1
if !RunDedCockKramSpuudBest
Exitapp


#include %A_ScriptDir%\data\offsets.ahk
#include %A_ScriptDir%\data\classMemory.ahk

Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico

Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray, add, SpeedBoost, MetkaMenu3
Menu,Tray, Disable, SpeedBoost
Menu,Tray, Icon, SpeedBoost, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Edit Config, MetkaMenu3
Menu,Tray, Icon, Edit Config, imageres.dll, 247, 16
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

gameEXE:= "ahk_exe project8.exe"
gameDLL:= "client.dll"
Toggler1 := false
Toogler2 := false

StartLabelStart:
sleep 500
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
if baseAddress
{
if (!Toggler1) 
{
#include %A_ScriptDir%\data\offsetsdump.ahk
Toggler1 := true
}
}

SetFormat, float, 2.20
vecPunchAngleOld = 0
Loop
{
	Sleep 50
	LocalPlayer := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0) ;мы в игре, а не в лобби?
	if !(LocalPlayer)
	Goto StartLabelStart
	;==============Локальный игрок
	ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
	pawnHandle1 := 1337flex.Read(ControllerBase1 + offsets.m_hPawn,"int")
	listEntry1 := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle1 & 0x7FFF) >> 0x9) + 0x10, 0x0)
	Pawn1 := 1337flex.getAddressFromOffsets(listEntry1 + 0x78 * (pawnHandle1 & 0x1FF), 0x0)

	pitch := 1337flex.Read(baseAddress + CCameraManager + 0x28, "Float", 0x38 + 0xC + 0x4)
	if GetKeyState(key_SpeedBoost, "P")
	{
		Toogler2:=true
		1337flex.write(Pawn1 + offsets.m_angLockedEyeAngles, "90", "Float")
		1337flex.write(Pawn1 + offsets.m_angLockedEyeAngles + 0x4, pitch, "Float")
		1337flex.write(Pawn1 + offsets.m_angLockedEyeAngles + 0x8, "90", "Float")

	}
	else if(Toogler2)
	{
		Toogler2:=false
		1337flex.write(Pawn1 + offsets.m_angLockedEyeAngles, "16384", "Float")
		1337flex.write(Pawn1 + offsets.m_angLockedEyeAngles + 0x4, "16384", "Float")
		1337flex.write(Pawn1 + offsets.m_angLockedEyeAngles + 0x8, "16384", "Float")
	}
}




AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"




HexFormat(address) {
    hexAddress := Format("{:X}", address)
    Clipboard := hexAddress
    return hexAddress
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
