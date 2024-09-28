
imagePath1 = %A_ScriptDir%\data\red2.png
imagePath2 = %A_ScriptDir%\data\green2.png
radarTopLeftX := round(A_ScreenWidth * (2014 / 2560))
radarTopLeftY := round(A_ScreenHeight * (873 / 1440))
radarBottomRightX := round(A_ScreenWidth * (2519 / 2560))
radarBottomRightY := round(A_ScreenHeight * (1380 / 1440))
radarWidth := radarBottomRightX - radarTopLeftX  ; Ширина радара
radarHeight := radarBottomRightY - radarTopLeftY  ; Высота радара
radarFillColor := 0x10000000  ; Полупрозрачный черный (альфа 0x10)
radarBorderColor := 0xFFFFFFFF  ; Белый цвет для рамки радара
radarBorderThickness := 2  ; Толщина рамки радара
maxDistance := 10000 ; Максимальная дальность видимости на радаре в игровых единицах
; Размеры области для центрирования текста
textWidth := 150  ; Примерная ширина текста
textHeight := 50  ; Примерная высота текста
extraOptions := "w" . textWidth . " h" . textHeight . " aCenter dsFF000000 dsx1 dsy1 olFF000000"



#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
SetBatchLines, -1
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

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
IniRead, key_radarHide, %iniFile%, Settings, key_radarHide, Alt
IniRead, radarHidekey, %iniFile%, Settings, radarHidekey, 1
IniRead, radarBoxEnable, %iniFile%, Settings, radarBoxEnable, 0
IniRead, radarShowTeam, %iniFile%, Settings, radarShowTeam, 1
IniRead, radarShowNameTeam, %iniFile%, Settings, radarShowNameTeam, 0
IniRead, radarShowNameEnemy, %iniFile%, Settings, radarShowNameEnemy, 1
IniRead, imageOrpoint, %iniFile%, Settings, imageOrpoint, 1
IniRead, pointSize, %iniFile%, Settings, pointSize, 8
IniRead, borderSize, %iniFile%, Settings, borderSize, 2
IniRead, imageSize, %iniFile%, Settings, imageSize, 40
IniRead, imageAlpha, %iniFile%, Settings, imageAlpha, 0.8
IniRead, imageSizeOrigin, %iniFile%, Settings, imageSizeOrigin, 128

#include %A_ScriptDir%\data\offsets.ahk
#include %A_ScriptDir%\data\classMemory.ahk
#include %A_ScriptDir%\data\ShinsOverlayClass.ahk

Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico

Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray, add, Radar, MetkaMenu3
Menu,Tray, Disable, Radar
Menu,Tray, Icon, Radar, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Edit Config, MetkaMenu3
Menu,Tray, Icon, Edit Config, imageres.dll, 247, 16
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16


; Создание массива героев
HeroNames := {1: "Infernus", 2: "Seven", 3: "Vindicta", 4: "LadyGeist", 6: "Abrams", 7: "Wraith", 8: "McGinnis", 10: "Paradox", 11: "Dynamo", 12: "Kelvin", 13: "Haze", 14: "Holliday", 15: "Bebop", 17: "GreyTalon", 18: "MoAndKrill", 19: "Shiv", 20: "Ivy", 25: "Warden", 27: "Yamato", 31: "Lash", 35: "Viscous", 48: "Wrecker", 50: "Pocket", 52: "Mirage", 55: "Dummy"}


gameEXE:= "ahk_exe project8.exe"
gameDLL:= "client.dll"

AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

Gui, 1: new, +hwndNewGuiID
game := new ShinsOverlayClass(0,0,A_ScreenWidth,A_ScreenHeight, "1", "1", "1",, NewGuiID)

