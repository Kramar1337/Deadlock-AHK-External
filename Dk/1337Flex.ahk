/*

Запланировано:
 - HWID Changer
 - Автоматическое парирование
 - Кастом радиус(показывать ренж)
 - Тавер радиус
 - обновлятор структур
 - обновлятор имен персонажей
 - Список наблюдателей




-console -novid -dx11 -m_rawinput 1 +exec autoexec.cfg -high -preload +@panorama_min_comp_layer_cache_cost_TURNED_OFF 256

-insecure -console -novid

H:\SteamHDD\steamapps\common\Deadlock
r_shadows 0

map street_test
exec citadel_botmatch_practice_6v6_hard.cfg



cs2-analyzer
https://a2x.github.io/cs2-analyzer/

Новые оффсеты
https://pastebin.com/1gqMqP5V

старые оффсеты
https://pastebin.com/raw/vqU9fdR1
https://pastebin.com/raw/TDCdVjax

dwEntityList = 0x1FC5460
dwGameEntitySystem_highestEntityIndex - 0x21E3E90


Signature GetEntityUnderCrosshair("48 89 5c 24 ? 57 48 81 ec ? ? ? ? 33 ff 8b cf", 0, 0);


; STeamFOWEntity
m_nEntIndex = 0x30
m_bVisibleOnMap = 0x41
; C_CitadelTeam
m_vecFOWEntities = 0x628

C_CitadelTeam
Он находится в глобальном списке сущностей
Есть сущность для каждой команды
STeamFOWEntity array = [C_CitadelTeam + m_vecFOWEntities]
[STeamFOWEntity + m_nEntIndex]
[STeamFOWEntity + m_bVisibleOnMap]


Originally Posted by hoomanlegit View Post
I see, ty. Is CCitadel_Ability_PrimaryWeaponVData a field from CBaseEntity? or controllers? Can you give example on how to reach that field?
1: C_BasePlayerPawn->m_pWeaponServices->m_hActiveWeapon(CBaseHandle)

2:C_CitadelPlayerPawn->m_CCitadelAbilityComponent->m_vecAbilities(CUtlVector<CBaseHandle>) get Element[0] is CCitadel_Ability_PrimaryWeapon_Empty than get public C_BaseEntity->m_nSubclassID+0x8 == CitadelAbilityVData


тяжелая атака
Pawn->GameSceneNode + 0x4D0

-console -novid -dx11 -m_rawinput 1 +exec autoexec.cfg -high -preload +@panorama_min_comp_layer_cache_cost_TURNED_OFF 256
-insecure -console -novid


Все консольные команды DEADLOCK
https://steamcommunity.com/sharedfiles/filedetails/?id=3317893255
map street_test
exec citadel_botmatch_practice_6v6_hard.cfg

citadel_hero_testing_enabled 1
citadel_hero_testing_infinite_money
trooper_kill_all
host_timescale 1
l_ent_actornames


https://www.youtube.com/watch?v=VPskGHjG-bA
Cпуфер:
Закрыть стим
C:\Program Files (x86)\Steam
appcache
userdata
ssfn
C:\Users\Nagibskiy\AppData\Roaming
C:\Users\Nagibskiy\AppData\Local\Steam
Чистим реестр

valve
steam
deadlock
project8
Citadel


TMAC v6
Меняем мак адреса все что можно

Меняем в реестре ID
machineGUID
https://www.guidgen.com/
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography
MachineGuid
4c14a75a-ee26-47ba-bb97-13342f911e14

Меняем ид диска
Hwid Changer.exe
ee26-47ba
A046-53F0 было

Перезагружаемся

*/

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
Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico
Menu,Tray, NoStandard
Menu,Tray, DeleteAll
Menu,Tray, add, Menu, MetkaMenu3
Menu,Tray, Disable, Menu
Menu,Tray, Icon, Menu, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Edit Config, MetkaMenu3
Menu,Tray, Icon, Edit Config, imageres.dll, 247, 16
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16
Gui, -Caption +AlwaysOnTop
Gui, Add, Button, gStart w100 h30, Start
Gui, Add, Button, gHashChanger w100 h30, Hash Changer
Gui, Add, Button, gNameChanger w100 h30, Name Changer
Gui, Add, Button, gUpCfg w100 h30, Import Config
Gui, Add, Button, gMetkaMenu3 w100 h30, Edit Config
Gui, Add, Button, gUpOffsets w100 h30, UpOffsets

