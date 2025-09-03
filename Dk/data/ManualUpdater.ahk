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
IniFile := A_ScriptDir "\config.ini"
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"
#include %A_ScriptDir%\offsets.ahk
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"
#include %A_ScriptDir%\classMemory.ahk
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"
#include %A_ScriptDir%\ShinsOverlayClass.ahk

bone64 = 64
HeroArray := {}
#include %A_ScriptDir%\HeroArray.ahk
Menu,Tray, Icon, %A_ScriptDir%\icon.ico
Menu,Tray, NoStandard
Menu,Tray, DeleteAll
Menu,Tray, add, ManualUpdater, MetkaMenu3
Menu,Tray, Disable, ManualUpdater
Menu,Tray, Icon, ManualUpdater, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Edit Config, MetkaMenu3
Menu,Tray, Icon, Edit Config, imageres.dll, 247, 16
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16
gameEXE:= "ahk_exe deadlock.exe"
gameDLL:= "client.dll"
Gui, 1: new, +hwndNewGuiID
game := new ShinsOverlayClass(0,0,A_ScreenWidth,A_ScreenHeight, "1", "1", "1",, NewGuiID)



Gui, 2: -MaximizeBox -DPIScale
Gui, 2: Add, Tab3, x0 y0 w380 h149, Update offsets.ahk|Debugging|Command line
Gui, 2: Tab, 1
Gui, 2: Add, GroupBox, x8 y24 w176 h50, Онлайн дампер
Gui, 2: Add, Link, x16 y48 w77 h20, <a href="https://a2x.github.io/cs2-analyzer/">CS2-Analyzer</a>
Gui, 2: Add, Button, gLgetClientdll x96 y40 w80 h23, Open client.dll
Gui, 2: Add, GroupBox, x8 y80 w176 h58, Оффлайн дампер
Gui, 2: Add, Link, x16 y112 w75 h23, <a href="https://github.com/neverlosecc/source2gen">Source2gen</a>
Gui, 2: Add, Link, x200 y48 w76 h20, <a href="https://github.com/ouwou/source2sdk-deadlock">SdkDeadlock</a>
Gui, 2: Add, GroupBox, x192 y24 w176 h50, Онлайн автообновление
Gui, 2: Add, Button, gLGuideoff x96 y104 w40 h23, Guide
Gui, 2: Add, Button, gMnlUp x136 y104 w40 h23, MnlUp
Gui, 2: Add, Button, gUpOffsets x280 y40 w80 h23, AutoUp
Gui, 2: Add, GroupBox, x192 y80 w176 h58, Ручной поиск
Gui, 2: Add, Link, x296 y112 w66 h20, <a href="https://github.com/search?q=m_flUltimateCooldownEnd&type=code">Github</a>
Gui, 2: Add, Link, x200 y112 w80 h20, <a href="https://www.unknowncheats.me/forum/deadlock/639185-deadlock-reversal-structs-offsets.html">Unknowncheats</a>
Gui, 2: Tab, 2
Gui, 2: Add, Button, gLgetController x8 y32 w80 h23, Pl Controller
Gui, 2: Add, Button, gLgetPawn x8 y64 w80 h23, Player Pawn
Gui, 2: Add, Button, gLgetEntityList x8 y96 w80 h23, EntityList Out
Gui, 2: Add, Button, gLBoneDbgStart x104 y32 w80 h23, Start BoneDbg
Gui, 2: Add, Button, gLBoneDbgEnd x104 y64 w80 h23, End BoneDbg
Gui, 2: Add, Button, gLHeroAndBoneOpen x104 y96 w80 h23, HeroAndBone
Gui, 2: Add, Button, gLoffsetsahk x200 y32 w80 h23, Offsets.ahk
Gui, 2: Add, Button, gLoffsetsdumpahk x200 y64 w80 h23, OffDump.ahk
Gui, 2: Tab, 3
Gui, 2: Add, Edit, vCparam1 x8 y32 w255 h21 +ReadOnly, -insecure -console -novid
Gui, 2: Add, Edit, vCparam2 x8 y64 w255 h21 +ReadOnly, -console -novid -dx11 -m_rawinput 1 +exec autoexec.cfg -high -preload +@panorama_min_comp_layer_cache_cost_TURNED_OFF 256
Gui, 2: Add, Button, gLCopy1 x272 y32 w80 h23, Copy
Gui, 2: Add, Button, gLCopy2 x272 y64 w80 h23, Copy
Gui, 2: Add, Edit, x8 y96 w255 h45 +ReadOnly, map street_test`nexec citadel_botmatch_practice_6v6_hard.cfg`nsv_cheats 1`ncitadel_hero_testing_enabled 1`ncitadel_hero_testing_infinite_money`ntrooper_kill_all`nhost_timescale 1`ncl_ent_actornames`n`nВсе консольные команды DEADLOCK`nhttps://steamcommunity.com/sharedfiles/filedetails/?id=3317893255
Gui, 2: Tab
randomName := GenerateRandomName(15)
Gui, 2: Show, w376 h148, %randomName%


