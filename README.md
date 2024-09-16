# Deadlock-AHK-External

![hippo](https://i.imgur.com/YveKqnK.jpeg)

Из говна и палок, переворачивая форумы и мучая ChatGPT я слепил:

External чит на AHK для игры [Deadlock](https://store.steampowered.com/app/1422450/Deadlock/)

🙏 Использование читов может привести к блокировке учетной записи, бан дают по железу, использовать на свой страх и риск на пустом аккиче

[__✨Boosty✨__](https://boosty.to/kramar1337)
[__✨SteamTrade✨__](https://steamcommunity.com/tradeoffer/new/?partner=176456946&token=QbYR9jmE)

__🚀Функционал:🚀__

- Esp Box (HP, Box, Name)
- AimBot (Голова, Шея, Высшая кость)
- Radar (Топовый)
- Обновлятор оффсетов

:musical_keyboard:__Горячие клавиши:__:musical_keyboard:
```
V - AimBot
Home - Перезапуск
End - Завершить работу
```

:memo:Как запустить?:memo:

1. Скачать и установить [Autohotkey.com](https://www.autohotkey.com/download/ahk-install.exe)

  "Custom installation" => "Unicode 64" => All checkboxes => "Install"
![hippo](https://media.giphy.com/media/LerrohpjasApOHH9G1/giphy.gif)

2. Скачать репозиторий (Code > [Download Zip👌](https://github.com/Kramar1337/Deadlock-AHK-External/archive/main.zip))

3. Запустить

🛠️ Настройки 🛠️ 
```
Открывать через блокнот файлы и искать
Dk\ДедКок-КрамКвадраты.ahk
boxTeam = 1
boxEnemy = 1
SleepCpu = 1 	; рекомендую 20. для идеальной плавности 0, но жрет много CPU 5% в моем случае
boneDBGmode = 0 	;показывать индексы костей для настройки ДедКок-КрамАимбот.ahk

Dk\ДедКок-КрамАимбот.ahk
key_aim := "V"
sensitivity := 0.5  	; 0.05	Чувствительность движения
tolerance := 1       	; 2 	Допустимое расстояние до цели для остановки движения
captureRange := 150  	; 100 пикселей
SleepCpu = 1 			; 0 для идеальной плавности но жрет много CPU 5% в моем случае
BoneMode = 1 			; 1 - кости из базы, 0 - выбрать самую верхнюю кость(промахи, например, поднятые руки выше уровня головы)
headOrneck = 1 			; 1 - приоритет на голову из базы, 0 - приоритет на шею из базы

Dk\ДедКок-КрамРадар.ahk
radarBoxEnable = 0 	; Рекомендую 0 чтобы не мешала рамка
radarShowName = 1 	; Рекомендую 1 чтобы знать кто гангает
radarShowTeam = 0 	; Рекомендую 0 чтобы не мешало
```
Как обновить оффсеты?

Автоматически:
- запустить Dk\data\1337offsetsUpdate.ahk
- ждать пока я обновлю обновлятор

Вручную редактировать Dk\data\offsets.ahk:
- искать на форуме [UC](https://www.unknowncheats.me/forum/deadlock/639185-deadlock-reversal-structs-offsets.html)
- искать по гитхабу [github](https://github.com/Loara228/deadlock-esp/blob/master/deadlock/Offsets.cs)


## Disclaimer 
This project is intended solely for educational purposes. 

## License

This project is licensed under the MIT License. For more information, see the [LICENSE] file.
