# The development on this repository has ceased due to probable breaking of Android's security model and adding further layers of trust where it is inappropriate by rooting (More details at [https://madaidans-insecurities.github.io/](https://madaidans-insecurities.github.io/android.html)). 

# Please visit & update from other repositories mentioned at the bottom of this page.

# dnscrypt-proxy2 for Android [Revival] 
### [bluemeda's original magisk module - Revived](https://github.com/Magisk-Modules-Repo/dnscrypt-proxy/) 

A flexible DNS proxy, with support for modern encrypted DNS protocols such as [DNSCrypt v2](https://dnscrypt.info/protocol), [DNS-over-HTTPS](https://www.rfc-editor.org/rfc/rfc8484.txt) and [Anonymized DNSCrypt](https://github.com/DNSCrypt/dnscrypt-protocol/blob/master/ANONYMIZED-DNSCRYPT.txt).

## Features
- arm, arm64, x86 and x86_64 are supported.
- ipv4  and ipv6  are supported.
- All binary files are downloaded from [https://github.com/jedisct1/dnscrypt-proxy/releases](https://github.com/jedisct1/dnscrypt-proxy/releases)

## Installation
- Download/install using Magisk Manager App  and set the DNS server as follows. 

### Set DNS server manually with 3rd-party app (not included in this module)
- DNS server address is 127.0.0.1:5354 for ipv4 and [::1]:5354 for ipv6
- The following custom startup and shutdown script may be used along with AFwall firewall, where IP address 9.9.9.9 (can be 1.1.1.1 or 8.8.8.8 or any IP address of a reliable DNS server) should be same as the IP address of fallback_resolver & netprobe_address in configuration file dnscrypt-proxy.toml located at /data/media/0/dnscrypt-proxy. A script file is included in the configuration directory with name "dns-redirect.sh".
  
 ```
 IP6TABLES=/system/bin/ip6tables
 IPTABLES=/system/bin/iptables

# Force a specific DNS
# First two lines deletes current DNS settings 
$IPTABLES -t nat -D OUTPUT -p tcp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
$IPTABLES -t nat -D OUTPUT -p udp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354

# These two lines sets DNS running at 127.0.0.1 on port 5354 
$IPTABLES -t nat -A OUTPUT -p tcp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
$IPTABLES -t nat -A OUTPUT -p udp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354

# uncomment to restart dnscrypt-proxy
# pkill dnscrypt-proxy
  
  ``` 
Refer AFWall [Docs](https://github.com/ukanth/afwall/wiki), [FAQs](https://github.com/ukanth/afwall/wiki/FAQ) and [custom scripts](https://github.com/ukanth/afwall/wiki/CustomScripts). 

The script file named dns-redirect.sh, included in the configuration directory, may be copied to /data/adb/service.d & its permission set to executable for auto-redirection of dns request (for users not interested in using  AFWall or other apps).

## Configuration (post-installation)
- Read & correct the configuration options, especially the IP address, which should be same in redirection script and fallback_resolver & netprobe_address of dnscrypt-proxy.toml. 
- Configuration is located at `/sdcard/dnscrypt-proxy/dnscrypt-proxy.toml` [or /data/media/0/dnscrypt-proxy/dnscrypt-proxy.toml]
- Changes in configuration takes effect only after the dnscrypt-proxy [or the phone] is restarted. Typing "pkill -HUP dnscrypt-proxy" in terminal restarts the dnscrypt-proxy process [without rebooting the phone].
- For more detailed configuration please refer to [upstream documentation](https://github.com/jedisct1/dnscrypt-proxy/wiki/Configuration)

## Testing
- [https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Checking/](https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Checking/) 
## Changelog
- [Full changelog](https://github.com/Magisk-Modules-Repo/dnscrypt-proxy2/blob/master/changelog.md)
## License
- DNSCrypt-proxy binaries from [jedisct1](https://github.com/jedisct1/dnscrypt-proxy)
 is governed by ISC license.
- All of the magisk-modules, excluding the DNSCrypt-proxy binaries, is governed by GNU-GPL-v3.0 license.
## Credits
- [topjohnwu](https://github.com/topjohnwu) for the magisk & [magisk-modules-repo](https://github.com/Magisk-Modules-Repo)
- DNSCrypt-Proxy2 upstream | [jedisct1](https://github.com/jedisct1/dnscrypt-proxy)
- [bluemeda & all other contributors for the magisk module](https://github.com/Magisk-Modules-Repo/dnscrypt-proxy2/graphs/contributors)
## DNSCrypt-proxy for android is also developed by & available at:
- [quindecim](https://git.nixnet.xyz/quindecim/dnscrypt-proxy-android) with support in [Telegram group](https://t.me/qd_invitations) & [Telegram channel](https://t.me/dnscrypt_proxy)
- [CHEF-KOCH](https://github.com/CHEF-KOCH/dnscrypt-proxy-android)
- [adit](https://github.com/adit/dnscrypt-proxy/)
- [InviZible Pro](https://github.com/Gedsh/InviZible)

"# onixheat-magisk" 
# onixheat-magisk
