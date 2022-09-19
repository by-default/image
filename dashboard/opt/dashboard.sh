#!/bin/bash

PIN=3

trap ctrl_c INT
function ctrl_c() {
    echo "go away by default"
    if [[ -d /sys/class/gpio/gpio$PIN ]]; then
        echo $PIN >/sys/class/gpio/unexport
    fi
    kill $DASHBOARD_PID
    reset
    sudo chvt $LAST_TTY
    exit 0
}

raspi-gpio set $PIN ip pu

if [[ ! -d /sys/class/gpio/gpio$PIN ]]; then
    echo $PIN >/sys/class/gpio/export
fi

while true; do
    # wait for gpio pull
    while [[ $(cat /sys/class/gpio/gpio$PIN/value) == "1" ]]; do sleep 1s; done

    # save current tty
    LAST_TTY=`sudo fgconsole`
    MY_TTY=`tty | sed 's/\/dev\/tty//g'`

    /usr/bin/sampler --config /boot/bydefault/config.yml & DASHBOARD_PID=$!
    sudo chvt $MY_TTY

    # wait for gpio release
    while [[ $(cat /sys/class/gpio/gpio$PIN/value) == "0" ]]; do sleep 1s; done
    kill $DASHBOARD_PID
    reset
    sudo chvt $LAST_TTY
done
