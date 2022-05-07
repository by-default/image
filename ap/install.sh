apt install hostapd
apt install dnsmasq
DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
systemctl unmask hostapd
systemctl disable hostapd
systemctl disable dnsmasq
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
rfkill unblock wlan

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
netfilter-persistent save
