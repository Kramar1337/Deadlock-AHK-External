; Настройки
key_aim := "V"
sensitivity := 0.5  	; 0.05	Чувствительность движения
tolerance := 1       	; 2 	Допустимое расстояние до цели для остановки движения
captureRange := 150  	; 100 пикселей
SleepCpu = 1 			; 0 для идеальной плавности но жрет много CPU 5% в моем случае
BoneMode = 1 			; 1 - кости из базы, 0 - выбрать самую верхнюю кость(промахи, например, поднятые руки выше уровня головы)
headOrneck = 1 			; 1 - приоритет на голову из базы, 0 - приоритет на шею из базы

HeroNames := {1: "Infernus", 2: "Seven", 3: "Vindicta", 4: "LadyGeist", 6: "Abrams", 7: "Wraith", 8: "McGinnis", 10: "Paradox", 11: "Dynamo", 12: "Kelvin", 13: "Haze", 14: "Holliday", 15: "Bebop", 17: "GreyTalon", 18: "MoAndKrill", 19: "Shiv", 20: "Ivy", 25: "Warden", 27: "Yamato", 31: "Lash", 35: "Viscous", 48: "Wrecker", 50: "Pocket", 52: "Mirage", 55: "Dummy"}
HeroBones := {1: {head: 30, neck: 29}, 2: {head: 14, neck: 13}, 3: {head: 7, neck: 6}, 4: {head: 11, neck: 10}, 6: {head: 7, neck: 6}, 7: {head: 7, neck: 6}, 8: {head: 7, neck: 6}, 10: {head: 8, neck: 7}, 11: {head: 13, neck: 12}, 12: {head: 12, neck: 11}, 13: {head: 8, neck: 7}, 14: {head: 0, neck: 0}, 15: {head: 6, neck: 5}, 17: {head: 17, neck: 18}, 18: {head: 10, neck: 9}, 19: {head: 13, neck: 12}, 20: {head: 13, neck: 12}, 25: {head: 11, neck: 10}, 27: {head: 35, neck: 34}, 31: {head: 12, neck: 11}, 35: {head: 7, neck: 6}, 48: {head: 0, neck: 0}, 50: {head: 13, neck: 12}, 52: {head: 0, neck: 0}, 55: {head: 0, neck: 0}}


; Abrams 7 голова 6 шея
; Bebop 6 голова 5 шея
; Vindicta 7 голова 6 шея
; Viscous 7 голова 6 шея
; Infernus 30 голова 29 шея
; Seven 14 голова 13 шея
; LadyGeist 11 голова 10 шея
; Wraith 7 голова 6 шея
; McGinnis 7 голова 6 шея
; Paradox 8 голова 7 шея
; Dynamo 13 голова 12 шея
; Kelvin 12 голова 11 шея
; Haze 8 голова 7 шея
; Holliday 
; GreyTalon 17 голова 18 шея
; MoAndKrill 10 голова 9 шея
; Shiv 13 голова 12 шея
; Ivy 13 голова 12 шея
; Warden 11 голова 10 шея
; Yamato 35 голова 34 шея
; Lash 12 голова 11 шея
; Wrecker 
; Pocket 13 голова 12 шея
; Mirage 
; Dummy 



#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
SetBatchLines, -1

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
		if (TeamNum != MyTeamIs)
		{
			if Health > 0
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