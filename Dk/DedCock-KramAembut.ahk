
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"


HeroBones := {}
HeroBones[1] := {name: "Infernus", head: 30, neck: 29, body: 11}
HeroBones[2] := {name: "Seven", head: 14, neck: 11, body: 10}
HeroBones[3] := {name: "Vindicta", head: 7, neck: 8, body: 4}
HeroBones[4] := {name: "LadyGeist", head: 11, neck: 12, body: 7}
HeroBones[6] := {name: "Abrams", head: 7, neck: 6, body: 5}
HeroBones[7] := {name: "Wraith", head: 7, neck: 6, body: 5}
HeroBones[8] := {name: "McGinnis", head: 7, neck: 5, body: 4}
HeroBones[10] := {name: "Paradox", head: 8, neck: 9, body: 5}
HeroBones[11] := {name: "Dynamo", head: 13, neck: 12, body: 16}
HeroBones[12] := {name: "Kelvin", head: 12, neck: 13, body: 9}
HeroBones[13] := {name: "Haze", head: 8, neck: 5, body: 4}
HeroBones[14] := {name: "Holliday", head: 0, neck: 0, body: 0}
HeroBones[15] := {name: "Bebop", head: 6, neck: 4, body: 3}
HeroBones[17] := {name: "GreyTalon", head: 17, neck: 25, body: 15}
HeroBones[18] := {name: "MoAndKrill", head: 10, neck: 9, body: 15}
HeroBones[19] := {name: "Shiv", head: 13, neck: 14, body: 9}
HeroBones[20] := {name: "Ivy", head: 13, neck: 10, body: 9}
HeroBones[25] := {name: "Warden", head: 11, neck: 12, body: 9}
HeroBones[27] := {name: "Yamato", head: 35, neck: 18, body: 17}
HeroBones[31] := {name: "Lash", head: 12, neck: 10, body: 9}
HeroBones[35] := {name: "Viscous", head: 7, neck: 5, body: 4}
HeroBones[48] := {name: "Wrecker", head: 0, neck: 0, body: 0}
HeroBones[50] := {name: "Pocket", head: 13, neck: 11, body: 10}
HeroBones[52] := {name: "Mirage", head: 8, neck: 9, body: 5}
HeroBones[55] := {name: "Dummy", head: 0, neck: 0, body: 0}



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
IniRead, key_aim, %iniFile%, Settings, key_aim, V
IniRead, WriteMode, %iniFile%, Settings, WriteMode, 1
IniRead, sensitivity, %iniFile%, Settings, sensitivity, 0.5
IniRead, tolerance, %iniFile%, Settings, tolerance, 0
IniRead, captureRange, %iniFile%, Settings, captureRange, 150
IniRead, SleepCpu, %iniFile%, Settings, SleepCpu, 0
IniRead, BoneMode, %iniFile%, Settings, BoneMode, 1
IniRead, headOrneck, %iniFile%, Settings, headOrneck, 1
IniRead, circleColor, %iniFile%, Settings, circleColor, 0x8FFF0000
IniRead, thickness, %iniFile%, Settings, thickness, 1
IniRead, HeadOrNeckOrBody, %iniFile%, Settings, HeadOrNeckOrBody, 1
IniRead, key_HeadOrNeckOrBody, %iniFile%, Settings, key_HeadOrNeckOrBody, Numpad0
IniRead, MaxDistAim, %iniFile%, Settings, MaxDistAim, 150
IniRead, LegitCaptureRange, %iniFile%, Settings, LegitCaptureRange, 1
IniRead, CalcPredictionAim, %iniFile%, Settings, CalcPredictionAim, 1
IniRead, velocityDiv, %iniFile%, Settings, velocityDiv, 10
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

