class offsets
{
; localplayer->CPlayer_CameraServices->m_vecPunchAngle отдача
; Pawn1->CPlayer_CameraServices(0xda0)->m_vecPunchAngle(0x40)

; C_BasePlayerPawn смещение
static m_pCameraServices = 0xda8
; CPlayer_CameraServices
static m_vecPunchAngle = 0x40
static m_vecPunchAngleVel = 0x58
; CEntityInstance
static m_pEntity = 0x10
; CEntityIdentity
static m_designerName = 0x20
; C_BaseEntity
static m_flSimulationTime = 0x3b8
;ControllerBase в CE отмотать 0x7b8 в поисках Dormant 1-жив 0-мертв, преобразовать в 4 байт целое
static m_bDormant = 0x7C8
; CGameSceneNode
static m_bDormant2 = 0xef
;C_BaseEntity
static m_pGameSceneNode = 0x328
;C_BaseEntity. старое: ControllerBase в CE отмотать 0x7A0 в поисках хп, преобразовать в 4 байт целое
static m_ihealth = 0x34c
static m_iMaxHealth = 0x348
;C_BaseEntity
static m_iTeamNum = 0x03eb
;CGameSceneNode
static m_vecAbsOrigin = 0xd0
;?
static m_boneArray = 0x80
;CBasePlayerController
static m_hPawn = 0x60c
;CSkeletonInstance
static m_modelState = 0x170
;C_BasePlayerPawn
static v_angle = 0x0E04
;CModelState
static m_hModel = 0xD0
;ControllerBase в CE отмотать 0x774 в поисках id, преобразовать в 4 байт целое
static m_heroid = 0x784
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




