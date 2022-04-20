apt install hostapd
apt install dnsmasq
systemctl unmask hostapd
systemctl disable hostapd
systemctl disable dnsmasq
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
rfkill unblock wlan