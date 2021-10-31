#!/bin/bash
trap ctrl_c INT

function find_usbflash {
    ls /dev/sd*1 2> /dev/null | head -1
}

function ctrl_c() {
    echo "go away by default"
    killall omxplayer
    cd /
    if [[ -z $(find_usbflash) ]]; then
        sudo umount $USBFLASH_DIR
    fi
    exit 0
}

function default {
    # echo "Default script, do nothing, wait for usb"
    $()
}

USBFLASH_DIR=/usbflash

function default_usb {
    echo "Default usb script, play all by omxplayer"
    while true; do
        for file in /usbflash/*; do
            # check flash exists to stop playback
            if [[ ! -z $(find_usbflash) ]]; then
                echo "play $file"
                omxplayer "$file"
            else
                return
            fi
        done
        sleep 1s
    done
}

function mount_flash {
    if [[ ! -z $(find_usbflash) ]] && \
       [[ -d "$USBFLASH_DIR" ]] && \
       ([[ ! -z $(mount | grep $(find_usbflash)) ]] || sudo mount $(find_usbflash) $USBFLASH_DIR -o ro,uid=$USER,gid=$USER);
    then

        echo "$USBFLASH connected and mounted"
        cd $USBFLASH_DIR
        if [ -a "start.sh" ]; then
            echo "start script exists, run"
            ./start.sh
        else
            # echo "no start script, run default on usb"
            default_usb
        fi

        cd /
        if [[ -z $(find_usbflash) ]]; then
            echo "flash ejected"
            sudo umount $USBFLASH_DIR
        fi
    else
        if [[ -z "$USBFLASH" ]]; then $()
        elif [[ ! -d "$USBFLASH_DIR" ]]; then echo "$USBFLASH_DIR not exists";
        elif [[ ! -z $(mount | grep /dev/sda1) ]]; then echo "not already mounted";
        else echo "mount failed"; fi
        
        default
    fi
}

echo "Start script by default"

# try to mount flash infinite
while true; do
    mount_flash
    sleep 1s
done