IniRead, URLDeadlockSdk, %iniFile%, Settings, URLDeadlockSdk, 0
return



; C_BaseCombatCharacter
; static m_pObserverServices = 0xD80
; CPlayerPawnComponent
; static m_hObserverTarget = 0x44







LBoneDbgEnd:
BoneDbgBool = 0
return

LBoneDbgStart:
BoneDbgBool = 1
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
if baseAddress
{
Gosub Loffsetsdump
}

VarStart_time = 0
While (BoneDbgBool)
{
	Sleep 1
	game.BeginDraw()
	j=0
	ViewMatrix:=Array()
	while(j<16)
	{
		ViewMatrix.Push(1337flex.Read(baseAddress + dwViewMatrix + (j * 0x4),"float"))
		j++
	}
	VarElapsed_time := A_TickCount - VarStart_time
	if (VarElapsed_time > ReloadTime) ;3000
	{
		LocalPlayer := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
		if !(LocalPlayer)
		{
			game.EndDraw()
			break
		}
		playerIndex=0
		BubaArrayPawn := []
		BubaArrayEntity := []
		while(playerIndex < 64)
		{
			;==============Энтити лист
			EntityList := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
			AddressBase := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
			ControllerBase := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
			pawnHandle := 1337flex.Read(ControllerBase + offsets.m_hPawn,"int")
			listEntry := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle & 0x7FFF) >> 0x9) + 0x10, 0x0)
			PawnGet := 1337flex.getAddressFromOffsets(listEntry + 0x78 * (pawnHandle & 0x1FF), 0x0)
			Health := 1337flex.Read(ControllerBase + offsets.m_PlayerDataGlobal + offsets.m_iHealth,"int")
			if Health
			{
			BubaArrayEntity.push(ControllerBase)
			BubaArrayPawn.push(PawnGet)
			}
			playerIndex++
		}
		ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
		pawnHandle1 := 1337flex.Read(ControllerBase1 + offsets.m_hPawn,"int")
		listEntry1 := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle1 & 0x7FFF) >> 0x9) + 0x10, 0x0)
		Pawn1 := 1337flex.getAddressFromOffsets(listEntry1 + 0x78 * (pawnHandle1 & 0x1FF), 0x0)
		GameSceneNode1 := 1337flex.getAddressFromOffsets(Pawn1 + offsets.m_pGameSceneNode, 0x0)
		VarStart_time := A_TickCount
	}
	WinGetPos, windowX, windowY, windowWidth, windowHeight, ahk_exe deadlock.exe
	Kramindex := 0
	playerIndexGet := 0 	;Удалить
	while Kramindex < BubaArrayEntity.length()
	{
	Kramindex++
	ControllerBaseEntity := BubaArrayEntity[Kramindex]
	Pawn := BubaArrayPawn[Kramindex]
	bAlive := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_bAlive,"int")
	iHealth := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_iHealth,"int")
	HeroID := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_nHeroID,"int")
	if (bAlive = 1 && iHealth > 0)
	{
	GameSceneNode := 1337flex.getAddressFromOffsets(Pawn + offsets.m_pGameSceneNode, 0x0)
	enemyXLocation := 1337flex.Read(GameSceneNode + offsets.m_vecAbsOrigin,"float")
	enemyYLocation := 1337flex.Read(GameSceneNode + offsets.m_vecAbsOrigin+0x4,"float")
	enemyZLocation := 1337flex.Read(GameSceneNode + offsets.m_vecAbsOrigin+0x8,"float")
	BoneArray := 1337flex.getAddressFromOffsets(GameSceneNode + Offsets.m_modelState + 0x80, 0x0)
	i := 0
	while (i < bone64)
	{
		BoneXLocation := 1337flex.Read(BoneArray + i * 32, "float")
		BoneYLocation := 1337flex.Read(BoneArray + i * 32+0x4, "float")
		BoneZLocation := 1337flex.Read(BoneArray + i * 32+0x8, "float")
		arr:=WorldToScreen(BoneXLocation,BoneYLocation,BoneZLocation,windowWidth,windowHeight)
		xpos1:=arr[1]
		ypos1:=arr[2]
		game.DrawText(i, xpos1, ypos1, "10", "0x00FFFFFF", "Arial", "dsFF000000 dsx1 dsy1 olFF000000")
		i++
	}
		if (arr := WorldToScreen(enemyXLocation, enemyYLocation, enemyZLocation, windowWidth, windowHeight))
		{
		xpos1 := arr[1] + windowX ; Учитываем позицию окна по оси X
		ypos1 := arr[2] + windowY ; Учитываем позицию окна по оси Y
		arr2 := WorldToScreen(enemyXLocation, enemyYLocation, enemyZLocation + 75, windowWidth, windowHeight)
		xpos2 := arr2[1] + windowX
		ypos2 := arr2[2] + windowY
	
		ESPheight := (ypos1 - ypos2) * 1.3  ; Регулируемая высота
		ESPwidth := ESPheight / 2.6            ; Пропорциональная ширина
		extraOptions2 := "w80 h80 aCenter dsFF000000 dsx1 dsy1 olFF000000"
		xDrawText := xpos1 - (ESPwidth / 2) + (ESPwidth / 2) - 80 / 2
		yDrawText := ypos1 - ESPheight + ESPheight
		game.DrawText(HeroArray[HeroID].name "`n" HeroID " ID", xDrawText, yDrawText, "14", "0x00FF0000", "Arial", extraOptions2)
		}
	}
	}
	game.EndDraw()
}
game.BeginDraw()
game.EndDraw()
return


