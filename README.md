# Deadlock-AHK-External v0.38

В игру наигрался, обновления будут редко. Оффсеты обновлять самостоятельно, инструкция ниже

Из говна и палок, переворачивая форумы и мучая ChatGPT я слепил:

Deadlock External Cheat на AHK для игры [Deadlock](https://store.steampowered.com/app/1422450/Deadlock/)

🙏 Использование читов может привести к блокировке учетной записи, бан дают по железу, использовать на свой страх и риск на пустом аккиче

<details>
<summary>💪Информация по банам💪</summary>

Информация актуальна на момент публикации (22.10.2024)

- Ручные жалобы
- Автоматически античит определяет меткость стрельбы(я пока не разгадал в чем секрет)

Бан дают по железу, выглядит это так: подаешь поиск(режимы: 12 игроков, 6vs6 игроки боты, 1vs11 игрок против ботов) и табличка "Вы навсегда заблокированы в этом режиме"

Правила:
- Бан никак не отображается в профиле и никак не отследить, проверить только подав поиск.
- Бан дается всем кому ты отправил гифт(лично я не проверял)
- Бан дается на аккаунт и на компьютер(*HWID BAN)
- Если зайти с забаненного компьютера на чистый аккаунт то тот будет мгновенно забанен(зайти в игру! не в стим)

</details>

<details>
<summary>☢️Как обновлять оффсеты?☢️</summary>

Оффсеты тип "m_": (устаревают раз в 2-4 недели)

 - Запустить "1337Flex.ahk" => "DBG"
 - AutoUp
 - В конце откроется блокнот и оффсеты и оффсеты уже скопированы в буфер обмена
 - Убрать старые и просто вставить

Оффсеты тип "dw_": (устаревают оч редко)

 - Запустить "1337Flex.ahk" => "DBG"
 - Open client.dll, автоматически откроет папку с файлом если открыта игра или искать путь самому
 - Например steamapps\common\Deadlock\game\citadel\bin\win64\client.dll
 - Жми "CS2-Analyzer", откроется сайт, отдать ему "client.dll"
 - На сайте вкладка "Offsets", другие не открывай, а то зависнет браузер, скопировать и привести к виду

```
dwEntityList=0x1234567
dwViewMatrix=0x1234567
dwLocalPlayerPawn=0x1234567
CCameraManager=0x1234567
dwGlobalVars=0x1234567
dwGameRules=0x1234567
dwGameEntitySystem_highestEntityIndex=0x1234567
```

 - Запустить "1337Flex.ahk" => "DBG"
 - Вкладка "Debugging" => "OffDump.ahk"
 - Вставить в конце оффсеты, если чегото не хватает то пропустить
 - Такой способ трубует ручное обновление каждую обнову, любую, даже на 1 мб

</details>

[__✨Boosty✨__](https://boosty.to/kramar1337)
[__✨SteamTrade✨__](https://steamcommunity.com/tradeoffer/new/?partner=176456946&token=QbYR9jmE)

__🚀Функционал:🚀__

- SpeedBoost (SpeedHack)
- Wallhack (Квадраты)
  + HP
  + Name
  + Box, Corners
  + CD Ult
  + NetWorth
  + LvL
- AimBot (Автонаводка)
  + Голова 60%, Шея*, Тело, Голова 100%
  + Упреждение
  + Запоминание цели
  + Расстояние до цели
  + Режим только чтение, режим записи
- Spoofer (Снятие HWID бана)
- AimBot Soul (Автонаводка на души, работает криво)
- RCS (Контроль отдачи, режим записи)
- Radar
- Обновлятор оффсетов(Авто, ручной)
- DBG (Инструменты отладки и обновления)
- Полуавтоматический импорт настроек

:musical_keyboard:__Горячие клавиши:__:musical_keyboard:
```
XButton1(Боковая в мышке) - SpeedBoost(SpeedHack, нажимать в воздухе)
V - AimBot
Rbutton(ПКМ) - AimBot Soul
C - Jump(Shift + Space + Ctrl)
N - Spam Ctrl
R - Активная перезарядка*
Alt - Показать Золото и Уровень противника и посчитать отставание
Ctrl - Скрыть радар
Numpad 0 - Переключить AimBot: Голова+Шея, Шея, Тело, Голова
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

<details>
<summary>🛠️ Настройки 🛠️ </summary>
  
```
Или ПКМ по любому скрипту в трей меню => Edit Config
Или Открыть файл "Dk\data\config.ini"

[Settings]
; Настройки лаунчера 1337Flex.ahk
; Скрипт автоматически закроется - 0, скрипт будет работать - 1
RunDedCockKramAembut=1
RunDedCockKramAembutSous=1
RunDedCockKramMokros=1
RunDedCockKramRadur=1
RunDedCockKramRSC=1
RunDedCockKramXBox=1
RunDedCockKramSpuudBest=1

;================================================================
; Настройки DedCock-KramMokros.ahk
; Shift + Space + Ctrl
key_jump=C
; Spam Ctrl
key_crouch=N
; Активная перезарядка
key_activereload=R
; Активная перезарядка, зеленый цвет
PColor=0x7BF06B
; Активная перезарядка, диапазон цветов
PColVn=30
; Активная перезарядка, 1 - автоматически определить координаты. 0 - указать координаты вручную
AAcord=1
; Активная перезарядка, координаты зеленой полоски
MouseX=100
MouseY=100

;================================================================
; Настройки AimBot DedCock-KramAembut.ahk
; Упреждение работает только вблизи < 40ю.
AimSafeModeTest=1
; Рассчитать упреждение для всех
CalcPredictionAim=1
; Использовать упреждение для Vindicta: 0 - нет, 1 - да
VindictaPrediction=1
; Множитель упреждения
VelocityDiv=0.20
; При запоминании цели, если цель вышла из зоны захвата, больше *1.5 от диапазона, то терять цель - 1. Не терять цель никогда - 0
LegitCaptureRange=1
; Максимальная дистанция, расстояние в игре
MaxDistAim=150
; Клавиша aim
key_aim=V
; Переключить кости 1 - Голова 60%, 2 - Шея, 3 - Тело, 4 - Голова 100%
key_HeadOrNeckOrBody=Numpad0
; 0.1 - 0.9	Чувствительность движения
sensitivity=0.6
; Допустимое расстояние до цели для остановки движения 1-2 пикселя
tolerance=1
; 150 Диапазон захвата пикселей
captureRange=150
; Дополнительная задержка для процессора в ms
SleepCpu=0
; 1 - Голова 60%, 2 - Шея, 3 - Тело, 4 - Голова 100%
HeadOrNeckOrBody=1
; Цвет (0xAARRGGBB, прозрачность, красный, зеленый, синий)
circleColor=0x60FF0000
; Толщина контура
thickness=1

;================================================================
; Настройки AimBot Soul на души крипов DedCock-KramAembutSous.ahk
; Максимальная дистанция, расстояние в игре
MaxDistAimSoul=150
; Клавиша aim
soulkey_aim=Rbutton
; 0.1 - 0.9	Чувствительность движения
soulsensitivity=0.6
; Допустимое расстояние до цели для остановки движения 1-2 пикселя
soultolerance=1
; 300 Диапазон захвата пикселей
soulcaptureRange=300
; Дополнительная задержка для процессора в ms
soulSleepCpu=15
; Цвет (0xAARRGGBB, прозрачность, красный, зеленый, синий)
soulcircleColor=0x60FFD800
; Толщина контура
soulthickness=1

;================================================================
; Настройки Esp DedCock-KramXBox.ahk
; Team
ESPboxTeam=1
; Enemy
ESPboxEnemy=1
; Показывать Enemy текст
ESPShowText=1
; Показывать Enemy перезарядку ультимейта
ESPShowUltCD=1
; Показывать Enemy: 0 - Ничего, 1 - уголки, 2 - квадраты
ESPLineOrRectangle=2
; Показывать Team текст
ESPShowTextTeam=1
; Показывать Team перезарядку ультимейта
ESPShowUltCDTeam=1
; Показывать Team: 0 - Ничего, 1 - уголки, 2 - квадраты
ESPLineOrRectangleTeam=0
; Показывать Team HPbar
ESPHPbarTeam=0
; Дополнительная задержка для процессора в ms
ESPSleepCpu=15
; Размер текста
TextSizeHero=14
TextSizeUltCD=15
TextSizeNetWorth=16
; Показывать NetWorth
ESPkey_NetWorthShow=Alt

;================================================================
; Настройки Radar DedCock-KramRadur.ahk
; Показывать NetWorth на радаре
key_NetWorthShow=Alt
; Скрыть радар
key_radarHide=Ctrl
; Использовать скрытие радара на "key_radarHide"
radarHidekey=1
; Отображать рамку
radarBoxEnable=0
; 0 - Указать размер радара вручную(экзотические мониторы), 1 - автоматически(для мониторов 16-9)
radarAutoMode=1
; X Y верхняя левая и X Y нижняя правая координата
radarTopLeftX=200
radarTopLeftY=200
radarBottomRightX=400
radarBottomRightY=400
; Показывать команду
radarShowTeam=1
; Показывать имя Team
radarShowNameTeam=0
; Показывать имя Enemy
radarShowNameEnemy=1
; 1 image 0 point
imageOrpoint=1
; Размер точки
pointSize=8
; Толщина обводки точки
borderSize=2
; Размер изображения на радаре	
imageSize=40
; Прозрачность изображения союзники
imageAlphaTeam=0.3
; Прозрачность изображения враги
imageAlphaEnemy=0.7
; Размер изображения в пикселях в свойствах	
imageSizeOrigin=128
; Размер текста
TextSizeRadar=16

;================================================================
; Настройки SpeedBoost(SpeedHack) DedCock-KramSpuudBest.ahk
key_SpeedBoost=XButton1

;================================================================
; Настройки ручного обновлятора ManualUpdater.ahk
URLDeadlockSdk=https://raw.githubusercontent.com/ouwou/source2sdk-deadlock/refs/heads/master/include/source2sdk

```

</details>

__🔗Ресурсы которые я использовал:🔗__
| Ссылка | Название | Описание |
| --- | --- | --- |
| [Github](https://github.com/Loara228/deadlock-esp) | Deadlock-esp | External Cheat for Deadlock от Loara228 |
| [Github](https://github.com/neverlosecc/source2gen) | Source2gen | Source2 games SDK generator |
| [Github](https://a2x.github.io/cs2-analyzer/) | CS2-analyzer | Offsets + SDK generator |
| [UC](https://www.unknowncheats.me/forum/deadlock/639185-deadlock-reversal-structs-offsets.html) | UC Deadlock | Обсуждение игры |
| [ChatGpt](https://chatgpt.com) | Chatgpt | Chatgpt |

![hippo](https://i.imgur.com/2LV7HZV.jpeg)

## Disclaimer 
This project is intended solely for educational purposes. 

## License

This project is licensed under the MIT License. For more information, see the [LICENSE] file.
