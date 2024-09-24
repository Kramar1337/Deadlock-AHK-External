# Deadlock-AHK-External

![hippo](https://i.imgur.com/JtLVIKz.jpeg)

Из говна и палок, переворачивая форумы и мучая ChatGPT я слепил:

External чит на AHK для игры [Deadlock](https://store.steampowered.com/app/1422450/Deadlock/)

🙏 Использование читов может привести к блокировке учетной записи, бан дают по железу, использовать на свой страх и риск на пустом аккиче

[__✨Boosty✨__](https://boosty.to/kramar1337)
[__✨SteamTrade✨__](https://steamcommunity.com/tradeoffer/new/?partner=176456946&token=QbYR9jmE)

__🚀Функционал:🚀__

- Wallhack (Квардарты, Dk\ДедКок-КрамКвадраты.ahk)
- AimBot (Автонаводка, Dk\ДедКок-КрамАимбот.ahk)
- RCS (Контроль отдачи, Dk\ДедКок-КрамРКС.ahk)
- Radar (Радар, Dk\ДедКок-КрамРадар.ahk)
- Обновлятор оффсетов

:musical_keyboard:__Горячие клавиши:__:musical_keyboard:
```
V - AimBot
C - Jump(Shift + Space + Ctrl)
Alt - Hide Radar
Home - Перезапуск
End - Завершить работу
```

:memo:Как запустить?:memo:

1. Скачать и установить [Autohotkey.com](https://www.autohotkey.com/download/ahk-install.exe)

"Custom installation" => "Unicode 64" => All checkboxes => "Install"
![hippo](https://media.giphy.com/media/LerrohpjasApOHH9G1/giphy.gif)

2. Скачать репозиторий (Code > [Download Zip👌](https://github.com/Kramar1337/Deadlock-AHK-External/archive/main.zip))
3. Использовать пустой аккаунт который не жалко потерять (бан по железу)
4. Зайти в игру. Открыть настройки и выставить Оконный безрамочный режим
5. Обновить оффсеты "AHK Dk\data\1337offsetsUpdate.ahk" игра должна быть запущена
6. Запустить скрипты. Проверить в режиме песочницы
7. Изменить настройки по необходимости. Открывать файлы через блокнот
8. *Если есть проблемы открывай "Issues" на гитхабе и прикрепляй скрины, будем решать

🛠️ Настройки 🛠️ 
```
Открывать через блокнот файлы и искать
Dk\ДедКок-КрамКвадраты.ahk
boxTeam = 0
boxEnemy = 1
SleepCpu = 1 		; рекомендую 20. для идеальной плавности 0, но жрет много CPU 5% в моем случае
boneDBGmode = 0 	;показывать индексы костей для настройки ДедКок-КрамАимбот.ahk

Dk\ДедКок-КрамАимбот.ahk
key_aim := "V"  		; Клавиша aim
WriteMode = 0 			; Режим: 1-запись в память(высокая точность, нелья регулировать чувствительность), 0-только чтение(mouse_event)
sensitivity := 0.5  	; 0.1 - 0.9	Чувствительность движения
tolerance := 0       	; 1 Допустимое расстояние до цели для остановки движения
captureRange := 150  	; 150 Диапазон захвата пикселей
SleepCpu = 1 			; 0 для идеальной плавности в "WriteMode = 1" но жрет много CPU 8% в моем случае
BoneMode = 1 			; 1 - кости из базы, 0 - выбрать самую верхнюю кость(промахи, например, поднятые руки выше уровня головы)
headOrneck = 1 			; 1 - приоритет на голову из базы, 0 - приоритет на шею из базы

Dk\ДедКок-КрамРадар.ahk
key_radarHide := "Alt" 	; Скрыть радар
radarHidekey = 1 		; Использовать скрытие радара
radarBoxEnable = 0 		; Отображать рамку
radarShowTeam = 1 		; Показывать команду
radarShowNameTeam = 0	; Показывать имя героя команды
radarShowNameEnemy = 1	; Показывать имя героя врага
imageOrpoint = 1 		; 1 image 0 point
pointSize = 8 			; Размер точки
borderSize = 2 			; Толщина обводки точки
imageSize = 40 			; Размер изображения на радаре
imageAlpha = 0.8		; Прозрачность изображения
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