WorldToScreen(posx,posy,posz,windowWidth,windowHeight)
{
	global
    clipCoordsx := posx*ViewMatrix[1] + posy*ViewMatrix[2] + posz*ViewMatrix[3] + ViewMatrix[4]
    clipCoordsy := posx*ViewMatrix[5] + posy*ViewMatrix[6] + posz*ViewMatrix[7] + ViewMatrix[8]
    clipCoordsz := posx*ViewMatrix[9] + posy*ViewMatrix[10] + posz*ViewMatrix[11] + ViewMatrix[12]
    clipCoordsw := posx*ViewMatrix[13] + posy*ViewMatrix[14] + posz*ViewMatrix[15] + ViewMatrix[16]
    if (clipCoordsw < 1)
        return false
    NDCx := clipCoordsx / clipCoordsw
    NDCy := clipCoordsy / clipCoordsw
    NDCz := clipCoordsz / clipCoordsw
    x := (windowWidth / 2 * NDCx) + (NDCx + windowWidth / 2)
    y := -(windowHeight / 2 * NDCy) + (NDCy + windowHeight / 2)
	coords:=array(x,y)
    return coords
}



;=======================Copy
LCopy1:
Gui, 2: Submit, Nohide
Clipboard := Cparam1
return
LCopy2:
Gui, 2: Submit, Nohide
Clipboard := Cparam2
return

;=======================offsetsdump
Loffsetsdump:
#include %A_ScriptDir%\offsetsdump.ahk
return

;=======================offsetsdump.ahk
Loffsetsdumpahk:
Run, notepad.exe "%A_ScriptDir%\offsetsdump.ahk"
return

;=======================offsets.ahk
Loffsetsahk:
Run, notepad.exe "%A_ScriptDir%\offsets.ahk"
return

;=======================HeroAndBone
LHeroAndBoneOpen:
Run, notepad.exe "%A_ScriptDir%\HeroArray.ahk"
return

