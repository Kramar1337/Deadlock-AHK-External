#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
SetBatchLines, -1

#include data/offsets.ahk
#include data/classMemory.ahk
#include data/ShinsOverlayClass.ahk


; Настройки
key_aim := "V"
sensitivity := 0.5  	; 0.05	Чувствительность движения
tolerance := 1       	; 2 	Допустимое расстояние до цели для остановки движения
captureRange := 200  	; 100 пикселей

Gui, 1: new, +hwndNewGuiID2
game2 := new ShinsOverlayClass(0,0,A_ScreenWidth,A_ScreenHeight, "1", "1", "1",, NewGuiID2)

gameEXE:= "ahk_exe project8.exe"
gameDLL:= "client.dll"

StartLabelStart:
sleep 300
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)

; Console.WriteLine("EntityList " + Deadlock.EntityList);
; Console.WriteLine("AddressBase " + AddressBase);
; Thread.Sleep(9999999);

WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
SetFormat, float, 2.20
VarStart_time := A_TickCount
Loop
{
	Sleep 1
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
		VarStart_time := A_TickCount
	}
	Kramindex := 0
	while (Kramindex < BubaArray.length() && GetKeyState(key_aim, "P"))
	{
	Kramindex++
	ControllerBase := BubaArray[Kramindex]
	Health := 1337flex.Read(ControllerBase + offsets.m_ihealth,"int")
	MaxHealth := 1337flex.Read(ControllerBase + offsets.m_iMaxHealth,"int")
	TeamNum := 1337flex.Read(ControllerBase + offsets.m_iTeamNum,"int")
	HeroID := 1337flex.Read(ControllerBase + offsets.m_heroid,"int")
	if Health>0
	{
		if(TeamNum=1 or TeamNum=2 or TeamNum=3)
		{
			Pawn := BubaArray2[Kramindex]
			GameSceneNode := 1337flex.getAddressFromOffsets(Pawn + offsets.m_pGameSceneNode, 0x0)
			BoneArray := 1337flex.getAddressFromOffsets(GameSceneNode + Offsets.m_modelState + Offsets.m_boneArray, 0x0)
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
			WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
			if(enemyXLocation!=0)
			{
				if(arr:=WorldToScreen(enemyXLocation,enemyYLocation,enemyZLocation,windowWidth,windowHeight))
				{
					xpos1:=arr[1]
					ypos1:=arr[2]
					dist:=getDistance(enemyXLocation,enemyYLocation,enemyZLocation)
					IfWinActive, ahk_exe project8.exe
					{
						if (dist > 1.2)
						{
							MyTeamIs := 1337flex.Read(ControllerBase1 + offsets.m_iTeamNum,"int")
							if(TeamNum!=MyTeamIs)
								AimAtTarget(xpos1, ypos1)
						}
					}
				}
			}
		}
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
    
    ; Вычисляем расстояние до цели
    distance := Sqrt(deltaX**2 + deltaY**2)
    
    ; Если цель находится в пределах диапазона захвата
    if (distance <= captureRange) {
        ; Применяем чувствительность
        deltaX := deltaX * sensitivity
        deltaY := deltaY * sensitivity
        
        ; Двигаем мышь к цели
        MoveMouseBy(deltaX, deltaY)
    }
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


*~$Home::
Reload
return

*~$End::
ExitApp
return