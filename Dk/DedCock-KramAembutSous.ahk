﻿
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"


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
IniRead, key_aim, %iniFile%, Settings, soulkey_aim, Rbutton
IniRead, key_aim2, %iniFile%, Settings, key_aim, V
IniRead, WriteMode, %iniFile%, Settings, soulWriteMode, 1
IniRead, sensitivity, %iniFile%, Settings, soulsensitivity, 0.5
IniRead, tolerance, %iniFile%, Settings, soultolerance, 0
IniRead, captureRange, %iniFile%, Settings, soulcaptureRange, 300
IniRead, SleepCpu, %iniFile%, Settings, soulSleepCpu, 1
IniRead, circleColor, %iniFile%, Settings, soulcircleColor, 0x6FFFD800
IniRead, thickness, %iniFile%, Settings, soulthickness, 1
IniRead, MaxDistAimSoul, %iniFile%, Settings, MaxDistAimSoul, 150
IniRead, RunDedCockKramAembutSous, %iniFile%, Settings, RunDedCockKramAembutSous, 1
if !RunDedCockKramAembutSous
Exitapp

#include %A_ScriptDir%\data\offsets.ahk
#include %A_ScriptDir%\data\classMemory.ahk
#include %A_ScriptDir%\data\ShinsOverlayClass.ahk

Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico
Menu,Tray, NoStandard
Menu,Tray, DeleteAll
Menu,Tray, add, AimBotSoul, MetkaMenu3
Menu,Tray, Disable, AimBotSoul
Menu,Tray, Icon, AimBotSoul, shell32.dll,264, 16
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
global isReading := false


AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

StartLabelStart:
sleep 1500
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
if baseAddress
{
#include %A_ScriptDir%\data\offsetsdump.ahk
SetTimer, ReadEntities, 1000
Gosub, ReadEntities
}
WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
SetFormat, float, 2.20
VarStart_time2 = 0

Loop
{
	if WriteMode
	{
		Sleep %SleepCpu%
	}
	else
	{
		Sleep %SleepCpu%
		Sleep 1
	}
	KeyWait, %key_aim%, D T2
	if GetKeyState(key_aim, "P")
	{
		SetTimer, ReadEntities, Off
	}
	else
	{
		SetTimer, ReadEntities, 1000
	}
	j=0
	ViewMatrix:=Array()
	while(j<16)
	{
		ViewMatrix.Push(1337flex.Read(baseAddress + dwViewMatrix + (j * 0x4),"float"))
		j++
	}
	
	VarElapsed_time2 := A_TickCount - VarStart_time2
	if (VarElapsed_time2 > 500)
	{
	LocalPlayer := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0) ;мы в игре, а не в лобби?
	if !(LocalPlayer)
	{
		sleep 1500
		game2.EndDraw()
		game2.BeginDraw()
		game2.EndDraw()
		VarStart_time = 0
		Goto StartLabelStart
	}
	else
	{
		IfWinActive, ahk_exe project8.exe
		{
			game2.EndDraw()
			game2.BeginDraw()
			centerX := A_ScreenWidth / 2
			centerY := A_ScreenHeight / 2

			game2.DrawEllipse(centerX, centerY, captureRange, captureRange, circleColor, thickness)
			game2.EndDraw()
		}
		else
		{
			game2.EndDraw()
			game2.BeginDraw()
			game2.EndDraw()
		}
	}
	VarStart_time2 := A_TickCount
	}
	Kramindex := 0
	bones := []
	distances := []
	while (Kramindex < BubaArray.length() && GetKeyState(key_aim, "P") && !GetKeyState(key_aim2, "P"))
	{
		Kramindex++
		ControllerBase := BubaArray[Kramindex]
		DormantVar := 1337flex.Read(ControllerBase + offsets.m_pGameSceneNode, "int", offsets.m_bDormant)
			if (DormantVar == "0")
			{
			enemyXLocation := 1337flex.Read(ControllerBase + offsets.m_pGameSceneNode,"float", offsets.m_vecAbsOrigin)
			enemyYLocation := 1337flex.Read(ControllerBase + offsets.m_pGameSceneNode,"float", offsets.m_vecAbsOrigin + 0x4)
			enemyZLocation := 1337flex.Read(ControllerBase + offsets.m_pGameSceneNode,"float", offsets.m_vecAbsOrigin + 0x8)
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
						if (distance <= captureRange)  ; Проверяем экранное расстояние, а не мировое
						{
							bones.Push([enemyXLocation, enemyYLocation, enemyZLocation])
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
		if (dist < MaxDistAimSoul)
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
		if !WriteMode
		{
			if (arr := WorldToScreen(closestBone[1], closestBone[2], closestBone[3], A_ScreenWidth, A_ScreenHeight))
			{
				xpos1 := arr[1]
				ypos1 := arr[2]
				IfWinActive, ahk_exe project8.exe
				AimAtTarget(xpos1, ypos1)
			}
		}
		else
		{
		IfWinActive, ahk_exe project8.exe
		{
			CCitadelCameraManager := 1337flex.getAddressFromOffsets(baseAddress + CCameraManager + 0x28, 0x38)
			camera_posXcam := 1337flex.Read(baseAddress + CCameraManager + 0x28, "float",0x38)
			camera_posYcam := 1337flex.Read(baseAddress + CCameraManager + 0x28, "float",0x38+0x4)
			camera_posZcam := 1337flex.Read(baseAddress + CCameraManager + 0x28, "float",0x38+0x8)
			CCameraServices := 1337flex.Read(Pawn1 + offsets.m_pCameraServices, "float", offsets.m_vecPunchAngle) 	;RCS
			pitch := 0
			yaw := 0
			AimAtTargetWrite(camera_posXcam, camera_posYcam, camera_posZcam, closestBone[1], closestBone[2], closestBone[3], yaw, pitch)
			if camera_posXcam
			{
				1337flex.write(baseAddress + CCameraManager + 0x28, pitch - CCameraServices, "Float", 0x44) 		;вертикаль
				1337flex.write(baseAddress + CCameraManager + 0x28, yaw, "Float", 0x44+0x4) 	;горизонталь
			}
		}
		}
	}
}

return
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"



ReadEntities:
if (!isReading) ; Проверяем, не запущен ли уже процесс чтения
{
    isReading := true
	
	LocalPlayer := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0) ;мы в игре, а не в лобби?
	if LocalPlayer
	{
		EntityListCout := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
		EntityListCout := 1337flex.Read(EntityListCout + offsets.dwGameEntitySystem_highestEntityIndex,"int")
		playerIndex=0
		BubaArray := []
		counter1 := 0
		while(playerIndex < EntityListCout)
		{
			counter1++
			if (counter1 >= 500)
			{
				Sleep 1  ; Пауза на 1 миллисекунду
				counter1 := 0  ; Сброс счётчика
			}
			;==============Энтити лист
			EntityList := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
			AddressBase := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
			ControllerBase := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
			pEntityString := 1337flex.readString(ControllerBase + offsets.m_pEntity,, "utf-8", 0x8, 0x30, 0x8, 0x0)
			if (pEntityString == "CItemXP")
			{
			BubaArray.push(ControllerBase)
			}
			playerIndex++
		}
		;==============Локальный игрок
		ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
		pawnHandle1 := 1337flex.Read(ControllerBase1 + offsets.m_hPawn,"int")
		listEntry1 := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle1 & 0x7FFF) >> 0x9) + 0x10, 0x0)
		Pawn1 := 1337flex.getAddressFromOffsets(listEntry1 + 0x78 * (pawnHandle1 & 0x1FF), 0x0)
		GameSceneNode1 := 1337flex.getAddressFromOffsets(Pawn1 + offsets.m_pGameSceneNode, 0x0)
	}
	
    isReading := false
	; soundbeep
}