;=======================Player Pawn
LgetPawn:
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
if baseAddress
{
Gosub Loffsetsdump
}
playerIndex=0
while(playerIndex < 64)
{
	EntityList := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
	AddressBase := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
	ControllerBase := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
	pawnHandle := 1337flex.Read(ControllerBase + offsets.m_hPawn,"int")
	listEntry := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle & 0x7FFF) >> 0x9) + 0x10, 0x0)
	PawnGet := 1337flex.getAddressFromOffsets(listEntry + 0x78 * (pawnHandle & 0x1FF), 0x0)
	Health := 1337flex.Read(ControllerBase + offsets.m_PlayerDataGlobal + offsets.m_iHealth,"int")
	if Health
	{
	msgbox % HexFormat(PawnGet)
	break
	}
	playerIndex++
}
soundbeep
return

;=======================Pl Controller
LgetController:
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
if baseAddress
{
Gosub Loffsetsdump
}
playerIndex=0
while(playerIndex < 64)
{
	EntityList := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
	AddressBase := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
	ControllerBase := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
	pawnHandle := 1337flex.Read(ControllerBase + offsets.m_hPawn,"int")
	listEntry := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle & 0x7FFF) >> 0x9) + 0x10, 0x0)
	PawnGet := 1337flex.getAddressFromOffsets(listEntry + 0x78 * (pawnHandle & 0x1FF), 0x0)
	Health := 1337flex.Read(ControllerBase + offsets.m_PlayerDataGlobal + offsets.m_iHealth,"int")
	if Health
	{
	msgbox % HexFormat(ControllerBase)
	break
	}
	playerIndex++
}
soundbeep
return

;===========================EntityList Out
LgetEntityList:
FileDelete, %A_ScriptDir%\EntityListOutput.txt
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
if baseAddress
{
Gosub Loffsetsdump
}
ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
myHealth := 1337flex.Read(ControllerBase1 + offsets.m_PlayerDataGlobal + offsets.m_iHealth,"int")
if !myHealth
{
MsgBox,,, Оффсеты устарели или ты не в песочнице, 3
return
}
EntityListCout := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
EntityListCout := 1337flex.Read(EntityListCout + dwGameEntitySystem_highestEntityIndex,"int")
EntityListCout=1024
playerIndex=0
while(playerIndex < EntityListCout + 1)
{
	EntityList := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
	AddressBase := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
	ControllerBase := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
	pawnHandle := 1337flex.Read(ControllerBase + offsets.m_hPawn,"int")
	listEntry := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle & 0x7FFF) >> 0x9) + 0x10, 0x0)
	PawnGet := 1337flex.getAddressFromOffsets(listEntry + 0x78 * (pawnHandle & 0x1FF), 0x0)

	pEntityString := 1337flex.readString(ControllerBase + offsets.m_pEntity,, "utf-8", 0x8, 0x30, 0x8, 0x0)
	designerName := 1337flex.readString(ControllerBase + offsets.m_pEntity,, "utf-8", offsets.m_designerName, 0x0)
	if designerName
	{
	ControllerBaseVar:=HexFormatNoClipboard(ControllerBase)
	PawnGetVar:=HexFormatNoClipboard(PawnGet)
	FileAppend, Index - %playerIndex%`n%pEntityString%`n%designerName%`n%ControllerBaseVar%`n%PawnGetVar%`n--------`n, EntityListOutput.txt
	}
	playerIndex++
}
Run, notepad.exe "%A_ScriptDir%\EntityListOutput.txt"
soundbeep
return

