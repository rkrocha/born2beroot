#!/bin/bash

wall "\
Architect.: $(uname -a)
CPU physical:	$(grep "^physical id" /proc/cpuinfo | uniq | wc -l)
CPU virtual:	$(grep -c ^processor /proc/cpuinfo)
Memory usage:	$(free -m | awk 'NR == 2 {printf "%d/%dMB (%d%%)", $3, $2, $3 / $2 * 100}')
Disk usage:	$(df -BM --total | awk 'END {printf "%.1f/%.1fGB (%d%%)", $3 / 1024, $2 / 1024, $5}')
CPU load:	$(top -bn1 | awk 'NR == 3 {printf "(%d%%)", $2 + $4}')
Last boot:	$(who -b | awk '{print $3 " " $4}')
LVM in use:	$(lsblk | grep -q "\slvm\s" && echo yes || echo no)
TCP connects.:	$(ss -s | awk '$1 == "TCP:" {gsub(/,/,""); print $4 " established"}')
Users logged:	$(who | wc -l)
Network:	IP $(hostname -I | cut -d ' ' -f1)\
 (MAC $(ip addr | awk '$1 == "link/ether" {print $2}'))
Sudo count:	$(grep -c ^\s*COMMAND= /var/log/sudo/sudo.log)"
