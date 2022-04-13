import netifaces
import sys

def get_my_ip(iface):
    try:
        wlan0 = netifaces.ifaddresses(iface)
        if netifaces.AF_INET in wlan0:
            return wlan0[netifaces.AF_INET][0]['addr']
        else:
            return None
    except ValueError:
        return None

def get_gw():
    return netifaces.gateways()['default'][netifaces.AF_INET]

if len(sys.argv) < 2:
    sys.exit()

if sys.argv[1] == "ip" and len(sys.argv) == 3:
    print(sys.argv[2], get_my_ip(sys.argv[2]))

if sys.argv[1] == "gw":
    gw = get_gw()
    print("gw", gw[0], gw[1])