;======================Guide
LGuideoff:
VarLGuideoff=
(
1. Скачать Репозиторий
https://github.com/neverlosecc/source2gen

2. Установить:
Visual Studio 2019 or newer
CMake

3. Команды для сборки source2gen в CMD
cd C:\Dk\source2gen-main
cmake -B build -DCMAKE_BUILD_TYPE=Release -DSOURCE2GEN_GAME=DEADLOCK
cmake --build build

4. Запустить source2gen-main\build\bin\Debug\source2gen-loader.exe

5. Нажать "MnlUp" и указать путь к "source2sdk"
)
Clipboard := VarLGuideoff
MsgBox, Скопировано в буфер обмена`n%VarLGuideoff%
return




;======================Open client.dll
LgetClientdll:
processName := "deadlock.exe"
filePath := GetProcessPath(processName)
if (filePath) 
{
	StringReplace, filePath, filePath, bin\win64\%processName%, citadel\bin\win64, All
    Run, %filePath%
} 
else 
{
    MsgBox, Процесс "%processName%" не найден!
}
return

;======================MnlUp
MnlUp:
MsgBox 0x1, ,Ручное обновление оффсетов из дампера
IfMsgBox OK, {
} Else IfMsgBox Cancel, {
Return
}
LocalDeadlockSdk = %A_ScriptDir%\Dumper\sdk\include\source2sdk
InputBox, UserInput2, Open, Путь к папке с оффсетами например "C:\Dk\source2gen-main\build\bin\Debug\sdk\include\source2sdk",,700,150,,,,, %LocalDeadlockSdk%
if ErrorLevel or UserInput2 = ""
return
FileCreateDir, %A_ScriptDir%\TempFlex
FileCopy, % LocalDeadlockSdk "/client/C_BasePlayerPawn.hpp", % A_ScriptDir "\TempFlex\C_BasePlayerPawn.hpp"
FileCopy, % LocalDeadlockSdk "/client/CPlayer_CameraServices.hpp", % A_ScriptDir "\TempFlex\CPlayer_CameraServices.hpp"
FileCopy, % LocalDeadlockSdk "/entity2/CEntityInstance.hpp", % A_ScriptDir "\TempFlex\CEntityInstance.hpp"
FileCopy, % LocalDeadlockSdk "/entity2/CEntityIdentity.hpp", % A_ScriptDir "\TempFlex\CEntityIdentity.hpp"
FileCopy, % LocalDeadlockSdk "/client/CGameSceneNode.hpp", % A_ScriptDir "\TempFlex\CGameSceneNode.hpp"
FileCopy, % LocalDeadlockSdk "/client/C_BaseEntity.hpp", % A_ScriptDir "\TempFlex\C_BaseEntity.hpp"
FileCopy, % LocalDeadlockSdk "/client/CBasePlayerController.hpp", % A_ScriptDir "\TempFlex\CBasePlayerController.hpp"
FileCopy, % LocalDeadlockSdk "/client/CSkeletonInstance.hpp", % A_ScriptDir "\TempFlex\CSkeletonInstance.hpp"
FileCopy, % LocalDeadlockSdk "/client/CModelState.hpp", % A_ScriptDir "\TempFlex\CModelState.hpp"
FileCopy, % LocalDeadlockSdk "/client/CCitadelPlayerController.hpp", % A_ScriptDir "\TempFlex\CCitadelPlayerController.hpp"
FileCopy, % LocalDeadlockSdk "/client/PlayerDataGlobal_t.hpp", % A_ScriptDir "\TempFlex\PlayerDataGlobal_t.hpp"
FileCopy, % LocalDeadlockSdk "/client/C_GameRules.hpp", % A_ScriptDir "\TempFlex\C_GameRules.hpp"
FileCopy, % LocalDeadlockSdk "/client/C_CitadelPlayerPawn.hpp", % A_ScriptDir "\TempFlex\C_CitadelPlayerPawn.hpp"

combinedResult := ""
combinedResult .= "; C_BasePlayerPawn" . "`n"
combinedResult .= GetKramOffsets("C_BasePlayerPawn.hpp", "m_pCameraServices") . "`n"
combinedResult .= "; CPlayer_CameraServices" . "`n"
combinedResult .= GetKramOffsets("CPlayer_CameraServices.hpp", "m_vecPunchAngle") . "`n"
combinedResult .= "; CEntityInstance" . "`n"
combinedResult .= GetKramOffsets("CEntityInstance.hpp", "m_pEntity") . "`n"
combinedResult .= GetKramOffsets("CEntityIdentity.hpp", "m_designerName") . "`n"
combinedResult .= "; CGameSceneNode" . "`n"
combinedResult .= GetKramOffsets("CGameSceneNode.hpp", "m_vecAbsOrigin") . "`n"
combinedResult .= GetKramOffsets("CGameSceneNode.hpp", "m_bDormant") . "`n"
combinedResult .= "; C_BaseEntity" . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_pGameSceneNode") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_iTeamNum") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_vecVelocity") . "`n"
combinedResult .= "; CBasePlayerController" . "`n"
combinedResult .= GetKramOffsets("CBasePlayerController.hpp", "m_hPawn") . "`n"
combinedResult .= "; CSkeletonInstance" . "`n"
combinedResult .= GetKramOffsets("CSkeletonInstance.hpp", "m_modelState") . "`n"
combinedResult .= "; CModelState" . "`n"
combinedResult .= GetKramOffsets("CModelState.hpp", "m_hModel") . "`n"
combinedResult .= "; CCitadelPlayerController" . "`n"
combinedResult .= GetKramOffsets("CCitadelPlayerController.hpp", "m_PlayerDataGlobal") . "`n"
combinedResult .= "; PlayerDataGlobal_t" . "`n"
combinedResult .= GetKramOffsets2("PlayerDataGlobal_t.hpp", "m_iHealth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iHealthMax") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_bAlive") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_nHeroID") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iGoldNetWorth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iAPNetWorth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_bUltimateTrained") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_flUltimateCooldownEnd") . "`n"
combinedResult .= "; C_GameRules" . "`n"
combinedResult .= GetKramOffsets("C_GameRules.hpp", "m_nTotalPausedTicks") . "`n"
combinedResult .= "; C_CitadelPlayerPawn" . "`n"
combinedResult .= GetKramOffsets("C_CitadelPlayerPawn.hpp", "m_angLockedEyeAngles") . "`n"