; Gui, Add, Button, gHwidSpoofer w100 h30, HWID Spoofer
Gui, Add, Button, gExit w100 h30, Exit
randomName := GenerateRandomName(15) ; 10 - длина имени
yPosGui := A_ScreenHeight // 2 - round(A_ScreenHeight * (500 / 1440))
Gui, Show, y%yPosGui%, %randomName%
return



UpOffsets:
; https://github.com/ouwou/source2sdk-deadlock
MsgBox 0x1, ,Ручное обновление оффсетов`nПеред продолжением отключи AV
IfMsgBox OK, {
} Else IfMsgBox Cancel, {
Return
}
FileCreateDir, %A_ScriptDir%\TempFlex

; Базовый URL
URLDeadlockSdk := "https://raw.githubusercontent.com/ouwou/source2sdk-deadlock/refs/heads/master/include/source2sdk"

; Скачивание файлов
URLDownloadToFile, % URLDeadlockSdk "/client/C_BasePlayerPawn.hpp", %A_ScriptDir%\TempFlex\C_BasePlayerPawn.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CPlayer_CameraServices.hpp", %A_ScriptDir%\TempFlex\CPlayer_CameraServices.hpp
URLDownloadToFile, % URLDeadlockSdk "/entity2/CEntityInstance.hpp", %A_ScriptDir%\TempFlex\CEntityInstance.hpp
URLDownloadToFile, % URLDeadlockSdk "/entity2/CEntityIdentity.hpp", %A_ScriptDir%\TempFlex\CEntityIdentity.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CGameSceneNode.hpp", %A_ScriptDir%\TempFlex\CGameSceneNode.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/C_BaseEntity.hpp", %A_ScriptDir%\TempFlex\C_BaseEntity.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CBasePlayerController.hpp", %A_ScriptDir%\TempFlex\CBasePlayerController.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CSkeletonInstance.hpp", %A_ScriptDir%\TempFlex\CSkeletonInstance.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CModelState.hpp", %A_ScriptDir%\TempFlex\CModelState.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/CCitadelPlayerController.hpp", %A_ScriptDir%\TempFlex\CCitadelPlayerController.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/PlayerDataGlobal_t.hpp", %A_ScriptDir%\TempFlex\PlayerDataGlobal_t.hpp
URLDownloadToFile, % URLDeadlockSdk "/client/C_GameRules.hpp", %A_ScriptDir%\TempFlex\C_GameRules.hpp


combinedResult := ""
combinedResult .= GetKramOffsets("CPlayer_CameraServices.hpp", "m_vecPunchAngle") . "`n"
combinedResult .= GetKramOffsets("CPlayer_CameraServices.hpp", "m_vecPunchAngleVel") . "`n"
combinedResult .= GetKramOffsets("C_BasePlayerPawn.hpp", "m_pCameraServices") . "`n"
combinedResult .= GetKramOffsets("CEntityInstance.hpp", "m_pEntity") . "`n"
combinedResult .= GetKramOffsets("CEntityIdentity.hpp", "m_designerName") . "`n"
combinedResult .= GetKramOffsets("CGameSceneNode.hpp", "m_vecAbsOrigin") . "`n"
combinedResult .= GetKramOffsets("CGameSceneNode.hpp", "m_bDormant") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_pGameSceneNode") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_iTeamNum") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_iMaxHealth") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_vecVelocity") . "`n"
combinedResult .= GetKramOffsets("C_BaseEntity.hpp", "m_lifeState") . "`n"
combinedResult .= GetKramOffsets("CBasePlayerController.hpp", "m_hPawn") . "`n"
combinedResult .= GetKramOffsets("CSkeletonInstance.hpp", "m_modelState") . "`n"
combinedResult .= GetKramOffsets("CModelState.hpp", "m_hModel") . "`n"
combinedResult .= GetKramOffsets("CCitadelPlayerController.hpp", "m_PlayerDataGlobal") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iHealth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iHealthMax") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_bAlive") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_nHeroID") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iGoldNetWorth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_iAPNetWorth") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_bUltimateTrained") . "`n"
combinedResult .= GetKramOffsets("PlayerDataGlobal_t.hpp", "m_flUltimateCooldownEnd") . "`n"
combinedResult .= GetKramOffsets("C_GameRules.hpp", "m_nTotalPausedTicks") . "`n"


