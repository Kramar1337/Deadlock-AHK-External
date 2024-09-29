# Deadlock-AHK-External v0.2

![hippo](https://i.imgur.com/2LV7HZV.jpeg)

Из говна и палок, переворачивая форумы и мучая ChatGPT я слепил:

Deadlock External Cheat на AHK для игры [Deadlock](https://store.steampowered.com/app/1422450/Deadlock/)

🙏 Использование читов может привести к блокировке учетной записи, бан дают по железу, использовать на свой страх и риск на пустом аккиче

[__✨Boosty✨__](https://boosty.to/kramar1337)
[__✨SteamTrade✨__](https://steamcommunity.com/tradeoffer/new/?partner=176456946&token=QbYR9jmE)

__🚀Функционал:🚀__

- Wallhack (Квардаты, Dk\ДедКок-КрамКвадраты.ahk)
- AimBot (Автонаводка, Dk\ДедКок-КрамАимбот.ahk)
- AimBot Soul (Автонаводка на души, ДедКок-КрамАимботДуши.ahk)
- RCS (Контроль отдачи, Dk\ДедКок-КрамРКС.ahk)
- Radar (Радар, Dk\ДедКок-КрамРадар.ahk)
- Обновлятор оффсетов
- Ручной импорт настроек

:musical_keyboard:__Горячие клавиши:__:musical_keyboard:
```
V - AimBot
Rbutton(ПКМ) - AimBot Soul
C - Jump(Shift + Space + Ctrl)
Alt - Hide Radar
Home - Перезапуск
End - Завершить работу
```

:memo:Как запустить?:memo:

1. Скачать и установить [Autohotkey.com](https://www.autohotkey.com/download/ahk-install.exe)(прямая ссылка)

"Custom installation" => "Unicode 64" => All checkboxes => "Install"
![hippo](https://media.giphy.com/media/LerrohpjasApOHH9G1/giphy.gif)

2. Скачать репозиторий (Code > [Download Zip👌](https://github.com/Kramar1337/Deadlock-AHK-External/archive/main.zip))
3. Использовать пустой аккаунт который не жалко потерять (бан по железу)
4. Запустить скрипты. Проверить в режиме песочницы
5. Изменить настройки по необходимости
6. *Если есть проблемы открывай "Issues" на гитхабе и прикрепляй скрины, будем решать

🛠️ Настройки 🛠️ 
```
Открывать файл "Dk\data\config.ini"

[Settings]
; Настройки AimBot ДедКок-КрамАимбот.ahk
; Клавиша aim
key_aim = V
; Режим: 1-запись в память, 0-только чтение
WriteMode = 1
; 0.1 - 0.9	Чувствительность движения (только для WriteMode = 0)
sensitivity = 0.5
; Допустимое расстояние до цели для остановки движения 1-2 пикселя (только для WriteMode = 0)
tolerance = 0
; 150 Диапазон захвата пикселей
captureRange = 150
; 0 для идеальной плавности в "WriteMode = 1" но жрет много CPU 8% в моем случае
SleepCpu = 0
; 1 - кости из базы, 0 - выбрать самую верхнюю кость(промахи, например, поднятые руки выше уровня головы)
BoneMode = 1
; 1 - приоритет на голову из базы, 0 - приоритет на шею из базы
headOrneck = 1
; Цвет (0xAARRGGBB)
circleColor = 0x8FFF0000
; Толщина контура
thickness = 1

;===============================================================================
; Настройки AimBot Soul на души крипов ДедКок-КрамАимботДуши.ahk
; Клавиша aim
soulkey_aim = N
; Режим: 1-запись в память, 0-только чтение
soulWriteMode = 1
; 0.1 - 0.9	Чувствительность движения
soulsensitivity = 0.5
; Допустимое расстояние до цели для остановки движения 1-2 пикселя
soultolerance = 0
; 300 Диапазон захвата пикселей
soulcaptureRange = 300
; 0 для идеальной плавности в "WriteMode = 1" но жрет много CPU
soulSleepCpu = 1
; Цвет (0xAARRGGBB)
soulcircleColor = 0x6FFFD800
; Толщина контура
soulthickness = 1

;===============================================================================
; Настройки Esp ДедКок-КрамКвадраты.ahk
; Team
ESPboxTeam = 0
; Enemy
ESPboxEnemy = 1
; рекомендую 20. для идеальной плавности 0
ESPSleepCpu = 1
; показывать индексы костей для настройки ДедКок-КрамАимбот.ahk
ESPboneDBGmode = 0 	

;===============================================================================
; Настройки Radar ДедКок-КрамРадар.ahk
; Скрыть радар
key_radarHide = Alt
; Использовать скрытие радара на "key_radarHide"
radarHidekey = 1
; Отображать рамку
radarBoxEnable = 0
; Показывать команду
radarShowTeam = 1
; Показывать имя Team
radarShowNameTeam = 0
; Показывать имя Enemy
radarShowNameEnemy = 1
; 1 image 0 point
imageOrpoint = 1
; Размер точки
pointSize = 8
; Толщина обводки точки
borderSize = 2
; Размер изображения на радаре	
imageSize = 40
; Прозрачность изображения	
imageAlpha = 0.8
; Размер изображения в пикселях в свойствах	
imageSizeOrigin = 128
```

## Disclaimer 
This project is intended solely for educational purposes. 

## License

This project is licensed under the MIT License. For more information, see the [LICENSE] file.