StartLabelStart:
sleep 1500
VindictaCuted := false
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
if baseAddress
{
#include %A_ScriptDir%\data\offsetsdump.ahk
}
WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
SetFormat, float, 2.20
VarStart_time := A_TickCount
LastTime1 := A_TickCount
currentTarget := false
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
	; KeyWait, %key_aim%, D T3
	j=0
	ViewMatrix:=Array()
	while(j<16)
	{
		ViewMatrix.Push(1337flex.Read(baseAddress + dwViewMatrix + (j * 0x4),"float"))
		j++
	}
	
if (!VindictaCuted) 
{
	EntityListCout := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
	EntityIndex := 1337flex.Read(EntityListCout + offsets.dwGameEntitySystem_highestEntityIndex,"int")
	playerIndex=0
	while(playerIndex < EntityIndex)
	{
	EntityList := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x0)
	AddressBase := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, (8 * ((playerIndex & 0x7FFF) >> 9) + 16), 0x0)
	ControllerBaseVindicta := 1337flex.getAddressFromOffsets(AddressBase + 0x78 * (playerIndex & 0x1FF), 0x0)
	pEntityString := 1337flex.readString(ControllerBaseVindicta + offsets.m_pEntity,, "utf-8", 0x8, 0x30, 0x8, 0x0)
	if (pEntityString == "CCitadel_Ability_PrimaryWeapon_Empty")
	{
		break
	}
	playerIndex++
	}
    VindictaCuted := true
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
			; msgbox % pEntityString
			; msgbox % HexFormat(ControllerBase)
			; msgbox % HexFormat(ControllerBase + offsets.m_pEntity)
			if Health
			{
				BubaArray.push(ControllerBase)
				BubaArray2.push(Pawn)
			}
			playerIndex++
		}
		; msgbox 1
		;==============Локальный игрок
		ControllerBase1 := 1337flex.getAddressFromOffsets(baseAddress + dwLocalPlayerPawn, 0x0)
		pawnHandle1 := 1337flex.Read(ControllerBase1 + offsets.m_hPawn,"int")
		listEntry1 := 1337flex.getAddressFromOffsets(baseAddress + dwEntityList, 0x8 * ((pawnHandle1 & 0x7FFF) >> 0x9) + 0x10, 0x0)
		Pawn1 := 1337flex.getAddressFromOffsets(listEntry1 + 0x78 * (pawnHandle1 & 0x1FF), 0x0)
		GameSceneNode1 := 1337flex.getAddressFromOffsets(Pawn1 + offsets.m_pGameSceneNode, 0x0)
		MyTeamIs := 1337flex.Read(ControllerBase1 + offsets.m_iTeamNum,"int")
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
		Health := 1337flex.Read(Pawn + offsets.m_ihealth,"int")
		MaxHealth := 1337flex.Read(Pawn + offsets.m_iMaxHealth,"int")
		TeamNum := 1337flex.Read(Pawn + offsets.m_iTeamNum,"int")
		
		; FlaggedAsCheater := 1337flex.Read(ControllerBase + offsets.m_PlayerDataGlobal + 0x76,"int")
		; msgbox % FlaggedAsCheater
		
		HeroID := 1337flex.Read(ControllerBase + offsets.m_PlayerDataGlobal + offsets.m_nHeroID,"int")
		DormantVar := 1337flex.Read(Pawn + offsets.m_lifeState,"int")
		if (TeamNum != MyTeamIs)
		{
			if DormantVar = 256
			{
				GameSceneNode := 1337flex.getAddressFromOffsets(Pawn + offsets.m_pGameSceneNode, 0x0)
				BoneArray := 1337flex.getAddressFromOffsets(GameSceneNode + Offsets.m_modelState + Offsets.m_boneArray, 0x0)
				if BoneMode
				{
					if HeadOrNeckOrBody = 1
					SelectBone := HeroBones[HeroID].head
					if HeadOrNeckOrBody = 2
					SelectBone := HeroBones[HeroID].neck
					if HeadOrNeckOrBody = 3
					SelectBone := HeroBones[HeroID].body
					if (SelectBone > 0)
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
						centerX := A_ScreenWidth / 2
						centerY := A_ScreenHeight / 2
						deltaX := (xpos1 - centerX)
						deltaY := (ypos1 - centerY)
						distance := Sqrt(deltaX**2 + deltaY**2)
						if (distance <= captureRange)  ; Проверяем экранное расстояние, а не мировое
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
	closestDistance := -1  ; Начальное значение, которое всегда будет меньше истинного расстояния
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
		
		DormantVar := 1337flex.Read(closestPindex + offsets.m_lifeState,"int")
		if DormantVar = 256
		{
				HeroID := 1337flex.Read(closestController + offsets.m_PlayerDataGlobal + offsets.m_nHeroID,"int")
				GameSceneNode := 1337flex.getAddressFromOffsets(closestPindex + offsets.m_pGameSceneNode, 0x0)
				BoneArray := 1337flex.getAddressFromOffsets(GameSceneNode + Offsets.m_modelState + Offsets.m_boneArray, 0x0)
				if BoneMode
				{
				
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
						SelectBone := HeroBones[HeroID].head
					} 
					else 
					{
						SelectBone := HeroBones[HeroID].neck
					}
				}
				}	
				; if HeadOrNeckOrBody = 1
				; SelectBone := HeroBones[HeroID].head
				if HeadOrNeckOrBody = 2
				SelectBone := HeroBones[HeroID].neck
				if HeadOrNeckOrBody = 3
				SelectBone := HeroBones[HeroID].body
				if (SelectBone > 0)
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
		velocityDiv2 := 0.05
		;=====================если Виндикта в прицеле то другое упреждение
		VindictaUlt := 1337flex.Read(ControllerBaseVindicta + 0x718,"int")
		if (VindictaUlt == 0)
		{
		enemyXLocation := enemyXLocation + vecVelocityX * dist * velocityDiv2 / 100
		enemyYLocation := enemyYLocation + vecVelocityY * dist * velocityDiv2 / 100
		enemyZLocation := enemyZLocation + vecVelocityZ * dist * velocityDiv2 / 100
		}
		else
		{
		enemyXLocation := enemyXLocation + vecVelocityX * dist * velocityDiv / 100
		enemyYLocation := enemyYLocation + vecVelocityY * dist * velocityDiv / 100
		enemyZLocation := enemyZLocation + vecVelocityZ * dist * velocityDiv / 100
		}
		}
		if !WriteMode
		{
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
		IfWinActive, ahk_exe project8.exe
		{
			CCitadelCameraManager := 1337flex.getAddressFromOffsets(baseAddress + CCameraManager + 0x28, 0x38)
			camera_posXcam := 1337flex.Read(baseAddress + CCameraManager + 0x28, "float",0x38)
			camera_posYcam := 1337flex.Read(baseAddress + CCameraManager + 0x28, "float",0x38+0x4)
			camera_posZcam := 1337flex.Read(baseAddress + CCameraManager + 0x28, "float",0x38+0x8)
			CCameraServices := 1337flex.Read(Pawn1 + offsets.m_pCameraServices, "float", offsets.m_vecPunchAngle) 	;RCS
			pitch := 0
			yaw := 0
			AimAtTargetWrite(camera_posXcam, camera_posYcam, camera_posZcam, enemyXLocation, enemyYLocation, enemyZLocation, yaw, pitch)
			if camera_posXcam
			{
				1337flex.write(baseAddress + CCameraManager + 0x28, pitch - CCameraServices, "Float", 0x44) 		;вертикаль
				1337flex.write(baseAddress + CCameraManager + 0x28, yaw, "Float", 0x44+0x4) 	;горизонталь
			}
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
    if (HeadOrNeckOrBody > 3)  ; Если значение больше 3, сбрасываем на 0
        HeadOrNeckOrBody := 1
    if HeadOrNeckOrBody = 1
	{
	Tooltip, Head
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