Clipboard := combinedResult
MsgBox, %combinedResult%
FileRemoveDir, %A_ScriptDir%\TempFlex, 1
return



GetKramOffsets(fileName, serviceName) {
    FileRead, content, %A_ScriptDir%\TempFlex\%fileName%
    if RegExMatch(content, serviceName . "[^\n]*//.*?0x[a-fA-F0-9]+", match)
	{
	RegExMatch(match, "(0x[a-fA-F0-9]+)[\s\n]*$", match1)
    return "static " . serviceName . " = " . match1
	}
    return ""
}



Start:
    ; Получаем путь к текущему скрипту
    scriptPath := A_ScriptDir
    ; Получаем имя текущего скрипта
    currentScript := A_ScriptName
	
    ; Подсчитываем количество файлов в папке
    fileCount := 0
    Loop, %scriptPath%\*
    {
        if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) ; Проверяем, что это не директория
        {
            fileCount++
        }
    }

    ; Проверка: если файлов больше 10, выводим ошибку
    if (fileCount > 10)
    {
        MsgBox, 16, Error, Too many files in the folder! (More than 10 files)
        return
    }
	
    ; Извлекаем все файлы в директории
    Loop, %scriptPath%\*
    {
        ; Пропускаем текущий скрипт
        if (A_LoopFileName != currentScript)
        {
            ; Запускаем файл
            Run, %A_LoopFileFullPath%
        }
    }
	ExitApp
return

HashChanger:
MsgBox 0x1, ,Изменить Hash всех файлов в папке?
IfMsgBox OK, {
} Else IfMsgBox Cancel, {
Return
}
    ; Получаем путь к текущему скрипту
    scriptPath := A_ScriptDir
    ; Получаем имя текущего скрипта
    currentScript := A_ScriptName

    ; Подсчитываем количество файлов в папке
    fileCount := 0
    Loop, %scriptPath%\*.ahk
    {
        if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) ; Проверяем, что это не директория
        {
            fileCount++
        }
    }

    ; Проверка: если файлов больше 10, выводим ошибку
    if (fileCount > 10)
    {
        MsgBox, 16, Error, Too many files in the folder! (More than 10 files)
        return
    }

    ; Перебираем файлы и изменяем содержимое
    Loop, %scriptPath%\*.ahk ; Можно указать любые расширения файлов, которые вы хотите изменять
    {
        ; Пропускаем текущий скрипт
        if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) ; Проверяем, что это не директория
        {
            ; Читаем содержимое файла
            FileRead, FileReadOutputVar1, %A_LoopFileFullPath%
            
            ; Генерируем случайное количество символов от 20 до 30
            Random, rand1488, 20, 30
            GenerateRandom := GenerateRandomName(rand1488)
            
            ; Регулярное выражение для замены
            1RepFile1 = AntiVACHashChanger:="\w*"
            2RepFile2 = AntiVACHashChanger:="%GenerateRandom%%GenerateRandom%%GenerateRandom%%GenerateRandom%"
            
            ; Выполняем замену
            RegExRepFile1 := RegExReplace(FileReadOutputVar1, 1RepFile1, 2RepFile2)
            
            ; Перезаписываем файл с новыми данными
            FileEncoding, UTF-8
            FileDelete, %A_LoopFileFullPath%
            FileAppend, %RegExRepFile1%, %A_LoopFileFullPath%
        }
    }
	MsgBox,,, Hash changing process completed, 1
