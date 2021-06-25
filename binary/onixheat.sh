#!/system/bin/sh
GREEN='\033[0;32m'
NC='\033[0m'
IP6TABLES=/system/bin/ip6tables
IPTABLES=/system/bin/iptables
redirect(){
$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -t nat -X

# Force a specific DNS
# First two lines delete current DNS settings
$IPTABLES -t nat -D OUTPUT -p tcp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
$IPTABLES -t nat -D OUTPUT -p udp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354

# These two new lines sets DNS running at 127.0.0.1 on port 5354
$IPTABLES -t nat -A OUTPUT -p tcp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
$IPTABLES -t nat -A OUTPUT -p udp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354

#PUBG
$IPTABLES -A INPUT -p tcp --destination-port 17500 -j DROP
$IPTABLES -A INPUT -p tcp --destination-port 443 -j DROP
$IPTABLES -A INPUT -p tcp --destination-port 80 -j DROP
$IPTABLES -A INPUT -p tcp --destination-port 8080 -j DROP
$IPTABLESs -A INPUT -p tcp --destination-port 8082 -j DROP
}
resetroute(){
$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -t nat -X
}
n=0
while true
do
PORT="$(netstat -nlp | grep 17500 | wc -l)"
if [ "$PORT" = 1 ];then
resetroute
redirect
pkill dnscrypt-proxy
/system/bin/dnscrypt-proxy --config /data/media/0/onixheat/dnscrypt-proxy.toml &
clear
echo "${GREEN}bypass proxy suksess${NC}"
cat <<EOF
░█████╗░███╗░░██╗██╗
██╔══██╗████╗░██║██║
██║░░██║██╔██╗██║██║
██║░░██║██║╚████║██║
╚█████╔╝██║░╚███║██║
░╚════╝░╚═╝░░╚══╝╚═╝

██╗░░██╗██╗░░██╗███████╗░█████╗░████████╗
╚██╗██╔╝██║░░██║██╔════╝██╔══██╗╚══██╔══╝
░╚███╔╝░███████║█████╗░░███████║░░░██║░░░
░██╔██╗░██╔══██║██╔══╝░░██╔══██║░░░██║░░░
██╔╝╚██╗██║░░██║███████╗██║░░██║░░░██║░░░
╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░
EOF
echo "${GREEN}http://facebook.com/friyadhibiermann/${NC}"
break
elif [ "$PORT" = 0 ];then
if [ $n == 0 ];then
clear
echo "please wait..."
else
echo -n "█"
fi
n=$(( $n + 1 ))
resetroute
pkill dnscrypt-proxy
sleep 1
fi
done
