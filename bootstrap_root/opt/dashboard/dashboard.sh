#!/bin/bash

trap ctrl_c INT
function ctrl_c() {
    echo "go away by default"
    if [[ -d /sys/class/gpio/gpio21 ]]; then
        echo 21 >/sys/class/gpio/unexport
    fi
    kill $DASHBOARD_PID
    reset
    sudo chvt $LAST_TTY
    exit 0
}

raspi-gpio set 21 ip pu

if [[ ! -d /sys/class/gpio/gpio21 ]]; then
    echo 21 >/sys/class/gpio/export
fi

while true; do
    # wait for gpio pull
    while [[ $(cat /sys/class/gpio/gpio21/value) == "1" ]]; do sleep 1s; done

    # save current tty
    LAST_TTY=`sudo fgconsole`
    MY_TTY=`tty | sed 's/\/dev\/tty//g'`

    /usr/bin/sampler --config config.yml & DASHBOARD_PID=$!
    sudo chvt $MY_TTY

    # wait for gpio release
    while [[ $(cat /sys/class/gpio/gpio21/value) == "0" ]]; do sleep 1s; done
    kill $DASHBOARD_PID
    reset
    sudo chvt $LAST_TTY
done
