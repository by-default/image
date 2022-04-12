import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

# test mode button
TEST_MODE = 4
GPIO.setup(TEST_MODE, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# DIP
DIP = [19,20,26,21,6,12,13,16]
for gpio in DIP:
    GPIO.setup(gpio, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# LEDs
LED = [11, 9, 10]
for led in LED:
    GPIO.setup(led, GPIO.OUT)
    GPIO.output(led, False)

def read_gpio():
    state = {}
    state["test"] = bool(GPIO.input(TEST_MODE))
    state["dip"] = [not GPIO.input(gpio) for gpio in DIP]

    return state

try:
    while True:
        gpio_state = read_gpio()
        print(gpio_state)
        GPIO.output(LED[0], gpio_state["dip"][0])
        GPIO.output(LED[1], gpio_state["dip"][1])
        GPIO.output(LED[2], gpio_state["dip"][2])
        
        time.sleep(0.5)

except KeyboardInterrupt:
    print('interrupted!')
