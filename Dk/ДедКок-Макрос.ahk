key_jump := "C"
#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
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
Hotkey, IfWinActive, ahk_exe project8.exe
Hotkey, *~$%key_jump%, JumpAction
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

JumpAction:
Sleep 1
SendInput {vkA0}   ; Shift
Sleep 330
SendInput {vk20}   ; Space
Sleep 1
SendInput {vkA2 down}
KeyWait %key_jump%
SendInput {vkA2 up}
return


MetkaMenu3:
Run, notepad.exe "%A_ScriptFullPath%"
return

*~$Home::
MetkaMenu2:
Reload
return

*~$End::
MetkaMenu1:
ExitApp
return