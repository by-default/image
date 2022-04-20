# Пакет для управления подключением к wifi сетям

Требует python3, python-argparse

`/usr/bin/update-supplicant`
Принимает конфигурационный файл, проверяет наличие сетей в wpa-supplicant файле, в случае отсутствия или различия параметров -- читает template файл, добавляет сеть и записывает в wpa-supplicant. 

Синтаксис `update-supplicant [config file] [-ts]`

`-t` путь к template-файлу (по-умолчанию `/etc/wpa_supplicant/wpa_supplicant.conf.template`)
`-s` путь к wpa_supplicant файлу (по-умолчанию `/etc/wpa_supplicant/wpa_supplicant.conf`)

После выполнения скрипта рекомендуется выполнить `wpa_cli -i wlan0 reconfigure` для переподключения к сети.
