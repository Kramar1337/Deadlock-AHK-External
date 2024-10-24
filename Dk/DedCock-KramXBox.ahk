﻿
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
IniFile := A_ScriptDir "\data\config.ini"
IniRead, boxTeam, %iniFile%, Settings, ESPboxTeam, 0
IniRead, boxEnemy, %iniFile%, Settings, ESPboxEnemy, 1
IniRead, SleepCpu, %iniFile%, Settings, ESPSleepCpu, 1
IniRead, boneDBGmode, %iniFile%, Settings, ESPboneDBGmode, 0
IniRead, key_NetWorthShow, %iniFile%, Settings, ESPkey_NetWorthShow, Alt
IniRead, LineOrRectangle, %iniFile%, Settings, LineOrRectangle, 1
IniRead, ESPShowText, %iniFile%, Settings, ESPShowText, 1
IniRead, RunDedCockKramXBox, %iniFile%, Settings, RunDedCockKramXBox, 1
if !RunDedCockKramXBox
Exitapp

AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

#include %A_ScriptDir%\data\offsets.ahk
#include %A_ScriptDir%\data\classMemory.ahk
#include %A_ScriptDir%\data\ShinsOverlayClass.ahk

ImagePathProp = %A_ScriptDir%\data\Crates.png
imageSizeOrigin = 32
imageAlpha = 0.7
textWidth := 20  ; Примерная ширина текста
textHeight := 20  ; Примерная высота текста
extraOptions := "w" . textWidth . " h" . textHeight . " aCenter dsFF000000 dsx1 dsy1 olFF000000"

bone64 = 64

Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico
Menu,Tray, NoStandard
Menu,Tray, DeleteAll
Menu,Tray, add, Esp Box, MetkaMenu3
Menu,Tray, Disable, Esp Box
Menu,Tray, Icon, Esp Box, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Edit Config, MetkaMenu3
Menu,Tray, Icon, Edit Config, imageres.dll, 247, 16
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16


HeroNames := {1: "Infernus", 2: "Seven", 3: "Vindicta", 4: "LadyGeist", 6: "Abrams", 7: "Wraith", 8: "McGinnis", 10: "Paradox", 11: "Dynamo", 12: "Kelvin", 13: "Haze", 14: "Holliday", 15: "Bebop", 17: "GreyTalon", 18: "MoAndKrill", 19: "Shiv", 20: "Ivy", 25: "Warden", 27: "Yamato", 31: "Lash", 35: "Viscous", 48: "Wrecker", 50: "Pocket", 52: "Mirage", 55: "Dummy"}


gameEXE:= "ahk_exe project8.exe"
gameDLL:= "client.dll"

Gui, 1: new, +hwndNewGuiID
game := new ShinsOverlayClass(0,0,A_ScreenWidth,A_ScreenHeight, "1", "1", "1",, NewGuiID)
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

StartLabelStart:
sleep 1300
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
if baseAddress
{
#include %A_ScriptDir%\data\offsetsdump.ahk
}

WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
SetFormat, float, 2.20
VarStart_time = 0
EntityIndex = 64
ReloadTime = 5000
Loop
{
	Sleep %SleepCpu%
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
			Goto StartLabelStart
		}
		playerIndex=0
		BubaArrayPawn := []
		BubaArrayEntity := []
		while(playerIndex < EntityIndex)
		{
			;==============Энтити лист
			EntityList := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
			AddressBase := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
			ControllerBase := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
			pawnHandle := 1337flex.Read(ControllerBase + offsets.m_hPawn,"int")
			listEntry := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle & 0x7FFF) >> 0x9) + 0x10, 0x0)
			PawnGet := 1337flex.getAddressFromOffsets(listEntry + 0x78 * (pawnHandle & 0x1FF), 0x0)
			Health := 1337flex.Read(PawnGet + offsets.m_ihealth,"int")
			if Health
			{
			BubaArrayEntity.push(ControllerBase)
			BubaArrayPawn.push(PawnGet)
			}
			playerIndex++
		}
		;==============Локальный игрок
		ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
		pawnHandle1 := 1337flex.Read(ControllerBase1 + offsets.m_hPawn,"int")
		listEntry1 := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle1 & 0x7FFF) >> 0x9) + 0x10, 0x0)
		Pawn1 := 1337flex.getAddressFromOffsets(listEntry1 + 0x78 * (pawnHandle1 & 0x1FF), 0x0)
		GameSceneNode1 := 1337flex.getAddressFromOffsets(Pawn1 + offsets.m_pGameSceneNode, 0x0)
		VarStart_time := A_TickCount
	}
	Kramindex := 0
	playerIndexGet := 0 	;Удалить
	while Kramindex < BubaArrayEntity.length()
	{
	Kramindex++
	ControllerBaseEntity := BubaArrayEntity[Kramindex]
	Pawn := BubaArrayPawn[Kramindex]
	; msgbox % HexFormat(Pawn)
	; msgbox % HexFormat(ControllerBaseEntity)
	; GameSceneNode := 1337flex.getAddressFromOffsets(Pawn + offsets.m_pGameSceneNode, 0x0)
	; msgbox % HexFormat(GameSceneNode)
	; Dormant2 := 1337flex.Read(GameSceneNode + offsets.m_bDormant,"int")
	; msgbox % HexFormat(GameSceneNode + offsets.m_bDormant)
	
	; GameSceneNode := 1337flex.getAddressFromOffsets(ControllerBaseEntity + offsets.m_pGameSceneNode, 0x0)
	; Dormant2 := 1337flex.Read(GameSceneNode + offsets.m_bDormant,"int")
	; msgbox % HexFormat(GameSceneNode + offsets.m_bDormant)
	
	
	; DormantVar := 1337flex.Read(ControllerBaseEntity + offsets.m_pGameSceneNode, "int", offsets.m_bDormant)
	Dormant2 := 1337flex.Read(ControllerBaseEntity + offsets.m_bDormant2,"int")
	; Dormant2 := 1337flex.Read(ControllerBaseEntity + offsets.m_pGameSceneNode, "int", offsets.m_bDormant)
	; msgbox % DormantVar2
	; msgbox % Dormant2
	; DormantVar := 1337flex.Read(Pawn + offsets.m_lifeState,"int")
	; Health := 1337flex.Read(Pawn + offsets.m_ihealth,"int")
	; bAlive := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_bAlive,"int")
	; iHealthMax := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_iHealthMax,"int")
	; msgbox % iHealthMax
	if (Dormant2 = 1)
	{
		TeamNum := 1337flex.Read(Pawn + offsets.m_iTeamNum,"int")
		if(TeamNum=1 or TeamNum=2 or TeamNum=3)
		{
			Health := 1337flex.Read(Pawn + offsets.m_ihealth,"int")
			MaxHealth := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_iHealthMax,"int")
			; MaxHealth := 1337flex.Read(Pawn + offsets.m_iMaxHealth,"int")
			HeroID := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_nHeroID,"int")
			GameSceneNode := 1337flex.getAddressFromOffsets(Pawn + offsets.m_pGameSceneNode, 0x0)
			; msgbox % HexFormat(Pawn + offsets.m_pGameSceneNode)
			enemyXLocation := 1337flex.Read(GameSceneNode + offsets.m_vecAbsOrigin,"float")
			enemyYLocation := 1337flex.Read(GameSceneNode + offsets.m_vecAbsOrigin+0x4,"float")
			enemyZLocation := 1337flex.Read(GameSceneNode + offsets.m_vecAbsOrigin+0x8,"float")
			if boneDBGmode
			{
				BoneArray := 1337flex.getAddressFromOffsets(GameSceneNode + Offsets.m_modelState + Offsets.m_boneArray, 0x0)
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
			}
			WinGetPos, windowX, windowY, windowWidth, windowHeight, ahk_exe project8.exe
			if (enemyXLocation != 0)
			{
				if (arr := WorldToScreen(enemyXLocation, enemyYLocation, enemyZLocation, windowWidth, windowHeight))
				{
					xpos1 := arr[1] + windowX ; Учитываем позицию окна по оси X
					ypos1 := arr[2] + windowY ; Учитываем позицию окна по оси Y
					arr2 := WorldToScreen(enemyXLocation, enemyYLocation, enemyZLocation + 75, windowWidth, windowHeight)
					xpos2 := arr2[1] + windowX
					ypos2 := arr2[2] + windowY
					dist := getDistance(enemyXLocation, enemyYLocation, enemyZLocation)
					IfWinActive, ahk_exe project8.exe
					{
						if (dist > 1.2)
						{
							MyTeamIs := 1337flex.Read(ControllerBase1 + offsets.m_iTeamNum, "int")
							if (TeamNum == MyTeamIs)
							{
							DrawESP(xpos1, ypos1, xpos2, ypos2, dist, 1)
							}
							else
							{
							myGoldNetWorth := 1337flex.Read(ControllerBase1 + offsets.m_PlayerDataGlobal + offsets.m_iGoldNetWorth,"int")
							myAPNetWorth := 1337flex.Read(ControllerBase1 + offsets.m_PlayerDataGlobal + offsets.m_iAPNetWorth,"int")
							
							GoldNetWorth := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_iGoldNetWorth,"int")
							APNetWorth := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_iAPNetWorth,"int")
							; UltimateTrained := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_bUltimateTrained,"int")
							; UltimateCooldownStart := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_flUltimateCooldownStart,"float")
							; UltimateCooldownEnd := 1337flex.Read(ControllerBaseEntity + offsets.m_PlayerDataGlobal + offsets.m_flUltimateCooldownEnd,"float")
							; TheTime := 1337flex.Read(baseAddress + GlobalVarsBase, "float", 0x0)
							; tooltip %UltimateTrained%`n%UltimateCooldownStart%`n%UltimateCooldownEnd%`n%TheTime%
							DrawESP(xpos1, ypos1, xpos2, ypos2, dist, 0)
							}
						}
					}
				}
			}
		}
	}

	}
	game.EndDraw()
}
return

AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"


DrawESP(x1,y1,x2,y2,distance, team)
{
	global
	if(team)
	{
		if(boxTeam)
		{
		ESPheight := (y1 - y2) * 1.3  ; Регулируемая высота
		ESPwidth := ESPheight / 2.6            ; Пропорциональная ширина
		boxEnemyColor := 0xff00FF00
		
		if LineOrRectangle
		{
		minCornerLength := 5   ; Минимальный размер уголков для дальних целей
		maxCornerLength := 20  ; Максимальный размер уголков для ближних целей
		minDistance := 15      ; Минимальное расстояние (при котором уголки будут максимальными)
		maxDistance := 50      ; Максимальное расстояние (при котором уголки будут минимальными)
		if (dist > maxDistance) {
			cornerLength := minCornerLength  ; Если цель далеко, уголки минимальные
		} else if (dist < minDistance) {
			cornerLength := maxCornerLength  ; Если цель близко, уголки максимальные
		} else {
			cornerLength := maxCornerLength - (maxCornerLength - minCornerLength) * ((dist - minDistance) / (maxDistance - minDistance))
		}
		xLeft := x1 - (ESPwidth / 2)
		xRight := x1 + (ESPwidth / 2)
		yTop := y1 - ESPheight
		yBottom := y1
		game.DrawLine(xLeft, yTop, xLeft + cornerLength, yTop, boxEnemyColor, 2)  ; Левый верхний угол
		game.DrawLine(xRight - cornerLength, yTop, xRight, yTop, boxEnemyColor, 2) ; Правый верхний угол
		game.DrawLine(xLeft, yBottom, xLeft + cornerLength, yBottom, boxEnemyColor, 2)  ; Левый нижний угол
		game.DrawLine(xRight - cornerLength, yBottom, xRight, yBottom, boxEnemyColor, 2) ; Правый нижний угол
		game.DrawLine(xLeft, yTop, xLeft, yTop + cornerLength, boxEnemyColor, 2)         ; Левый верхний угол
		game.DrawLine(xLeft, yBottom - cornerLength, xLeft, yBottom, boxEnemyColor, 2)   ; Левый нижний угол
		game.DrawLine(xRight, yTop, xRight, yTop + cornerLength, boxEnemyColor, 2)         ; Правый верхний угол
		game.DrawLine(xRight, yBottom - cornerLength, xRight, yBottom, boxEnemyColor, 2)   ; Правый нижний угол
		}
		else
		{	
		game.DrawRectangle(x1-(ESPwidth/2), y1-ESPheight, ESPwidth, ESPheight, boxEnemyColor, "2")
		}
		if ESPShowText
		{
		textWidth2 := 80
		textHeight2 := 80
		extraOptions2 := "w" . textWidth2 . " h" . textHeight2 . " aCenter dsFF000000 dsx1 dsy1 olFF000000"
		xDrawText := x1 - (ESPwidth / 2) + (ESPwidth / 2) - textWidth2 / 2
		yDrawText := y1 - ESPheight + ESPheight
		game.DrawText(HeroNames[HeroID] "`n" Health " HP", xDrawText, yDrawText, "14", "0x00FFFFFF", "Arial", extraOptions2)		; game.DrawText(HeroID "`n" Health " / " MaxHealth " %", x1-(ESPwidth/2), y1 + ESPheight * 0.01, "14", "0x00FFFFFF", "Arial", "dsFF000000 dsx1 dsy1 olFF000000")
		}
		if (Health > MaxHealth)
		MaxHealth:=Health
		HPHeight := ESPheight * (Health / MaxHealth)  ; Высота полосы пропорциональна проценту здоровья
		HPWidth := ESPwidth / 8  ; Ширина полосы, можно отрегулировать по вашему вкусу
		if (Health / MaxHealth <= 0.25) {
			HPColor := 0xffFF0000  ; Красный цвет (меньше 25% здоровья)
		} else if (Health / MaxHealth <= 0.5) {
			HPColor := 0xffFFFF00  ; Желтый цвет (меньше 50% здоровья)
		} else {
			HPColor := 0xff00FF00  ; Зеленый цвет (больше 50% здоровья)
		}
		game.FillRectangle(x1 - (ESPwidth / 2) - HPWidth - 5, y1 - HPHeight, HPWidth, HPHeight, HPColor, "1")
		}
	} 
	else 
	{
		if(boxEnemy)
		{

		ESPheight := (y1 - y2) * 1.3  ; Регулируемая высота
		ESPwidth := ESPheight / 2.6   ; Пропорциональная ширина
		boxEnemyColor := 0xffFF0000    ; Цвет рамки
		if LineOrRectangle
		{
		minCornerLength := 5   ; Минимальный размер уголков для дальних целей
		maxCornerLength := 20  ; Максимальный размер уголков для ближних целей
		minDistance := 15      ; Минимальное расстояние (при котором уголки будут максимальными)
		maxDistance := 50      ; Максимальное расстояние (при котором уголки будут минимальными)
		if (dist > maxDistance) {
			cornerLength := minCornerLength  ; Если цель далеко, уголки минимальные
		} else if (dist < minDistance) {
			cornerLength := maxCornerLength  ; Если цель близко, уголки максимальные
		} else {
			cornerLength := maxCornerLength - (maxCornerLength - minCornerLength) * ((dist - minDistance) / (maxDistance - minDistance))
		}
		xLeft := x1 - (ESPwidth / 2)
		xRight := x1 + (ESPwidth / 2)
		yTop := y1 - ESPheight
		yBottom := y1
		game.DrawLine(xLeft, yTop, xLeft + cornerLength, yTop, boxEnemyColor, 2)  ; Левый верхний угол
		game.DrawLine(xRight - cornerLength, yTop, xRight, yTop, boxEnemyColor, 2) ; Правый верхний угол
		game.DrawLine(xLeft, yBottom, xLeft + cornerLength, yBottom, boxEnemyColor, 2)  ; Левый нижний угол
		game.DrawLine(xRight - cornerLength, yBottom, xRight, yBottom, boxEnemyColor, 2) ; Правый нижний угол
		game.DrawLine(xLeft, yTop, xLeft, yTop + cornerLength, boxEnemyColor, 2)         ; Левый верхний угол
		game.DrawLine(xLeft, yBottom - cornerLength, xLeft, yBottom, boxEnemyColor, 2)   ; Левый нижний угол
		game.DrawLine(xRight, yTop, xRight, yTop + cornerLength, boxEnemyColor, 2)         ; Правый верхний угол
		game.DrawLine(xRight, yBottom - cornerLength, xRight, yBottom, boxEnemyColor, 2)   ; Правый нижний угол
		}
		else
		{	
		game.DrawRectangle(x1-(ESPwidth/2), y1-ESPheight, ESPwidth, ESPheight, boxEnemyColor, "2")
		}
		textWidth2 := 180
		textHeight2 := 180
		extraOptions2 := "w" . textWidth2 . " h" . textHeight2 . " aCenter dsFF000000 dsx1 dsy1 olFF000000"
		xDrawText := x1 - (ESPwidth / 2) + (ESPwidth / 2) - textWidth2 / 2
		yDrawText := y1 - ESPheight + ESPheight
		if !GetKeyState(key_NetWorthShow, "P")
		{
		if ESPShowText
		{
		game.DrawText(HeroNames[HeroID] "`n" Health " HP", xDrawText, yDrawText, "14", "0x00FFFFFF", "Arial", extraOptions2)
		; game.DrawText(HeroNames[HeroID] "`n" Health " / " MaxHealth " %", x1-(ESPwidth/2), y1 + ESPheight * 0.01, "14", "0x00FFFFFF", "Arial", "dsFF000000 dsx1 dsy1 olFF000000")
		; game.DrawText(HeroID "`n" Health " / " MaxHealth " %", x1-(ESPwidth/2), y1 + ESPheight * 0.01, "14", "0x00FFFFFF", "Arial", "dsFF000000 dsx1 dsy1 olFF000000")
		}
		}
		else
		{
		subGoldNetWorth := myGoldNetWorth - GoldNetWorth
		if (myGoldNetWorth < GoldNetWorth)
		game.DrawText("G " GoldNetWorth " (" subGoldNetWorth ")", xDrawText, yDrawText, "16", "0x00FF0000", "Arial", extraOptions2)
		else
		game.DrawText("G " GoldNetWorth " (" subGoldNetWorth ")", xDrawText, yDrawText, "16", "0x0000FF00", "Arial", extraOptions2)

		subAPNetWorth := myAPNetWorth - APNetWorth
		if (myAPNetWorth < APNetWorth)
		game.DrawText("`nA " APNetWorth " (" subAPNetWorth ")", xDrawText, yDrawText, "16", "0x00FF0000", "Arial", extraOptions2)
		else
		game.DrawText("`nA " APNetWorth " (" subAPNetWorth ")", xDrawText, yDrawText, "16", "0x0000FF00", "Arial", extraOptions2)
		}
		
		if (Health > MaxHealth)
		MaxHealth:=Health
		HPHeight := ESPheight * (Health / MaxHealth)  ; Высота полосы пропорциональна проценту здоровья
		HPWidth := ESPwidth / 8  ; Ширина полосы, можно отрегулировать по вашему вкусу
		if (Health / MaxHealth <= 0.25) {
			HPColor := 0xffFF0000  ; Красный цвет (меньше 25% здоровья)
		} else if (Health / MaxHealth <= 0.5) {
			HPColor := 0xffFFFF00  ; Желтый цвет (меньше 50% здоровья)
		} else {
			HPColor := 0xff00FF00  ; Зеленый цвет (больше 50% здоровья)
		}
		game.FillRectangle(x1 - (ESPwidth / 2) - HPWidth - 5, y1 - HPHeight, HPWidth, HPHeight, HPColor, "1")
		}
	}
}
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"


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

getDistance(x,y,z)
{
	global
	myXLocation := 1337flex.Read(GameSceneNode1 + offsets.m_vecAbsOrigin,"float")
	myYLocation := 1337flex.Read(GameSceneNode1 + offsets.m_vecAbsOrigin+0x4,"float")
	myZLocation := 1337flex.Read(GameSceneNode1 + offsets.m_vecAbsOrigin+0x8,"float")	
	distance := Sqrt(((myXLocation - x)**2) + ((myYLocation - y)**2) + ((myZLocation - z)**2)) * 0.0254
	return distance
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
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

*~$Home::
MetkaMenu2:
Reload
return

*~$End::
MetkaMenu1:
ExitApp
return