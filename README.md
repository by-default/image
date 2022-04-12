1. Образ запускается с параметрами `/boot/cmdline.txt` и `/boot/config.txt`
	* При старте образа показывается экран plymouth (благодаря параметрам ядра `quiet splash`). Фон лежит в `/usr/local/share/plymouth/themes/bydefault/boot_splash.png`, рядом лежит скрипт plymouth
	* По-умолчанию системный UART отключен от системной консоли
    * Если GPIO 21 замкнута на землю, загрузка происходит с выводом отладочной информации (используется cmdline.debug.txt)
2. `/boot` и `/` монтируются read-only, все каталоги, требующие записи (временные файлы, логи и т.д.) монтируются как tmpfs (в RAM). Параметры монтирования в `/etc/fstab`. Для переключения в режим read-write и обратно используются алиасы `set_rw` и `set_ro` (задаются в `/home/pi/.bashrc`)
3. При первом запуске на остатке sd-карты создается FAT32 раздел, который монтируется в `/data` как ro, предназначенный для записи данных, медиафайлов и т.д. Создание обеспечивается скриптом `/usr/bin/create_data`, запускающийся one-time сервисом `/etc/systemd/system/create-data.service`. Этот же скрипт устанавливает права на папку `/tmp`.
4. После загрузки служб запускается графическая подсистема, с помощью сервиса `lightdm`. Строка запуска X-сервера `xserver-command` в `/etc/lightdm/lightdm.conf` (по-умолчанию, запускается в режиме без курсора).
5. После запуска X-сервера создается X-сессия и выполняются команды `/home/pi/.xsessionrc`: отключается скринсейвер и устанавливается фон рабочего стола `/boot/bydefault/background.png`
6. После запуска графики запускается сервис `/etc/systemd/system/bydefault.service`, который запускает `/boot/bydefault/start.sh`
7. По-умолчанию, сервис пробует смонтировать флешку, если флешки нет, вызывается функция `default`. Если флешка вставлена, она монтируется. Если на флешке присутствует скрипт `start.sh`, то выполняется этот скрипт (например, можно в формате такого скрипта составить плейлист, добавить кастомные задержки и т.д.). Если скрипта нет, выполняется функция default_usb: по-умолчанию поочередно воспроизводятся с помощью omxplayer все файлы на флешке.
8. Для мониторинга состояния системы запускается сервис `/etc/systemd/system/dashboard.service`, который запускает скрипт `/opt/dashboard/dashboard.sh`. При замыкании GPIO 21 происходит переключение на tty8, где запускается dashboard с информацией о системе: загрузка CPU, RAM, температура, информация о сети (ip-адреc, адрес шлюза), информация о дисплее, а также логи сервиса bydefault.

### Полезные команды

* Для просмотра состояния сервиса: `journalctl -u bydefault.service -f`
* Для остановки/перезапуска `sudo service bydefault stop/start/restart/status`
* wpa_supplicant.conf можно разместить в /boot для подключения к необходимой сети, файл будет скопирован при следующей загрузке

### TODO

2. GPIO-jumper для вывода на экран сетки
3. Периодическая отправка на gateway адрес данных о системе и логов
4. omxplayer-sync