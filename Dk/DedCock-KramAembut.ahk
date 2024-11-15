
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
SetBatchLines, -1
HeroArray := {}
#include %A_ScriptDir%\data\HeroArray.ahk

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
IniRead, key_aim, %iniFile%, Settings, key_aim, V
IniRead, sensitivity, %iniFile%, Settings, sensitivity, 0.5
IniRead, tolerance, %iniFile%, Settings, tolerance, 0
IniRead, captureRange, %iniFile%, Settings, captureRange, 150
IniRead, SleepCpu, %iniFile%, Settings, SleepCpu, 0
IniRead, headOrneck, %iniFile%, Settings, headOrneck, 1
IniRead, circleColor, %iniFile%, Settings, circleColor, 0x8FFF0000
IniRead, thickness, %iniFile%, Settings, thickness, 1
IniRead, HeadOrNeckOrBody, %iniFile%, Settings, HeadOrNeckOrBody, 1
IniRead, key_HeadOrNeckOrBody, %iniFile%, Settings, key_HeadOrNeckOrBody, Numpad0
IniRead, MaxDistAim, %iniFile%, Settings, MaxDistAim, 150
IniRead, LegitCaptureRange, %iniFile%, Settings, LegitCaptureRange, 1
IniRead, CalcPredictionAim, %iniFile%, Settings, CalcPredictionAim, 1
IniRead, velocityDiv, %iniFile%, Settings, velocityDiv, 10
IniRead, VindictaPrediction, %iniFile%, Settings, VindictaPrediction, 1
IniRead, AimSafeModeTest, %iniFile%, Settings, AimSafeModeTest, 1


IniRead, RunDedCockKramAembut, %iniFile%, Settings, RunDedCockKramAembut, 1
if !RunDedCockKramAembut
Exitapp

Hotkey, *~$%key_HeadOrNeckOrBody%, LabelHeadOrNeckOrBody, on 	;Приостановить-возобновить




#include %A_ScriptDir%\data\offsets.ahk
#include %A_ScriptDir%\data\classMemory.ahk
#include %A_ScriptDir%\data\ShinsOverlayClass.ahk

Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico
Menu,Tray, NoStandard
Menu,Tray, DeleteAll
Menu,Tray, add, AimBot, MetkaMenu3
Menu,Tray, Disable, AimBot
Menu,Tray, Icon, AimBot, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Edit Config, MetkaMenu3
Menu,Tray, Icon, Edit Config, imageres.dll, 247, 16
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16

Gui, 1: new, +hwndNewGuiID2
game2 := new ShinsOverlayClass(0,0,A_ScreenWidth,A_ScreenHeight, "1", "1", "1",, NewGuiID2)