Clipboard := combinedResult
Run, notepad.exe "%A_ScriptDir%\offsets.ahk"
WinWait, ahk_exe notepad.exe, , 2
MsgBox, Отправлено в буфер обмена`n`n%combinedResult%

MsgBox 0x1, ,Очистить?`n%A_ScriptDir%\TempFlex
IfMsgBox OK, {
FileRemoveDir, %A_ScriptDir%\TempFlex, 1
} Else IfMsgBox Cancel, {
Return
}


return



;======================AutoUp
UpOffsets:
MsgBox 0x1, ,Ручное обновление оффсетов`nПеред продолжением отключи AV
IfMsgBox OK, {
} Else IfMsgBox Cancel, {
Return
}
InputBox, UserInput, Github, Ссылка на SDK в формате https://raw.githubusercontent.com,,700,150,,,,, %URLDeadlockSdk%
if ErrorLevel or UserInput = ""
return

FileCreateDir, %A_ScriptDir%\TempFlex
; Скачивание файлов
URLDownloadToFile, % URLDeadlockSdk "/client/C_BasePlayerPawn.hpp", %A_ScriptDir%\TempFlex\C_BasePlayerPawn.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CPlayer_CameraServices.hpp", %A_ScriptDir%\TempFlex\CPlayer_CameraServices.hpp
URLDownloadToFile, % URLDeadlockSdk "/entity2/CEntityInstance.hpp", %A_ScriptDir%\TempFlex\CEntityInstance.hpp
URLDownloadToFile, % URLDeadlockSdk "/entity2/CEntityIdentity.hpp", %A_ScriptDir%\TempFlex\CEntityIdentity.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CGameSceneNode.hpp", %A_ScriptDir%\TempFlex\CGameSceneNode.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/C_BaseEntity.hpp", %A_ScriptDir%\TempFlex\C_BaseEntity.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CBasePlayerController.hpp", %A_ScriptDir%\TempFlex\CBasePlayerController.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CSkeletonInstance.hpp", %A_ScriptDir%\TempFlex\CSkeletonInstance.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CModelState.hpp", %A_ScriptDir%\TempFlex\CModelState.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CCitadelPlayerController.hpp", %A_ScriptDir%\TempFlex\CCitadelPlayerController.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/PlayerDataGlobal_t.hpp", %A_ScriptDir%\TempFlex\PlayerDataGlobal_t.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/C_GameRules.hpp", %A_ScriptDir%\TempFlex\C_GameRules.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/C_CitadelPlayerPawn.hpp", %A_ScriptDir%\TempFlex\C_CitadelPlayerPawn.hpp