Return




AimAtTargetWrite(camX, camY, camZ, enemyX, enemyY, enemyZ, ByRef yaw, ByRef pitch) {
    ; Объявляем Pi
    Pi := 3.141592653589793
    ; Вычисляем разницу координат между камерой и противником
    deltaX := enemyX - camX
    deltaY := enemyY - camY
    deltaZ := enemyZ - camZ
    ; Проверка: вычисляем Yaw (азимут) только если deltaX не равен нулю
    if (deltaX != 0) {
        yaw := ATan(deltaY / deltaX) * (180 / Pi)
        if (deltaX < 0) {
            yaw += 180  ; Корректируем угол, если противник слева
        }
    } else {
        yaw := deltaY > 0 ? 90 : -90  ; Противник прямо перед нами или позади
    }
	; Вычисляем Pitch (тангаж) — угол по вертикали
	distance := Sqrt(deltaX**2 + deltaY**2)  ; Горизонтальное расстояние
	if (distance != 0) {
		angleInRadians := ATan(deltaZ / distance)  ; Угол в радианах
		pitch := angleInRadians * (180 / Pi) * -1  ; Преобразуем в градусы и меняем знак
	} else {
		pitch := 0  ; Если противник на одной высоте
	}
}


; Функция для перемещения мыши с помощью mouse_event
MoveMouseBy(deltaX, deltaY) {
    global
    deltaX := Round(deltaX)
    deltaY := Round(deltaY)
    DllCall("mouse_event", "UInt", 0x0001, "Int", deltaX, "Int", deltaY, "UInt", 0, "UInt", 0)
}
; Функция для движения мыши к цели с учетом диапазона захвата
AimAtTarget(targetX, targetY) {
    global
    centerX := A_ScreenWidth / 2
    centerY := A_ScreenHeight / 2
    deltaX := (targetX - centerX)
    deltaY := (targetY - centerY)
    deltaX := deltaX * sensitivity + 1
    deltaY := deltaY * sensitivity + 1
    MoveMouseBy(deltaX, deltaY)
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