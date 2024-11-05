﻿class offsets
{
static dwGameEntitySystem_highestEntityIndex = 0x1530
; C_BasePlayerPawn
static m_pCameraServices = 0xD40
; CPlayer_CameraServices
static m_vecPunchAngle = 0x40
; CEntityInstance
static m_pEntity = 0x10
; CEntityIdentity
static m_designerName = 0x20
; CGameSceneNode
static m_vecAbsOrigin = 0xd0
; CGameSceneNode
static m_bDormant = 0xef
; C_BaseEntity
static m_pGameSceneNode = 0x330
; C_BaseEntity
static m_iTeamNum = 0x3f3
; C_BaseEntity
static m_vecVelocity = 0x410
; CBasePlayerController
static m_hPawn = 0x614
; CSkeletonInstance
static m_modelState = 0x170
; CModelState
static m_hModel = 0xd0
; CCitadelPlayerController
static m_PlayerDataGlobal = 0x778
; PlayerDataGlobal_t
static m_iHealth = 0x48
static m_iHealthMax = 0x10
static m_bAlive = 0x60
static m_nHeroID = 0x1c
static m_iGoldNetWorth = 0x20
static m_iAPNetWorth = 0x24
static m_bUltimateTrained = 0x68
static m_flUltimateCooldownEnd = 0x70
; C_GameRules
static m_nTotalPausedTicks = 0x30
}
; Функция для выполнения поиска паттерна и вычисления адреса
FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2) {
    gameEXE := "ahk_exe project8.exe"
    1337flex := new _ClassMemory(gameEXE)
    baseAddress := 1337flex.getModuleBaseAddress(gameDLL)
    moduleInfo := []
    1337flex.GetModuleInformation(baseAddress, moduleInfo)
    SizeOfImage := moduleInfo.SizeOfImage
    address := 1337flex.addressPatternScan(baseAddress, SizeOfImage, aPattern*)
    if (address) {
        address2 := 1337flex.read(address + offset1, "UInt")
        outAddress := address + offset2 + address2 - baseAddress
		outAddress := ConvertNumberToAddress(outAddress)
    } 
	else 
	{
		outAddress = 0
    }
return outAddress
}


; Функция для преобразования строки байтов в массив байтов и символов
ConvertBytesStringToArray(bytesString) {
    ; Удаляем пробелы из строки
    bytesString := RegExReplace(bytesString, "\s+", " ")
    
    ; Разделяем строку на отдельные элементы
    byteArray := StrSplit(bytesString, " ")
    
    ; Создаём массив для результата
    aPattern := []
    
    ; Обрабатываем каждый элемент
    for index, byte in byteArray {
        if (byte = "?") {
            aPattern.Push("?")
        } else {
            ; Преобразуем в шестнадцатеричное число
            aPattern.Push("0x" byte)
        }
    }
    
    return aPattern
}

; Функция для преобразования числа в адрес
ConvertNumberToAddress(number) {
    ; Преобразуем число в шестнадцатеричную строку
    hexValue := Format("{:X}", number)
    
    ; Добавляем префикс 0x
    address := "0x" . hexValue
    
    ; Выводим результат (или записываем в файл)
    return address
}




