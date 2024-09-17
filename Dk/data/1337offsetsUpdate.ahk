/*
https://deadlocked.wiki/
Персонажи:
Bebop - Бибоп - Пудж (Пушка лазер, Крюк, много хп, Ульт лазер)
Wraith - Фантом (томик, блинк, баф атк от 3 спела, ульт стан)
Haze - Пелена - Рики (кортик сон, стаки, инвиз, ульт жнеца)
Vindicta - Виндикта - Дровка (Полет, авп)
Infernus - Инфернус (Стаки, Суперспринт)
McGinnis - Макгиннис (пулимет 60 пуль косой, турель, хил, миномет)
Ivy - Лоза - Висп (хил, релокейт*)
Seven - Семь - Зюс (стан, ульт зюса, баф атк от 3 спела)






client.dll+2D5A93 - 48 8D 3D 96F6C601     - lea rdi,[client.dll+1F45130]
Адрес инструкции - client.dll + 2D5A93 = 7FFDEF005A93
Через 3 байта считать "96F6C601" и перевернуть в Биг эндиан "0x01C6F696"
7FFDEF005A93 + 0x7 = 7FFDEF005A9A (7 это длинна инструкции)
7FFDEF005A9A + 0x01C6F696 = 7FFDF0C75130 (client.dll + результат(оффсет))
7FFDF0C75130 - client.dll(7FFDEED30000) = 1F45130 правильный оффсет

dwEntityList: 0x23b5f78 // 48 8B 0D ? ? ? ? 8B C5 48 C1 E8
ViewMatrix: 0x2573e30 // 48 8D 0D ? ? ? ? 48 C1 E0
LocalPlayer: 0x2562300 // 48 8B 0D ? ? ? ? 48 85 C9 74 65 83 FF FF
CCameraManager: 0x23d7960 // 48 8D 3D ? ? ? ? 8B D9
*/

#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
SetBatchLines, -1
#include %A_ScriptDir%\classMemory.ahk


; Проверяем, существует ли файл
if !FileExist(A_ScriptDir . "\offsets.ahk") {
    MsgBox, Файл "%A_ScriptDir%\offsets.ahk" не найден.
    ExitApp
}

FileRead, fileContent, %A_ScriptDir%\offsets.ahk

; static dwEntityList = 0x1F220C8 ; 48 8B 0D ? ? ? ? 8B C5 48 C1 E8
PatternVar1 := "48 8B 0D ? ? ? ? 8B C5 48 C1 E8"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
getOffsets := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)
newString := "static dwEntityList = "getOffsets
searchPattern := "static dwEntityList.*"
fileContent := RegExReplace(fileContent, searchPattern, newString)

; static dwViewMatrix = 0x20DFA20 ; 48 8D 0D ? ? ? ? 48 C1 E0
PatternVar1 := "48 63 C2 48 8D 0D ? ? ? ? 48 C1 E0"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x6
offset2 := 0xA
getOffsets := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)
newString := "static dwViewMatrix = "getOffsets
searchPattern := "static dwViewMatrix.*"
fileContent := RegExReplace(fileContent, searchPattern, newString)

; static dwLocalPlayerPawn = 0x1DCB588 ; 48 8B 0D ? ? ? ? 48 85 C9 74 65 83 FF FF
PatternVar1 := "48 8B 0D ? ? ? ? 48 85 C9 74 65 83 FF FF"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
getOffsets := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)
newString := "static dwLocalPlayerPawn = "getOffsets
searchPattern := "static dwLocalPlayerPawn.*"
fileContent := RegExReplace(fileContent, searchPattern, newString)

;static CCameraManager = 0x1F45130 ; 48 8D 3D ? ? ? ? 8B D9
PatternVar1 := "48 8D 3D ? ? ? ? 8B D9"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
getOffsets := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)
newString := "static CCameraManager = "getOffsets
searchPattern := "static CCameraManager.*"
fileContent := RegExReplace(fileContent, searchPattern, newString)

FileDelete, %A_ScriptDir%\offsets.ahk ; Удаляем старый файл
FileAppend, %fileContent%, %A_ScriptDir%\offsets.ahk ; Создаем новый файл с изменениями
MsgBox,,, Ok, 1
return


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


