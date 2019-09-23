nmcli con up WorkVPN
sudo ip route del default dev ppp0
sudo ip route add 172.26.129.0/24 dev ppp0 scope link