StartLabelStart:
sleep 300
1337flex := new _ClassMemory(gameEXE)
baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
#include %A_ScriptDir%\data\offsetsdump.ahk
WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
SetFormat, float, 2.20
VarStart_time := A_TickCount
Loop
{
sleep 1
	game.BeginDraw()

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
		LocalPlayer := 1337flex.read(baseAddress + dwLocalPlayerPawn, "Int") ;мы в игре, а не в лобби?
		if !(LocalPlayer)
		{
			game.BeginDraw()
			game.EndDraw()
			Goto StartLabelStart
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
			; TeamNum := 1337flex.Read(ControllerBase + offsets.m_iTeamNum,"int")
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
		
		VarStart_time := A_TickCount
	}
	Kramindex := 0
	while Kramindex < BubaArray.length()
	{
	Kramindex++
	ControllerBase := BubaArray[Kramindex]
	Pawn := BubaArray2[Kramindex]
	Health := 1337flex.Read(Pawn + offsets.m_ihealth,"int")
	MaxHealth := 1337flex.Read(Pawn + offsets.m_iMaxHealth,"int")
	TeamNum := 1337flex.Read(Pawn + offsets.m_iTeamNum,"int")
	HeroID := 1337flex.Read(ControllerBase + offsets.m_heroid,"int")
	DormantVar := 1337flex.Read(ControllerBase + offsets.m_bDormant,"int")
	if DormantVar = 1
	{
		if(TeamNum=1 or TeamNum=2 or TeamNum=3)
		{
			Pawn := BubaArray2[Kramindex]
			GameSceneNode := 1337flex.getAddressFromOffsets(Pawn + offsets.m_pGameSceneNode, 0x0)
			enemyXLocation := 1337flex.Read(GameSceneNode + offsets.m_vecAbsOrigin,"float")
			enemyYLocation := 1337flex.Read(GameSceneNode + offsets.m_vecAbsOrigin+0x4,"float")
			WinGetPos,,, windowWidth, windowHeight, ahk_exe project8.exe
			if(enemyXLocation!=0)
			{
			IfWinActive, ahk_exe project8.exe
			{
			; Координаты верхнего левого и нижнего правого углов радара
			if radarBoxEnable
			{
			game.FillRectangle(radarTopLeftX, radarTopLeftY, radarWidth, radarHeight, radarFillColor)
			game.DrawRectangle(radarTopLeftX, radarTopLeftY, radarWidth, radarHeight, radarBorderColor, radarBorderThickness)
			}
			MyTeamIs := 1337flex.Read(ControllerBase1 + offsets.m_iTeamNum, "int")
			if MyTeamIs = 2
			{
			mapCenterX := -180  ; Центр карты по X в игровом мире (условно)
			mapCenterY := 180  ; Центр карты по Y в игровом мире (условно)
			relativeX := (enemyXLocation - mapCenterX) / maxDistance  ; Преобразуем координаты врага по X относительно центра
			relativeY := (enemyYLocation - mapCenterY) / maxDistance  ; Преобразуем координаты врага по Y относительно центра
			radarX := radarTopLeftX + (radarWidth / 2) + (relativeX * radarWidth / 2)
			radarY := radarTopLeftY + (radarHeight / 2) - (relativeY * radarHeight / 2)  ; Y-инверсия
			}
			if MyTeamIs = 3
			{
			mapCenterX := 180  ; Центр карты по X в игровом мире (условно)
			mapCenterY := -180  ; Центр карты по Y в игровом мире (условно)
			relativeX := (enemyXLocation - mapCenterX) / maxDistance  ; Преобразуем координаты врага по X относительно центра
			relativeY := (enemyYLocation - mapCenterY) / maxDistance  ; Преобразуем координаты врага по Y относительно центра
			radarX := radarTopLeftX + (radarWidth / 2) - (relativeX * radarWidth / 2)  ; Инверсия по X
			radarY := radarTopLeftY + (radarHeight / 2) + (relativeY * radarHeight / 2)  ; Инверсия по Y
			}
			radarX := Max(radarTopLeftX, Min(radarX, radarBottomRightX))
			radarY := Max(radarTopLeftY, Min(radarY, radarBottomRightY))
			; MyTeamIs := 1337flex.Read(ControllerBase1 + offsets.m_iTeamNum, "int")
			

			if (TeamNum == MyTeamIs) 
			{
				if radarShowTeam
				{
				if imageOrpoint
				game.DrawImage(imagePath2, radarX - pointSize / 2, radarY - pointSize / 2, imageSize, imageSize, 0, 0, imageSizeOrigin, imageSizeOrigin, imageAlpha, 1, 0, 0)
				else
				{
				game.FillEllipse(radarX - (pointSize + borderSize) / 2, radarY - (pointSize + borderSize) / 2, pointSize + borderSize, pointSize + borderSize, 0xFFFFFFFF)  ; Белая обводка
				game.FillEllipse(radarX - pointSize / 2, radarY - pointSize / 2, pointSize, pointSize, 0xff00FF00)  ; Зеленый для союзников
				}
				if radarShowNameTeam
				game.DrawText(HeroNames[HeroID], radarX - pointSize / 2 - textWidth / 2, radarY - pointSize / 2 - textHeight / 2, "15", "0x00FFFFFF", "Arial", extraOptions)
				}
			} 
			else
			{
				if imageOrpoint
				game.DrawImage(imagePath1, radarX - pointSize / 2, radarY - pointSize / 2, imageSize, imageSize, 0, 0, imageSizeOrigin, imageSizeOrigin, imageAlpha, 1, 0, 0)
				else
				{
				game.FillEllipse(radarX - (pointSize + borderSize) / 2, radarY - (pointSize + borderSize) / 2, pointSize + borderSize, pointSize + borderSize, 0xFFFFFFFF)  ; Белая обводка
				game.FillEllipse(radarX - pointSize / 2, radarY - pointSize / 2, pointSize, pointSize, 0xffFF0000)  ; Красный для врагов
				}
				if radarShowNameEnemy
				game.DrawText(HeroNames[HeroID], radarX - pointSize / 2 - textWidth / 2, radarY - pointSize / 2 - textHeight / 2, "15", "0x00FFFFFF", "Arial", extraOptions)
			}
			}
			}
		}
	}
	}
sleep 1
if radarHidekey
if GetKeyState(key_radarHide, "P")
{
	game.EndDraw()
	game.BeginDraw()
	game.EndDraw()
	KeyWait %key_radarHide%
}

game.EndDraw()
}
return

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
    ; Преобразование адреса в 16-ричный формат без "0x"
    hexAddress := Format("{:X}", address)
    
    ; Копирование адреса в буфер обмена
    Clipboard := hexAddress
    
    ; Возвращаем 16-ричный адрес
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
