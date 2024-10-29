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
IniRead, RunDedCockKramRSC, %iniFile%, Settings, RunDedCockKramRSC, 1
if !RunDedCockKramRSC
Exitapp


#include %A_ScriptDir%\data\offsets.ahk
#include %A_ScriptDir%\data\classMemory.ahk

Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico

Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray, add, RCS, MetkaMenu3
Menu,Tray, Disable, RCS
Menu,Tray, Icon, RCS, shell32.dll,264, 16
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
WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
SetFormat, float, 2.20

vecPunchAngleOld = 0
Loop
{
	Sleep 1
	LocalPlayer := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0) ;мы в игре, а не в лобби?
	if !(LocalPlayer)
	Goto StartLabelStart
	pitch := 0
	yaw := 0
	;==============Локальный игрок
	ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
	pawnHandle1 := 1337flex.Read(ControllerBase1 + offsets.m_hPawn,"int")
	listEntry1 := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle1 & 0x7FFF) >> 0x9) + 0x10, 0x0)
	Pawn1 := 1337flex.getAddressFromOffsets(listEntry1 + 0x78 * (pawnHandle1 & 0x1FF), 0x0)

	pitch := 1337flex.Read(baseAddress + CCameraManager + 0x28, "Float", 0x44)
	vecPunchAngle := 1337flex.Read(Pawn1 + offsets.m_pCameraServices, "Float", offsets.m_vecPunchAngle) 	;RCS
	vecPunchAngleOld := vecPunchAngle - vecPunchAngleOld
	if (vecPunchAngle < 0)
	{
		1337flex.write(baseAddress + CCameraManager + 0x28, pitch - vecPunchAngleOld, "Float", 0x44) 		;вертикаль
		vecPunchAngleOld := vecPunchAngle
	}
	else
	{
		vecPunchAngleOld = 0
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
