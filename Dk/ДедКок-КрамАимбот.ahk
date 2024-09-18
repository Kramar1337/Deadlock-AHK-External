; Настройки
key_aim := "V"  		; Клавиша aim
sensitivity := 0.5  	; 0.1 - 0.9	Чувствительность движения
tolerance := 0       	; 1 Допустимое расстояние до цели для остановки движения
captureRange := 150  	; 150 Диапазон захвата пикселей
SleepCpu = 1 			; 0 для идеальной плавности но жрет много CPU 5% в моем случае
BoneMode = 1 			; 1 - кости из базы, 0 - выбрать самую верхнюю кость(промахи, например, поднятые руки выше уровня головы)
headOrneck = 1 			; 1 - приоритет на голову из базы, 0 - приоритет на шею из базы


HeroBones := {}
HeroBones[1] := {name: "Infernus", head: 30, neck: 29}
HeroBones[2] := {name: "Seven", head: 14, neck: 13}
HeroBones[3] := {name: "Vindicta", head: 7, neck: 6}
HeroBones[4] := {name: "LadyGeist", head: 11, neck: 10}
HeroBones[6] := {name: "Abrams", head: 7, neck: 6}
HeroBones[7] := {name: "Wraith", head: 7, neck: 6}
HeroBones[8] := {name: "McGinnis", head: 7, neck: 6}
HeroBones[10] := {name: "Paradox", head: 8, neck: 7}
HeroBones[11] := {name: "Dynamo", head: 13, neck: 12}
HeroBones[12] := {name: "Kelvin", head: 12, neck: 11}
HeroBones[13] := {name: "Haze", head: 8, neck: 7}
HeroBones[14] := {name: "Holliday", head: 0, neck: 0}
HeroBones[15] := {name: "Bebop", head: 6, neck: 5}
HeroBones[17] := {name: "GreyTalon", head: 17, neck: 18}
HeroBones[18] := {name: "MoAndKrill", head: 10, neck: 9}
HeroBones[19] := {name: "Shiv", head: 13, neck: 12}
HeroBones[20] := {name: "Ivy", head: 13, neck: 12}
HeroBones[25] := {name: "Warden", head: 11, neck: 10}
HeroBones[27] := {name: "Yamato", head: 35, neck: 34}
HeroBones[31] := {name: "Lash", head: 12, neck: 11}
HeroBones[35] := {name: "Viscous", head: 7, neck: 6}
HeroBones[48] := {name: "Wrecker", head: 0, neck: 0}
HeroBones[50] := {name: "Pocket", head: 13, neck: 12}
HeroBones[52] := {name: "Mirage", head: 0, neck: 0}
HeroBones[55] := {name: "Dummy", head: 0, neck: 0}



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

#include %A_ScriptDir%\data\offsets.ahk
#include %A_ScriptDir%\data\classMemory.ahk
#include %A_ScriptDir%\data\ShinsOverlayClass.ahk

Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico

Menu,Tray,NoStandard
Menu,Tray,DeleteAll
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

StartLabelStart:
sleep 300
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)

WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
SetFormat, float, 2.20
VarStart_time := A_TickCount
Loop
{
	Sleep %SleepCpu%
	j=0
	ViewMatrix:=Array()
	while(j<16)
	{
		ViewMatrix.Push(1337flex.Read(baseAddress + offsets.dwViewMatrix + (j * 0x4),"float"))
		j++
	}
	VarElapsed_time := A_TickCount - VarStart_time
	if (VarElapsed_time > 3000) ;3000
	{
		LocalPlayer := 1337flex.read(baseAddress + offsets.dwLocalPlayerPawn, "Int") ;мы в игре, а не в лобби?
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
			circleColor := 0xFFFF0000  ; Красный цвет (0xAARRGGBB)
			thickness := 1             ; Толщина контура
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
			EntityList := 1337flex.getAddressFromOffsets(baseAddress + offsets.dwEntityList, 0x0)
			AddressBase := 1337flex.getAddressFromOffsets(baseAddress + offsets.dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
			ControllerBase := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
			pawnHandle := 1337flex.Read(ControllerBase + offsets.m_hPawn,"int")
			listEntry := 1337flex.getAddressFromOffsets(baseAddress + offsets.dwEntityList, 0x8 * ((pawnHandle & 0x7FFF) >> 0x9) + 0x10, 0x0)
			Pawn := 1337flex.getAddressFromOffsets(listEntry + 0x78 * (pawnHandle & 0x1FF), 0x0)
			Health := 1337flex.Read(ControllerBase + offsets.m_ihealth,"int")
			if Health
			{
				BubaArray.push(ControllerBase)
				BubaArray2.push(Pawn)
			}
			playerIndex++
		}
		;==============Локальный игрок
		ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + offsets.dwLocalPlayerPawn, 0x0)
		pawnHandle1 := 1337flex.Read(ControllerBase1 + offsets.m_hPawn,"int")
		listEntry1 := 1337flex.getAddressFromOffsets(baseAddress + offsets.dwEntityList, 0x8 * ((pawnHandle1 & 0x7FFF) >> 0x9) + 0x10, 0x0)
		Pawn1 := 1337flex.getAddressFromOffsets(listEntry1 + 0x78 * (pawnHandle1 & 0x1FF), 0x0)
		GameSceneNode1 := 1337flex.getAddressFromOffsets(Pawn1 + offsets.m_pGameSceneNode, 0x0)
		MyTeamIs := 1337flex.Read(ControllerBase1 + offsets.m_iTeamNum,"int")
		
		VarStart_time := A_TickCount
	}
	Kramindex := 0
	bones := []
	distances := []
	while (Kramindex < BubaArray.length() && GetKeyState(key_aim, "P"))
	{
		Kramindex++
		ControllerBase := BubaArray[Kramindex]
		Health := 1337flex.Read(ControllerBase + offsets.m_ihealth,"int")
		MaxHealth := 1337flex.Read(ControllerBase + offsets.m_iMaxHealth,"int")
		TeamNum := 1337flex.Read(ControllerBase + offsets.m_iTeamNum,"int")
		HeroID := 1337flex.Read(ControllerBase + offsets.m_heroid,"int")
		DormantVar := 1337flex.Read(ControllerBase + offsets.m_bDormant,"int")
		if (TeamNum != MyTeamIs)
		{
			if DormantVar = 1
			{
				Pawn := BubaArray2[Kramindex]
				GameSceneNode := 1337flex.getAddressFromOffsets(Pawn + offsets.m_pGameSceneNode, 0x0)
				BoneArray := 1337flex.getAddressFromOffsets(GameSceneNode + Offsets.m_modelState + Offsets.m_boneArray, 0x0)
				
				if BoneMode
				{
				if headOrneck
				SelectBone := HeroBones[HeroID].head
				else
				SelectBone := HeroBones[HeroID].neck
				if SelectBone
				{
					enemyXLocation := 1337flex.Read(BoneArray + SelectBone * 32, "float")
					enemyYLocation := 1337flex.Read(BoneArray + SelectBone * 32+0x4, "float")
					enemyZLocation := 1337flex.Read(BoneArray + SelectBone * 32+0x8, "float")
				}
				else
				{
					highestBoneIndex := -1
					highestBoneZ := -999999  ; Установим минимально возможное значение для сравнения
					i := 0
					while (i < 64)
					{
						BoneZLocation := 1337flex.Read(BoneArray + i * 32 + 0x8, "float")
						if (BoneZLocation > highestBoneZ)
						{
							highestBoneZ := BoneZLocation
							highestBoneIndex := i
						}
						i++
					}
					if (highestBoneIndex >= 0)
					{
						enemyXLocation := 1337flex.Read(BoneArray + highestBoneIndex * 32, "float")
						enemyYLocation := 1337flex.Read(BoneArray + highestBoneIndex * 32+0x4, "float")
						enemyZLocation := 1337flex.Read(BoneArray + highestBoneIndex * 32+0x8, "float")
					}
				}
				}
				else
				{
					highestBoneIndex := -1
					highestBoneZ := -999999  ; Установим минимально возможное значение для сравнения
					i := 0
					while (i < 64)
					{
						BoneZLocation := 1337flex.Read(BoneArray + i * 32 + 0x8, "float")
						if (BoneZLocation > highestBoneZ)
						{
							highestBoneZ := BoneZLocation
							highestBoneIndex := i
						}
						i++
					}
					if (highestBoneIndex >= 0)
					{
						enemyXLocation := 1337flex.Read(BoneArray + highestBoneIndex * 32, "float")
						enemyYLocation := 1337flex.Read(BoneArray + highestBoneIndex * 32+0x4, "float")
						enemyZLocation := 1337flex.Read(BoneArray + highestBoneIndex * 32+0x8, "float")
					}
				}
				if (enemyXLocation != 0)
				{
					arr := WorldToScreen(enemyXLocation, enemyYLocation, enemyZLocation, A_ScreenWidth, A_ScreenHeight)
					if (arr) ; Если цель видна на экране
					{
						xpos1 := arr[1]
						ypos1 := arr[2]
						; Получаем центр экрана
						centerX := A_ScreenWidth / 2
						centerY := A_ScreenHeight / 2
						; Вычисляем смещение от центра экрана до цели
						deltaX := (xpos1 - centerX)
						deltaY := (ypos1 - centerY)
						; Вычисляем расстояние до цели на экране
						distance := Sqrt(deltaX**2 + deltaY**2)
						; Добавляем кость в массив, если она находится в пределах видимого диапазона захвата
						if (distance <= captureRange)  ; Проверяем экранное расстояние, а не мировое
						{
							bones.Push([enemyXLocation, enemyYLocation, enemyZLocation])
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
		dist := getDistance(boneX, boneY, boneZ)
		distances.Push([dist, bone])
	}
	Sort, distances, D
	closestBone := ""
	closestDistance := -1  ; Начальное значение, которое всегда будет меньше истинного расстояния
	for index, item in distances
	{
		distance := item[1]
		bone := item[2]
		if (closestDistance = -1 || distance < closestDistance)
		{
			closestBone := bone
			closestDistance := distance
		}
	}
	if (closestBone != "")
	{
		if (arr := WorldToScreen(closestBone[1], closestBone[2], closestBone[3], A_ScreenWidth, A_ScreenHeight))
		{
			xpos1 := arr[1]
			ypos1 := arr[2]
			IfWinActive, ahk_exe project8.exe
			AimAtTarget(xpos1, ypos1)
		}
	}
	
}
return





; Функция для перемещения мыши с помощью mouse_event
MoveMouseBy(deltaX, deltaY) {
    global
    ; Преобразуем смещения в целые числа
    deltaX := Round(deltaX)
    deltaY := Round(deltaY)
    ; Используем mouse_event для перемещения мыши
    DllCall("mouse_event", "UInt", 0x0001, "Int", deltaX, "Int", deltaY, "UInt", 0, "UInt", 0)
}
; sensitivity := 0.5
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
    deltaX := deltaX * sensitivity + 1
    deltaY := deltaY * sensitivity + 1
    ; Двигаем мышь к цели
    MoveMouseBy(deltaX, deltaY)
}




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


MetkaMenu3:
msgbox Пока ничего нет
return

*~$Home::
MetkaMenu2:
Reload
return

*~$End::
MetkaMenu1:
ExitApp
return