combinedResult := ""
combinedResult .= "; C_BasePlayerPawn" . "`n"
combinedResult .= GetKramOffsets("C_BasePlayerPawn.hpp", "m_pCameraServices") . "`n"
combinedResult .= "; CPlayer_CameraServices" . "`n"
combinedResult .= GetKramOffsets("CPlayer_CameraServices.hpp", "m_vecPunchAngle") . "`n"
combinedResult .= "; CEntityInstance" . "`n"
combinedResult .= GetKramOffsets("CEntityInstance.hpp", "m_pEntity") . "`n"
combinedResult .= GetKramOffsets("CEntityIdentity.hpp", "m_designerName") . "`n"
combinedResult .= "; CGameSceneNode" . "`n"
combinedResult .= GetKramOffsets("CGameSceneNode.hpp", "m_vecAbsOrigin") . "`n"
combinedResult .= GetKramOffsets("CGameSceneNode.hpp", "m_bDormant") . "`n"
combinedResult .= "; C_BaseEntity" . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_pGameSceneNode") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_iTeamNum") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_vecVelocity") . "`n"
combinedResult .= "; CBasePlayerController" . "`n"
combinedResult .= GetKramOffsets("CBasePlayerController.hpp", "m_hPawn") . "`n"
combinedResult .= "; CSkeletonInstance" . "`n"
combinedResult .= GetKramOffsets("CSkeletonInstance.hpp", "m_modelState") . "`n"
combinedResult .= "; CModelState" . "`n"
combinedResult .= GetKramOffsets("CModelState.hpp", "m_hModel") . "`n"
combinedResult .= "; CCitadelPlayerController" . "`n"
combinedResult .= GetKramOffsets("CCitadelPlayerController.hpp", "m_PlayerDataGlobal") . "`n"
combinedResult .= "; PlayerDataGlobal_t" . "`n"
combinedResult .= GetKramOffsets2("PlayerDataGlobal_t.hpp", "m_iHealth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iHealthMax") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_bAlive") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_nHeroID") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iGoldNetWorth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iAPNetWorth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_bUltimateTrained") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_flUltimateCooldownEnd") . "`n"
combinedResult .= "; C_GameRules" . "`n"
combinedResult .= GetKramOffsets("C_GameRules.hpp", "m_nTotalPausedTicks") . "`n"
combinedResult .= "; C_CitadelPlayerPawn" . "`n"
combinedResult .= GetKramOffsets("C_CitadelPlayerPawn.hpp", "m_angLockedEyeAngles") . "`n"

Clipboard := combinedResult
Run, notepad.exe "%A_ScriptDir%\offsets.ahk"
WinWait, ahk_exe notepad.exe, , 2
MsgBox, Отправлено в буфер обмена`n`n%combinedResult%

MsgBox 0x1, ,Удалить скачанные файлы?
IfMsgBox OK, {
FileRemoveDir, %A_ScriptDir%\TempFlex, 1
} Else IfMsgBox Cancel, {
Return
}
return



GetKramOffsets(fileName, serviceName) {
    FileRead, content, %A_ScriptDir%\TempFlex\%fileName%
    if RegExMatch(content, serviceName . "[^\n]*//.*?0x[a-fA-F0-9]+", match)
	{
	RegExMatch(match, "(0x[a-fA-F0-9]+)[\s\n]*$", match1)
    return "static " . serviceName . " = " . match1
	}
    return ""
}
GetKramOffsets2(fileName, serviceName) {
    FileRead, content, %A_ScriptDir%\TempFlex\%fileName%
    if RegExMatch(content, serviceName . ";[^\n]*//.*?0x[a-fA-F0-9]+", match)
	{
	RegExMatch(match, "(0x[a-fA-F0-9]+)[\s\n]*$", match1)
    return "static " . serviceName . " = " . match1
	}
    return ""
}

; Функция для генерации случайного имени
GenerateRandomName(length) {
    chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    name := ""
    Loop, %length%
    {
        Random, index, 1, StrLen(chars)
        name .= SubStr(chars, index, 1)
    }
    return name
}

AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

GetProcessPath(processName) {
    query := "SELECT ExecutablePath FROM Win32_Process WHERE Name = '" processName "'"
    wmi := ComObjGet("winmgmts:")
    for process in wmi.ExecQuery(query)
        return process.ExecutablePath ; Возвращает путь к файлу процесса, если найден

    return "" ; Возвращает пустую строку, если процесс не найден
}

HexFormatNoClipboard(address) {
    hexAddress := Format("{:X}", address)
    return hexAddress
}
HexFormat(address) {
    hexAddress := Format("{:X}", address)
    Clipboard := hexAddress
    return hexAddress
}

MetkaMenu3:
Run, notepad.exe "%IniFile%"
return
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

*~$Home::
MetkaMenu2:
Reload
return

*~$End::
MetkaMenu1:
ExitApp
return

2GuiEscape:
2GuiClose:
FileDelete, %A_ScriptDir%\EntityListOutput.txt
ExitApp





