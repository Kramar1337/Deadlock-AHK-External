# Deadlock-AHK-External v0.34

![hippo](https://i.imgur.com/2LV7HZV.jpeg)

Из говна и палок, переворачивая форумы и мучая ChatGPT я слепил:

Deadlock External Cheat на AHK для игры [Deadlock](https://store.steampowered.com/app/1422450/Deadlock/)

🙏 Использование читов может привести к блокировке учетной записи, бан дают по железу, использовать на свой страх и риск на пустом аккиче

<details>
<summary>💪Информация по банам + Spoofer(кликни сюда)💪</summary>

Информация актуальна на момент публикации (30.09.2024)

Бан дают по железу, от ручных жалоб, выглядит это так: подаешь поиск(режимы: 12 игроков, 6vs6 игроки боты, 1vs11 игрок против ботов) и табличка "Вы навсегда заблокированы в этом режиме"

Правила:
- Бан никак не отображается в профиле и никак не отследить, проверить только подав поиск.
- Бан дается всем кому ты отправил гифт(лично я не проверял)
- Бан дается на аккаунт и на компьютер(*HWID BAN)
- Если зайти с забаненного компьютера на чистый аккаунт то тот будет мгновенно забанен(зайти в игру! не в стим)

План по разбану:
- Купить аккич на [Funpay](https://funpay.com/)
- Провести Spoofer`изацию [YouTube](https://www.youtube.com/watch?v=VPskGHjG-bA)
- Зайти на аккич и играть
- *Сгоревший аккаунт продать за пол цены на Funpay
- *Скрыть игру в списке стим(после бана), чтобы случайно не открыть

P.S. Габен не умеет делать античит и по сути используется анти смурфинг система из Dota2 с мгновенным применением бана, чистишь реестр, папки, меняешь ID. И бан PC снимается.
```
Если в кратце выжимка из видоса:
Закрыть стим
C:\Program Files (x86)\Steam

Удалить appcache
Удалить userdata
Удалить ssfn
Удалить \AppData\Local\Steam

Чистим реестр поиск по RegOrganizer

valve
steam
deadlock
project8
Citadel

TMAC.exe
Меняем мак адреса всего что можно

Меняем в реестре ID
machineGUID
https://www.guidgen.com/
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography
MachineGuid
4c14175a-ee16-47ba-b197-13372f911114

Меняем ид диска
Hwid Changer.exe
ee16-47ba

Перезагружаемся
```

</details>

[__✨Boosty✨__](https://boosty.to/kramar1337)
[__✨SteamTrade✨__](https://steamcommunity.com/tradeoffer/new/?partner=176456946&token=QbYR9jmE)

__🚀Функционал:🚀__

- Wallhack (Квардаты)
 + 123
- AimBot (Автонаводка)
- AimBot Soul (Автонаводка на души)
- RCS (Контроль отдачи)
- Radar (Радар)
- Обновлятор оффсетов
- Полуавтоматический импорт настроек

:musical_keyboard:__Горячие клавиши:__:musical_keyboard:
```
V - AimBot
Rbutton(ПКМ) - AimBot Soul
C - Jump(Shift + Space + Ctrl)
Alt - Показать Золото и Уровень противника и посчитать отставание
Ctrl - Скрыть радар
Numpad 0 - Переключить AimBot: Голова, Шея, Тело
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
; Максимальная дистанция, расстояние в игре
MaxDistAim=150
; Клавиша aim
key_aim=V
; Переключить кости 1 - Голова и Шея рандомно 60/40%, 2 - Шея, 3 - Тело
key_HeadOrNeckOrBody=Numpad0
; Режим: 1-запись в память, 0-только чтение
WriteMode=0
; 0.1 - 0.9	Чувствительность движения (только для WriteMode = 0)
sensitivity=0.6
; Допустимое расстояние до цели для остановки движения 1-2 пикселя (только для WriteMode = 0)
tolerance=0
; 150 Диапазон захвата пикселей
captureRange=150
; 0 для идеальной плавности в "WriteMode = 1" но жрет много CPU 8% в моем случае
SleepCpu=0
; 1 - кости из базы, 0 - выбрать самую верхнюю кость(промахи, например, поднятые руки выше уровня головы)
BoneMode=1
; 1 - Голова и Шея рандомно 60/40%, 2 - Шея, 3 - Тело
HeadOrNeckOrBody=1
; Цвет (0xAARRGGBB)
circleColor=0x8FFF0000
; Толщина контура
thickness=1

;===============================================================================
; Настройки AimBot Soul на души крипов ДедКок-КрамАимботДуши.ahk
; Максимальная дистанция, расстояние в игре
MaxDistAimSoul=150
; Клавиша aim
soulkey_aim=Rbutton
; Режим: 1-запись в память, 0-только чтение
soulWriteMode=0
; 0.1 - 0.9	Чувствительность движения
soulsensitivity=0.5
; Допустимое расстояние до цели для остановки движения 1-2 пикселя
soultolerance=0
; 300 Диапазон захвата пикселей
soulcaptureRange=300
; 0 для идеальной плавности в "WriteMode = 1" но жрет много CPU
soulSleepCpu=1
; Цвет (0xAARRGGBB)
soulcircleColor=0x6FFFD800
; Толщина контура
soulthickness=1

;===============================================================================
; Настройки Esp ДедКок-КрамКвадраты.ahk
; Показывать текст
ESPShowText=1
; Показывать 1 - уголки, 0 - квадраты
LineOrRectangle=1
; Показывать NetWorth
ESPkey_NetWorthShow=Alt
; Team
ESPboxTeam=1
; Enemy
ESPboxEnemy=1
; рекомендую 20. для идеальной плавности 0
ESPSleepCpu=1
; показывать индексы костей для настройки ДедКок-КрамАимбот.ahk
ESPboneDBGmode=0

;===============================================================================
; Настройки Radar ДедКок-КрамРадар.ahk
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
; Прозрачность изображения	
imageAlpha=0.7
; Размер изображения в пикселях в свойствах	
imageSizeOrigin=128
```

## Disclaimer 
This project is intended solely for educational purposes. 

## License

This project is licensed under the MIT License. For more information, see the [LICENSE] file.
