﻿#NoEnv
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
Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico
Menu,Tray, NoStandard
Menu,Tray, DeleteAll
Menu,Tray, add, Menu, MetkaMenu3
Menu,Tray, Disable, Menu
Menu,Tray, Icon, Menu, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16
Gui, -Caption +AlwaysOnTop ; Убирает кнопки управления и делает окно всегда на верх
Gui, Add, Button, gStart w100 h30, Start
Gui, Add, Button, gHashChanger w100 h30, Hash Changer
Gui, Add, Button, gNameChanger w100 h30, Name Changer
Gui, Add, Button, gUpdate w100 h30 Disabled, Update
Gui, Add, Button, gExit w100 h30, Exit
randomName := GenerateRandomName(15) ; 10 - длина имени
Gui, Show, , %randomName%
return

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

    ; Переименовываем файлы в директории
    Loop, %scriptPath%\*
    {
        ; Пропускаем текущий скрипт
        if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) ; Проверяем, что это не директория
        {
            newName := GenerateRandomName(16) ; Генерируем новое имя длиной 16 символов
            newPath := scriptPath "\" newName "." A_LoopFileExt ; Формируем новый путь с расширением

            ; Переименовываем файл
            FileMove, %A_LoopFileFullPath%, %newPath%
        }
    }
	MsgBox,,, All files renamed except for this script, 1
return

Update:
    ; Здесь добавьте код для обновления
    MsgBox, Update clicked (this button is disabled)
return

Exit:
    Gui, Destroy
    ExitApp
return

GuiClose:
    ExitApp
return
MetkaMenu3:
Run, notepad.exe "%A_ScriptFullPath%"
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
