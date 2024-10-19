class offsets
{
static dwGameEntitySystem_highestEntityIndex = 0x1520
; C_BasePlayerPawn
static m_pCameraServices = 0xdb8
; CPlayer_CameraServices
static m_vecPunchAngle = 0x40
static m_vecPunchAngleVel = 0x58
; CEntityInstance
static m_pEntity = 0x10
; CEntityIdentity
static m_designerName = 0x20
; C_BaseEntity
static m_flSimulationTime = 0x3c0
; CGameSceneNode
static m_bDormant = 0xef
;C_BaseEntity
static m_pGameSceneNode = 0x330
;C_BaseEntity. старое: ControllerBase в CE отмотать 0x7A0 в поисках хп, преобразовать в 4 байт целое
static m_ihealth = 0x354
static m_iMaxHealth = 0x350
; 256 жив 258 мертв
static m_lifeState = 0x358
;C_BaseEntity
static m_iTeamNum = 0x3f3
;CGameSceneNode
static m_vecAbsOrigin = 0xd0
;????????
static m_boneArray = 0x80
;CBasePlayerController
static m_hPawn = 0x614
; static m_iszPlayerName = 0x648
;CSkeletonInstance
static m_modelState = 0x170
;C_BasePlayerPawn
static v_angle = 0xe24
;CModelState
static m_hModel = 0xd0
;CCitadelPlayerController
static m_PlayerDataGlobal = 0x770
;PlayerDataGlobal
static m_nHeroID = 0x1c
static m_iGoldNetWorth = 0x20
static m_iAPNetWorth = 0x24
static m_bUltimateTrained = 0x68
static m_flUltimateCooldownStart = 0x6c
static m_flUltimateCooldownEnd = 0x70
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




