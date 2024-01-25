#!/bin/sh

#IPV4 Firewall Rules
echo "iptables - v4"
/sbin/iptables-restore < /etc/network/iptables

#IPV6 Firewall Rules
echo "iptables - v6"
/sbin/ip6tables-restore < /etc/network/ip6tables