return

NameChanger:
MsgBox 0x1, ,Изменить имена всех файлов в папке?
IfMsgBox OK, {
} Else IfMsgBox Cancel, {
Return
}
; Основной скрипт
scriptPath := A_ScriptDir ; Путь к текущему скрипту
currentScript := A_ScriptName ; Имя текущего скрипта

; Переименовываем файлы в директории
Loop, %scriptPath%\* ; Проходим по всем файлам в директории
{
    ; Пропускаем текущий скрипт
    if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) { ; Проверяем, что это не директория
        fileNameWithoutExt := RegExReplace(A_LoopFileName, "\..*$") ; Убираем расширение файла
        fileExt := A_LoopFileExt ; Сохраняем расширение
        randomPrefix := GenerateRandomPrefix()
        if (StrLen(fileNameWithoutExt) > 5) {
            modifiedName := ModifyFileName(fileNameWithoutExt) ; Изменяем каждый третий символ на цифру
            newName := randomPrefix . modifiedName ; Собираем новое имя
        } else {
            newName := randomPrefix
        }
        newPath := scriptPath "\" newName "." fileExt
        FileMove, %A_LoopFileFullPath%, %newPath%
    }
}
	MsgBox,,, All files renamed except for this script, 1
return

UpCfg:
    FileSelectFile, selectedFile, 3, %A_ScriptDir%, Выберите файл config.ini, INI (*.ini)
    if selectedFile =
        return
    if (FileExist(selectedFile) && RegExMatch(selectedFile, "config\.ini$") = 0)
    {
        MsgBox,,, Выбранный файл не является "config.ini",1
        return
    }
    newFilePath := A_ScriptDir "\data\config.ini"
    IniRead, sections, %selectedFile%, ,
    Loop, Parse, sections, `n
    {
        section := A_LoopField
        IniRead, keys, %selectedFile%, %section%
        Loop, Parse, keys, `n
        {
            keyArray := StrSplit(A_LoopField, "=")
            if (keyArray.MaxIndex() = 2) ; Проверить, была ли строка успешно разделена
            {
                paramName := keyArray[1]
                paramValue := keyArray[2]
                IniWrite, %paramValue%, %newFilePath%, %section%, %paramName%
            }
            else
            {
                MsgBox,,, Неправильный формат строки в файле: %selectedFile%
                continue
            }
        }
    }
    MsgBox,,, Настройки импортированы,1
return

HwidSpoofer:
MsgBox,,, Пока ничего нет,1
return



; Функция для генерации первых 5 случайных символов
GenerateRandomPrefix() {
    characters := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    randomPrefix := ""
    Loop, 5 {
        randomPrefix .= SubStr(characters, Random(1, StrLen(characters)), 1)
    }
    return randomPrefix
}

ModifyFileName(name) {
    newName := ""
    ; Получаем длину имени
    length := StrLen(name)
    
    Loop, %length% {
        index := A_Index
        char := SubStr(name, index, 1)
        
        ; Проверяем, является ли индекс третьим символом (т.е. 3, 6, 9 и т.д.)
        if (Mod(index, 4) = 0 && index > 5) { 
            ; Заменяем на случайную цифру
            randomDigit := Random(0, 9)
            newName .= randomDigit
        } else {
            newName .= char
        }
    }

    return newName
}

Random(min, max) {
    Random, rand, min, max
    return rand
}










Exit:
    Gui, Destroy
    ExitApp
return

GuiClose:
    ExitApp
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

; Функция для генерации случайного имени
GenerateRandomName(length) {
    chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    name := ""
    Loop, %length%
    {
        Random, index, 1, StrLen(chars)
        name .= SubStr(chars, index, 1)
    }
    return name
}