gameEXE:= "ahk_exe project8.exe"
gameDLL:= "client.dll"
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"
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
VarStart_time := A_TickCount
LastTime1 := A_TickCount
currentTarget := false
Loop
{
	Sleep %SleepCpu%
	Sleep 1
	
	j=0
	ViewMatrix:=Array()
	while(j<16)
	{
		ViewMatrix.Push(1337flex.Read(baseAddress + dwViewMatrix + (j * 0x4),"float"))
		j++
	}

	VarElapsed_time := A_TickCount - VarStart_time
	if (VarElapsed_time > 3000) ;3000
	{
		LocalPlayer := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0) ;мы в игре, а не в лобби?
		if !(LocalPlayer)
		{
			game2.BeginDraw()
			game2.EndDraw()
			Goto StartLabelStart
		}
		else
		{
		IfWinActive, ahk_exe project8.exe
		{
			game2.BeginDraw()
			centerX := A_ScreenWidth / 2
			centerY := A_ScreenHeight / 2

			game2.DrawEllipse(centerX, centerY, captureRange, captureRange, circleColor, thickness)
			game2.EndDraw()
		}
		else
		{
			game2.BeginDraw()
			game2.EndDraw()
		}
		}

		playerIndex=0
		BubaArray := []
		BubaArray2 := []
		while(playerIndex < 64)
		{
			;==============Энтити лист
			EntityList := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
			AddressBase := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
			ControllerBase := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
			pawnHandle := 1337flex.Read(ControllerBase + offsets.m_hPawn,"int")
			listEntry := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle & 0x7FFF) >> 0x9) + 0x10, 0x0)
			Pawn := 1337flex.getAddressFromOffsets(listEntry + 0x78 * (pawnHandle & 0x1FF), 0x0)
			Health := 1337flex.Read(Pawn + offsets.m_ihealth,"int")
			if Health
			{
				BubaArray.push(ControllerBase)
				BubaArray2.push(Pawn)
			}
			playerIndex++
		}
		;==============Локальный игрок
		ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
		pawnHandle1 := 1337flex.Read(ControllerBase1 + offsets.m_hPawn,"int")
		listEntry1 := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle1 & 0x7FFF) >> 0x9) + 0x10, 0x0)
		Pawn1 := 1337flex.getAddressFromOffsets(listEntry1 + 0x78 * (pawnHandle1 & 0x1FF), 0x0)
		GameSceneNode1 := 1337flex.getAddressFromOffsets(Pawn1 + offsets.m_pGameSceneNode, 0x0)
		MyTeamIs := 1337flex.Read(ControllerBase1 + offsets.m_iTeamNum,"int")
		MyHeroID := 1337flex.Read(ControllerBase1 + offsets.m_PlayerDataGlobal + offsets.m_nHeroID,"int")
		VarStart_time := A_TickCount
	}
	
	
	if (!currentTarget)
    {
	Kramindex := 0
	bones := []
	distances := []
	while (Kramindex < BubaArray.length() && GetKeyState(key_aim, "P"))
	{
		Kramindex++
		ControllerBase := BubaArray[Kramindex]
		Pawn := BubaArray2[Kramindex]
		TeamNum := 1337flex.Read(Pawn + offsets.m_iTeamNum,"int")
		HeroID := 1337flex.Read(ControllerBase + offsets.m_PlayerDataGlobal + offsets.m_nHeroID,"int")
		bAlive := 1337flex.Read(ControllerBase + offsets.m_PlayerDataGlobal + offsets.m_bAlive,"int")
		iHealth := 1337flex.Read(ControllerBase + offsets.m_PlayerDataGlobal + offsets.m_iHealth,"int")
		if (TeamNum != MyTeamIs)
		{
			if (bAlive = 1 && iHealth > 0)
			{
				GameSceneNode := 1337flex.getAddressFromOffsets(Pawn + offsets.m_pGameSceneNode, 0x0)
				BoneArray := 1337flex.getAddressFromOffsets(GameSceneNode + Offsets.m_modelState + 0x80, 0x0)
				
				if HeadOrNeckOrBody = 1
				SelectBone := HeroArray[HeroID].head
				if HeadOrNeckOrBody = 2
				SelectBone := HeroArray[HeroID].neck
				if HeadOrNeckOrBody = 3
				SelectBone := HeroArray[HeroID].body
				if HeadOrNeckOrBody = 4
				SelectBone := HeroArray[HeroID].head
				
				if (SelectBone > 0)
				{
					enemyXLocation := 1337flex.Read(BoneArray + SelectBone * 32, "float")
					enemyYLocation := 1337flex.Read(BoneArray + SelectBone * 32+0x4, "float")
					enemyZLocation := 1337flex.Read(BoneArray + SelectBone * 32+0x8, "float")
				}
				if (enemyXLocation != 0)
				{
					arr := WorldToScreen(enemyXLocation, enemyYLocation, enemyZLocation, A_ScreenWidth, A_ScreenHeight)
					if (arr) ; Если цель видна на экране
					{
						xpos1 := arr[1]
						ypos1 := arr[2]
						centerX := A_ScreenWidth / 2
						centerY := A_ScreenHeight / 2
						deltaX := (xpos1 - centerX)
						deltaY := (ypos1 - centerY)
						distance := Sqrt(deltaX**2 + deltaY**2)
						if (distance <= captureRange)  ; Проверяем экранное расстояние
						{
							bones.Push([enemyXLocation, enemyYLocation, enemyZLocation, Pawn, ControllerBase])
						}
					}
				}
			}
		}
	}
	; Заполняем массив расстояний и костей
	for index, bone in bones
	{
		boneX := bone[1]
		boneY := bone[2]
		boneZ := bone[3]
		inIndexX := bone[4]
		inIndexController := bone[5]
		dist := getDistance(boneX, boneY, boneZ)
		if (dist < MaxDistAim)
		distances.Push([dist, bone, inIndexX, inIndexController])
	}
	Sort, distances, D
	closestPindex := ""
	closestBone := ""
	closestDistance := -1
	for index, item in distances
	{
		distance := item[1]
		bone := item[2]
		inPindex := item[3]
		inIndexContro := item[4]
		if (closestDistance = -1 || distance < closestDistance)
		{
			closestPindex := inPindex
			closestBone := bone
			closestController := inIndexContro
			closestDistance := distance
		}
	}
    
    }

	if !GetKeyState(key_aim, "P")
	{
	currentTarget := false
	}

	
	if (closestBone != "" && GetKeyState(key_aim, "P"))
	{
		currentTarget := true
		
		bAlive := 1337flex.Read(closestController + offsets.m_PlayerDataGlobal + offsets.m_bAlive,"int")
		iHealth := 1337flex.Read(closestController + offsets.m_PlayerDataGlobal + offsets.m_iHealth,"int")
		if (bAlive = 1 && iHealth > 0)
		{
				HeroID := 1337flex.Read(closestController + offsets.m_PlayerDataGlobal + offsets.m_nHeroID,"int")
				GameSceneNode := 1337flex.getAddressFromOffsets(closestPindex + offsets.m_pGameSceneNode, 0x0)
				BoneArray := 1337flex.getAddressFromOffsets(GameSceneNode + Offsets.m_modelState + 0x80, 0x0)

				if HeadOrNeckOrBody = 1
				{
				CurrentTime1 := A_TickCount
				ElapsedTime1 := CurrentTime1 - LastTime1
				if (ElapsedTime1 >= 350) 
				{
					LastTime1 := CurrentTime1
					Random, HitChance, 1, 100
					if (HitChance <= 70) 
					{
						SelectBone := HeroArray[HeroID].head
					} 
					else 
					{
						SelectBone := HeroArray[HeroID].neck
					}
				}
				}	
				; if HeadOrNeckOrBody = 1
				; SelectBone := HeroArray[HeroID].head
				if HeadOrNeckOrBody = 2
				SelectBone := HeroArray[HeroID].neck
				if HeadOrNeckOrBody = 3
				SelectBone := HeroArray[HeroID].body
				if HeadOrNeckOrBody = 4
				SelectBone := HeroArray[HeroID].head
				
				if (SelectBone > 0)
				{
					enemyXLocation := 1337flex.Read(BoneArray + SelectBone * 32, "float")
					enemyYLocation := 1337flex.Read(BoneArray + SelectBone * 32+0x4, "float")
					enemyZLocation := 1337flex.Read(BoneArray + SelectBone * 32+0x8, "float")
				}

		}
		else
		{
		currentTarget := false
		}
		if CalcPredictionAim
		{
			vecVelocityX := 1337flex.Read(closestPindex + offsets.m_vecVelocity,"float")
			vecVelocityY := 1337flex.Read(closestPindex + offsets.m_vecVelocity+0x4,"float")
			vecVelocityZ := 1337flex.Read(closestPindex + offsets.m_vecVelocity+0x8,"float")
			dist := getDistance(enemyXLocation, enemyYLocation, enemyZLocation)
			if !((AimSafeModeTest = 1) and (dist > 40))
			{
				;=====================если Виндикта то другое упреждение
				if (MyHeroID = 3)
				{
					if VindictaPrediction
					{
					enemyXLocation := enemyXLocation + vecVelocityX * dist * velocityDiv / 100
					enemyYLocation := enemyYLocation + vecVelocityY * dist * velocityDiv / 100
					enemyZLocation := enemyZLocation + vecVelocityZ * dist * velocityDiv / 100
					}
					else
					{
					velocityDiv2 := 0.05
					enemyXLocation := enemyXLocation + vecVelocityX * dist * velocityDiv2 / 100
					enemyYLocation := enemyYLocation + vecVelocityY * dist * velocityDiv2 / 100
					enemyZLocation := enemyZLocation + vecVelocityZ * dist * velocityDiv2 / 100
					}
				}
				else
				{
					enemyXLocation := enemyXLocation + vecVelocityX * dist * velocityDiv / 100
					enemyYLocation := enemyYLocation + vecVelocityY * dist * velocityDiv / 100
					enemyZLocation := enemyZLocation + vecVelocityZ * dist * velocityDiv / 100
				}
			}
		}
		if (arr := WorldToScreen(enemyXLocation, enemyYLocation, enemyZLocation, A_ScreenWidth, A_ScreenHeight))
		{
			xpos1 := arr[1]
			ypos1 := arr[2]
			if LegitCaptureRange
			{
				centerX := A_ScreenWidth / 2
				centerY := A_ScreenHeight / 2
				deltaX := (xpos1 - centerX)
				deltaY := (ypos1 - centerY)
				distance := Sqrt(deltaX**2 + deltaY**2)
				if (distance <= captureRange*1.5)  ; Проверяем экранное расстояние, а не мировое
				{
					IfWinActive, ahk_exe project8.exe
					AimAtTarget(xpos1, ypos1)
				}
			}
			else
			{
				IfWinActive, ahk_exe project8.exe
				AimAtTarget(xpos1, ypos1)
			}
		}
	}
	else
	{
	currentTarget := false
	}
}
return

AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"


; Функция для движения мыши к цели с учетом диапазона захвата
AimAtTarget(targetX, targetY) {
    global
    ; Определяем центр экрана (прицел)
    centerX := A_ScreenWidth / 2
    centerY := A_ScreenHeight / 2
    ; Вычисляем смещение от центра экрана до цели
    deltaX := (targetX - centerX)
    deltaY := (targetY - centerY)
    ; Применяем чувствительность
    deltaX := Round(deltaX * sensitivity + 1)
    deltaY := Round(deltaY * sensitivity + 1)
    ; Двигаем мышь к цели
    DllCall("mouse_event", "UInt", 0x0001, "Int", deltaX, "Int", deltaY, "UInt", 0, "UInt", 0)
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

HexFormat(address) {
    hexAddress := Format("{:X}", address)
    Clipboard := hexAddress
    return hexAddress
}
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

LabelHeadOrNeckOrBody:
    HeadOrNeckOrBody++
    if (HeadOrNeckOrBody > 4)  ; Если значение больше 3, сбрасываем на 0
        HeadOrNeckOrBody := 1
    if HeadOrNeckOrBody = 1
	{
	Tooltip, Head 60`%
    Sleep, 500
    Tooltip
	}
	if HeadOrNeckOrBody = 2
	{
	Tooltip, Neck
    Sleep, 500
    Tooltip
	}
	if HeadOrNeckOrBody = 3
	{
	Tooltip, Body
    Sleep, 500
    Tooltip
	}
	if HeadOrNeckOrBody = 4
	{
	Tooltip, Head 100`%
    Sleep, 500
    Tooltip
	}
return

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